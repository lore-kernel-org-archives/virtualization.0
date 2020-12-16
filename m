Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A31C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:48:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E2D22D6E
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E2D22D6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B5F8866E5;
	Wed, 16 Dec 2020 06:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XwjSUibqNKIy; Wed, 16 Dec 2020 06:48:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0070865AB;
	Wed, 16 Dec 2020 06:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9D3BC0893;
	Wed, 16 Dec 2020 06:48:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E682C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5D3D3868BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbMrTFqq-gA6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:48:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6DAB9868A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYvHFSpnGQ/Xc2iIMD2acH4W7AP5GAvM4Rrxb5A3iwc=;
 b=HpNFiejiq93I9JsysX/kWDq+nW8IaR8OWUlA2lE145U2z4pwarIQaTAlqUFwT2PBaZhQvN
 7xMK0Q6Bfo9yod+y2MlrTbfqF39hR2AP4L7ytl59UVqIsUIzaEFyH4z0BdvG2tUmS4X8e3
 vYsWlc50EJ9QmA3gmwy2BOHVuzCN5J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-01oddXuzPP24jhB9X6RZkQ-1; Wed, 16 Dec 2020 01:48:52 -0500
X-MC-Unique: 01oddXuzPP24jhB9X6RZkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5A231005504;
 Wed, 16 Dec 2020 06:48:50 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1AA510016F5;
 Wed, 16 Dec 2020 06:48:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 03/21] vhost-vdpa: passing iotlb to IOMMU mapping helpers
Date: Wed, 16 Dec 2020 14:48:00 +0800
Message-Id: <20201216064818.48239-4-jasowang@redhat.com>
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

To prepare for the ASID support for vhost-vdpa, try to pass IOTLB
object to dma helpers. No functional changes, it's just a preparation
for support multiple IOTLBs.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 29ed4173f04e..07f92d48c173 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -501,10 +501,11 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	return r;
 }
 
-static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
+static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
+				   struct vhost_iotlb *iotlb,
+				   u64 start, u64 last)
 {
 	struct vhost_dev *dev = &v->vdev;
-	struct vhost_iotlb *iotlb = dev->iotlb;
 	struct vhost_iotlb_map *map;
 	struct page *page;
 	unsigned long pfn, pinned;
@@ -526,8 +527,9 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
 static void vhost_vdpa_iotlb_free(struct vhost_vdpa *v)
 {
 	struct vhost_dev *dev = &v->vdev;
+	struct vhost_iotlb *iotlb = dev->iotlb;
 
-	vhost_vdpa_iotlb_unmap(v, 0ULL, 0ULL - 1);
+	vhost_vdpa_iotlb_unmap(v, iotlb, 0ULL, 0ULL - 1);
 	kfree(dev->iotlb);
 	dev->iotlb = NULL;
 }
@@ -554,7 +556,7 @@ static int perm_to_iommu_flags(u32 perm)
 	return flags | IOMMU_CACHE;
 }
 
-static int vhost_vdpa_map(struct vhost_vdpa *v,
+static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			  u64 iova, u64 size, u64 pa, u32 perm)
 {
 	struct vhost_dev *dev = &v->vdev;
@@ -562,7 +564,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 	const struct vdpa_config_ops *ops = vdpa->config;
 	int r = 0;
 
-	r = vhost_iotlb_add_range(dev->iotlb, iova, iova + size - 1,
+	r = vhost_iotlb_add_range(iotlb, iova, iova + size - 1,
 				  pa, perm);
 	if (r)
 		return r;
@@ -571,43 +573,44 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		r = ops->dma_map(vdpa, iova, size, pa, perm);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
-			r = ops->set_map(vdpa, dev->iotlb);
+			r = ops->set_map(vdpa, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm));
 	}
 
 	if (r)
-		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
+		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
 	else
 		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
 
 	return r;
 }
 
-static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
+static void vhost_vdpa_unmap(struct vhost_vdpa *v,
+			     struct vhost_iotlb *iotlb,
+			     u64 iova, u64 size)
 {
-	struct vhost_dev *dev = &v->vdev;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 
-	vhost_vdpa_iotlb_unmap(v, iova, iova + size - 1);
+	vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1);
 
 	if (ops->dma_map) {
 		ops->dma_unmap(vdpa, iova, size);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
-			ops->set_map(vdpa, dev->iotlb);
+			ops->set_map(vdpa, iotlb);
 	} else {
 		iommu_unmap(v->domain, iova, size);
 	}
 }
 
 static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
+					   struct vhost_iotlb *iotlb,
 					   struct vhost_iotlb_msg *msg)
 {
 	struct vhost_dev *dev = &v->vdev;
-	struct vhost_iotlb *iotlb = dev->iotlb;
 	struct page **page_list;
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
@@ -676,7 +679,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 			if (last_pfn && (this_pfn != last_pfn + 1)) {
 				/* Pin a contiguous chunk of memory */
 				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
-				ret = vhost_vdpa_map(v, iova, csize,
+				ret = vhost_vdpa_map(v, iotlb, iova, csize,
 						     map_pfn << PAGE_SHIFT,
 						     msg->perm);
 				if (ret) {
@@ -706,7 +709,8 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	}
 
 	/* Pin the rest chunk */
-	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
+	ret = vhost_vdpa_map(v, iotlb, iova,
+			     (last_pfn - map_pfn + 1) << PAGE_SHIFT,
 			     map_pfn << PAGE_SHIFT, msg->perm);
 out:
 	if (ret) {
@@ -726,7 +730,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}
-		vhost_vdpa_unmap(v, msg->iova, msg->size);
+		vhost_vdpa_unmap(v, iotlb, msg->iova, msg->size);
 	}
 unlock:
 	mmap_read_unlock(dev->mm);
@@ -741,6 +745,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vhost_iotlb *iotlb = dev->iotlb;
 	int r = 0;
 
 	r = vhost_dev_check_owner(dev);
@@ -749,17 +754,17 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
-		r = vhost_vdpa_process_iotlb_update(v, msg);
+		r = vhost_vdpa_process_iotlb_update(v, iotlb, msg);
 		break;
 	case VHOST_IOTLB_INVALIDATE:
-		vhost_vdpa_unmap(v, msg->iova, msg->size);
+		vhost_vdpa_unmap(v, iotlb, msg->iova, msg->size);
 		break;
 	case VHOST_IOTLB_BATCH_BEGIN:
 		v->in_batch = true;
 		break;
 	case VHOST_IOTLB_BATCH_END:
 		if (v->in_batch && ops->set_map)
-			ops->set_map(vdpa, dev->iotlb);
+			ops->set_map(vdpa, iotlb);
 		v->in_batch = false;
 		break;
 	default:
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
