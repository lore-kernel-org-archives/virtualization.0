Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC3EC25B67
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 23:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7E7961464;
	Mon, 23 Oct 2023 23:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7E7961464
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VXqYeNUG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QdY--37wjCVw; Mon, 23 Oct 2023 23:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 50B4961467;
	Mon, 23 Oct 2023 23:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50B4961467
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2443AC0039;
	Mon, 23 Oct 2023 23:17:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 330C7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E1A0428B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:17:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E1A0428B6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VXqYeNUG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6dbG2EI1-GOy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:17:13 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2AD9428B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:17:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2AD9428B5
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NMJZnC012114; Mon, 23 Oct 2023 23:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=GpxSDSh7UIyddMbQEDT+nBmKcU5KTVkXVikk2aYD+GM=;
 b=VXqYeNUGIT8y0g4T2ZEdAQYN3l9XjV49wDOfcpXMc3yh+hYxg1vDI3VvoCzuuU0g2FCt
 QDoUuKyxedDQcIodsfm3k4DABNRGj6jZ8XKftBZsad5a61jp2JcsEmObvTkXORwHpCiJ
 XEb2OJ1xMkKmnc35fSa14UtB5l/p7GRHalPGyZqBrFUeeTiyZFqmuY3UXkBNaSfuGTmx
 fFAeoKyUrMP6GBFYPdFsrTDwsyriN5fYeRExKFmjMQAG2c5pCiO2Fik0c9d6MFjUECjb
 J4q8pAhETydCyO6wvPMEjhlOz6Yq82SFIt6GbtPAnQzgQnfEQZCm70H4DSvItCxC8yJ7 RA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tc9rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 23:17:05 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NLO3lF018954; Mon, 23 Oct 2023 23:17:05 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3tv534verp-1; Mon, 23 Oct 2023 23:17:05 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, sfr@canb.auug.org.au
Subject: [PATCH] vhost-vdpa: fix NULL pointer deref in _compat_vdpa_reset
Date: Mon, 23 Oct 2023 16:14:23 -0700
Message-Id: <1698102863-21122-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230204
X-Proofpoint-ORIG-GUID: kFqRJFETwDPh-5HKFdvBMTVe0lcMo_3O
X-Proofpoint-GUID: kFqRJFETwDPh-5HKFdvBMTVe0lcMo_3O
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
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

As subject. There's a vhost_vdpa_reset() done earlier before
vhost_dev is initialized via vhost_dev_init(), ending up with
NULL pointer dereference. Fix is to check if vqs is initialized
before checking backend features and resetting the device.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 3 PID: 1727 Comm: qemu-system-x86 Not tainted 6.6.0-rc6+ #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-
  a4aeb02-prebuilt.qemu.org 04/01/2014
  RIP: 0010:_compat_vdpa_reset+0x47/0xc0 [vhost_vdpa]
  Code: c7 c7 fb 12 56 a0 4c 8d a5 b8 02 00 00 48 89 ea e8 7e b8 c4
  48 89 ee 48 c7 c7 19 13 56 a0 4c 8b ad b0 02 00 00 <48> 8b 00 49
  00 48 8b 80 88 45 00 00 48 c1 e8 08 48
  RSP: 0018:ffff8881063c3c38 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff8881074eb800 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffff888103ab4000 RDI: ffffffffa0561319
  RBP: ffff888103ab4000 R08: 00000000ffffdfff R09: 0000000000000001
  R10: 0000000000000003 R11: ffff88887fecbac0 R12: ffff888103ab42b8
  R13: ffff888106dbe850 R14: 0000000000000003 R15: ffff8881074ebc18
  FS:  00007f02fba6ef00(0000) GS:ffff88885f8c0000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 00000001325e5003 CR4: 0000000000372ea0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   ? __die+0x1f/0x60
   ? page_fault_oops+0x14c/0x3b0
   ? exc_page_fault+0x74/0x140
   ? asm_exc_page_fault+0x22/0x30
   ? _compat_vdpa_reset+0x47/0xc0 [vhost_vdpa]
   ? _compat_vdpa_reset+0x32/0xc0 [vhost_vdpa]
   vhost_vdpa_open+0x55/0x270 [vhost_vdpa]
   ? sb_init_dio_done_wq+0x50/0x50
   chrdev_open+0xc0/0x210
   ? __unregister_chrdev+0x50/0x50
   do_dentry_open+0x1fc/0x4f0
   path_openat+0xc2d/0xf20
   do_filp_open+0xb4/0x160
   ? kmem_cache_alloc+0x3c/0x490
   do_sys_openat2+0x8d/0xc0
   __x64_sys_openat+0x6a/0xa0
   do_syscall_64+0x3c/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 10cbf8dfaf93 ("vhost-vdpa: clean iotlb map during reset for older userspace")
Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Closes: https://lore.kernel.org/all/b4913f84-8b52-4d28-af51-8573dc361f82@oracle.com/
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9ce40003793b..9a2343c45df0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -232,9 +232,11 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 	u32 flags = 0;
 
-	flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
-					    VHOST_BACKEND_F_IOTLB_PERSIST) ?
-		 VDPA_RESET_F_CLEAN_MAP : 0;
+	if (v->vdev.vqs) {
+		flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
+						    VHOST_BACKEND_F_IOTLB_PERSIST) ?
+			 VDPA_RESET_F_CLEAN_MAP : 0;
+	}
 
 	return vdpa_reset(vdpa, flags);
 }
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
