Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D0C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1552336D
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1552336D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 23C6187319;
	Wed, 16 Dec 2020 06:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3bdgcGxLSOAV; Wed, 16 Dec 2020 06:49:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 576C6872EE;
	Wed, 16 Dec 2020 06:49:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EAEFC0893;
	Wed, 16 Dec 2020 06:49:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9909BC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 86ED786735
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6IsqA6NgcQ1x
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6831C865AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9ppAgPjY/FxJKVaQ6BCXkGpxrYyI+WO7XOUHYOXZbg=;
 b=EYd0CcUN1JyEift/ULwQpof3L8Q3tw6vGVVyzfhBEBepmb3QJj1Yxoy6n/KdR4zLMy9neT
 +zpPLlrEzUFlOSDKCfDZ0BRb5pdx6CuSo8I7l1pQ/EMluSUOfGzLxJ0kZvCeI+/sgv4aKe
 kbb4TRs2t3Sl4xhb4PeeJmg8bBWynq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-PZNyQY6QN5ysvwyBeh8m_Q-1; Wed, 16 Dec 2020 01:49:12 -0500
X-MC-Unique: PZNyQY6QN5ysvwyBeh8m_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 002AB180A092;
 Wed, 16 Dec 2020 06:49:11 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA48510023B8;
 Wed, 16 Dec 2020 06:49:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 06/21] vdpa: introduce virtqueue groups
Date: Wed, 16 Dec 2020 14:48:03 +0800
Message-Id: <20201216064818.48239-7-jasowang@redhat.com>
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

This patch introduces virtqueue groups to vDPA device. The virtqueue
group is the minimal set of virtqueues that must share an address
space. And the adddress space identifier could only be attached to
a specific virtqueue group.

A new mandated bus operation is introduced to get the virtqueue group
ID for a specific virtqueue.

All the vDPA device drivers were converted to simply support a single
virtqueue group.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c   |  9 ++++++++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  8 +++++++-
 drivers/vdpa/vdpa.c               |  4 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c  | 11 ++++++++++-
 include/linux/vdpa.h              | 12 +++++++++---
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 8b4028556cb6..c629f4fcc738 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -332,6 +332,11 @@ static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
 	return IFCVF_QUEUE_ALIGNMENT;
 }
 
+static u32 ifcvf_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	return 0;
+}
+
 static void ifcvf_vdpa_get_config(struct vdpa_device *vdpa_dev,
 				  unsigned int offset,
 				  void *buf, unsigned int len)
@@ -392,6 +397,7 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
 	.get_device_id	= ifcvf_vdpa_get_device_id,
 	.get_vendor_id	= ifcvf_vdpa_get_vendor_id,
 	.get_vq_align	= ifcvf_vdpa_get_vq_align,
+	.get_vq_group	= ifcvf_vdpa_get_vq_group,
 	.get_config	= ifcvf_vdpa_get_config,
 	.set_config	= ifcvf_vdpa_set_config,
 	.set_config_cb  = ifcvf_vdpa_set_config_cb,
@@ -439,7 +445,8 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
 				    dev, &ifc_vdpa_ops,
-				    IFCVF_MAX_QUEUE_PAIRS * 2);
+				    IFCVF_MAX_QUEUE_PAIRS * 2, 1);
+
 	if (adapter == NULL) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return -ENOMEM;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1fa6fcac8299..719b52fcc547 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1436,6 +1436,11 @@ static u32 mlx5_vdpa_get_vq_align(struct vdpa_device *vdev)
 	return PAGE_SIZE;
 }
 
+static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	return 0;
+}
+
 enum { MLX5_VIRTIO_NET_F_GUEST_CSUM = 1 << 9,
 	MLX5_VIRTIO_NET_F_CSUM = 1 << 10,
 	MLX5_VIRTIO_NET_F_HOST_TSO6 = 1 << 11,
@@ -1854,6 +1859,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.get_vq_notification = mlx5_get_vq_notification,
 	.get_vq_irq = mlx5_get_vq_irq,
 	.get_vq_align = mlx5_vdpa_get_vq_align,
+	.get_vq_group = mlx5_vdpa_get_vq_group,
 	.get_features = mlx5_vdpa_get_features,
 	.set_features = mlx5_vdpa_set_features,
 	.set_config_cb = mlx5_vdpa_set_config_cb,
@@ -1941,7 +1947,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 2 * mlx5_vdpa_max_qps(max_vqs));
+				 2 * mlx5_vdpa_max_qps(max_vqs), 1);
 	if (IS_ERR(ndev))
 		return ndev;
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index a69ffc991e13..46399746ec7c 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -62,6 +62,7 @@ static void vdpa_release_dev(struct device *d)
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
  * @nvqs: number of virtqueues supported by this device
+ * @ngroups: number of groups supported by this device
  * @size: size of the parent structure that contains private data
  *
  * Driver should use vdpa_alloc_device() wrapper macro instead of
@@ -72,7 +73,7 @@ static void vdpa_release_dev(struct device *d)
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					int nvqs,
+					int nvqs, unsigned int ngroups,
 					size_t size)
 {
 	struct vdpa_device *vdev;
@@ -100,6 +101,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->config = config;
 	vdev->features_valid = false;
 	vdev->nvqs = nvqs;
+	vdev->ngroups = ngroups;
 
 	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
 	if (err)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..5d554b3cd152 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -80,6 +80,7 @@ struct vdpasim {
 	u32 status;
 	u32 generation;
 	u64 features;
+	u32 groups;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
 };
@@ -357,7 +358,8 @@ static struct vdpasim *vdpasim_create(void)
 	else
 		ops = &vdpasim_net_config_ops;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
+				    VDPASIM_VQ_NUM, 1);
 	if (!vdpasim)
 		goto err_alloc;
 
@@ -496,6 +498,11 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 	return VDPASIM_QUEUE_ALIGN;
 }
 
+static u32 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	return 0;
+}
+
 static u64 vdpasim_get_features(struct vdpa_device *vdpa)
 {
 	return vdpasim_features;
@@ -671,6 +678,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.set_vq_state           = vdpasim_set_vq_state,
 	.get_vq_state           = vdpasim_get_vq_state,
 	.get_vq_align           = vdpasim_get_vq_align,
+	.get_vq_group           = vdpasim_get_vq_group,
 	.get_features           = vdpasim_get_features,
 	.set_features           = vdpasim_set_features,
 	.set_config_cb          = vdpasim_set_config_cb,
@@ -698,6 +706,7 @@ static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
 	.set_vq_state           = vdpasim_set_vq_state,
 	.get_vq_state           = vdpasim_get_vq_state,
 	.get_vq_align           = vdpasim_get_vq_align,
+	.get_vq_group           = vdpasim_get_vq_group,
 	.get_features           = vdpasim_get_features,
 	.set_features           = vdpasim_set_features,
 	.set_config_cb          = vdpasim_set_config_cb,
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8ab8dcde705d..bfc6790b263e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -51,6 +51,7 @@ struct vdpa_device {
 	unsigned int index;
 	bool features_valid;
 	int nvqs;
+	unsigned int ngroups;
 };
 
 /**
@@ -119,6 +120,10 @@ struct vdpa_iova_range {
  *				for the device
  *				@vdev: vdpa device
  *				Returns virtqueue algin requirement
+ * @get_vq_group:		Get the group id for a specific virtqueue
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns u32: group id for this virtqueue
  * @get_features:		Get virtio features supported by the device
  *				@vdev: vdpa device
  *				Returns the virtio features support by the
@@ -217,6 +222,7 @@ struct vdpa_config_ops {
 
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
+	u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
 	u64 (*get_features)(struct vdpa_device *vdev);
 	int (*set_features)(struct vdpa_device *vdev, u64 features);
 	void (*set_config_cb)(struct vdpa_device *vdev,
@@ -245,12 +251,12 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					int nvqs,
+					int nvqs, unsigned int ngroups,
 					size_t size);
 
-#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
+#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs, ngroups) \
 			  container_of(__vdpa_alloc_device( \
-				       parent, config, nvqs, \
+				       parent, config, nvqs, ngroups, \
 				       sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
 				       dev_struct, member))), \
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
