Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11A4EB56
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MPXVECQ/"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DBB983DA5
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 20:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DBB983DA5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=MPXVECQ/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GhD16ZifIs-z
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 20:40:31 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CBC2783DA7
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 20:40:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBC2783DA7
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AHuFUC013759;
	Wed, 10 Jan 2024 20:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=yEP4TWDAy69XkemuYw4WGO8L6fdu/vnXGOJdbDSg9O8=;
 b=MPXVECQ/Mr74dQuDn+I/fM2u3GBwwc/5pV0LXpTwH6XcSEXan5Iga7ztzIcQtL2L5a1G
 xaLnPg4A34gKZNLJg2KOwHj/YRk3Al1SIH7AaTA55bXkZTC87tPvTaHecbg/Zd9j/2kQ
 czQbZP5YgtOAH3k7aSevhkN1IR6El4+6PbLLmHMG8b9DTM1z+k3lSuSqKkAgC76xyxx/
 3JZzoiAhAsCPU13/rY37u2LWDDuQ61ytP/ApX5frheeIF9H9js4TBSu1RNdtVvvyC+JD
 K6f35AzH15T8FAszzTf3UGUKlYfv17R3oKDt49krqKxk30wiL+yuNz6od57gLsVmtClf JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhs1x1b3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJJfQ2030062;
	Wed, 10 Jan 2024 20:40:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5x5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrP005067;
	Wed, 10 Jan 2024 20:40:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-1;
	Wed, 10 Jan 2024 20:40:16 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 00/13] vdpa live update
Date: Wed, 10 Jan 2024 12:40:02 -0800
Message-Id: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_10,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=554 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100163
X-Proofpoint-ORIG-GUID: QgvA-PCAnCNlnNiZJFQDskCPJxxozxm-
X-Proofpoint-GUID: QgvA-PCAnCNlnNiZJFQDskCPJxxozxm-
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Live update is a technique wherein an application saves its state, exec's
to an updated version of itself, and restores its state.  Clients of the
application experience a brief suspension of service, on the order of 
100's of milliseconds, but are otherwise unaffected.

Define and implement interfaces that allow vdpa devices to be preserved
across fork or exec, to support live update for applications such as qemu.
The device must be suspended during the update, but its dma mappings are
preserved, so the suspension is brief.

The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
accounting from one process to another.

The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
VHOST_NEW_OWNER is supported.

The VHOST_IOTLB_REMAP message type updates a dma mapping with its userland
address in the new process.

The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
VHOST_IOTLB_REMAP is supported and required.  Some devices do not
require it, because the userland address of each dma mapping is discarded
after being translated to a physical address.

Here is a pseudo-code sequence for performing live update, based on
suspend + reset because resume is not yet available.  The vdpa device
descriptor, fd, remains open across the exec.

  ioctl(fd, VHOST_VDPA_SUSPEND)
  ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
  exec 

  ioctl(fd, VHOST_NEW_OWNER)

  issue ioctls to re-create vrings

  if VHOST_BACKEND_F_IOTLB_REMAP
      foreach dma mapping
          write(fd, {VHOST_IOTLB_REMAP, new_addr})

  ioctl(fd, VHOST_VDPA_SET_STATUS,
            ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)


Steve Sistare (13):
  vhost-vdpa: count pinned memory
  vhost-vdpa: pass mm to bind
  vhost-vdpa: VHOST_NEW_OWNER
  vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
  vhost-vdpa: VHOST_IOTLB_REMAP
  vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
  vhost-vdpa: flush workers on suspend
  vduse: flush workers on suspend
  vdpa_sim: reset must not run
  vdpa_sim: flush workers on suspend
  vdpa/mlx5: new owner capability
  vdpa_sim: new owner capability
  vduse: new owner capability

 drivers/vdpa/mlx5/net/mlx5_vnet.c  |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c   |  24 ++++++-
 drivers/vdpa/vdpa_user/vduse_dev.c |  32 +++++++++
 drivers/vhost/vdpa.c               | 101 +++++++++++++++++++++++++++--
 drivers/vhost/vhost.c              |  15 +++++
 drivers/vhost/vhost.h              |   1 +
 include/uapi/linux/vhost.h         |  10 +++
 include/uapi/linux/vhost_types.h   |  15 ++++-
 8 files changed, 191 insertions(+), 10 deletions(-)

-- 
2.39.3

