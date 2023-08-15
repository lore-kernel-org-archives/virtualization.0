Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E97C04A6A
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 01:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A38D381DE1;
	Tue, 15 Aug 2023 01:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A38D381DE1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=EpEKazCt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oK4RLMGMfIBj; Tue, 15 Aug 2023 01:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1366E81D68;
	Tue, 15 Aug 2023 01:45:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1366E81D68
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43C90C0DD3;
	Tue, 15 Aug 2023 01:45:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A23C3C0072
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68C9560BBC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68C9560BBC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=EpEKazCt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5v77Q5IYAJg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:45:36 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84E7960B22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 01:45:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84E7960B22
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37EJOsfN023645; Tue, 15 Aug 2023 01:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=isLDdj55dk3TEYOF3O/6pe8yWHbfvkmHF+RBga3O+1k=;
 b=EpEKazCtzr8oFp04jVmlrIuYhQ+XuvzBJ1akiD4OW3muRgTSQrhQ83KM6hzOdjcsf+NU
 AduombdrV+KbnwcwYuFydJALBiafNJ0ungtBfY8DZ8wLp3xA0eRaYaolrOV8jRViw+QK
 Kx7eBw+Vr8Rnko96zPcGgnT9Gy37fCsR4HMx5puAh8gmZuZ3W+aQoHncW3mr5kKIV0fg
 W/dvsN44YZ2zVU+N+I0yumHPUNeq00jtPzIwrgA0wYoMcj4p3wuRF3jSb4WkJ8QRmhJ6
 jIeSA7kfXICvnplwMu0pAe3zAo2ijLPx4/XjyGAZyHWV7ulXrEJrcYZ7osJ7Q7bAWO9q Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5uusu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 01:45:31 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37ENi3ET006666; Tue, 15 Aug 2023 01:45:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey2ckehp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 01:45:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F1jTK7011831;
 Tue, 15 Aug 2023 01:45:29 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3sey2ckehb-1; Tue, 15 Aug 2023 01:45:29 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com
Subject: [PATCH RFC 0/4] vdpa: decouple reset of iotlb mapping from device
 reset
Date: Mon, 14 Aug 2023 18:43:23 -0700
Message-Id: <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150013
X-Proofpoint-ORIG-GUID: MkglPRxJV_rjwCHNdD2PANq_ld-vgh2d
X-Proofpoint-GUID: MkglPRxJV_rjwCHNdD2PANq_ld-vgh2d
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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
on-chip IOMMU parent device should implement a separate
.reset_map() operation callback to restore 1:1 DMA mapping
without having to resort to the .reset() callback, which
is mainly used to reset virtio specific device state.
This new .reset_map() callback will be invoked only when
the vhost-vdpa driver is to be removed and detached from
the vdpa bus, such that other vdpa bus drivers, e.g. 
virtio-vdpa, can get back on 1:1 DMA mapping when they
are attached. For the context, those on-chip IOMMU parent
devices, create the 1:1 DMA mapping at vdpa device add,
and they would implicitly destroy the 1:1 mapping when
the first .set_map or .dma_map callback is invoked.

[1] Reducing vdpa migration downtime because of memory pin / maps
https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html

---

Si-Wei Liu (4):
  vdpa: introduce .reset_map operation callback
  vdpa/mlx5: implement .reset_map driver op
  vhost-vdpa: should restore 1:1 dma mapping before detaching driver
  vhost-vdpa: introduce IOTLB_PERSIST backend feature bit

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 72 +++++++++++++++++++++-----------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 18 +++++++---
 drivers/vhost/vdpa.c               | 33 ++++++++++++++++-
 include/linux/vdpa.h               |  7 ++++
 include/uapi/linux/vhost_types.h   |  2 ++
 6 files changed, 95 insertions(+), 38 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
