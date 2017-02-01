From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] virtio-console: avoid DMA from stack
Date: Wed,  1 Feb 2017 00:02:27 -0800
Message-ID: <075115ddd99246ffc4228a3e050ba68eb36c6a8c.1485935920.git.osandov@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Omar Sandoval <osandov@fb.com>

put_chars() stuffs the buffer it gets into an sg, but that buffer may be
on the stack. This breaks with CONFIG_VMAP_STACK=y (for me, it
manifested as printks getting turned into NUL bytes).

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Patch based on v4.10-rc6.

 drivers/char/virtio_console.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 17857beb4892..3cbf4c95e446 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1136,6 +1136,8 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 {
 	struct port *port;
 	struct scatterlist sg[1];
+	void *data;
+	int ret;
 
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
@@ -1144,8 +1146,14 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (!port)
 		return -EPIPE;
 
-	sg_init_one(sg, buf, count);
-	return __send_to_port(port, sg, 1, count, (void *)buf, false);
+	data = kmemdup(buf, count, GFP_ATOMIC);
+	if (!data)
+		return -ENOMEM;
+
+	sg_init_one(sg, data, count);
+	ret = __send_to_port(port, sg, 1, count, data, false);
+	kfree(data);
+	return ret;
 }
 
 /*
-- 
2.11.0
