From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 22/28] virtio: console: Register with sysfs and create a
	'name' attribute for ports
Date: Sat, 28 Nov 2009 12:20:45 +0530
Message-ID: <1259391051-7752-23-git-send-email-amit.shah@redhat.com>
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
	<1259391051-7752-18-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-19-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-20-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-21-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-22-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-22-git-send-email-amit.shah@redhat.com>
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

The host can set a name for ports so that they're easily discoverable
instead of going by the /dev/vportNpn naming. This attribute will be
placed in /sys/class/vportdevN/vportNpn/name. udev scripts can then
create symlinks to the port using the name.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   58 ++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_console.h |    1 +
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3a305f8..d0bdc18 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -163,6 +163,9 @@ struct port {
 	 */
 	struct console cons;
 
+	/* The 'name' of the port that we expose via sysfs properties */
+	char *name;
+
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 
@@ -745,10 +748,14 @@ static void fill_receive_queue(struct ports_device *portdev)
 	spin_unlock(&portdev->read_list_lock);
 }
 
+static struct attribute_group port_attribute_group;
+
 /* Any private messages that the Host and Guest want to share */
 static void handle_control_message(struct port *port, struct port_buffer *buf)
 {
 	struct virtio_console_control *cpkt;
+	size_t name_size;
+	int err;
 
 	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
 
@@ -775,6 +782,35 @@ static void handle_control_message(struct port *port, struct port_buffer *buf)
 		port->host_connected = cpkt->value;
 		wake_up_interruptible(&port->waitqueue);
 		break;
+	case VIRTIO_CONSOLE_PORT_NAME:
+		/*
+		 * Skip the size of the header and the cpkt to get the size
+		 * of the name that was sent
+		 */
+		name_size = buf->len - buf->offset - sizeof(*cpkt) + 1;
+
+		port->name = kmalloc(name_size, GFP_KERNEL);
+		if (!port->name) {
+			dev_err(port->dev,
+				"not enough space to store port name\n");
+			break;
+		}
+		strncpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
+			name_size - 1);
+		port->name[name_size - 1] = 0;
+
+		/*
+		 * Since we only have one sysfs attribute, 'name',
+		 * create it only if we have a name for the port.
+		 */
+		err = sysfs_create_group(&port->dev->kobj,
+					 &port_attribute_group);
+		if (err)
+			dev_err(port->dev,
+				"error creating sysfs device attributes, ret = %d\n",
+				err);
+
+		break;
 	}
 }
 
@@ -902,6 +938,28 @@ static void tx_intr(struct virtqueue *vq)
 	spin_unlock_irqrestore(&portdev->write_list_lock, flags);
 }
 
+static ssize_t show_port_name(struct device *dev,
+			      struct device_attribute *attr, char *buffer)
+{
+	struct port *port;
+
+	port = dev_get_drvdata(dev);
+
+	return sprintf(buffer, "%s\n", port->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_port_name, NULL);
+
+static struct attribute *port_sysfs_entries[] = {
+	&dev_attr_name.attr,
+	NULL
+};
+
+static struct attribute_group port_attribute_group = {
+	.name = NULL,		/* put in device directory */
+	.attrs = port_sysfs_entries,
+};
+
 static int __devinit add_port(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 14af53d..d65fdb5 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -37,6 +37,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_CONSOLE_PORT	1
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
+#define VIRTIO_CONSOLE_PORT_NAME	4
 
 /*
  * This struct is put at the start of each buffer that gets passed to
-- 
1.6.2.5
