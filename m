Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47188EEB572
	for <virtualization@archiver.kernel.org>; Sat,  9 Sep 2023 13:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8CA061019;
	Sat,  9 Sep 2023 13:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8CA061019
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=pHbSN+EJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gw4uvLDdrT97; Sat,  9 Sep 2023 13:40:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85A3261024;
	Sat,  9 Sep 2023 13:40:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85A3261024
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 559B2C0071;
	Sat,  9 Sep 2023 13:40:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8D69C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C95C94169B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:40:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C95C94169B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=pHbSN+EJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9emfLJnFOgge
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:40:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3C0541603
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:40:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3C0541603
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 389DUC5t002081; Sat, 9 Sep 2023 13:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=XuUKUzB3YN3yP+u3j1mJSSBRfv9vUl7xjjThWQubZnA=;
 b=pHbSN+EJrQrU5qRFjfBSzXrkStvAJxvaureLLdhiE3lWWP1Sk+YSzMLkGGKKZKwtNkmo
 534nzhyKULsS9MCrrnM02NwOGfuuNBt2utUUiQMOiwR3hJF8nT49HyDxNCWfsezXMPGV
 FY726miCaXmsGFFhJmiMusealUkdm7aNpiJwWRr6HjzWkHOlwAKum//n3pbvFob0o9CC
 gV1y/WMja709jCDuhkj3IQidp5GvHQk0jFHFskoiNQq2eUbRGHf05/F5i3uLES7Q3Uj2
 FV7F+gLnb0p1nMSKeg0681CDk6D1YmXPHh3T7s2OqBVRlCZy+bhLdTwrk3nJ39WBJQ9F bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0sn2g0db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 13:40:12 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 389D22JJ023060; Sat, 9 Sep 2023 13:34:19 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3t0f52vccr-5; Sat, 09 Sep 2023 13:34:19 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Subject: [PATCH RFC v2 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Date: Sat,  9 Sep 2023 06:31:59 -0700
Message-Id: <1694266319-32287-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694266319-32287-1-git-send-email-si-wei.liu@oracle.com>
References: <1694266319-32287-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090123
X-Proofpoint-GUID: Q_iG6F6yswQnIqRld4C9LHwyhuwF_wgt
X-Proofpoint-ORIG-GUID: Q_iG6F6yswQnIqRld4C9LHwyhuwF_wgt
Cc: virtualization@lists.linux-foundation.org
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

Userspace needs this feature flag to distinguish if vhost-vdpa
iotlb in the kernel supports persistent IOTLB mapping across
device reset. There are two cases that backend may claim
this feature bit on:

- parent device that has to work with platform IOMMU
- parent device with on-chip IOMMU that has the expected
  .reset_map support in driver

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c             | 15 ++++++++++++++-
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 71fbd559..bbb1092 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -414,6 +414,14 @@ static bool vhost_vdpa_has_desc_group(const struct vhost_vdpa *v)
 	return ops->get_vq_desc_group;
 }
 
+static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	return (!ops->set_map && !ops->dma_map) || ops->reset_map;
+}
+
 static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -716,7 +724,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
 				 BIT_ULL(VHOST_BACKEND_F_DESC_ASID) |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
-				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
+				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
+				 BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
@@ -729,6 +738,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			return -EINVAL;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
 		     !vhost_vdpa_has_desc_group(v))
+		if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &&
+		     !vhost_vdpa_has_persistent_map(v))
 			return -EOPNOTSUPP;
 		vhost_set_backend_features(&v->vdev, features);
 		return 0;
@@ -785,6 +796,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
 		if (vhost_vdpa_has_desc_group(v))
 			features |= BIT_ULL(VHOST_BACKEND_F_DESC_ASID);
+		if (vhost_vdpa_has_persistent_map(v))
+			features |= BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST);
 		if (copy_to_user(featurep, &features, sizeof(features)))
 			r = -EFAULT;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 6acc604..0fdb6f0 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -186,5 +186,7 @@ struct vhost_vdpa_iova_range {
  * buffers may reside. Requires VHOST_BACKEND_F_IOTLB_ASID.
  */
 #define VHOST_BACKEND_F_DESC_ASID    0x6
+/* IOTLB don't flush memory mapping across device reset */
+#define VHOST_BACKEND_F_IOTLB_PERSIST  0x7
 
 #endif
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
