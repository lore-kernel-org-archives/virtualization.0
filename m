From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 25/32] virtio: console: Register with sysfs and create a
	'name' attribute for ports
Date: Mon, 18 Jan 2010 19:15:19 +0530
Message-ID: <1263822326-24208-26-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-10-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-11-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-12-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-13-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-14-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-15-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-16-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-17-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-18-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-19-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-20-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-21-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-22-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-23-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-24-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-25-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-25-git-send-email-amit.shah@redhat.com>
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
placed in /sys/class/virtio-ports/vportNpn/name. udev scripts can then
create symlinks to the port using the name.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   57 ++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_console.h |    1 +
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 49cd185..e76eacf 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -176,6 +176,9 @@ struct port {
 	/* A waitqueue for poll() or blocking read operations */
 	wait_queue_head_t waitqueue;
 
+	/* The 'name' of the port that we expose via sysfs properties */
+	char *name;
+
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 
@@ -746,12 +749,36 @@ int init_port_console(struct port *port)
 	return 0;
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
 /* Any private messages that the Host and Guest want to share */
 static void handle_control_message(struct ports_device *portdev,
 				   struct port_buffer *buf)
 {
 	struct virtio_console_control *cpkt;
 	struct port *port;
+	size_t name_size;
+	int err;
 
 	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
 
@@ -786,6 +813,35 @@ static void handle_control_message(struct ports_device *portdev,
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
+				"Not enough space to store port name\n");
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
+				"Error %d creating sysfs device attributes\n",
+				err);
+
+		break;
 	}
 }
 
@@ -883,6 +939,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->portdev = portdev;
 	port->id = id;
 
+	port->name = NULL;
 	port->inbuf = NULL;
 	port->cons.hvc = NULL;
 
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 6a76a44..13e56c8 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -40,6 +40,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_CONSOLE_PORT	1
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
+#define VIRTIO_CONSOLE_PORT_NAME	4
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
