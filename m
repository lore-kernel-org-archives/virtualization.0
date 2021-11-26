Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB74CC433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 16:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77D3C82AF5;
	Fri, 26 Nov 2021 16:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ML3w_L2Ij-ob; Fri, 26 Nov 2021 16:48:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1BD3982A7F;
	Fri, 26 Nov 2021 16:48:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 050F4C001E;
	Fri, 26 Nov 2021 16:48:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9AA0C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6E854010B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6RCoQB81K9K
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4E454018D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637945292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYsAcPSlRkl2DsuuqLF/X0qsnzjiIk9tSNjhgB+R1/g=;
 b=e6q6iJGfpFvaUnvmvYEYjMIsvlRnQiYKhS0LGxsboc0bOVDS0WwGwfMGFGIwoJvXdSBWju
 miPo3H3sKs8cCoJCORh3G5iK1CIM7zvTPvSmUfVdwXIH8ERAwpXx1mYaj7bNRG+yBgZtDS
 7JzPt4irUfxHNfJA/F2Y7RBEBeMAi5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-U1CIvzgBPm-r-3VL5h1SJw-1; Fri, 26 Nov 2021 11:48:11 -0500
X-MC-Unique: U1CIvzgBPm-r-3VL5h1SJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66294801B10;
 Fri, 26 Nov 2021 16:48:10 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.39.193.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ABA4604CC;
 Fri, 26 Nov 2021 16:48:03 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/2] vdpa: add driver_override support
Date: Fri, 26 Nov 2021 17:47:53 +0100
Message-Id: <20211126164753.181829-3-sgarzare@redhat.com>
In-Reply-To: <20211126164753.181829-1-sgarzare@redhat.com>
References: <20211126164753.181829-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

`driver_override` allows to control which of the vDPA bus drivers
binds to a vDPA device.

If `driver_override` is not set, the previous behaviour is followed:
devices use the first vDPA bus driver loaded (unless auto binding
is disabled).

Tested on Fedora 34 with driverctl(8):
  $ modprobe virtio-vdpa
  $ modprobe vhost-vdpa
  $ modprobe vdpa-sim-net

  $ vdpa dev add mgmtdev vdpasim_net name dev1

  # dev1 is attached to the first vDPA bus driver loaded
  $ driverctl -b vdpa list-devices
    dev1 virtio_vdpa

  $ driverctl -b vdpa set-override dev1 vhost_vdpa

  $ driverctl -b vdpa list-devices
    dev1 vhost_vdpa [*]

  Note: driverctl(8) integrates with udev so the binding is
  preserved.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- added documentation in Documentation/ABI/testing/sysfs-bus-vdpa
---
 include/linux/vdpa.h                     |  2 +
 drivers/vdpa/vdpa.c                      | 74 ++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-vdpa | 20 +++++++
 3 files changed, 96 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index c3011ccda430..ae34015b37b7 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
+ * @driver_override: driver name to force a match
  * @config: the configuration ops for this device.
  * @cf_mutex: Protects get and set access to configuration layout.
  * @index: device index
@@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
 struct vdpa_device {
 	struct device dev;
 	struct device *dma_dev;
+	const char *driver_override;
 	const struct vdpa_config_ops *config;
 	struct mutex cf_mutex; /* Protects get/set config */
 	unsigned int index;
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 7332a74a4b00..659231bbfee8 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
 		drv->remove(vdev);
 }
 
+static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
+{
+	struct vdpa_device *vdev = dev_to_vdpa(dev);
+
+	/* Check override first, and if set, only use the named driver */
+	if (vdev->driver_override)
+		return strcmp(vdev->driver_override, drv->name) == 0;
+
+	/* Currently devices must be supported by all vDPA bus drivers */
+	return 1;
+}
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct vdpa_device *vdev = dev_to_vdpa(dev);
+	const char *driver_override, *old;
+	char *cp;
+
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = vdev->driver_override;
+	if (strlen(driver_override)) {
+		vdev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		vdev->driver_override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct vdpa_device *vdev = dev_to_vdpa(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
+	device_unlock(dev);
+
+	return len;
+}
+static DEVICE_ATTR_RW(driver_override);
+
+static struct attribute *vdpa_dev_attrs[] = {
+	&dev_attr_driver_override.attr,
+	NULL,
+};
+
+static const struct attribute_group vdpa_dev_group = {
+	.attrs  = vdpa_dev_attrs,
+};
+__ATTRIBUTE_GROUPS(vdpa_dev);
+
 static struct bus_type vdpa_bus = {
 	.name  = "vdpa",
+	.dev_groups = vdpa_dev_groups,
+	.match = vdpa_dev_match,
 	.probe = vdpa_dev_probe,
 	.remove = vdpa_dev_remove,
 };
@@ -68,6 +141,7 @@ static void vdpa_release_dev(struct device *d)
 
 	ida_simple_remove(&vdpa_index_ida, vdev->index);
 	mutex_destroy(&vdev->cf_mutex);
+	kfree(vdev->driver_override);
 	kfree(vdev);
 }
 
diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI/testing/sysfs-bus-vdpa
index 4e55761a39df..28a6111202ba 100644
--- a/Documentation/ABI/testing/sysfs-bus-vdpa
+++ b/Documentation/ABI/testing/sysfs-bus-vdpa
@@ -35,3 +35,23 @@ Description:
 		Writing a device name to this file will cause the driver to
 		attempt to unbind from the device. This may be useful when
 		overriding default bindings.
+
+What:		/sys/bus/vdpa/devices/.../driver_override
+Date:		November 2021
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		This file allows the driver for a device to be specified.
+		When specified, only a driver with a name matching the value
+		written to driver_override will have an opportunity to bind to
+		the device. The override is specified by writing a string to the
+		driver_override file (echo vhost-vdpa > driver_override) and may
+		be cleared with an empty string (echo > driver_override).
+		This returns the device to standard matching rules binding.
+		Writing to driver_override does not automatically unbind the
+		device from its current driver or make any attempt to
+		automatically load the specified driver. If no driver with a
+		matching name is currently loaded in the kernel, the device will
+		not bind to any driver. This also allows devices to opt-out of
+		driver binding using a driver_override name such as "none".
+		Only a single driver may be specified in the override, there is
+		no support for parsing delimiters.
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
