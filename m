Return-Path: <SRS0=Cd1r=BK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D13C433E0
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 07:38:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904BA2067D
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 07:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux32LvGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904BA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4E7D386277;
	Fri, 31 Jul 2020 07:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HmYs1MtYvc9o; Fri, 31 Jul 2020 07:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B00BB8614A;
	Fri, 31 Jul 2020 07:38:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 924BFC0050;
	Fri, 31 Jul 2020 07:38:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CD1AC004D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 07:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 75271885DB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 07:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NufyHy7c57Kb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 07:38:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 973F6885DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 07:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596181131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UyyG9Gm6TcIIbyN+Hyz6xBxQjagceQ+V95AfdEn0yag=;
 b=Ux32LvGgsYj2STxSweSxygL9wyCIUBFIq1q2HsHmW6KMN76GAC7sCeaWmZcbWajE16Wk1x
 TRCj3ByrP7rwjX2PA+NtKS75cKKXSw7cVfZSHI26Xs80Ujf07ZGRsqdOdHm5lxnGEoOiL5
 PIcjAkM445bh8KK7911R1VulJSGpsuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-hl_wTcw1O5m5Md_oFS1kSg-1; Fri, 31 Jul 2020 03:38:46 -0400
X-MC-Unique: hl_wTcw1O5m5Md_oFS1kSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A62088014D7;
 Fri, 31 Jul 2020 07:38:45 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC851C953;
 Fri, 31 Jul 2020 07:38:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vdpasim: protect concurrent access to iommu iotlb
Date: Fri, 31 Jul 2020 15:38:22 +0800
Message-Id: <20200731073822.13326-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
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

From: Max Gurtovoy <maxg@mellanox.com>

Iommu iotlb can be accessed by different cores for performing IO using
multiple virt queues. Add a spinlock to synchronize iotlb accesses.

This could be easily reproduced when using more than 1 pktgen threads
to inject traffic to vdpa simulator.

Fixes: 2c53d0f64c06f("vdpasim: vDPA device simulator")
Cc: stable@vger.kernel.org
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a9bc5e0fb353..5b5725d951ce 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -70,6 +70,8 @@ struct vdpasim {
 	u32 status;
 	u32 generation;
 	u64 features;
+	/* spinlock to synchronize iommu table */
+	spinlock_t iommu_lock;
 };
 
 static struct vdpasim *vdpasim_dev;
@@ -118,7 +120,9 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	for (i = 0; i < VDPASIM_VQ_NUM; i++)
 		vdpasim_vq_reset(&vdpasim->vqs[i]);
 
+	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_reset(vdpasim->iommu);
+	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
 	vdpasim->status = 0;
@@ -236,8 +240,10 @@ static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
 	/* For simplicity, use identical mapping to avoid e.g iova
 	 * allocator.
 	 */
+	spin_lock(&vdpasim->iommu_lock);
 	ret = vhost_iotlb_add_range(iommu, pa, pa + size - 1,
 				    pa, dir_to_perm(dir));
+	spin_unlock(&vdpasim->iommu_lock);
 	if (ret)
 		return DMA_MAPPING_ERROR;
 
@@ -251,8 +257,10 @@ static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	struct vdpasim *vdpasim = dev_to_sim(dev);
 	struct vhost_iotlb *iommu = vdpasim->iommu;
 
+	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_del_range(iommu, (u64)dma_addr,
 			      (u64)dma_addr + size - 1);
+	spin_unlock(&vdpasim->iommu_lock);
 }
 
 static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
@@ -264,9 +272,10 @@ static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
 	void *addr = kmalloc(size, flag);
 	int ret;
 
-	if (!addr)
+	spin_lock(&vdpasim->iommu_lock);
+	if (!addr) {
 		*dma_addr = DMA_MAPPING_ERROR;
-	else {
+	} else {
 		u64 pa = virt_to_phys(addr);
 
 		ret = vhost_iotlb_add_range(iommu, (u64)pa,
@@ -279,6 +288,7 @@ static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
 		} else
 			*dma_addr = (dma_addr_t)pa;
 	}
+	spin_unlock(&vdpasim->iommu_lock);
 
 	return addr;
 }
@@ -290,8 +300,11 @@ static void vdpasim_free_coherent(struct device *dev, size_t size,
 	struct vdpasim *vdpasim = dev_to_sim(dev);
 	struct vhost_iotlb *iommu = vdpasim->iommu;
 
+	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_del_range(iommu, (u64)dma_addr,
 			      (u64)dma_addr + size - 1);
+	spin_unlock(&vdpasim->iommu_lock);
+
 	kfree(phys_to_virt((uintptr_t)dma_addr));
 }
 
@@ -532,6 +545,7 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 	u64 start = 0ULL, last = 0ULL - 1;
 	int ret;
 
+	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_reset(vdpasim->iommu);
 
 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
@@ -541,10 +555,12 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 		if (ret)
 			goto err;
 	}
+	spin_unlock(&vdpasim->iommu_lock);
 	return 0;
 
 err:
 	vhost_iotlb_reset(vdpasim->iommu);
+	spin_unlock(&vdpasim->iommu_lock);
 	return ret;
 }
 
@@ -552,16 +568,23 @@ static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
 			   u64 pa, u32 perm)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	int ret;
 
-	return vhost_iotlb_add_range(vdpasim->iommu, iova,
-				     iova + size - 1, pa, perm);
+	spin_lock(&vdpasim->iommu_lock);
+	ret = vhost_iotlb_add_range(vdpasim->iommu, iova, iova + size - 1, pa,
+				    perm);
+	spin_unlock(&vdpasim->iommu_lock);
+
+	return ret;
 }
 
 static int vdpasim_dma_unmap(struct vdpa_device *vdpa, u64 iova, u64 size)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
+	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_del_range(vdpasim->iommu, iova, iova + size - 1);
+	spin_unlock(&vdpasim->iommu_lock);
 
 	return 0;
 }
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
