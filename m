Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5FCC004C0
	for <virtualization@archiver.kernel.org>; Sat, 21 Oct 2023 09:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15AC561478;
	Sat, 21 Oct 2023 09:28:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15AC561478
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=HWiKcHjB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cp-LCX2bhFm; Sat, 21 Oct 2023 09:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6DCE66F6BA;
	Sat, 21 Oct 2023 09:28:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DCE66F6BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98AD4C0DD6;
	Sat, 21 Oct 2023 09:28:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0669FC0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D073E84E7C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D073E84E7C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=HWiKcHjB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xKjwrFFyoo0Y
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:23 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA7A184E35
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA7A184E35
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39L4p9o3006653; Sat, 21 Oct 2023 09:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=rQlggAy4pN3gnMyAshWWZTOLkhIWgVAQ+BfTTFPvYKY=;
 b=HWiKcHjBrCws2iHlDd/utuqRN2dvnT7KaKwPBEC1b47MDaHtAnXOwITWsTXOytZLBqJA
 ARO6iK6xwOw0q8Z/LS+Eyf+2FVgDc2oHqj5akN1Xrs3ezAlFG751e2LSNDnUc0ot/RLl
 DljAqYMXOgKyWf8LHinjVFsSOvgFd/vkdax1I+P/UDT/TfeeLJeZOALGgKBLC1LWdXkY
 vk0GViiyD8/Ryc8VwbWbYNn3Z93AAHRn+zpMBu0C6EF7w3mRXs6WpFWRrbkKS7hCSaj9
 FrrGjpGxc0iWkLeiJ28pT1mluyGzuHSKkGQi2FGDUBfzDO6hjzFiQo6OPI0LIcVBDO1l wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e30d30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 09:28:21 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39L6FU6G019120; Sat, 21 Oct 2023 09:28:21 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3tv532gf44-5; Sat, 21 Oct 2023 09:28:20 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v4 4/7] vdpa: introduce .compat_reset operation callback
Date: Sat, 21 Oct 2023 02:25:16 -0700
Message-Id: <1697880319-4937-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210086
X-Proofpoint-GUID: t4g0uzVF_C0BQvuL2EqFkXw28Jb5-LFY
X-Proofpoint-ORIG-GUID: t4g0uzVF_C0BQvuL2EqFkXw28Jb5-LFY
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Some device specific IOMMU parent drivers have long standing bogus
behaviour that mistakenly clean up the maps during .reset. By
definition, this is violation to the on-chip IOMMU ops (i.e. .set_map,
or .dma_map & .dma_unmap) in those offending drivers, as the removal of
internal maps is completely agnostic to the upper layer, causing
inconsistent view between the userspace and the kernel. Some userspace
app like QEMU gets around of this brokenness by proactively removing and
adding back all the maps around vdpa device reset, but such workaround
actually penaltize other well-behaved driver setup, where vdpa reset
always comes with the associated mapping cost, especially for kernel
vDPA devices (use_va=false) that have high cost on pinning. It's
imperative to rectify this behaviour and remove the problematic code
from all those non-compliant parent drivers.

However, we cannot unconditionally remove the bogus map-cleaning code
from the buggy .reset implementation, as there might exist userspace
apps that already rely on the behaviour on some setup. Introduce a
.compat_reset driver op to keep compatibility with older userspace. New
and well behaved parent driver should not bother to implement such op,
but only those drivers that are doing or used to do non-compliant
map-cleaning reset will have to.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/linux/vdpa.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 26ae6ae1eac3..6b8cbf75712d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -252,6 +252,17 @@ struct vdpa_map_file {
  * @reset:			Reset device
  *				@vdev: vdpa device
  *				Returns integer: success (0) or error (< 0)
+ * @compat_reset:		Reset device with compatibility quirks to
+ *				accommodate older userspace. Only needed by
+ *				parent driver which used to have bogus reset
+ *				behaviour, and has to maintain such behaviour
+ *				for compatibility with older userspace.
+ *				Historically compliant driver only has to
+ *				implement .reset, Historically non-compliant
+ *				driver should implement both.
+ *				@vdev: vdpa device
+ *				@flags: compatibility quirks for reset
+ *				Returns integer: success (0) or error (< 0)
  * @suspend:			Suspend the device (optional)
  *				@vdev: vdpa device
  *				Returns integer: success (0) or error (< 0)
@@ -393,6 +404,8 @@ struct vdpa_config_ops {
 	u8 (*get_status)(struct vdpa_device *vdev);
 	void (*set_status)(struct vdpa_device *vdev, u8 status);
 	int (*reset)(struct vdpa_device *vdev);
+	int (*compat_reset)(struct vdpa_device *vdev, u32 flags);
+#define VDPA_RESET_F_CLEAN_MAP 1
 	int (*suspend)(struct vdpa_device *vdev);
 	int (*resume)(struct vdpa_device *vdev);
 	size_t (*get_config_size)(struct vdpa_device *vdev);
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
