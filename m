From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [RFC PATCH 3/6] virtio/console: Wait until the port is ready on splice
Date: Tue, 24 Jul 2012 11:37:28 +0900
Message-ID: <20120724023728.6600.36390.stgit@ltc189.sdl.hitachi.co.jp>
References: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120724023657.6600.52706.stgit@ltc189.sdl.hitachi.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, yrl.pp-manager.tt@hitachi.com, qemu-devel@nongnu.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Wait if the port is not connected or full on splice
like as write is doing.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 drivers/char/virtio_console.c |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 911cb3e..e49d435 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -724,6 +724,26 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 	return fill_readbuf(port, ubuf, count, true);
 }
 
+static int wait_port_writable(struct port *port, bool nonblock)
+{
+	int ret;
+
+	if (will_write_block(port)) {
+		if (nonblock)
+			return -EAGAIN;
+
+		ret = wait_event_freezable(port->waitqueue,
+					   !will_write_block(port));
+		if (ret < 0)
+			return ret;
+	}
+	/* Port got hot-unplugged. */
+	if (!port->guest_connected)
+		return -ENODEV;
+
+	return 0;
+}
+
 static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 			       size_t count, loff_t *offp)
 {
@@ -740,18 +760,9 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 
 	nonblock = filp->f_flags & O_NONBLOCK;
 
-	if (will_write_block(port)) {
-		if (nonblock)
-			return -EAGAIN;
-
-		ret = wait_event_freezable(port->waitqueue,
-					   !will_write_block(port));
-		if (ret < 0)
-			return ret;
-	}
-	/* Port got hot-unplugged. */
-	if (!port->guest_connected)
-		return -ENODEV;
+	ret = wait_port_writable(port, nonblock);
+	if (ret < 0)
+		return ret;
 
 	count = min((size_t)(32 * 1024), count);
 
@@ -851,6 +862,10 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 		.u.data = &sgl,
 	};
 
+	ret = wait_port_writable(port, filp->f_flags & O_NONBLOCK);
+	if (ret < 0)
+		return ret;
+
 	sgl.n = 0;
 	sgl.len = 0;
 	sgl.sg = kmalloc(sizeof(struct scatterlist) * MAX_SPLICE_PAGES,
