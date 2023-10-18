Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F3CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 05:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4A6541DE6;
	Wed, 18 Oct 2023 05:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4A6541DE6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=0A+sh3TU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llISnq0lVisC; Wed, 18 Oct 2023 05:14:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FAE041B95;
	Wed, 18 Oct 2023 05:14:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FAE041B95
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFD4EC0039;
	Wed, 18 Oct 2023 05:14:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B109C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D488A81A50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D488A81A50
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=0A+sh3TU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id erNoPKD3JSSa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:14:14 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B69CA81444
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B69CA81444
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HJwpYv015737; Wed, 18 Oct 2023 05:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=iUNSO/bYR9F/qcPJc1+lRcxI13H2YKnKpW68eyRCbEo=;
 b=0A+sh3TUnM6mQ083lKq3P5JZY8EsR8bCUvUfpFfFepiSG4V9WniDC8ua0ltWjsnAx8ih
 6tzYReL5bbPR+PmCWR/me7WXd0n9Ug3T5HwoAACq3vGFwU3wJrrD1j2QWYji3Fyb02ZF
 obP4sgXYySfn4clhs1xunbcvKZDegr8N/R5yPyENWgU6yBlF50rROcn4a+24m1f3PiSB
 jmQrEBKzx5qLSl+iUe1Un6jlqSKMP3bsPlL4WND3lpt0kLSMyPSOpC/Q9eX+WibQ45Sm
 OZ0bP9ED+5YcJrquB6yzxyqjMhts0wn2OSKWOlE6iKjs+hvIqE0mx3tsT6LEIcjDcKmM cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjynepeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 05:14:13 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39I49CXR021681; Wed, 18 Oct 2023 05:14:12 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3trg51ycja-1; Wed, 18 Oct 2023 05:14:12 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com
Subject: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Date: Tue, 17 Oct 2023 22:11:33 -0700
Message-Id: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180044
X-Proofpoint-GUID: 6TIiuHvcMa6pdS6WnxcIN-uqP71R4NJO
X-Proofpoint-ORIG-GUID: 6TIiuHvcMa6pdS6WnxcIN-uqP71R4NJO
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

RFC only. Not tested on vdpa-sim-blk with user virtual address.
Works fine with vdpa-sim-net which uses physical address to map.

This patch is based on top of [1].

[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

---
RFC v2:
  - initialize iotlb to passthrough mode in device add
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 34 ++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 76d41058add9..2a0a6042d61d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -151,13 +151,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 				 &vdpasim->iommu_lock);
 	}
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
-		vhost_iotlb_reset(&vdpasim->iommu[i]);
-		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
-				      0, VHOST_MAP_RW);
-		vdpasim->iommu_pt[i] = true;
-	}
-
 	vdpasim->running = true;
 	spin_unlock(&vdpasim->iommu_lock);
 
@@ -259,8 +252,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	if (!vdpasim->iommu_pt)
 		goto err_iommu;
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
+	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
+		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX, 0,
+				      VHOST_MAP_RW);
+		vdpasim->iommu_pt[i] = true;
+	}
 
 	for (i = 0; i < dev_attr->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
@@ -637,6 +634,25 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
 	return ret;
 }
 
+static int vdpasim_reset_map(struct vdpa_device *vdpa, unsigned int asid)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (asid >= vdpasim->dev_attr.nas)
+		return -EINVAL;
+
+	spin_lock(&vdpasim->iommu_lock);
+	if (vdpasim->iommu_pt[asid])
+		goto out;
+	vhost_iotlb_reset(&vdpasim->iommu[asid]);
+	vhost_iotlb_add_range(&vdpasim->iommu[asid], 0, ULONG_MAX,
+			      0, VHOST_MAP_RW);
+	vdpasim->iommu_pt[asid] = true;
+out:
+	spin_unlock(&vdpasim->iommu_lock);
+	return 0;
+}
+
 static int vdpasim_bind_mm(struct vdpa_device *vdpa, struct mm_struct *mm)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -759,6 +775,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_group_asid         = vdpasim_set_group_asid,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
+	.reset_map              = vdpasim_reset_map,
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
@@ -796,6 +813,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_group_asid         = vdpasim_set_group_asid,
 	.set_map                = vdpasim_set_map,
+	.reset_map              = vdpasim_reset_map,
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
