From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [PATCH 5/5] trace-cmd: Use polling function
Date: Wed, 22 Aug 2012 17:43:43 +0900
Message-ID: <20120822084343.17293.28556.stgit@ltc189.sdl.hitachi.co.jp>
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

Use poll() for avoiding a busy loop to read trace data of a guest from FIFO.

Signed-off-by: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
---

 trace-recorder.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/trace-recorder.c b/trace-recorder.c
index 6577fe8..bdf9798 100644
--- a/trace-recorder.c
+++ b/trace-recorder.c
@@ -34,9 +34,12 @@
 #include <ctype.h>
 #include <errno.h>
 #include <stdbool.h>
+#include <poll.h>
 
 #include "trace-cmd.h"
 
+#define WAIT_MSEC 1
+
 struct tracecmd_recorder {
 	int		fd;
 	int		trace_fd;
@@ -235,9 +238,37 @@ static void stop_operation_to_trace_agent(int ctl_fd)
 	operation_to_trace_agent(ctl_fd, false);
 }
 
-int tracecmd_start_recording(struct tracecmd_recorder *recorder, unsigned long sleep)
+static int wait_data(struct tracecmd_recorder *recorder, unsigned long sleep)
 {
+	struct pollfd poll_fd;
 	struct timespec req;
+	int ret = 0;
+
+	if (recorder->agent_existing) {
+		poll_fd.fd = recorder->trace_fd;
+		poll_fd.events = POLLIN;
+		while (1) {
+			ret = poll(&poll_fd, 1, WAIT_MSEC);
+
+			if(ret < 0) {
+				warning("polling error");
+				return ret;
+			}
+
+			if (ret)
+				break;
+		}
+	} else if (sleep) {
+		req.tv_sec = sleep / 1000000;
+		req.tv_nsec = (sleep % 1000000) * 1000;
+		nanosleep(&req, NULL);
+	}
+
+	return ret;
+}
+
+int tracecmd_start_recording(struct tracecmd_recorder *recorder, unsigned long sleep)
+{
 	long ret;
 
 	recorder->stop = 0;
@@ -246,11 +277,10 @@ int tracecmd_start_recording(struct tracecmd_recorder *recorder, unsigned long s
 		run_operation_to_trace_agent(recorder->ctl_fd);
 	
 	do {
-		if (sleep) {
-			req.tv_sec = sleep / 1000000;
-			req.tv_nsec = (sleep % 1000000) * 1000;
-			nanosleep(&req, NULL);
-		}
+		ret = wait_data(recorder, sleep);
+		if (ret < 0)
+			return ret;
+
 		ret = splice_data(recorder);
 		if (ret < 0)
 			return ret;
