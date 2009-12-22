From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 20/31] virtio: console: Introduce a 'header' for each buffer
	towards supporting multiport
Date: Tue, 22 Dec 2009 20:04:30 +0530
Message-ID: <1261492481-19817-21-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-5-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-6-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-7-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-8-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-9-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-10-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-11-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-12-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-13-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-14-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-15-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-16-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-17-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-18-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-19-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-20-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-20-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This header can contain flags that give buffers special meaning, for
example the first and last buffers of a single write request. This
enables the host to send out the data to host applications in a single
read request rather than splitting it up, which is how some applications
like their data to be received.

This header is put in by the host as well as the guest for all data
packets.

This header is currently a 0-length field. It will be populated when
multiport support is added.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   32 ++++++++++++++++++++++++++------
 include/linux/virtio_console.h |    7 +++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6509e62..9d55778 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -161,6 +161,18 @@ out:
 	return port;
 }
 
+static inline bool use_multiport(struct ports_device *portdev)
+{
+	/*
+	 * This condition can be true when put_chars is called from
+	 * early_init
+	 */
+	if (!portdev->vdev)
+		return 0;
+	/* Check for feature bit once multiport support is added */
+	return 0;
+}
+
 static void free_buf(struct port_buffer *buf)
 {
 	kfree(buf->buf);
@@ -199,7 +211,8 @@ static void *get_inbuf(struct port *port)
 	buf = vq->vq_ops->get_buf(vq, &len);
 	if (buf) {
 		buf->len = len;
-		buf->offset = 0;
+		buf->offset = use_multiport(port->portdev)
+			? sizeof(struct virtio_console_header) : 0;
 	}
 	return buf;
 }
@@ -246,27 +259,34 @@ out:
 static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 {
 	struct scatterlist sg[1];
+	struct virtio_console_header header;
 	struct virtqueue *out_vq;
 	struct port_buffer *buf;
 	size_t in_offset, copy_size;
 	ssize_t ret;
-	unsigned int tmplen;
+	unsigned int header_len, tmplen;
 
 	out_vq = port->out_vq;
 	buf = port->outbuf;
 
+	header_len = use_multiport(port->portdev) ? sizeof(header) : 0;
+
 	in_offset = 0; /* offset in the user buffer */
 	while (in_offset < in_count) {
-		copy_size = min(in_count - in_offset, buf->size);
+		copy_size = min(in_count - in_offset + header_len, buf->size);
+		copy_size -= header_len;
 		/*
 		 * Since we're not sure when the host will actually
 		 * consume the data and tell us about it, we have
 		 * to copy the data here in case the caller
 		 * frees the in_buf
 		 */
-		memcpy(buf->buf, in_buf + in_offset, copy_size);
+		memcpy(buf->buf + header_len, in_buf + in_offset, copy_size);
+
+		buf->len = header_len + copy_size;
 
-		buf->len = copy_size;
+		if (header_len)
+			memcpy(buf->buf, &header, header_len);
 
 		sg_init_one(sg, buf->buf, buf->len);
 		ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
@@ -277,7 +297,7 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 		if (ret < 0)
 			break;
 
-		in_offset += buf->len;
+		in_offset += buf->len - header_len;
 		while (!out_vq->vq_ops->get_buf(out_vq, &tmplen))
 			cpu_relax();
 	}
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 9e0da40..7ea5372 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -18,6 +18,13 @@ struct virtio_console_config {
 	__u16 rows;
 } __attribute__((packed));
 
+/*
+ * This struct is put at the start of each data buffer that gets
+ * passed to Host and vice-versa.
+ */
+struct virtio_console_header {
+	/* Empty till multiport support is added */
+};
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
