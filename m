From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [PATCH 2/5] trace-cmd: Use tracing directory to count CPUs
Date: Wed, 22 Aug 2012 17:43:12 +0900
Message-ID: <20120822084312.17293.47596.stgit@ltc189.sdl.hitachi.co.jp>
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

Count debugfs/tracing/per_cpu/cpu* to determine the
number of CPUs.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Signed-off-by: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
---

 trace-record.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/trace-record.c b/trace-record.c
index 9dc18a9..ed18951 100644
--- a/trace-record.c
+++ b/trace-record.c
@@ -1179,6 +1179,41 @@ static void expand_event_list(void)
 	}
 }
 
+static int count_tracingdir_cpus(void)
+{
+	char *tracing_dir = NULL;
+	char *percpu_dir = NULL;
+	struct dirent **namelist;
+	int count = 0, n;
+
+	/* Count cpus in per_cpu directory */
+	tracing_dir = tracecmd_find_tracing_dir();
+	if (!tracing_dir)
+		return 0;
+	percpu_dir = malloc_or_die(strlen(tracing_dir) + 9);
+	if (!percpu_dir)
+		goto err;
+
+	sprintf(percpu_dir, "%s/per_cpu", tracing_dir);
+
+	n = scandir(percpu_dir, &namelist, NULL, alphasort);
+	if (n > 0) {
+		while (n--) {
+			if (strncmp("cpu", namelist[n]->d_name, 3) == 0)
+				count++;
+			free(namelist[n]);
+		}
+		free(namelist);
+	}
+
+	if (percpu_dir)
+		free(percpu_dir);
+err:
+	if (tracing_dir)
+		free(tracing_dir);
+	return count;
+}
+
 static int count_cpus(void)
 {
 	FILE *fp;
@@ -1189,6 +1224,12 @@ static int count_cpus(void)
 	size_t n;
 	int r;
 
+	cpus = count_tracingdir_cpus();
+	if (cpus > 0)
+		return cpus;
+
+	warning("failed to use tracing_dir to determine number of CPUS");
+
 	cpus = sysconf(_SC_NPROCESSORS_CONF);
 	if (cpus > 0)
 		return cpus;
