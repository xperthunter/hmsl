assert_true() {
	"$@" || {
		echo "FAIL: $*"
		exit 1
	}
}

assert_equals() {
	[[ "$1" == "$2" ]] || {
		echo "FAIL expected '$1' got '$2'"
		exit 1
	}
}
