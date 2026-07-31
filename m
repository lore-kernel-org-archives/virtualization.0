Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10603783B0
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536020; cv=none; b=VE6aSdM8j8PcLXJbjzdZWUu6o6rnTwkTBM3QnGObCzTqXbo0ZfxpFVKXRgIElhqHq4eYnlyB0V95Luhr2Iz53omH0ZCVxiTIxHvxExSkoPW26eJaXa4onCm8Gk+zMxLTNsomxREvIWre2m7BhucWOIFk8wr9GLdf04ehXu3cPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536020; c=relaxed/simple;
	bh=cbg66S599oYEnTDxeHAko0kawMfXDkpEV5WIaR9/DTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKKbTZfYzDREtJLI/3A6y4ggoJo114s/GVM9F+n0QnRwP51UMYHzOMpAFQPyonqgAtp9kJCbPfbLh5p72Km9cK/Ac0CTCTeKEznAzdr0TtA6DMnYW9tPQRc3hx5we0njiDoX33HsoW+t+2HzxzAgPRaLGFWDszc7e4WkASR1qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hI/zdJTa; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hI/zdJTa"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VJtYdJ333124;
	Fri, 31 Jul 2026 22:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=S6TDc
	bRmKTn+qMmttv38f3y+XW/b4MSfCGd0YqQCi30=; b=hI/zdJTadRUv/CdHrkg7R
	5CBHBORwe1pzI2RXPX8NNQF2ZOjRg7ORVO1BTKFOQky7qxDKxDGQF8/etucOUjbh
	KdL0psSXscn0kvBi7fBErpphAsiHSNyUyR7v/mHeLpMew2e21Oib8K407/Shxamo
	vYLfTL2MVM0wXqxIJNQ5iT3XyEaq7GME+9PD5OH/UpxgtULy1OD+Yxk4o55xkqNS
	PHdrKmUE3IpXF6geZpXGIMTzQM5zd3bSAA/aTEC4KhCRt65brvDKOmiF1RzkiSxp
	TIUCGllekKE5f7fR9HcryK6sQyxImzqbSLKG+LY0c/RVcUiqMxuFkLbwRGOgSHJ5
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr1dm77t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 22:13:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VMA4oB007474;
	Fri, 31 Jul 2026 22:13:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fnheq8a9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 22:13:36 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66VMDZB7018145;
	Fri, 31 Jul 2026 22:13:36 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fnheq8a8s-2;
	Fri, 31 Jul 2026 22:13:36 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        kvm@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH 1/2] vhost-scsi: use kvzalloc for vq array allocation
Date: Fri, 31 Jul 2026 15:10:23 -0700
Message-ID: <20260731221116.236791-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260731221116.236791-1-dongli.zhang@oracle.com>
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310167
X-Proofpoint-GUID: lkhiBy7uO6CFmNQ-FkVjEiieqqoUYoxI
X-Authority-Analysis: v=2.4 cv=Y8fIdBeN c=1 sm=1 tr=0 ts=6a6d1e11 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=Aw3GVznJ7T6Chps5h7QA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2NyBTYWx0ZWRfX6QqqC7LQaZs9
 0bPetRziJ60Snx7hXyZ+9H8EPEQh2MnVKU0eWEPD2aSEgMMrnt7fH0Zznxw5hciK3O41L+Xsbaa
 Y18VLohDAN7UgpTPa1Yk4zj4F4+jWVG4LfEPNquVCXpOfnrQ7/a6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2NyBTYWx0ZWRfXzb7along0v/Q
 BQB5GEhqazug2NqhUTawVfVcWXukjCxmf11DufeD+yw/s7oVltKCkiqax5kgIxPypDCVVJoqr43
 Fes1liOnJuwpgNh5WBdhO6+qNR0vAdN597KVggFgsoBWg9Bd5M750ZdzDzcWnwX6P84BAHBs707
 InwqT9sOm6WBtEWJYlecEAcgJ6bOIo+rsDbeRg7+6EKcQWL90Ndwe68muNVZxdDAozntif/95uD
 pH0QfssutKbnkpzNF09iGnc7HHrcM35vK6g5d9f8EyK0EDo/8gjfEGECdefZRV8lEk3vbiipbqi
 rb0j21bqsqi2Y4WwOZzTYsNZBsbpb5nX1ee+PG7veYaCsVn8VUr9klbpbBz1rRiO41srAZApGKv
 soAaKa1PlyODyxJ8E4jwvim6t/mOudueYK/YczTDLzTUw2oVFTgbmif5NWWGRDz6txvWVV5Omb/
 8YQ++cWp4RH2at9PUAw==
X-Proofpoint-ORIG-GUID: lkhiBy7uO6CFmNQ-FkVjEiieqqoUYoxI

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

