Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62476EB64DD
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 12:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D15DD611B7;
	Wed,  9 Aug 2023 12:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D15DD611B7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=MnAOIxZf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ilb3NMXlPi-Y; Wed,  9 Aug 2023 12:56:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D4BA60597;
	Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D4BA60597
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CF12C0071;
	Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0132C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6715260FE2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6715260FE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NRsAeo4y7MkH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:46 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BCE36059B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BCE36059B
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 379CrANB003841; Wed, 9 Aug 2023 12:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=lOxnd7Vk8S1IQl1Nez316tb5aqa+ch/yX4FzpbvPC5U=;
 b=MnAOIxZfjbrX9uTQl0wh4zhhk8W/gtuW9frwNNnTL/WYjGO+hjqxqY+CsjRfOTxPl6Dd
 S/1CrhI/is0QYiaakR4IgCqCVrCth3AV/QymkggzJ935ISVElCL7tCp2I9I+xTwVy0zd
 /sfPNBGfXYIVIixqELxaP0b5qrdG3i41PZZfOAILdrXC6rdJrxCpDMyY/aDevTYc2y5c
 AXAiNmOMzqpudiO6G2RQWtqTClnVjwV/Ry/kkWKv8niL/jRdK21Z8F/1kpiabsD4wWJn
 aSWv+GlFb/JhgHT82/+/HPy+f0Yotyw1Rj9H1HpkTZvYnIsyr3UsYmXfUfrRuu0seW+/ ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9efd8mmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Aug 2023 12:56:45 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 379CFxLK030509; Wed, 9 Aug 2023 12:56:44 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3s9cvdf832-2; Wed, 09 Aug 2023 12:56:44 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH RFC 1/3] vdpa: introduce dedicated descriptor group for
 virtqueue
Date: Wed,  9 Aug 2023 05:54:41 -0700
Message-Id: <1691585683-3948-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=837
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090114
X-Proofpoint-GUID: -8hbKtWLfzKrMVQxNaHWKfFb5w-9ztE1
X-Proofpoint-ORIG-GUID: -8hbKtWLfzKrMVQxNaHWKfFb5w-9ztE1
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

In some cases, the access to the virtqueue's descriptor table (including
the associated available and used ring for split layout) has to be
isolated from guest memory access where the buffer address contained in
vring descriptor points to. Introduce dedicated descriptor group with
driver op .get_vq_desc_group(), denoting the descriptor table portion of a
virtqueue can optionally reside on a different group than what's obtained
via the .get_vq_group() op. The descriptor group may or may not share a
same group ID as the default group of the virtqueue. If the descriptor
group has a different ID, it means the descriptor table portion of the
virtqueue potentially can be placed onto a separate address space than
where guest memory resides. For this to work, .set_group_asid() API will
accept the dedicated group ID for descriptor table to get it associated
to certain ASID, while the .reset() semantics of resetting all groups
(including descriptor table group) back to ASID 0 remain same.

QEMU's shadow virtqueue is going to use dedicated descriptor group not
just to isolate the access between descriptors and buffers, but also
speed up the mapping setup process for shadow vring descriptors.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/linux/vdpa.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db1b0ea..17a4efa 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -204,6 +204,16 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns u32: group id for this virtqueue
+ * @get_vq_desc_group:		Get the group id for the descriptor table of
+ *				a specific virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns u32: group id for the descriptor table
+ *				portion of this virtqueue. Could be different
+ *				than the one from @get_vq_group, in which case
+ *				the access to the descriptor table can be
+ *				confined to a separate asid, isolating from
+ *				the virtqueue's buffer address access.
  * @get_device_features:	Get virtio features supported by the device
  *				@vdev: vdpa device
  *				Returns the virtio features support by the
@@ -357,6 +367,7 @@ struct vdpa_config_ops {
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
 	u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
+	u32 (*get_vq_desc_group)(struct vdpa_device *vdev, u16 idx);
 	u64 (*get_device_features)(struct vdpa_device *vdev);
 	int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
 	u64 (*get_driver_features)(struct vdpa_device *vdev);
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
