From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 16/28] virtio: console: Introduce a 'header' for each buffer
	towards supporting multiport
Date: Sat, 28 Nov 2009 12:20:39 +0530
Message-ID: <1259391051-7752-17-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-11-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-15-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-16-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-16-git-send-email-amit.shah@redhat.com>
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

To identify which port data that gets sent to the Host belongs to, we'll
have to add a 'header' to each outgoing buffer that will tell the Host
the port number.

This is also done for each buffer that's received from userspace.

The header is currently a 0-length field, but will contain the port id
among other things when support for multiple ports per device is added.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   37 +++++++++++++++++++++++++++++++------
 include/linux/virtio_console.h |    7 +++++++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 64a927c..def1678 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -150,24 +150,39 @@ out:
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
+	/* Check for feature bit once multiport support has been added */
+	return 0;
+}
+
 static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 {
 	struct scatterlist sg[1];
+	struct virtio_console_header header;
 	struct virtqueue *out_vq;
 	struct port_buffer *buf;
 	size_t in_offset, copy_size;
 	ssize_t ret;
 	unsigned long irqf;
+	unsigned int header_len;
 
 	if (!in_count)
 		return 0;
 
 	out_vq = port->portdev->out_vq;
+	header_len = use_multiport(port->portdev) ? sizeof(header) : 0;
 
 	in_offset = 0; /* offset in the user buffer */
 	spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
 	while (in_count - in_offset) {
-		copy_size = min(in_count - in_offset, PAGE_SIZE);
+		copy_size = min(in_count - in_offset + header_len, PAGE_SIZE);
 
 		if (list_empty(&port->portdev->unused_write_head))
 			break;
@@ -177,15 +192,19 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 		list_del(&buf->list);
 		spin_unlock_irqrestore(&port->portdev->write_list_lock, irqf);
 
+		if (header_len) {
+			memcpy(buf->buf, &header, header_len);
+			copy_size -= header_len;
+		}
 		/*
 		 * Since we're not sure when the host will actually
 		 * consume the data and tell us about it, we have
 		 * to copy the data here in case the caller
 		 * frees the in_buf
 		 */
-		memcpy(buf->buf, in_buf + in_offset, copy_size);
+		memcpy(buf->buf + header_len, in_buf + in_offset, copy_size);
 
-		buf->len = copy_size;
+		buf->len = header_len + copy_size;
 		sg_init_one(sg, buf->buf, buf->len);
 
 		spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
@@ -196,7 +215,7 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 				      &port->portdev->unused_write_head);
 			break;
 		}
-		in_offset += buf->len;
+		in_offset += buf->len - header_len;
 
 		/* No space left in the vq anyway */
 		if (!ret)
@@ -494,19 +513,25 @@ static void *get_incoming_buf(struct ports_device *portdev,
 
 static void rx_work_handler(struct work_struct *work)
 {
+	struct virtio_console_header header;
 	struct ports_device *portdev;
 	struct port *port;
 	struct port_buffer *buf;
-	unsigned int tmplen;
+	unsigned int tmplen, header_len;
 	bool console_activity = false;
 
 	portdev = container_of(work, struct ports_device, rx_work);
+	header_len = use_multiport(portdev) ? sizeof(header) : 0;
 
 	/* We currently have only one port */
 	port = find_port_by_vtermno(0);
 	while ((buf = get_incoming_buf(portdev, &tmplen))) {
+
+		if (use_multiport(portdev))
+			memcpy(&header, buf->buf, header_len);
+
 		buf->len = tmplen;
-		buf->offset = 0;
+		buf->offset = header_len;
 
 		spin_lock_irq(&port->readbuf_list_lock);
 		list_add_tail(&buf->list, &port->readbuf_head);
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 9e0da40..3dfc7d1 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -18,6 +18,13 @@ struct virtio_console_config {
 	__u16 rows;
 } __attribute__((packed));
 
+/*
+ * This struct is put at the start of each buffer that gets passed to
+ * Host and vice-versa.
+ */
+struct virtio_console_header {
+	/* Empty till multiport support is added */
+} __attribute__((packed));
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
