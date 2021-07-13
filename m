Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75792C07E95
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 16:19:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270E161166
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 16:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270E161166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED58C60ABC;
	Tue, 13 Jul 2021 16:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cPnvQt5jDAhD; Tue, 13 Jul 2021 16:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 391A360AC4;
	Tue, 13 Jul 2021 16:19:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DF36C0010;
	Tue, 13 Jul 2021 16:19:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1B16C0010
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAA1383264
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLB4bDgIfaud
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E1E682D75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626193161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hdgt87jDYVPvBMHlz3oOFZWil5KClrfBwnUpI6smyYE=;
 b=RxFFvjGh7HEILsBOonncHJDid5zOBa3LK7TYnezNYYyruxGH7ARRsyyPWQdVK1xFhiXW9g
 vJPKRDypY0h8oOeGmRllVV9R1BwEH2DUqpmkbFOhzzHXyIzny/j23ZzRF5xtEv0ihjSnpi
 1MEVjBZalX26macJpNTuHXCydAmhdZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-spjfYe4aPiyycmVJ66oQdA-1; Tue, 13 Jul 2021 12:19:20 -0400
X-MC-Unique: spjfYe4aPiyycmVJ66oQdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63A9610766D5;
 Tue, 13 Jul 2021 16:19:18 +0000 (UTC)
Received: from localhost (ovpn-112-172.ams2.redhat.com [10.36.112.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C53EA5D9CA;
 Tue, 13 Jul 2021 16:19:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 2/3] virtio: add poll_source virtqueue polling
Date: Tue, 13 Jul 2021 17:19:05 +0100
Message-Id: <20210713161906.457857-3-stefanha@redhat.com>
In-Reply-To: <20210713161906.457857-1-stefanha@redhat.com>
References: <20210713161906.457857-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

VIRTIO drivers can cheaply disable interrupts by setting
RING_EVENT_FLAGS_DISABLE in the packed virtqueues's Driver Event
Suppression structure. See "2.7.10 Driver and Device Event Suppression"
in the VIRTIO 1.1 specification for details
(https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.html).

Add a per-virtqueue poll_source that disables events in ->start(),
processes completed virtqueue buffers in ->poll(), and re-enables events
in ->stop().

This optimization avoids interrupt injection during cpuidle polling.
Workloads that submit requests and then halt the vCPU until completion
benefit from this.

To enable this optimization:

1. Enable the cpuidle haltpoll driver:
   https://www.kernel.org/doc/html/latest/virt/guest-halt-polling.html

2. Enable poll_source on the virtio device:
   # echo -n 1 > /sys/block/vda/device/poll_source

Note that this feature currently as no effect on split virtqueues when
VIRTIO_F_EVENT_IDX is negotiated. It may be possible to tweak
virtqueue_disable_cb_split() but I haven't attempted it here.

This optimization has been benchmarked successfully with virtio-blk
devices. Currently it does not improve virtio-net performance, probably
because it doesn't combine with NAPI polling.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/virtio/virtio_pci_common.h |  7 +++
 include/linux/virtio.h             |  2 +
 include/linux/virtio_config.h      |  2 +
 drivers/virtio/virtio.c            | 34 ++++++++++++
 drivers/virtio/virtio_pci_common.c | 86 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_modern.c |  2 +
 6 files changed, 133 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index beec047a8f8d..630746043183 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/poll_source.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
@@ -38,6 +39,9 @@ struct virtio_pci_vq_info {
 
 	/* MSI-X vector (or none) */
 	unsigned msix_vector;
+
+	/* the cpuidle poll_source */
+	struct poll_source poll_source;
 };
 
 /* Our device structure */
@@ -102,6 +106,9 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 	return container_of(vdev, struct virtio_pci_device, vdev);
 }
 
+/* enable poll_source API for vq polling */
+int vp_enable_poll_source(struct virtio_device *vdev, bool enable);
+
 /* wait for pending irq handlers */
 void vp_synchronize_vectors(struct virtio_device *vdev);
 /* the notify function used when creating a virt queue */
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..baaa3c8fadb1 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -93,6 +93,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
+ * @poll_source_enabled: poll_source API enabled for vq polling
  * @config_enabled: configuration change reporting enabled
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
@@ -107,6 +108,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
 struct virtio_device {
 	int index;
 	bool failed;
+	bool poll_source_enabled;
 	bool config_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8519b3ae5d52..5fb78d56fd44 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -72,6 +72,7 @@ struct virtio_shm_region {
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
  * @get_shm_region: get a shared memory region based on the index.
+ * @enable_poll_source: enable/disable poll_source API vq polling (optional).
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -97,6 +98,7 @@ struct virtio_config_ops {
 			int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
+	int (*enable_poll_source)(struct virtio_device *dev, bool enable);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..22fee71bbe34 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -59,12 +59,44 @@ static ssize_t features_show(struct device *_d,
 }
 static DEVICE_ATTR_RO(features);
 
+static ssize_t poll_source_show(struct device *_d,
+				struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	return sprintf(buf, "%d\n", dev->poll_source_enabled);
+}
+
+static ssize_t poll_source_store(struct device *_d,
+		                 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	if (val == dev->poll_source_enabled)
+		return count;
+	if (!dev->config->enable_poll_source)
+		return -ENOTSUPP;
+
+	rc = dev->config->enable_poll_source(dev, val);
+	if (rc)
+		return rc;
+	return count;
+}
+static DEVICE_ATTR_RW(poll_source);
+
 static struct attribute *virtio_dev_attrs[] = {
 	&dev_attr_device.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_status.attr,
 	&dev_attr_modalias.attr,
 	&dev_attr_features.attr,
+	&dev_attr_poll_source.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(virtio_dev);
@@ -343,6 +375,8 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
 
+	dev->poll_source_enabled = false;
+
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 222d630c41fc..6de372e12afb 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -24,6 +24,83 @@ MODULE_PARM_DESC(force_legacy,
 		 "Force legacy mode for transitional virtio 1 devices");
 #endif
 
+static void vp_poll_source_start(struct poll_source *src)
+{
+	struct virtio_pci_vq_info *info =
+		container_of(src, struct virtio_pci_vq_info, poll_source);
+
+	/* This API does not require a lock */
+	virtqueue_disable_cb(info->vq);
+}
+
+static void vp_poll_source_stop(struct poll_source *src)
+{
+	struct virtio_pci_vq_info *info =
+		container_of(src, struct virtio_pci_vq_info, poll_source);
+
+	/* Poll one last time in case */
+	/* TODO allow driver to provide spinlock */
+	if (!virtqueue_enable_cb(info->vq))
+		vring_interrupt(0 /* ignored */, info->vq);
+}
+
+static void vp_poll_source_poll(struct poll_source *src)
+{
+	struct virtio_pci_vq_info *info =
+		container_of(src, struct virtio_pci_vq_info, poll_source);
+
+	vring_interrupt(0 /* ignored */, info->vq);
+}
+
+static const struct poll_source_ops vp_poll_source_ops = {
+	.start = vp_poll_source_start,
+	.stop = vp_poll_source_stop,
+	.poll = vp_poll_source_poll,
+};
+
+/* call this when irq affinity changes to update cpuidle poll_source */
+/* TODO this function waits for a smp_call_function_single() completion, is that allowed in all caller contexts? */
+/* TODO this function is not thread-safe, do all callers hold the same lock? */
+static int vp_update_poll_source(struct virtio_device *vdev, int index)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct poll_source *src = &vp_dev->vqs[index]->poll_source;
+	const struct cpumask *mask;
+
+	if (!list_empty(&src->node))
+		poll_source_unregister(src);
+
+	if (!vdev->poll_source_enabled)
+		return 0;
+
+	mask = vp_get_vq_affinity(vdev, index);
+	if (!mask)
+		return -ENOTTY;
+
+	/* Update the poll_source cpu */
+	src->cpu = cpumask_first(mask);
+
+	/* Don't use poll_source if interrupts are handled on multiple CPUs */
+	if (cpumask_next(src->cpu, mask) < nr_cpu_ids)
+		return 0;
+
+	return poll_source_register(src);
+}
+
+/* TODO add this to virtio_pci_legacy config ops? */
+int vp_enable_poll_source(struct virtio_device *vdev, bool enable)
+{
+	struct virtqueue *vq;
+
+	vdev->poll_source_enabled = enable;
+
+	/* TODO locking */
+	list_for_each_entry(vq, &vdev->vqs, list) {
+		vp_update_poll_source(vdev, vq->index); /* TODO handle errors? */
+	}
+	return 0;
+}
+
 /* wait for pending irq handlers */
 void vp_synchronize_vectors(struct virtio_device *vdev)
 {
@@ -186,6 +263,9 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned index,
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
+	info->poll_source.ops = &vp_poll_source_ops;
+	INIT_LIST_HEAD(&info->poll_source.node);
+
 	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
 			      msix_vec);
 	if (IS_ERR(vq))
@@ -237,6 +317,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 				int irq = pci_irq_vector(vp_dev->pci_dev, v);
 
 				irq_set_affinity_hint(irq, NULL);
+				vp_update_poll_source(vdev, vq->index);
 				free_irq(irq, vq);
 			}
 		}
@@ -342,6 +423,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 				  vqs[i]);
 		if (err)
 			goto error_find;
+
+		if (desc)
+			vp_update_poll_source(vdev, i);
 	}
 	return 0;
 
@@ -440,6 +524,8 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 			cpumask_copy(mask, cpu_mask);
 			irq_set_affinity_hint(irq, mask);
 		}
+
+		vp_update_poll_source(vdev, vq->index);
 	}
 	return 0;
 }
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 30654d3a0b41..417d568590f2 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -394,6 +394,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
 	.get_shm_region  = vp_get_shm_region,
+	.enable_poll_source = vp_enable_poll_source,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -411,6 +412,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
 	.get_shm_region  = vp_get_shm_region,
+	.enable_poll_source = vp_enable_poll_source,
 };
 
 /* the PCI probing function */
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
