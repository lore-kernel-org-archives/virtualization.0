Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FBC5517A
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 08:27:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46532206DC
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 08:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ukvu6M07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46532206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B5446872A6;
	Fri, 30 Oct 2020 08:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xWdnGFmo6PWD; Fri, 30 Oct 2020 08:27:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9287E87001;
	Fri, 30 Oct 2020 08:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF98C0893;
	Fri, 30 Oct 2020 08:27:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B1D8C0859
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 55D71867E9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Fak8I0lbkbX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:27:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5253A867B6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:27:10 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U8Ie03157762;
 Fri, 30 Oct 2020 08:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=SPTCCzaaMoMH7ZkqcSn/3OnyNUPLbSrB1kzNwJ9Szq4=;
 b=ukvu6M07XEqbvu3282i4sI5HiwsbeRgyi9XTQlqSQtg8lQKI1NqWI+fO9qtnvaRvjVvw
 HnH0otzm6Ad4armKPstpcrzpDVSGK9gGmXADz2x3SLhT/3jxleionCsr1KI0JBctYMDL
 +/YJzw/6b64AasDIuHo4F7RH+4CHxuvdh6M2d9/Dh/TqCs6I7rJkP7yTCNBg+poD5PCH
 vCK/AcuJp73Dx5rwH+65ILiiAhvtlsYyGKniVMkED8JWbnVCy+r737iaF1HDLqu31MDV
 48v6NnbxaXeWH4gN9gQ7/Ai3IdrGjF7xIraaqMeykpCYoQY04fR7dmtHCJ8aivkfQaSZ 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 34dgm4e4k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 30 Oct 2020 08:27:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U8QYuU005266;
 Fri, 30 Oct 2020 08:27:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 34cwuqqcxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 08:27:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09U8R12b006577;
 Fri, 30 Oct 2020 08:27:01 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 30 Oct 2020 01:27:00 -0700
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com
Subject: [PATCH 1/2] Revert "vhost-vdpa: fix page pinning leakage in error
 path"
Date: Fri, 30 Oct 2020 03:45:43 -0400
Message-Id: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300062
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This reverts commit 7ed9e3d97c32d969caded2dfb6e67c1a2cc5a0b1.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c | 119 +++++++++++++++++++++------------------------------
 1 file changed, 48 insertions(+), 71 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a2dbc85..b6d9016 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -588,19 +588,21 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	struct vhost_dev *dev = &v->vdev;
 	struct vhost_iotlb *iotlb = dev->iotlb;
 	struct page **page_list;
-	struct vm_area_struct **vmas;
+	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
-	unsigned long map_pfn, last_pfn = 0;
-	unsigned long npages, lock_limit;
-	unsigned long i, nmap = 0;
+	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
+	unsigned long locked, lock_limit, pinned, i;
 	u64 iova = msg->iova;
-	long pinned;
 	int ret = 0;
 
 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
 
+	page_list = (struct page **) __get_free_page(GFP_KERNEL);
+	if (!page_list)
+		return -ENOMEM;
+
 	if (msg->perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
@@ -608,86 +610,61 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	if (!npages)
 		return -EINVAL;
 
-	page_list = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
-	vmas = kvmalloc_array(npages, sizeof(struct vm_area_struct *),
-			      GFP_KERNEL);
-	if (!page_list || !vmas) {
-		ret = -ENOMEM;
-		goto free;
-	}
-
 	mmap_read_lock(dev->mm);
 
+	locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
 
-	pinned = pin_user_pages(msg->uaddr & PAGE_MASK, npages, gup_flags,
-				page_list, vmas);
-	if (npages != pinned) {
-		if (pinned < 0) {
-			ret = pinned;
-		} else {
-			unpin_user_pages(page_list, pinned);
-			ret = -ENOMEM;
-		}
-		goto unlock;
+	if (locked > lock_limit) {
+		ret = -ENOMEM;
+		goto out;
 	}
 
+	cur_base = msg->uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
-	map_pfn = page_to_pfn(page_list[0]);
-
-	/* One more iteration to avoid extra vdpa_map() call out of loop. */
-	for (i = 0; i <= npages; i++) {
-		unsigned long this_pfn;
-		u64 csize;
-
-		/* The last chunk may have no valid PFN next to it */
-		this_pfn = i < npages ? page_to_pfn(page_list[i]) : -1UL;
-
-		if (last_pfn && (this_pfn == -1UL ||
-				 this_pfn != last_pfn + 1)) {
-			/* Pin a contiguous chunk of memory */
-			csize = last_pfn - map_pfn + 1;
-			ret = vhost_vdpa_map(v, iova, csize << PAGE_SHIFT,
-					     map_pfn << PAGE_SHIFT,
-					     msg->perm);
-			if (ret) {
-				/*
-				 * Unpin the rest chunks of memory on the
-				 * flight with no corresponding vdpa_map()
-				 * calls having been made yet. On the other
-				 * hand, vdpa_unmap() in the failure path
-				 * is in charge of accounting the number of
-				 * pinned pages for its own.
-				 * This asymmetrical pattern of accounting
-				 * is for efficiency to pin all pages at
-				 * once, while there is no other callsite
-				 * of vdpa_map() than here above.
-				 */
-				unpin_user_pages(&page_list[nmap],
-						 npages - nmap);
-				goto out;
+
+	while (npages) {
+		pinned = min_t(unsigned long, npages, list_size);
+		ret = pin_user_pages(cur_base, pinned,
+				     gup_flags, page_list, NULL);
+		if (ret != pinned)
+			goto out;
+
+		if (!last_pfn)
+			map_pfn = page_to_pfn(page_list[0]);
+
+		for (i = 0; i < ret; i++) {
+			unsigned long this_pfn = page_to_pfn(page_list[i]);
+			u64 csize;
+
+			if (last_pfn && (this_pfn != last_pfn + 1)) {
+				/* Pin a contiguous chunk of memory */
+				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
+				if (vhost_vdpa_map(v, iova, csize,
+						   map_pfn << PAGE_SHIFT,
+						   msg->perm))
+					goto out;
+				map_pfn = this_pfn;
+				iova += csize;
 			}
-			atomic64_add(csize, &dev->mm->pinned_vm);
-			nmap += csize;
-			iova += csize << PAGE_SHIFT;
-			map_pfn = this_pfn;
+
+			last_pfn = this_pfn;
 		}
-		last_pfn = this_pfn;
+
+		cur_base += ret << PAGE_SHIFT;
+		npages -= ret;
 	}
 
-	WARN_ON(nmap != npages);
+	/* Pin the rest chunk */
+	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
+			     map_pfn << PAGE_SHIFT, msg->perm);
 out:
-	if (ret)
+	if (ret) {
 		vhost_vdpa_unmap(v, msg->iova, msg->size);
-unlock:
+		atomic64_sub(npages, &dev->mm->pinned_vm);
+	}
 	mmap_read_unlock(dev->mm);
-free:
-	kvfree(vmas);
-	kvfree(page_list);
+	free_page((unsigned long)page_list);
 	return ret;
 }
 
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
