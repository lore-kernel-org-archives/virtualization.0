Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE711CD68E5
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 09:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8902B4094F;
	Tue, 10 Oct 2023 09:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8902B4094F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=w9y8s1ug
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LMa0QLr3aU2D; Tue, 10 Oct 2023 09:05:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E1E0B40A90;
	Tue, 10 Oct 2023 09:05:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1E0B40A90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C4BC0071;
	Tue, 10 Oct 2023 09:05:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB46AC0DE3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 09:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 885E140131
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 09:05:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 885E140131
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aD34RwqJpjHr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 09:05:39 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E732E4000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 09:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E732E4000B
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39A800V7017503; Tue, 10 Oct 2023 09:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=V9hW5xCiXKTlut56vA+Ni1Kl2uT76zDTn5zdh6DLiTc=;
 b=w9y8s1ugO04ALPsNP6Cg6U4csoUtVhu2xwJnClmxPWIJ50FoUdUeBLFuBM9Aism5BUH0
 zry4gQhoEt+6MsYCKiIbtr/ytI9AyfSs0EY6EtddJReTNX932O7d3GVDbgx+p8Nn/Hiw
 rTsbDOO74fcRtiLK27rmH0Nv7Hx/nZIC1myhoyEtMtKyRV85vjZqKxzUyCoE/X+HnxFF
 my8tkPMqKJnKSeef+dAVCFeC4Fxsjrk4C/Vqwb+DXSR+gJITYgW1auXDchu2jUogQUSd
 L2TSM4l2qdq39u+y4J7VJgU9yKwYvwAEM+QrEM1BoCzrm2wl19ibfNI6Myyr8jZ1fuo+ Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cck99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 09:05:35 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39A6sxrC021395; Tue, 10 Oct 2023 09:05:34 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3tjwsc5cy2-1; Tue, 10 Oct 2023 09:05:34 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Subject: [PATCH 0/4] vdpa: decouple reset of iotlb mapping from device reset
Date: Tue, 10 Oct 2023 02:02:56 -0700
Message-Id: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100067
X-Proofpoint-ORIG-GUID: 8Ide89K5gZkO8He6usVpDSFLh-m0Q4Np
X-Proofpoint-GUID: 8Ide89K5gZkO8He6usVpDSFLh-m0Q4Np
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

In order to reduce needlessly high setup and teardown cost
of iotlb mapping during live migration, it's crucial to
decouple the vhost-vdpa iotlb abstraction from the virtio
device life cycle, i.e. iotlb mappings should be left
intact across virtio device reset [1]. For it to work, the
on-chip IOMMU parent device could implement a separate
.reset_map() operation callback to restore 1:1 DMA mapping
without having to resort to the .reset() callback, the
latter of which is mainly used to reset virtio device state.
This new .reset_map() callback will be invoked only before
the vhost-vdpa driver is to be removed and detached from
the vdpa bus, such that other vdpa bus drivers, e.g. 
virtio-vdpa, can start with 1:1 DMA mapping when they
are attached. For the context, those on-chip IOMMU parent
devices, create the 1:1 DMA mapping at vdpa device creation,
and they would implicitly destroy the 1:1 mapping when
the first .set_map or .dma_map callback is invoked.

This patchset is based off of the descriptor group v3 series
from Dragos. [2]

[1] Reducing vdpa migration downtime because of memory pin / maps
https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
[2] [PATCH vhost v3 00/16] vdpa: Add support for vq descriptor mappings
https://lore.kernel.org/lkml/20231009112401.1060447-1-dtatulea@nvidia.com/

---
v1:
- rewrote commit messages to include more detailed description and background
- reword to vendor specific IOMMU implementation from on-chip IOMMU
- include parent device backend feautres to persistent iotlb precondition
- reimplement mlx5_vdpa patch on top of descriptor group series

RFC v3:
- fix missing return due to merge error in patch #4

RFC v2:
- rebased on top of the "[PATCH RFC v2 0/3] vdpa: dedicated descriptor table group" series:
  https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com/

---

Si-Wei Liu (4):
  vdpa: introduce .reset_map operation callback
  vhost-vdpa: reset vendor specific mapping to initial state in .release
  vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
  vdpa/mlx5: implement .reset_map driver op

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 17 +++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 18 +++++++++++++-----
 drivers/vhost/vdpa.c               | 31 +++++++++++++++++++++++++++++++
 include/linux/vdpa.h               | 10 ++++++++++
 include/uapi/linux/vhost_types.h   |  2 ++
 6 files changed, 74 insertions(+), 5 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
