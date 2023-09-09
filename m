Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41095EEB58C
	for <virtualization@archiver.kernel.org>; Sat,  9 Sep 2023 13:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEE5981E70;
	Sat,  9 Sep 2023 13:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEE5981E70
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=XRTLdUqj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAXT6Lh3ytWY; Sat,  9 Sep 2023 13:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 358D281E97;
	Sat,  9 Sep 2023 13:34:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 358D281E97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ED77C0DD2;
	Sat,  9 Sep 2023 13:34:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 525ABC0071
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DC434064D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:34:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DC434064D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=XRTLdUqj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0jYMS3o_u6xO
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:34:36 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 927DE40407
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 927DE40407
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 389DU4Fb002052; Sat, 9 Sep 2023 13:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=i/R+hZszIojuSKEkahnln0XrxFnHZtMMbCWAtpJop40=;
 b=XRTLdUqjHarXbTfBG8upzodjV3RuAEZxpIKXrPQNO/XdOhVWOIhkh9pQxDPIIZRe7yW+
 osis1zk1JfaAcVeL0ad6RvN7kUTk/WwK8FUS+TlaTAoX8NCfvOYgowDZ+LyB9UaS4z9n
 Y/o/lEhBquSmb64RxC9UF5uN7duVkV+wPebNE0CKXCbIM5L8d7rN4dfX5d3w3NXar0vn
 Up4jH/T0fSvzdGZueOh3CPqaiVLg+IH9QvREOkc/fxpPP6FKedxPMUOiBnBYGGpmXBlc
 a7r2FU8r6+lvOQ9xOd9kKLh3LAqKW5SWhs7WKa/7RA2OyCPmrqOVJU//lR2lsjfufmvO UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0sn2g02f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 13:34:29 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 389D22JG023060; Sat, 9 Sep 2023 13:34:17 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3t0f52vccr-2; Sat, 09 Sep 2023 13:34:16 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Subject: [PATCH RFC v2 1/4] vdpa: introduce .reset_map operation callback
Date: Sat,  9 Sep 2023 06:31:56 -0700
Message-Id: <1694266319-32287-2-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: qVrLz_8y8LwtctmR2V3ZHdjTQfYi5GUf
X-Proofpoint-ORIG-GUID: qVrLz_8y8LwtctmR2V3ZHdjTQfYi5GUf
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

On-chip IOMMU parent driver could use it to restore memory mapping
to the initial state.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/linux/vdpa.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 17a4efa..daecf55 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -324,6 +324,12 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @reset_map:			Reset device memory mapping (optional)
+ *				Needed for device that using device
+ *				specific DMA translation (on-chip IOMMU)
+ *				@vdev: vdpa device
+ *				@asid: address space identifier
+ *				Returns integer: success (0) or error (< 0)
  * @get_vq_dma_dev:		Get the dma device for a specific
  *				virtqueue (optional)
  *				@vdev: vdpa device
@@ -401,6 +407,7 @@ struct vdpa_config_ops {
 		       u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
 			 u64 iova, u64 size);
+	int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
 	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
