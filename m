From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [PATCH 1/5] trace-cmd: Use TRACE_DIR envrionment variable if defined
Date: Wed, 22 Aug 2012 17:43:02 +0900
Message-ID: <20120822084301.17293.90649.stgit@ltc189.sdl.hitachi.co.jp>
References: <20120822084251.17293.69086.stgit@ltc189.sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120822084251.17293.69086.stgit@ltc189.sdl.hitachi.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>, yrl.pp-manager.tt@hitachi.com
List-Id: virtualization@lists.linuxfoundation.org

From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Use TRACE_DIR environment variable for setting
debugfs/tracing directory if defined. This is
for controlling guest(or remote) ftrace.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Signed-off-by: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
---

 trace-util.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/trace-util.c b/trace-util.c
index e128188..d5a3eb4 100644
--- a/trace-util.c
+++ b/trace-util.c
@@ -311,6 +311,15 @@ char *tracecmd_find_tracing_dir(void)
 	char type[100];
 	FILE *fp;
 	
+	tracing_dir = getenv("TRACE_DIR");
+	if (tracing_dir) {
+		tracing_dir = strdup(tracing_dir);
+		if (!tracing_dir)
+			die("malloc");
+		warning("Use environmental tracing directory: %s\n", tracing_dir);
+		return tracing_dir;
+	}
+
 	if ((fp = fopen("/proc/mounts","r")) == NULL) {
 		warning("Can't open /proc/mounts for read");
 		return NULL;
