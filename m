Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710D2C04A94
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 12:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA7FD60FE2;
	Wed,  9 Aug 2023 12:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA7FD60FE2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=I8Jlr3uR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tfq7on49w5Em; Wed,  9 Aug 2023 12:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D571611DD;
	Wed,  9 Aug 2023 12:56:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D571611DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED38FC0DD9;
	Wed,  9 Aug 2023 12:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF61FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 983F540C6C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 983F540C6C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=I8Jlr3uR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zAKqFyd6-RtC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA471409AD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA471409AD
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 379CrDeU009152; Wed, 9 Aug 2023 12:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=PwqbrPAMlguA1Wr1oMTiW68K4Ea22MPJy3PTEDT8a8s=;
 b=I8Jlr3uRafChvhCuLGXwG5vb03GCdqFdoraX4xKV/potCYsjnDGpuyMfrJWfWyE1ag23
 +RiB4t0ApfYptNDL+TnPI1lnJVkF1xYHbdLcxJwicmDjB3bg7W0Y+RprV+NaKyPRBmuI
 lPvhv8xVeNFemz1ybgxJDuh5B+MzRkYiV9RZLCeLE3ocX3hKlQY4W5j+IyFv1EGHvfIK
 nAIQ+ujKUR4ltCLbuwge4COSgMrAk4NXH8qWGl7PNBQ4JUGv6bcV8SVnZSjX7paF+hKY
 pG8kJU4DyUDmHYPT1/wzRAArQWOWTfebeU0dVq0NcSU4fBp+72HYcskuvLBOgCKupz4d WQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc8n28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Aug 2023 12:56:47 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 379CFxLN030509; Wed, 9 Aug 2023 12:56:46 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3s9cvdf832-4; Wed, 09 Aug 2023 12:56:46 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH RFC 3/3] vhost-vdpa: uAPI to get dedicated descriptor group id
Date: Wed,  9 Aug 2023 05:54:43 -0700
Message-Id: <1691585683-3948-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=667
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090114
X-Proofpoint-ORIG-GUID: qzYvtcjap7rI1-gEYvaEIHRmHyYuSwFe
X-Proofpoint-GUID: qzYvtcjap7rI1-gEYvaEIHRmHyYuSwFe
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

With _F_DESC_ASID backend feature, the device can now support the
VHOST_VDPA_GET_VRING_DESC_GROUP ioctl, and it may expose the descriptor
table (including avail and used ring) in a different group than the
buffers it contains. This new uAPI will fetch the group ID of the
descriptor table.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c       | 10 ++++++++++
 include/uapi/linux/vhost.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index f2e5dce..eabac06 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -602,6 +602,16 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		else if (copy_to_user(argp, &s, sizeof(s)))
 			return -EFAULT;
 		return 0;
+	case VHOST_VDPA_GET_VRING_DESC_GROUP:
+		if (!vhost_vdpa_has_desc_group(v))
+			return -EOPNOTSUPP;
+		s.index = idx;
+		s.num = ops->get_vq_desc_group(vdpa, idx);
+		if (s.num >= vdpa->ngroups)
+			return -EIO;
+		else if (copy_to_user(argp, &s, sizeof(s)))
+			return -EFAULT;
+		return 0;
 	case VHOST_VDPA_SET_GROUP_ASID:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index f5c48b6..05faad2 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -219,4 +219,12 @@
  */
 #define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
 
+/* Get the dedicated group for the descriptor table of a virtqueue:
+ * read index, write group in num.
+ * The virtqueue index is stored in the index field of vhost_vring_state.
+ * The group id for the descriptor table of this specific virtqueue
+ * is returned via num field of vhost_vring_state.
+ */
+#define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
+					      struct vhost_vring_state)
 #endif
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
