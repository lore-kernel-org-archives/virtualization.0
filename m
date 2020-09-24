Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC6C4727F
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:23:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E2423600
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwl004ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E2423600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ACE202D002;
	Thu, 24 Sep 2020 03:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yK6leMcLx4mu; Thu, 24 Sep 2020 03:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B9A1B2DE22;
	Thu, 24 Sep 2020 03:23:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0D9CC0889;
	Thu, 24 Sep 2020 03:23:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B296AC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A10CE84D8E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Bm-WpLNglLr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:23:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 890E084CF3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600917805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DlevwzBa/okzwujLw8aBX41kaqgm9GO4UJfWHRuSoQ=;
 b=cwl004eigqD/5lqlSAAIK7MXXnWZXobUbb3EkEzUMOe91BglRK5eVVnzM1JQumSWaLaEkl
 TF+W6HOWi19RvdxqPIeH1w65szGlvKoXMcLRLvYNJseDuUKqRIil7Dqg/Fb/RxsaAiLpsO
 8Fw4yapS6LklltngJfRLniNxnA8KJvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-qozGjWuSP6qnaDGy0PEjIw-1; Wed, 23 Sep 2020 23:23:22 -0400
X-MC-Unique: qozGjWuSP6qnaDGy0PEjIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A10801AF7;
 Thu, 24 Sep 2020 03:23:21 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0575B55777;
 Thu, 24 Sep 2020 03:23:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 09/24] vdpa: multiple address spaces support
Date: Thu, 24 Sep 2020 11:21:10 +0800
Message-Id: <20200924032125.18619-10-jasowang@redhat.com>
In-Reply-To: <20200924032125.18619-1-jasowang@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

This patches introduces the multiple address spaces support for vDPA
device. This idea is to identify a specific address space via an
dedicated identifier - ASID.

During vDPA device allocation, vDPA device driver needs to report the
number of address spaces supported by the device then the DMA mapping
ops of the vDPA device needs to be extended to support ASID.

This helps to isolate the DMA among the virtqueues. E.g in the case of
virtio-net, the control virtqueue will not be assigned directly to
guest.

This RFC patch only converts for the device that wants its own
IOMMU/DMA translation logic. So it will rejects the device with more
that 1 address space that depends on platform IOMMU. The plan to
moving all the DMA mapping logic to the vDPA device driver instead of
doing it in vhost-vDPA (otherwise it could result a very complicated
APIs and actually vhost-vDPA doesn't care about how the actual
composition/emulation were done in the device driver).

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c   |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  5 +++--
 drivers/vdpa/vdpa.c               |  4 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c  | 10 ++++++----
 drivers/vhost/vdpa.c              | 14 +++++++++-----
 include/linux/vdpa.h              | 23 ++++++++++++++++-------
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index e6a0be374e51..86cdf5f8bcae 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -440,7 +440,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
 				    dev, &ifc_vdpa_ops,
-				    IFCVF_MAX_QUEUE_PAIRS * 2, 1);
+				    IFCVF_MAX_QUEUE_PAIRS * 2, 1, 1);
 
 	if (adapter == NULL) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 4e480f4f754e..db7404e121bf 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1788,7 +1788,8 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 	return mvdev->generation;
 }
 
-static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb)
+static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
+			     struct vhost_iotlb *iotlb)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
@@ -1931,7 +1932,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 2 * mlx5_vdpa_max_qps(max_vqs), 1);
+				 2 * mlx5_vdpa_max_qps(max_vqs), 1, 1);
 	if (IS_ERR(ndev))
 		return ndev;
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 46399746ec7c..05195fa7865d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -63,6 +63,7 @@ static void vdpa_release_dev(struct device *d)
  * @config: the bus operations that is supported by this device
  * @nvqs: number of virtqueues supported by this device
  * @ngroups: number of groups supported by this device
+ * @nas: number of address spaces supported by this device
  * @size: size of the parent structure that contains private data
  *
  * Driver should use vdpa_alloc_device() wrapper macro instead of
@@ -74,7 +75,7 @@ static void vdpa_release_dev(struct device *d)
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
 					int nvqs, unsigned int ngroups,
-					size_t size)
+					unsigned int nas, size_t size)
 {
 	struct vdpa_device *vdev;
 	int err = -EINVAL;
@@ -102,6 +103,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->features_valid = false;
 	vdev->nvqs = nvqs;
 	vdev->ngroups = ngroups;
+	vdev->nas = nas;
 
 	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
 	if (err)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6669c561bc6e..5dc04ec271bb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -354,7 +354,7 @@ static struct vdpasim *vdpasim_create(void)
 		ops = &vdpasim_net_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    VDPASIM_VQ_NUM, 1);
+				    VDPASIM_VQ_NUM, 1, 1);
 	if (!vdpasim)
 		goto err_alloc;
 
@@ -581,7 +581,7 @@ static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
 	return vdpasim->generation;
 }
 
-static int vdpasim_set_map(struct vdpa_device *vdpa,
+static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
 			   struct vhost_iotlb *iotlb)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -608,7 +608,8 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 	return ret;
 }
 
-static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
+static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
+			   u64 iova, u64 size,
 			   u64 pa, u32 perm)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -622,7 +623,8 @@ static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
 	return ret;
 }
 
-static int vdpasim_dma_unmap(struct vdpa_device *vdpa, u64 iova, u64 size)
+static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
+			     u64 iova, u64 size)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ec3c94f706c1..eeefcd971e3f 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -557,10 +557,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, 0, iova, size, pa, perm);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
-			r = ops->set_map(vdpa, iotlb);
+			r = ops->set_map(vdpa, 0, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm));
@@ -579,10 +579,10 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
 	vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1);
 
 	if (ops->dma_map) {
-		ops->dma_unmap(vdpa, iova, size);
+		ops->dma_unmap(vdpa, 0, iova, size);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
-			ops->set_map(vdpa, iotlb);
+			ops->set_map(vdpa, 0, iotlb);
 	} else {
 		iommu_unmap(v->domain, iova, size);
 	}
@@ -700,7 +700,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 		break;
 	case VHOST_IOTLB_BATCH_END:
 		if (v->in_batch && ops->set_map)
-			ops->set_map(vdpa, iotlb);
+			ops->set_map(vdpa, 0, iotlb);
 		v->in_batch = false;
 		break;
 	default:
@@ -949,6 +949,10 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	int minor;
 	int r;
 
+	/* Only support 1 address space */
+	if (vdpa->ngroups != 1)
+		return -ENOTSUPP;
+
 	/* Currently, we only accept the network devices. */
 	if (ops->get_device_id(vdpa) != VIRTIO_ID_NET)
 		return -ENOTSUPP;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index d829512efd27..1e1163daa352 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -43,6 +43,8 @@ struct vdpa_vq_state {
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
  * @nvqs: the number of virtqueues
+ * @ngroups: the number of virtqueue groups
+ * @nas: the number of address spaces
  */
 struct vdpa_device {
 	struct device dev;
@@ -52,6 +54,7 @@ struct vdpa_device {
 	bool features_valid;
 	int nvqs;
 	unsigned int ngroups;
+	unsigned int nas;
 };
 
 /**
@@ -161,6 +164,7 @@ struct vdpa_device {
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
  *				@vdev: vdpa device
+ *				@asid: address space identifier
  *				@iotlb: vhost memory mapping to be
  *				used by the vDPA
  *				Returns integer: success (0) or error (< 0)
@@ -169,6 +173,7 @@ struct vdpa_device {
  *				specific DMA translation (on-chip IOMMU)
  *				and preferring incremental map.
  *				@vdev: vdpa device
+ *				@asid: address space identifier
  *				@iova: iova to be mapped
  *				@size: size of the area
  *				@pa: physical address for the map
@@ -180,6 +185,7 @@ struct vdpa_device {
  *				specific DMA translation (on-chip IOMMU)
  *				and preferring incremental unmap.
  *				@vdev: vdpa device
+ *				@asid: address space identifier
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
@@ -225,10 +231,12 @@ struct vdpa_config_ops {
 	u32 (*get_generation)(struct vdpa_device *vdev);
 
 	/* DMA ops */
-	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
-	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
-		       u64 pa, u32 perm);
-	int (*dma_unmap)(struct vdpa_device *vdev, u64 iova, u64 size);
+	int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
+		       struct vhost_iotlb *iotlb);
+	int (*dma_map)(struct vdpa_device *vdev, unsigned int asid,
+		       u64 iova, u64 size, u64 pa, u32 perm);
+	int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
+			 u64 iova, u64 size);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
@@ -237,11 +245,12 @@ struct vdpa_config_ops {
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
 					int nvqs, unsigned int ngroups,
-					size_t size);
+					unsigned int nas, size_t size);
 
-#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs, ngroups) \
+#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs, \
+			  ngroups, nas)				    \
 			  container_of(__vdpa_alloc_device( \
-				       parent, config, nvqs, ngroups, \
+				       parent, config, nvqs, ngroups, nas,  \
 				       sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
 				       dev_struct, member))), \
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
