From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [PATCH V2 5/6] virtio/console: Allocate scatterlist according to the
	current pipe size
Date: Thu, 09 Aug 2012 21:31:20 +0900
Message-ID: <20120809123120.8542.10604.stgit@ltc189.sdl.hitachi.co.jp>
References: <20120809123029.8542.38311.stgit@ltc189.sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120809123029.8542.38311.stgit@ltc189.sdl.hitachi.co.jp>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, qemu-devel@nongnu.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>, yrl.pp-manager.tt@hitachi.com
List-Id: virtualization@lists.linuxfoundation.org

From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Allocate scatterlist according to the current pipe size.
This allows splicing bigger buffer if the pipe size has
been changed by fcntl.

Changes in v2:
 - Just a minor fix for avoiding a confliction with previous patch.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---

 drivers/char/virtio_console.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b2fc2ab..e88f843 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -229,7 +229,6 @@ struct port {
 	bool guest_connected;
 };
 
-#define MAX_SPLICE_PAGES	32
 /* This is the very early arch-specified put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
 
@@ -482,15 +481,16 @@ struct buffer_token {
 		void *buf;
 		struct scatterlist *sg;
 	} u;
-	bool sgpages;
+	/* If sgpages == 0 then buf is used, else sg is used */
+	unsigned int sgpages;
 };
 
-static void reclaim_sg_pages(struct scatterlist *sg)
+static void reclaim_sg_pages(struct scatterlist *sg, unsigned int nrpages)
 {
 	int i;
 	struct page *page;
 
-	for (i = 0; i < MAX_SPLICE_PAGES; i++) {
+	for (i = 0; i < nrpages; i++) {
 		page = sg_page(&sg[i]);
 		if (!page)
 			break;
@@ -511,7 +511,7 @@ static void reclaim_consumed_buffers(struct port *port)
 	}
 	while ((tok = virtqueue_get_buf(port->out_vq, &len))) {
 		if (tok->sgpages)
-			reclaim_sg_pages(tok->u.sg);
+			reclaim_sg_pages(tok->u.sg, tok->sgpages);
 		else
 			kfree(tok->u.buf);
 		kfree(tok);
@@ -581,7 +581,7 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
 	tok = kmalloc(sizeof(*tok), GFP_ATOMIC);
 	if (!tok)
 		return -ENOMEM;
-	tok->sgpages = false;
+	tok->sgpages = 0;
 	tok->u.buf = in_buf;
 
 	sg_init_one(sg, in_buf, in_count);
@@ -597,7 +597,7 @@ static ssize_t send_pages(struct port *port, struct scatterlist *sg, int nents,
 	tok = kmalloc(sizeof(*tok), GFP_ATOMIC);
 	if (!tok)
 		return -ENOMEM;
-	tok->sgpages = true;
+	tok->sgpages = nents;
 	tok->u.sg = sg;
 
 	return __send_to_port(port, sg, nents, in_count, tok, nonblock);
@@ -797,6 +797,7 @@ out:
 
 struct sg_list {
 	unsigned int n;
+	unsigned int size;
 	size_t len;
 	struct scatterlist *sg;
 };
@@ -807,7 +808,7 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	struct sg_list *sgl = sd->u.data;
 	unsigned int offset, len;
 
-	if (sgl->n == MAX_SPLICE_PAGES)
+	if (sgl->n == sgl->size)
 		return 0;
 
 	/* Try lock this page */
@@ -868,12 +869,12 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 
 	sgl.n = 0;
 	sgl.len = 0;
-	sgl.sg = kmalloc(sizeof(struct scatterlist) * MAX_SPLICE_PAGES,
-			 GFP_KERNEL);
+	sgl.size = pipe->nrbufs;
+	sgl.sg = kmalloc(sizeof(struct scatterlist) * sgl.size, GFP_KERNEL);
 	if (unlikely(!sgl.sg))
 		return -ENOMEM;
 
-	sg_init_table(sgl.sg, MAX_SPLICE_PAGES);
+	sg_init_table(sgl.sg, sgl.size);
 	ret = __splice_from_pipe(pipe, &sd, pipe_to_sg);
 	if (likely(ret > 0))
 		ret = send_pages(port, sgl.sg, sgl.n, sgl.len, true);
