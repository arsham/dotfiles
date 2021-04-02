package margo

import (
	"time"

	"margo.sh/format"
	"margo.sh/golang"
	"margo.sh/golang/goutil"
	"margo.sh/mg"
	"margo.sh/sublime"
)

// Margo is the entry-point to margo
func Margo(m mg.Args) {
	m.Use(
		// &golang.Gocode{
		// 	ShowFuncParams:      true,
		// 	ShowFuncResultNames: true,
		// 	ProposeBuiltins:     true,
		// 	// ProposeTests:        true,
		// },
		&golang.MarGocodeCtl{
			// ImporterMode: golang.SrcImporterWithFallback,
			ImporterMode: golang.KimPorter,
			ProposeTests: true,
		},
		// &golang.TypeCheck{},
		&golang.GocodeCalltips{},
		mg.NewReducer(func(mx *mg.Ctx) *mg.State {
			return mx.SetConfig(mx.Config.EnabledForLangs(mg.AllLangs))
		}),
		golang.GoVet(),
		&golang.SyntaxCheck{},
		golang.GoImports,
		// golang.GoTest("-short", "--tags", "integration"),
		golang.GoTest("-short"),
		// golang.GoInstallDiscardBinaries("-i"),
		// golang.GoTest("-race"),

		&golang.Linter{Name: "golangci-lint", Label: "golangci", Args: []string{
			"run",
			"--fast",
			"--enable=asciicheck",
			"--enable=bodyclose",
			"--enable=dogsled",
			"--enable=depguard",
			"--enable=dupl",
			"--enable=errorlint",
			"--enable=gocognit",
			"--enable=goconst",
			"--enable=gocritic",
			"--enable=gocyclo",
			"--enable=godot",
			"--enable=godox",
			"--enable=golint",
			"--enable=goprintffuncname",
			"--enable=gosec",
			"--enable=gosimple",
			"--enable=interfacer",
			"--enable=maligned",
			"--enable=misspell",
			"--enable=nakedret",
			"--enable=nestif",
			"--enable=prealloc",
			"--enable=rowserrcheck",
			"--enable=scopelint",
			"--enable=staticcheck",
			"--enable=stylecheck",
			"--enable=unconvert",
			"--enable=unparam",
			"--enable=unused",
			"--enable=whitespace",
			"--enable=wrapcheck",
			"--enable=tparallel",
			"--skip-dirs=vendor",
			"--build-tags=integration",
			// "--no-config",
			// "--tests=false",
			// "--new-from-rev=HEAD~1",
		}},
		// &golang.Linter{Name: "golint", Label: "Go/Lint"},
		// &golang.Linter{Name: "mylinter", Label: "Go/mylinter", Args: []string{"./..."}},

		golang.Snippets,
		MySnippets,
		// &golang.GoCmd{},
		&golang.Guru{},
		&golang.TestCmds{
			TestArgs:  []string{"--tags", "integration"},
			BenchArgs: []string{"-benchmem"},
		},
		&golang.GoGenerate{
			Args: []string{"./...", "-v", "-x"},
		},

		// &mg.CmdCtx{}, // try this
		// 	mg.NewReducer(func(mx *mg.Ctx) *mg.State {
		// 	return mx.AddBuiltinCmds(mg.BuiltinCmd{
		// 		Name: "goimports-test",
		// 		Run: func(cx *mg.CmdCtx) *mg.State {
		// 			cx = cx.WithCmd("goimports", "-v", "-d", "-srcdir", cx.View.Filename())
		// 			cx.Input = true
		// 			return mg.Builtins.ExecCmd(cx)
		// 		},
		// 	})
		// }),

		// &DayTimeStatus{},
		// &cleanTests{},
		// mg.NewReducer(gofumpt),
	)
}

type cleanTests struct {
	mg.ReducerType
	Args []string
}

func (*cleanTests) RCond(mx *mg.Ctx) bool {
	return mx.ActionIs(mg.QueryUserCmds{})
}

func (s *cleanTests) Reduce(mx *mg.Ctx) *mg.State {
	dir := goutil.ClosestPkgDir(mx.View.Dir())
	if dir == nil {
		return mx.State
	}
	return mx.State.AddUserCmds(mg.UserCmd{
		Title: "go clean",
		Name:  "go",
		Args:  []string{"clean", "-testcache"},
		Dir:   dir.Path(),
	})
}

type tidy struct {
	mg.ReducerType
}

func (*tidy) RCond(mx *mg.Ctx) bool {
	return mx.ActionIs(mg.QueryUserCmds{})
}

func (s *tidy) Reduce(mx *mg.Ctx) *mg.State {
	return mx.State.AddUserCmds(mg.UserCmd{
		Title: "go mod tidy",
		Name:  "go",
		Args:  []string{"mod", "tidy"},
	})
}

func disableGsFmt(st *mg.State) *mg.State {
	if cfg, ok := st.Config.(sublime.Config); ok {
		return st.SetConfig(cfg.DisableGsFmt())
	}
	return st
}

// broken
func gofumpt(mx *mg.Ctx) *mg.State {
	return disableGsFmt(format.FmtCmd{
		Name:  "gofumpt",
		Args:  []string{"-l", "-extra", mx.View.Filename()},
		Langs: []mg.Lang{mg.Go},
		Actions: []mg.Action{
			mg.ViewFmt{},
			mg.ViewPreSave{},
		},
	}.Reduce(mx))
}

// DayTimeStatus adds the current day and time to the status bar
type DayTimeStatus struct {
	mg.ReducerType
}

func (dts DayTimeStatus) ReducerMount(mx *mg.Ctx) {
	// kick off the ticker when we start
	dispatch := mx.Store.Dispatch
	go func() {
		ticker := time.NewTicker(1 * time.Second)
		for range ticker.C {
			dispatch(mg.Render)
		}
	}()
}

func (dts DayTimeStatus) Reduce(mx *mg.Ctx) *mg.State {
	// we always want to render the time
	// otherwise it will sometimes disappear from the status bar
	now := time.Now()
	format := "Mon, 15:04"
	if now.Second()%2 == 0 {
		format = "Mon, 15 04"
	}
	return mx.AddStatus(now.Format(format))
}

// MySnippets is a slice of functions returning our own snippets
var MySnippets = golang.SnippetFuncs(
	func(cx *golang.CompletionCtx) []mg.Completion {
		// if we're not in a block (i.e. function), do nothing
		if !cx.Scope.Is(golang.BlockScope) {
			return nil
		}

		return []mg.Completion{
			{
				Query: "if err",
				Title: "err != nil { return }",
				Src:   "if ${1:err} != nil {\n\treturn $0\n}",
			},
		}
	},
	func(cx *golang.CompletionCtx) []mg.Completion {
		// if !cx.Scope.Is(golang.BlockScope) || !cx.IsTestFile {
		// 	return nil
		// }
		if !cx.IsTestFile {
			return nil
		}
		return []mg.Completion{
			{
				Query: "test error",
				Title: "t.Error() condition",
				Src: `
	if $1 {
		t.Error("$2: $3 = ($4); want ($5)")
	}`,
			},
			{
				Query: "test errorf",
				Title: "t.Errorf() condition",
				Src: `
	if $1 {
		t.Errorf("$2: $3 = ($4); want ($5)", $6)
	}`,
			},
			{
				Query: "test cases",
				Title: "Test Cases",
				Src: `
	tcs := map[string]struct {
		$1
	}{}
	for name, tc := range tcs {
		tc := tc
		t.Run(name, func(t *testing.T) {
			$2
		})
	}`,
			},
			{
				Query: "patch method",
				Title: "Monkey path a method",
				Src: `
	monkey.PatchInstanceMethod(reflect.TypeOf(${1:instance}), "${2:method name}", func(${3:receiver}, ${4:args}) ${5:return values} {
	})
	defer monkey.UnpatchInstanceMethod(reflect.TypeOf(${1:instance}), "${2:method name}")
	`,
			},
			{
				Query: "patch func",
				Title: "Monkey path a function",
				Src: `
	monkey.Patch(${1:time.Now}, ${2:func() time.Time} {
	})
	defer monkey.Unpatch(${1:time.Now})
	`,
			},
			{
				Query: "db mock",
				Title: "Get db mock",
				Src: `
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()
	defer assert.NoError(t, mock.ExpectationsWereMet(), "there were unfulfilled expectations")
	$1`,
			},
		}
	},
	func(cx *golang.CompletionCtx) []mg.Completion {
		if !cx.IsTestFile {
			return nil
		}
		return []mg.Completion{
			{
				Query: "random generator",
				Title: "random generator",
				Src: `
func init() {
	rand.Seed(time.Now().UnixNano())
}

func randomString(count int) string {
	const runes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	b := make([]byte, count)
	for i := range b {
		b[i] = runes[rand.Intn(len(runes))]
	}
	return string(b)
}

`,
			},
		}
	},

	func(cx *golang.CompletionCtx) []mg.Completion {
		if !cx.Scope.Is(golang.BlockScope) {
			return nil
		}
		return []mg.Completion{
			{
				Query: "ppp",
				Title: "pprint",
				Src:   "pp.Println($0)",
			},
		}
	},
	func(cx *golang.CompletionCtx) []mg.Completion {
		return []mg.Completion{
			{
				Query: "fuzz function",
				Title: "Fuzz Function",
				Src: `
func Fuzz${1:funcName}(data []byte) int {
    if !${2:notInteresting} {
        return -1
    }
    if _, err := ${1:funcName}(p); err != nil {
        return 0
    }
    return 1
}
`,
			},
		}
	},
)

var qtSnippets = golang.SnippetFuncs(
	func(cx *golang.CompletionCtx) []mg.Completion {
		return []mg.Completion{
			{
				Query: "QtqmlResource",
				Title: "Load a qml resource",
				Src: `
    core.QCoreApplication_SetAttribute(core.Qt__AA_EnableHighDpiScaling, true)
    core.QCoreApplication_SetAttribute(core.Qt__AA_ShareOpenGLContexts, true)

    gui.NewQGuiApplication(len(os.Args), os.Args)
    if quickcontrols2.QQuickStyle_Name() == "" {
        quickcontrols2.QQuickStyle_SetStyle("Material")
    }

    var engine = qml.NewQQmlApplicationEngine(nil)
    engine.Load(core.NewQUrl3("qrc:/${0:filepath}.qml", 0))
    gui.QGuiApplication_Exec()
`,
			},
			{
				Query: "QtuiResource",
				Title: "Load a ui resource",
				Src: `
    core.QCoreApplication_SetAttribute(core.Qt__AA_ShareOpenGLContexts, true)
    core.QCoreApplication_SetAttribute(core.Qt__AA_EnableHighDpiScaling, true)

    widgets.NewQApplication(len(os.Args), os.Args)
    window := widgets.NewQMainWindow(nil, 0)
    dialog, err := qtlib.LoadResource(window, "./qml/${0:filepath}.ui")
    if err != nil {
        ${1:return err}
    }
    window.SetupUi(dialog)

    dialog.Show()
    widgets.QApplication_Exec()
                `,
			},
			{
				Query: "QtuiFindElement",
				Title: "Find and create an element from a widget",
				Src: `
    ${1:name} := widgets.NewQ${2:SomethingPointer}(
        ${3:parent}.FindChild("${1:name}", core.Qt__FindChildrenRecursively).Pointer(),
    )
    $4
                `,
			},
		}
	},
)
