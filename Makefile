P:=BatchUpdates.xcodeproj

XCODEBUILD:=xcodebuild
JAZZY:=jazzy

all: docs

$(P):
	swift package generate-xcodeproj --xcconfig-overrides ./iphoneos.xcconfig
	agvtool new-version -all 1

docs: $(P)
	$(JAZZY) --author "Michael Nisi" --author_url https://troubled.pro

.PHONY: clean
clean:
	rm -rf $(P) docs
