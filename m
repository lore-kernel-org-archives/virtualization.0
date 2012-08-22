From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [PATCH 4/5] trace-cmd: Add non-blocking option for open() and
	splice_read()
Date: Wed, 22 Aug 2012 17:43:32 +0900
Message-ID: <20120822084332.17293.84508.stgit@ltc189.sdl.hitachi.co.jp>
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

Add non-blocking option for open() and splice_read() for avoiding block to read
trace data of a guest from FIFO.

If SIGINT comes to read/write processes from the parent process in the case
where FIFO as a read I/F is assigned, then reading is normally blocked for
splice_read(). So, we added nonblock option to open() and splice_read().

Signed-off-by: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
---

 trace-recorder.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/trace-recorder.c b/trace-recorder.c
index 3b750e9..6577fe8 100644
--- a/trace-recorder.c
+++ b/trace-recorder.c
@@ -124,7 +124,7 @@ struct tracecmd_recorder *tracecmd_create_recorder_fd(int fd, int cpu)
 		goto out_free;
 
 	sprintf(path, "%s/per_cpu/cpu%d/trace_pipe_raw", tracing, cpu);
-	recorder->trace_fd = open(path, O_RDONLY);
+	recorder->trace_fd = open(path, O_RDONLY | O_NONBLOCK);
 	if (recorder->trace_fd < 0)
 		goto out_free;
 
@@ -172,14 +172,17 @@ static long splice_data(struct tracecmd_recorder *recorder)
 	long ret;
 
 	ret = splice(recorder->trace_fd, NULL, recorder->brass[1], NULL,
-		     recorder->page_size, 1 /* SPLICE_F_MOVE */);
+		     recorder->page_size, SPLICE_F_MOVE | SPLICE_F_NONBLOCK);
 	if (ret < 0) {
-		warning("recorder error in splice input");
-		return -1;
+		if (errno != EAGAIN) {
+			warning("recorder error in splice input");
+			return -1;
+		}
+		return 0; /* Buffer is empty */
 	}
 
 	ret = splice(recorder->brass[0], NULL, recorder->fd, NULL,
-		     recorder->page_size, 3 /* and NON_BLOCK */);
+		     recorder->page_size, SPLICE_F_MOVE | SPLICE_F_NONBLOCK);
 	if (ret < 0) {
 		if (errno != EAGAIN) {
 			warning("recorder error in splice output");
