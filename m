From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: [RFC PATCH 2/6] virtio/console: Add a failback for unstealable pipe
	buffer
Date: Tue, 24 Jul 2012 11:37:18 +0900
Message-ID: <20120724023718.6600.68836.stgit@ltc189.sdl.hitachi.co.jp>
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

Add a failback memcpy path for unstealable pipe buffer.
If buf->ops->steal() fails, virtio-serial tries to
copy the page contents to an allocated page, instead
of just failing splice().

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 drivers/char/virtio_console.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fe31b2f..911cb3e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -794,7 +794,7 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 			struct splice_desc *sd)
 {
 	struct sg_list *sgl = sd->u.data;
-	unsigned int len = 0;
+	unsigned int offset, len;
 
 	if (sgl->n == MAX_SPLICE_PAGES)
 		return 0;
@@ -807,9 +807,31 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 
 		len = min(buf->len, sd->len);
 		sg_set_page(&(sgl->sg[sgl->n]), buf->page, len, buf->offset);
-		sgl->n++;
-		sgl->len += len;
+	} else {
+		/* Failback to copying a page */
+		struct page *page = alloc_page(GFP_KERNEL);
+		char *src = buf->ops->map(pipe, buf, 1);
+		char *dst;
+
+		if (!page)
+			return -ENOMEM;
+		dst = kmap(page);
+
+		offset = sd->pos & ~PAGE_MASK;
+
+		len = sd->len;
+		if (len + offset > PAGE_SIZE)
+			len = PAGE_SIZE - offset;
+
+		memcpy(dst + offset, src + buf->offset, len);
+
+		kunmap(page);
+		buf->ops->unmap(pipe, buf, src);
+
+		sg_set_page(&(sgl->sg[sgl->n]), page, len, offset);
 	}
+	sgl->n++;
+	sgl->len += len;
 
 	return len;
 }
