Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E1C25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 07:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F253E830C2;
	Thu, 26 Oct 2023 07:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F253E830C2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=dtiBETwY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o1s7l4b_dyv4; Thu, 26 Oct 2023 07:17:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7DD69830A8;
	Thu, 26 Oct 2023 07:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DD69830A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5256DC0071;
	Thu, 26 Oct 2023 07:17:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E37CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 732CD61126
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 732CD61126
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=dtiBETwY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16DnJkPt1T7E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:27 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60C1C61125
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60C1C61125
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39Q3TVX3026203; Thu, 26 Oct 2023 07:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=X3a3iMFmYQw/CMdUXMYbinGUijqCuBut6pJA3oZ9q40=;
 b=dtiBETwYeqenKYB3667NRLSJibQtUKO2SmxLXMuzkC4GzWTS9iNMrShenwsaw+LWVsHL
 YhGJWG+Kx+DPW2yRhmpLoBCggkQsr7oC/Kuh36dRmhhK4YxL/cI9DgCDhSAfx0Yv1VAC
 3fWHTMoy5O3sQezUTYgw6EEl+zzF+BnkYGzCPcNvummZEbB+Xxs8Nl2tsKXzgXYLC3Ao
 RiXToDrIvXkq79MPuWBLgMK/0Ic+IxBnpTNkiEvHo30DuwfJmJ9EPeieA5rqVLLvO/Kq
 FcRwzyP7rUPprxuXnvn2flA5TLl6dj61wek71Ad2iQ1FXNEV+sZ5FI5ZG+2DXltlnG/F Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52e2bvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 07:17:26 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39Q6tbAE015200; Thu, 26 Oct 2023 07:17:25 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3tv537t53r-1; Thu, 26 Oct 2023 07:17:24 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v5 0/7] vdpa: decouple reset of iotlb mapping from device reset
Date: Thu, 26 Oct 2023 00:14:33 -0700
Message-Id: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260060
X-Proofpoint-ORIG-GUID: qJzScXUnYZ5ovVfehxHlTl8PaF3d8GsY
X-Proofpoint-GUID: qJzScXUnYZ5ovVfehxHlTl8PaF3d8GsY
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

This patchset is rebased on top of the latest vhost tree.

[1] Reducing vdpa migration downtime because of memory pin / maps
https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html

---
v5:
- Squashed two fixups to the clean map patch

v4:
- Rework compatibility using new .compat_reset driver op

v3:
- add .reset_map support to vdpa_sim
- introduce module parameter to provide bug-for-bug compatibility with older
  userspace 

v2:
- improved commit message to clarify the intended csope of .reset_map API
- improved commit messages to clarify no breakage on older userspace

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

Si-Wei Liu (7):
  vdpa: introduce .reset_map operation callback
  vhost-vdpa: reset vendor specific mapping to initial state in .release
  vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
  vdpa: introduce .compat_reset operation callback
  vhost-vdpa: clean iotlb map during reset for older userspace
  vdpa/mlx5: implement .reset_map driver op
  vdpa_sim: implement .reset_map support

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 17 ++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 27 ++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 52 ++++++++++++++++++++++++------
 drivers/vhost/vdpa.c               | 52 +++++++++++++++++++++++++++---
 drivers/virtio/virtio_vdpa.c       |  2 +-
 include/linux/vdpa.h               | 30 +++++++++++++++--
 include/uapi/linux/vhost_types.h   |  2 ++
 8 files changed, 164 insertions(+), 19 deletions(-)

-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
