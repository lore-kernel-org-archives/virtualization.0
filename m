Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A1C001B0
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 12:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50224611F8;
	Wed,  9 Aug 2023 12:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50224611F8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=x+nGvJkB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLww9tqocctK; Wed,  9 Aug 2023 12:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C9BAA6119B;
	Wed,  9 Aug 2023 12:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9BAA6119B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7F25C0DD7;
	Wed,  9 Aug 2023 12:56:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EDC5C0DD6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A3BE8216C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A3BE8216C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=x+nGvJkB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7_LBCFWwOE8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:47 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 849ED82127
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 849ED82127
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 379CrbaY001769; Wed, 9 Aug 2023 12:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=zzG0zcf6t2ayfD6iDUDXPBgadsk0gvptgjNEEQA8wK4=;
 b=x+nGvJkB/E4S299+7e4ngWLYvJapVAN+W2x9WujpO7d9DMoP4Hv2Xi8e4pEpPMVmBQ5q
 nkw/GE5IV9CEFqNJ6J5vCOO+Ph7KuWPgaoQtOTm8UWZcBH+LTlOpClEgj0ykNse9zMzZ
 3Xfk9bD3fyiXMvBIDuDcOO8li+xef2IlvCtAxFTrgd0tSkHrBzICbjyjpkag8gVHlxKf
 Bi4zISoqvYIpHUcU+RH4K5UNt5NRsNjwNygTXie9dKvrQB96Tu2iTDFaN6tf76tS9mid
 JsGdRNLR2TRM/7aPZXcLlM2kWRJzRKif1PTUFVzAAB7kVxBlRJqMtMC0hm07N69TOebZ Hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u8h51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Aug 2023 12:56:46 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 379CFxLL030509; Wed, 9 Aug 2023 12:56:45 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3s9cvdf832-3; Wed, 09 Aug 2023 12:56:45 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH RFC 2/3] vhost-vdpa: introduce descriptor group backend feature
Date: Wed,  9 Aug 2023 05:54:42 -0700
Message-Id: <1691585683-3948-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=862
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090114
X-Proofpoint-GUID: tNLRNvMTjxjMkMS600zcFWxeoI0goGny
X-Proofpoint-ORIG-GUID: tNLRNvMTjxjMkMS600zcFWxeoI0goGny
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

Userspace knows if the device has dedicated descriptor group or not
by checking this feature bit.

It's only exposed if the vdpa driver backend implements the
.get_vq_desc_group() operation callback. Userspace trying to negotiate
this feature when it or the dependent _F_IOTLB_ASID feature hasn't
been exposed will result in an error.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c             | 17 +++++++++++++++++
 include/uapi/linux/vhost_types.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b43e868..f2e5dce 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -389,6 +389,14 @@ static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
 	return ops->resume;
 }
 
+static bool vhost_vdpa_has_desc_group(const struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	return ops->get_vq_desc_group;
+}
+
 static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -679,6 +687,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if (copy_from_user(&features, featurep, sizeof(features)))
 			return -EFAULT;
 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
+				 BIT_ULL(VHOST_BACKEND_F_DESC_ASID) |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
 			return -EOPNOTSUPP;
@@ -688,6 +697,12 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
 		     !vhost_vdpa_can_resume(v))
 			return -EOPNOTSUPP;
+		if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
+		    !(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)))
+			return -EINVAL;
+		if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
+		     !vhost_vdpa_has_desc_group(v))
+			return -EOPNOTSUPP;
 		vhost_set_backend_features(&v->vdev, features);
 		return 0;
 	}
@@ -741,6 +756,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
 		if (vhost_vdpa_can_resume(v))
 			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
+		if (vhost_vdpa_has_desc_group(v))
+			features |= BIT_ULL(VHOST_BACKEND_F_DESC_ASID);
 		if (copy_to_user(featurep, &features, sizeof(features)))
 			r = -EFAULT;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d3aad12a..0856f84 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -181,5 +181,10 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_SUSPEND  0x4
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
+/* Device may expose the descriptor table, avail and used ring in a
+ * different group for ASID binding than the buffers it contains.
+ * Requires VHOST_BACKEND_F_IOTLB_ASID.
+ */
+#define VHOST_BACKEND_F_DESC_ASID    0x6
 
 #endif
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
