From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 17/28] virtio: console: Add a new MULTIPORT feature,
	support for generic ports
Date: Sat, 28 Nov 2009 12:20:40 +0530
Message-ID: <1259391051-7752-18-git-send-email-amit.shah@redhat.com>
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
	<1259391051-7752-17-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-17-git-send-email-amit.shah@redhat.com>
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

This commit adds a new feature, MULTIPORT. If the host supports this
feature as well, the config space has the number of ports defined for
that device. New ports are spawned according to this information.

Using this feature, generic ports can be created which are not tied to
hvc consoles.

We also open up a private channel between the host and the guest via
which some "control" messages are exchanged for the ports, like whether
the port being spawned is a console port, resizing the console window,
etc.

Next commits will add support for hotplugging and presenting char
devices in /dev/ for bi-directional guest-host communication.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/Kconfig           |    8 ++
 drivers/char/virtio_console.c  |  187 ++++++++++++++++++++++++++++++++++++----
 include/linux/virtio_console.h |   27 ++++++-
 3 files changed, 202 insertions(+), 20 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 6aad99e..006b815 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -679,6 +679,14 @@ config VIRTIO_CONSOLE
 	help
 	  Virtio console for use with lguest and other hypervisors.
 
+	  Also serves as a general-purpose serial device for data
+	  transfer between the guest and host.  Character devices at
+	  /dev/vportNpn will be created when corresponding ports are
+	  found, where N is the device number and n is the port number
+	  within that device.  If specified by the host, a sysfs
+	  attribute called 'name' will be populated with a name for
+	  the port which can be used by udev scripts to create a
+	  symlink to the device.
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index def1678..a26781b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2006, 2007, 2009 Rusty Russell, IBM Corporation
+ * Copyright (C) 2009, Red Hat, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -84,14 +85,21 @@ struct ports_device {
 	 */
 	struct work_struct rx_work;
 
+	struct list_head ports_head;
 	struct list_head unused_read_head;
 	struct list_head unused_write_head;
 
+	/* To protect the list of ports */
+	spinlock_t ports_list_lock;
+
 	/* To protect the list of unused read buffers and the in_vq */
 	spinlock_t read_list_lock;
 
 	/* To protect the list of unused write buffers and the out_vq */
 	spinlock_t write_list_lock;
+
+	/* The current config space is stored here */
+	struct virtio_console_config config;
 };
 
 /* This struct holds individual buffers received for each port */
@@ -108,6 +116,9 @@ struct port_buffer {
 
 /* This struct holds the per-port data */
 struct port {
+	/* Next port in the list, head is in the ports_device */
+	struct list_head list;
+
 	/* Pointer to the parent virtio_console device */
 	struct ports_device *portdev;
 
@@ -126,6 +137,9 @@ struct port {
 	 * hooked up to an hvc console
 	 */
 	struct console cons;
+
+	/* The 'id' to identify the port with the Host */
+	u32 id;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -150,6 +164,28 @@ out:
 	return port;
 }
 
+static struct port *find_port_by_id(struct ports_device *portdev, u32 id)
+{
+	struct port *port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&portdev->ports_list_lock, flags);
+	list_for_each_entry(port, &portdev->ports_head, list)
+		if (port->id == id)
+			goto out;
+	port = NULL;
+out:
+	spin_unlock_irqrestore(&portdev->ports_list_lock, flags);
+	return port;
+}
+
+static bool is_console_port(struct port *port)
+{
+	if (port->cons.hvc)
+		return true;
+	return false;
+}
+
 static inline bool use_multiport(struct ports_device *portdev)
 {
 	/*
@@ -158,11 +194,16 @@ static inline bool use_multiport(struct ports_device *portdev)
 	 */
 	if (!portdev->vdev)
 		return 0;
-	/* Check for feature bit once multiport support has been added */
-	return 0;
+	return portdev->vdev->features[0] & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+}
+
+static inline bool is_control(u32 flags)
+{
+	return flags & VIRTIO_CONSOLE_HDR_CONTROL;
 }
 
-static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
+static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
+			u32 flags)
 {
 	struct scatterlist sg[1];
 	struct virtio_console_header header;
@@ -177,6 +218,16 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 		return 0;
 
 	out_vq = port->portdev->out_vq;
+
+	/*
+	 * We should not send control messages to a host that won't
+	 * understand them
+	 */
+	if (!use_multiport(port->portdev) && is_control(flags))
+		return 0;
+
+	header.id = port->id;
+	header.flags = flags;
 	header_len = use_multiport(port->portdev) ? sizeof(header) : 0;
 
 	in_offset = 0; /* offset in the user buffer */
@@ -229,6 +280,17 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 	return in_offset;
 }
 
+static ssize_t send_control_msg(struct port *port, unsigned int event,
+				unsigned int value)
+{
+	struct virtio_console_control cpkt;
+
+	cpkt.event = event;
+	cpkt.value = value;
+	return send_buf(port, (char *)&cpkt, sizeof(cpkt),
+			VIRTIO_CONSOLE_HDR_CONTROL);
+}
+
 /*
  * Give out the data that's requested from the buffers that we have
  * queued up.
@@ -293,7 +355,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
-	return send_buf(port, buf, count);
+	return send_buf(port, buf, count, 0);
 }
 
 /*
@@ -362,7 +424,7 @@ static void notifier_del_vio(struct hvc_struct *hp, int data)
 	hp->irq_requested = 0;
 }
 
-/* The operations for the console. */
+/* The operations for console ports. */
 static const struct hv_ops hv_ops = {
 	.get_chars = get_chars,
 	.put_chars = put_chars,
@@ -493,6 +555,35 @@ static void fill_receive_queue(struct ports_device *portdev)
 	spin_unlock(&portdev->read_list_lock);
 }
 
+/* Any private messages that the Host and Guest want to share */
+static void handle_control_message(struct port *port, struct port_buffer *buf)
+{
+	struct virtio_console_control *cpkt;
+
+	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
+
+	switch (cpkt->event) {
+	case VIRTIO_CONSOLE_CONSOLE_PORT:
+		if (!cpkt->value)
+			break;
+		if (is_console_port(port))
+			break;
+
+		init_port_console(port);
+		/*
+		 * Could remove the port here in case init fails - but
+		 * have to notify the host first.
+		 */
+		break;
+	case VIRTIO_CONSOLE_RESIZE:
+		if (!is_console_port(port))
+			break;
+		port->cons.hvc->irq_requested = 1;
+		resize_console(port);
+		break;
+	}
+}
+
 static void *get_incoming_buf(struct ports_device *portdev,
 			      unsigned int *len)
 {
@@ -523,21 +614,43 @@ static void rx_work_handler(struct work_struct *work)
 	portdev = container_of(work, struct ports_device, rx_work);
 	header_len = use_multiport(portdev) ? sizeof(header) : 0;
 
-	/* We currently have only one port */
-	port = find_port_by_vtermno(0);
 	while ((buf = get_incoming_buf(portdev, &tmplen))) {
-
+		header.id = 0;
 		if (use_multiport(portdev))
 			memcpy(&header, buf->buf, header_len);
 
+		port = find_port_by_id(portdev, header.id);
+		if (!port) {
+			/* No valid header at start of buffer. Drop it. */
+			dev_dbg(&portdev->vdev->dev,
+				"invalid index %u in header\n",	header.id);
+			/*
+			 * OPT: This buffer can be added to the unused
+			 * list to avoid free / alloc
+			 */
+			kfree(buf->buf);
+			kfree(buf);
+			continue;
+		}
 		buf->len = tmplen;
 		buf->offset = header_len;
 
+		if (use_multiport(portdev) && is_control(header.flags)) {
+			handle_control_message(port, buf);
+			/*
+			 * OPT: This buffer can be added to the unused
+			 * list to avoid free/alloc
+			 */
+			kfree(buf->buf);
+			kfree(buf);
+			continue;
+		}
 		spin_lock_irq(&port->readbuf_list_lock);
 		list_add_tail(&buf->list, &port->readbuf_head);
 		spin_unlock_irq(&port->readbuf_list_lock);
 
-		console_activity |= hvc_poll(port->cons.hvc);
+		if (is_console_port(port))
+			console_activity |= hvc_poll(port->cons.hvc);
 	}
 	if (console_activity)
 		hvc_kick();
@@ -587,7 +700,7 @@ static void tx_intr(struct virtqueue *vq)
 	spin_unlock_irqrestore(&portdev->write_list_lock, flags);
 }
 
-static int __devinit add_port(struct ports_device *portdev)
+static int __devinit add_port(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
 	int err;
@@ -598,13 +711,30 @@ static int __devinit add_port(struct ports_device *portdev)
 		goto fail;
 
 	port->portdev = portdev;
+	port->id = id;
 
 	spin_lock_init(&port->readbuf_list_lock);
 	INIT_LIST_HEAD(&port->readbuf_head);
 
-	err = init_port_console(port);
-	if (err)
-		goto free;
+	/*
+	 * If we're not using multiport support, this has to be a console port
+	 */
+	if (!use_multiport(port->portdev)) {
+		err = init_port_console(port);
+		if (err)
+			goto free;
+	}
+	spin_lock_irq(&portdev->ports_list_lock);
+	list_add_tail(&port->list, &port->portdev->ports_head);
+	spin_unlock_irq(&portdev->ports_list_lock);
+
+	/*
+	 * Tell the host we're set so that the Host can send us
+	 * various configuration parameters for this port (eg, port
+	 * name; caching, throttling parameters; whether this is a
+	 * console port, etc.)
+	 */
+	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 
 	return 0;
 free:
@@ -616,6 +746,10 @@ fail:
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
+ *
+ * If the host also supports multiple console ports, we check the
+ * config space to see how many ports the host has spawned.  We
+ * initialize each port found.
  */
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
@@ -623,7 +757,9 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	struct ports_device *portdev;
+	u32 i;
 	int err;
+	bool multiport;
 
 	err = -ENOMEM;
 	portdev = kzalloc(sizeof *portdev, GFP_KERNEL);
@@ -634,6 +770,18 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	portdev->vdev = vdev;
 	vdev->priv = portdev;
 
+	multiport = false;
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
+		multiport = true;
+		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
+
+		vdev->config->get(vdev, offsetof(struct virtio_console_config,
+						 nr_ports),
+				  &portdev->config.nr_ports,
+				  sizeof(portdev->config.nr_ports));
+	}
+	vdev->config->finalize_features(vdev);
+
 	/* Find the queues. */
 	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
 	if (err)
@@ -644,7 +792,9 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&portdev->read_list_lock);
 	spin_lock_init(&portdev->write_list_lock);
+	spin_lock_init(&portdev->ports_list_lock);
 
+	INIT_LIST_HEAD(&portdev->ports_head);
 	INIT_LIST_HEAD(&portdev->unused_read_head);
 	INIT_LIST_HEAD(&portdev->unused_write_head);
 
@@ -653,17 +803,15 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	fill_receive_queue(portdev);
 	alloc_write_bufs(portdev);
 
-	/* We only have one port. */
-	err = add_port(portdev);
-	if (err)
-		goto free_vqs;
+	add_port(portdev, 0);
+	if (multiport)
+		for (i = 1; i < portdev->config.nr_ports; i++)
+			add_port(portdev, i);
 
 	/* Start using the new console output. */
 	early_put_chars = NULL;
 	return 0;
 
-free_vqs:
-	vdev->config->del_vqs(vdev);
 free:
 	kfree(portdev);
 fail:
@@ -677,6 +825,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
+	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
 static struct virtio_driver virtio_console = {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 3dfc7d1..ad9557d 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -6,26 +6,51 @@
 /*
  * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
  * anyone can use the definitions to implement compatible drivers/servers.
+ *
+ * Copyright (C) Red Hat, Inc., 2009
  */
 
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
+#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 
 struct virtio_console_config {
 	/* colums of the screens */
 	__u16 cols;
 	/* rows of the screens */
 	__u16 rows;
+	/* number of ports added so far */
+	__u32 nr_ports;
 } __attribute__((packed));
 
 /*
+ * A message that's passed between the Host and the Guest for a
+ * particular port.
+ */
+struct virtio_console_control {
+	__u16 event;
+	__u16 value;
+};
+
+/* Some events for control messages */
+#define VIRTIO_CONSOLE_PORT_READY	0
+#define VIRTIO_CONSOLE_CONSOLE_PORT	1
+#define VIRTIO_CONSOLE_RESIZE		2
+
+/*
  * This struct is put at the start of each buffer that gets passed to
  * Host and vice-versa.
  */
 struct virtio_console_header {
-	/* Empty till multiport support is added */
+	/* Port number */
+	u32 id;
+	/* Some message between host and guest */
+	u32 flags;
 } __attribute__((packed));
 
+/* Messages between host and guest ('flags' field in the header above) */
+#define VIRTIO_CONSOLE_HDR_CONTROL	(1 << 0)
+
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
 #endif /* __KERNEL__ */
-- 
1.6.2.5
