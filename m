Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99729EEB572
	for <virtualization@archiver.kernel.org>; Sat,  9 Sep 2023 13:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F75A41DAA;
	Sat,  9 Sep 2023 13:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F75A41DAA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fDEvmQ7y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRC_jyWxDlM9; Sat,  9 Sep 2023 13:46:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A1B041E26;
	Sat,  9 Sep 2023 13:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A1B041E26
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0BBC0071;
	Sat,  9 Sep 2023 13:46:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB05C0DD8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04EB082005
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04EB082005
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fDEvmQ7y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jwsNRb1PXnAJ
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:46:30 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CE5881E97
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 13:46:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CE5881E97
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 389DgGQc011948; Sat, 9 Sep 2023 13:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=vbYMJnEWVzpm1upDJQ24BL55G/RKawOnVA7X5moFr+8=;
 b=fDEvmQ7yfnHr8tMbmxOWBnPy3ZsvVcU1XJ6QTkt7IG4bf+fRZLMm++3rXKcSRAKY6syY
 dmk+/ioWYKKVw4xQsFnTLAs9YVeRiEovWCHFJo00p/mHdWfZbAqLNjRd1mPoMocHaQfX
 I/1oh66+1MtlC264LC0yANvicJbtxu1E86OvO0Sr58dG1Va3uGy3Gb0LavrG/S+E06sc
 1xmQZAvuBxA4Jl59l3HtCPD6od3pPnjp8+DRrGe9ormecwd/5OWZXpFql6Hd2u80yYaA
 pyG+vElIumLrUtwzImeosW9FNcdbGetBCWCKMRMJGO6Z38CcHayGEwKd+Qy/ZP5uQBsv SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0ssm804j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 13:46:25 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 389A1UVB007574; Sat, 9 Sep 2023 13:46:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3t0f52mh12-4; Sat, 09 Sep 2023 13:46:24 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Subject: [PATCH RFC v3 3/4] vhost-vdpa: should restore 1:1 dma mapping before
 detaching driver
Date: Sat,  9 Sep 2023 06:43:58 -0700
Message-Id: <1694267039-718-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694267039-718-1-git-send-email-si-wei.liu@oracle.com>
References: <1694267039-718-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090124
X-Proofpoint-ORIG-GUID: XmuV_WUS-ae4Fy1C9aKQ5Ypl2nv3cDwU
X-Proofpoint-GUID: XmuV_WUS-ae4Fy1C9aKQ5Ypl2nv3cDwU
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

Devices with on-chip IOMMU may need to restore iotlb to 1:1 identity
mapping from IOVA to PA. Before vhost-vdpa is going away, give them
a chance to clean up and reset iotlb back to 1:1 identify mapping
mode. This is done so that any vdpa bus driver may start with 1:1
identity mapping by default.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index eabac06..71fbd559 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
 	return vhost_vdpa_alloc_as(v, asid);
 }
 
+static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (ops->reset_map)
+		ops->reset_map(vdpa, asid);
+}
+
 static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 {
 	struct vhost_vdpa_as *as = asid_to_as(v, asid);
@@ -140,6 +149,14 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 
 	hlist_del(&as->hash_link);
 	vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
+	/*
+	 * Devices with on-chip IOMMU need to restore iotlb
+	 * to 1:1 identity mapping before vhost-vdpa is going
+	 * to be removed and detached from the device. Give
+	 * them a chance to do so, as this cannot be done
+	 * efficiently via the whole-range unmap call above.
+	 */
+	vhost_vdpa_reset_map(v, asid);
 	kfree(as);
 
 	return 0;
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
