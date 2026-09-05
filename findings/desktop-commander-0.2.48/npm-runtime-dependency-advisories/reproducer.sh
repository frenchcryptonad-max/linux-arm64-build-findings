#!/usr/bin/env bash
set +e
WORK="${TMPDIR:-/tmp}/osarm-dc-0.2.48-audit-$$"
mkdir -p "$WORK" && cd "$WORK" || exit 2
printf '{"name":"osarm-dc-audit","version":"1.0.0","private":true}\n' > package.json
PUPPETEER_SKIP_DOWNLOAD=true npm install --ignore-scripts --package-lock-only --no-fund --no-audit @wonderwhy-er/desktop-commander@0.2.48
INSTALL_RC=$?
npm audit --omit=dev --json > npm-audit.json 2>npm-audit.err
AUDIT_RC=$?
node -e 'const j=require("./npm-audit.json"); const v=j.metadata?.vulnerabilities||{}; console.log(JSON.stringify(v,null,2));' 2>/dev/null
printf 'INSTALL_RC=%s\nAUDIT_RC=%s\n' "$INSTALL_RC" "$AUDIT_RC"
exit 0
