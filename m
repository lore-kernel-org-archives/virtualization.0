From: Stephen Hemminger <shemminger@vyatta.com>
Subject: [PATCH] virtio: fix format of sysfs driver/vendor files
Date: Tue, 9 Nov 2010 22:20:29 -0800
Message-ID: <20101109222029.65f3e192@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The sysfs files for virtio produce the wrong format and are missing
the required newline. The output for virtio bus vendor/device should
have the same format as the corresponding entries for PCI devices.

Although this technically changes the ABI for sysfs, these files were
broken to start with!

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>


--- a/drivers/virtio/virtio.c	2010-11-09 21:39:31.713916249 -0800
+++ b/drivers/virtio/virtio.c	2010-11-09 21:40:16.072089461 -0800
@@ -9,19 +9,19 @@ static ssize_t device_show(struct device
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
-	return sprintf(buf, "%hu", dev->id.device);
+	return sprintf(buf, "0x%04x\n", dev->id.device);
 }
 static ssize_t vendor_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
-	return sprintf(buf, "%hu", dev->id.vendor);
+	return sprintf(buf, "0x%04x\n", dev->id.vendor);
 }
 static ssize_t status_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
-	return sprintf(buf, "0x%08x", dev->config->get_status(dev));
+	return sprintf(buf, "0x%08x\n", dev->config->get_status(dev));
 }
 static ssize_t modalias_show(struct device *_d,
 			     struct device_attribute *attr, char *buf)
