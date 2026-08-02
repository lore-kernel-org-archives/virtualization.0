Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4453955DB
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691694; cv=none; b=E2jgusz06TUpLsyms4emxCdJSJ3z/Hm+iv/wfkOB+RJrKkBaRsdzp8trAzFA7hTRz7cD4BArqweusm6R7NsgWu6yUeiLB3ctCT/wF7qip58GtQ0nNhudJyQZgX3dXsW0xRE/urdb0ljAGokz00CAYiNL6LAiM5Y9yYKM9vqa+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691694; c=relaxed/simple;
	bh=cbg66S599oYEnTDxeHAko0kawMfXDkpEV5WIaR9/DTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFjy6k2PuTUAQoA73HA96TDN8TLwuKqoWiMw2Axt5Bt5Y6/5U4TTBinOCqQqk75tsf6A8M4v+nrZVeJc4Bufm9TLLO90lN28GNbtDc82iSxB3lmvMfnJHyWnPAQkFefJnHd1Zm+UjVXym/lQV7tqqojgI/NqoNjjAK9qqEw2K+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qNkkOPYj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qNkkOPYj"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672HNTZN805587;
	Sun, 2 Aug 2026 17:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=S6TDc
	bRmKTn+qMmttv38f3y+XW/b4MSfCGd0YqQCi30=; b=qNkkOPYj4acxUSdy9eB/k
	bzrAG4m1A8Uj1F0CIjjy2cA0TLADqW49VYcVUPKc3TrQ11gW9uZEyh8bAGA55TZw
	E27UqTSDyHl1jvdU1PumJXXGNBDfCnZfiVioj43ertA/srmpz/iA95lHCsDoDXVq
	seyvwBDK95ObUjqLEQYyAEi7KoYE2S9U4grofx9CqaqRmweRtxZ1tpTHIMRT014K
	qfb8IA/TYSaTXd7VVMmppvgJdk0WHUxycJeyQyFYCR56uBQlKmnvkyHHUeK1zKTL
	0W1rheiJk/sno5WwQY8cLwkpSQwUffmoSKT3KNFeq5k1v6fu//joUja/iRd1jN/G
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9bt2neb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 17:28:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 672HPpr9027695;
	Sun, 2 Aug 2026 17:28:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78r0h75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 17:28:10 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 672HS8PE032953;
	Sun, 2 Aug 2026 17:28:09 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fs78r0h6r-2;
	Sun, 02 Aug 2026 17:28:09 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        kvm@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH v2 1/2] vhost-scsi: use kvzalloc for vq array allocation
Date: Sun,  2 Aug 2026 10:24:55 -0700
Message-ID: <20260802172534.260047-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260802172534.260047-1-dongli.zhang@oracle.com>
References: <20260802172534.260047-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608020159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1OSBTYWx0ZWRfX6+dE+rxQVlvD
 2qmOsvo37on7WhpbPinT9+rz6UlQAkP4+JGRHiAnO0BjC5SujQUJOHDhtJdxiWLb6u4/4VCrvMN
 dQSMzNFgDk+TgSqjDRlQl4aTc7dubEeBt/jTghRsyx1QHjZlTI/E+EX+ZEB6PDef6o3mRLpVTII
 5Cjnc1ogcxeSCjykKULEI2u6QBqyBG0tyF74uYjS5VLsJceGLU36ikGHajUvX7Cl499cQZ6m15n
 B5zRcfQv6srI9CBkXOmBnUBVT4TdMmbIBROk2g/HD4AQz91dZC2Gca22ejOHiJT6ELfAtLfAS+C
 5FH50e0IpPogdnAjrPjLuUlLyzdFclYMu0wD9gv+zq96cyYyCE1dYjRHWfQnP5yjcg/kHqD0fiN
 MAEAuwbw8C/Uuypr9DzW2YKvxY7/P05EDN9lYxCJ58XK42S9g1todBGmTqT/Hd0IdErrsk3lgzW
 iwvwby+l9e6MQ+aQCLCk0G3lx8tRlCBVDIsG2qts=
X-Proofpoint-ORIG-GUID: ANwT6mhlWeJ-BA0-ylbqhtKJyJTQ3C1t
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1OSBTYWx0ZWRfX5F07lVQWr1U0
 TyeXQp6eVNCw/9YH6oSMdmHvxozgd35m96YFWglQ28CfdJ++/xRt67prZfyRNWyyKm6SAcbrmi6
 Xca++ihxYqeZDs3y01rgpyEnbJXp/EHuXwThRbCuax+ulFAiTCFA
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a6f7e2b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=Aw3GVznJ7T6Chps5h7QA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13517
X-Proofpoint-GUID: ANwT6mhlWeJ-BA0-ylbqhtKJyJTQ3C1t

vhost_scsi_open() allocates one "struct vhost_scsi_virtqueue" for each
virtqueue. With large max_io_vqs values, this array can require a
high-order contiguous allocation and trigger a page allocator warning.

hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
256

[  766.075787] ------------[ cut here ]------------
[  766.077030] WARNING: mm/page_alloc.c:5280 at __alloc_frozen_pages_noprof+0x32c/0x15c0, CPU#23: qemu-system-x86/5964
... ...
[  766.080351] RIP: 0010:__alloc_frozen_pages_noprof+0x32c/0x15c0
... ...
[  766.085813] Call Trace:
[  766.085969]  <TASK>
[  766.086098]  ? srso_alias_return_thunk+0x5/0xfbef5
[  766.086365]  ? context_struct_compute_av+0x38a/0x4b0
[  766.086652]  alloc_pages_mpol+0x9f/0x170
[  766.086883]  ___kmalloc_large_node+0xb6/0xd0
[  766.087124]  ? srso_alias_return_thunk+0x5/0xfbef5
[  766.087389]  __kmalloc_large_node_noprof+0x18/0xa0
[  766.087655]  __kmalloc_noprof+0x3a0/0x440
[  766.087877]  ? vhost_scsi_open+0xcb/0x2d0 [vhost_scsi]
[  766.088162]  vhost_scsi_open+0xcb/0x2d0 [vhost_scsi]
[  766.088449]  misc_open+0x123/0x160
[  766.088679]  chrdev_open+0xb1/0x230
[  766.088885]  ? __pfx_chrdev_open+0x10/0x10
[  766.089157]  do_dentry_open+0x11a/0x470
[  766.089389]  vfs_open+0x29/0xf0
[  766.089596]  path_openat+0x7c0/0x1100
[  766.089821]  do_file_open+0xdd/0x190
[  766.090032]  ? srso_alias_return_thunk+0x5/0xfbef5
[  766.090332]  do_sys_openat2+0x7e/0x100
[  766.090601]  __x64_sys_openat+0x51/0xa0
[  766.090857]  do_syscall_64+0xfe/0x590
[  766.091087]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  766.091411] RIP: 0033:0x7f9525a11fa6

The array does not require physical contiguity, so allocate it with
kvzalloc_objs() and free it with kvfree().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/vhost/scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..0c0634eea144 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2295,7 +2295,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	if (!vs->old_inflight)
 		goto err_inflight;
 
-	vs->vqs = kmalloc_objs(*vs->vqs, nvqs, GFP_KERNEL | __GFP_ZERO);
+	vs->vqs = kvzalloc_objs(*vs->vqs, nvqs);
 	if (!vs->vqs)
 		goto err_vqs;
 
@@ -2331,7 +2331,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	return 0;
 
 err_local_vqs:
-	kfree(vs->vqs);
+	kvfree(vs->vqs);
 err_vqs:
 	kfree(vs->old_inflight);
 err_inflight:
@@ -2352,7 +2352,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	vhost_dev_stop(&vs->dev);
 	vhost_dev_cleanup(&vs->dev);
 	kfree(vs->dev.vqs);
-	kfree(vs->vqs);
+	kvfree(vs->vqs);
 	kfree(vs->old_inflight);
 	kvfree(vs);
 	return 0;
-- 
2.43.5

