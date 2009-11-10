From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 10/15] virtio_console: Register with sysfs and create a 'name'
	attribute
Date: Tue, 10 Nov 2009 15:11:36 +0530
Message-ID: <1257846101-23258-11-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-6-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-7-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-8-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-9-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-10-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-10-git-send-email-amit.shah@redhat.com>
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

A name property, if set by the host, is exposed in

    /sys/class/virtio-console/vconNN/name

that can be used to create symlinks by udev scripts, example:

    /dev/vcon/org.libvirt.channel.0  -> /dev/vcon1

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3458340..c3498ec 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -153,6 +153,17 @@ static struct virtio_console_port *get_port_from_vtermno(u32 vtermno)
 	return NULL;
 }
 
+static struct virtio_console_port *get_port_from_devt(dev_t devt)
+{
+	struct virtio_console_port *port;
+
+	list_for_each_entry(port, &virtconsole.port_head, list) {
+		if (port->dev->devt == devt)
+			return port;
+	}
+	return NULL;
+}
+
 static struct virtio_console_port *get_port_from_id(u32 id)
 {
 	struct virtio_console_port *port;
@@ -883,6 +894,30 @@ static void config_intr(struct virtio_device *vdev)
 	virtcons_apply_config(get_port_from_id(0));
 }
 
+static ssize_t show_port_name(struct device *dev,
+			      struct device_attribute *attr, char *buffer)
+{
+	struct virtio_console_port *port;
+
+	port = get_port_from_devt(dev->devt);
+	if (!port || !port->name)
+		return 0;
+
+	return sprintf(buffer, "%s\n", port->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_port_name, NULL);
+
+static struct attribute *virtcon_sysfs_entries[] = {
+	&dev_attr_name.attr,
+	NULL
+};
+
+static struct attribute_group virtcon_attribute_group = {
+	.name = NULL,		/* put in device directory */
+	.attrs = virtcon_sysfs_entries,
+};
+
 static int virtconsole_add_port(u32 port_nr)
 {
 	struct virtio_console_port *port;
@@ -917,6 +952,12 @@ static int virtconsole_add_port(u32 port_nr)
 		pr_err("%s: error creating device, ret = %d\n", __func__, ret);
 		goto free_cdev;
 	}
+	ret = sysfs_create_group(&port->dev->kobj, &virtcon_attribute_group);
+	if (ret) {
+		pr_err("%s: error creating sysfs device attributes, ret = %d\n",
+		       __func__, ret);
+		goto free_cdev;
+	}
 	/*
 	 * If we're not using multiport support, this has to be a console port
 	 */
-- 
1.6.2.5
