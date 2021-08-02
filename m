Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777B7C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 01:37:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FCB61057
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 01:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7FCB61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31BD840452;
	Mon,  2 Aug 2021 01:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gEYRn3Jp7qis; Mon,  2 Aug 2021 01:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 810B84041E;
	Mon,  2 Aug 2021 01:37:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 559F7C001B;
	Mon,  2 Aug 2021 01:37:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC14AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 01:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C50B582CAC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 01:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S0ZmB9BnL_lS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 01:37:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
 by smtp1.osuosl.org (Postfix) with ESMTP id B8AD382CA5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 01:37:26 +0000 (UTC)
Received: from BJHW-Mail-Ex09.internal.baidu.com (unknown [10.127.64.32])
 by Forcepoint Email with ESMTPS id 199164070AFAC34E39FC;
 Mon,  2 Aug 2021 09:37:24 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 2 Aug 2021 09:37:23 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 2 Aug 2021 09:37:23 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <mst@redhat.com>, <jasowang@redhat.com>
Subject: [PATCH] vdpa: Make use of PFN_PHYS/PFN_UP/PFN_DOWN helper macro
Date: Mon, 2 Aug 2021 09:37:17 +0800
Message-ID: <20210802013717.851-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex09_2021-08-02 09:37:24:152
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

it's a nice refactor to make use of
PFN_PHYS/PFN_UP/PFN_DOWN helper macro

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/vhost/vdpa.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 210ab35a7ebf..1f6dd6ad0f8b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -507,15 +507,15 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
 	unsigned long pfn, pinned;
 
 	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
-		pinned = map->size >> PAGE_SHIFT;
-		for (pfn = map->addr >> PAGE_SHIFT;
+		pinned = PFN_DOWN(map->size);
+		for (pfn = PFN_DOWN(map->addr);
 		     pinned > 0; pfn++, pinned--) {
 			page = pfn_to_page(pfn);
 			if (map->perm & VHOST_ACCESS_WO)
 				set_page_dirty_lock(page);
 			unpin_user_page(page);
 		}
-		atomic64_sub(map->size >> PAGE_SHIFT, &dev->mm->pinned_vm);
+		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
 		vhost_iotlb_map_free(iotlb, map);
 	}
 }
@@ -577,7 +577,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 	if (r)
 		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
 	else
-		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
+		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
 
 	return r;
 }
@@ -630,7 +630,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	if (msg->perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
-	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
+	npages = PFN_UP(msg->size + (iova & ~PAGE_MASK));
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
@@ -638,7 +638,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 
 	mmap_read_lock(dev->mm);
 
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
 	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -672,9 +672,9 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 
 			if (last_pfn && (this_pfn != last_pfn + 1)) {
 				/* Pin a contiguous chunk of memory */
-				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
+				csize = PFN_PHYS(last_pfn - map_pfn + 1);
 				ret = vhost_vdpa_map(v, iova, csize,
-						     map_pfn << PAGE_SHIFT,
+						     PFN_PHYS(map_pfn),
 						     msg->perm);
 				if (ret) {
 					/*
@@ -698,13 +698,13 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 			last_pfn = this_pfn;
 		}
 
-		cur_base += pinned << PAGE_SHIFT;
+		cur_base += PFN_PHYS(pinned);
 		npages -= pinned;
 	}
 
 	/* Pin the rest chunk */
-	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
-			     map_pfn << PAGE_SHIFT, msg->perm);
+	ret = vhost_vdpa_map(v, iova, PFN_PHYS(last_pfn - map_pfn + 1),
+			     PFN_PHYS(map_pfn), msg->perm);
 out:
 	if (ret) {
 		if (nchunks) {
@@ -944,7 +944,7 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
-			    notify.addr >> PAGE_SHIFT, PAGE_SIZE,
+			    PFN_DOWN(notify.addr), PAGE_SIZE,
 			    vma->vm_page_prot))
 		return VM_FAULT_SIGBUS;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
