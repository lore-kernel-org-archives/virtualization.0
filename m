Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13513667D
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016742; cv=none; b=d4hy4XZwjBu/PohCOhSgne9qr4fJOAGGIdcf8Srf2FfsmepoPihChDAFZIp0bFYkrTPvN4cImY0gRJ9XZucAwu78TLo+Z4PzVOS1hPndgH56noBSQ44J1vKH3WGk+Pz9ekkVbIGbEpry+td3W8MctZfLQurAZrZIq98vM6orA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016742; c=relaxed/simple;
	bh=jHG9H8i9qhAeOn57Plf+Ex4DiuuEmdAlsRWhZjMgxes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HzwOELKDfU0ZaqY6gBMs8EkgLUP71/b7/KIZ6lPQu3jBXEDazVYfCnj34mN16JOe1Z6j5Whlcf/pGoK99uNkzbvs9fBigxWiB0A18QT8FYgyc5zWG/jUM6TpQfdOIvlPU3hb8rS5M38eaSsVPptL7u4+fSegcQeVKaLFq0MFmWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NkxVgyAC; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NkxVgyAC"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5B7D40210
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 17:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VijOF-DEUFzB
	for <virtualization@lists.linux-foundation.org>;
	Thu, 15 Feb 2024 17:05:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=jonah.palmer@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1674440163
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1674440163
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=NkxVgyAC
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1674440163
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 17:05:27 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFT4t2022495;
	Thu, 15 Feb 2024 17:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=PJ/JEvX0jmjLAMAQh6ULKyKsJAdiUkLyj1BxUN+t8+0=;
 b=NkxVgyACq+1iT7M/+n09tmgGM/jHGjgFoKaNppR/dtWK6JxHs4JMIvFKbrgBBZxmzS2L
 iPZLpwUtxZ3fcnuNWbTr4Nuqc2tKqn5swrO1iMjsH+qENzeeNXbvCMDPldxeM/IW/uoN
 0aXtrSbfqcNVDfMWkXWXbck9sIdxBAQC/fk0uUS+8nQDTKSnjwYW285xaikeM/NIDG4P
 E87jhU1CfpJ7h0nNo3HLrjZHo0J45CASSjPO+69bAkA/1U1lxYznuPNJFh1Xok/8ac1H
 n1wf4NRpLS6JMEGLRbE9IApE195ayvRrkZGmaPz1JRPkpHxLZ8LrtbBlU5/XJzdF6gqk nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db2rmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:05:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FG5PWx013766;
	Thu, 15 Feb 2024 17:05:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apdpuwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:05:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FH28Gp005056;
	Thu, 15 Feb 2024 17:05:24 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-162-170.vpn.oracle.com [10.65.162.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w6apdpuv4-1;
	Thu, 15 Feb 2024 17:05:24 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: eperezma@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org
Cc: dtatulea@nvidia.com, jonah.palmer@oracle.com, boris.ostrovsky@oracle.com,
        leiyang@redhat.com
Subject: vdpa/mlx5: Allow CVQ size changes
Date: Thu, 15 Feb 2024 12:05:07 -0500
Message-Id: <20240215170507.3865986-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_16,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150137
X-Proofpoint-GUID: p19iuPOhisQgpcUR8rM3f5ySjTekpx77
X-Proofpoint-ORIG-GUID: p19iuPOhisQgpcUR8rM3f5ySjTekpx77

The MLX driver was not updating its control virtqueue size at set_vq_num
and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
setup_cvq_vring.

Qemu would try to set the size to 64 by default, however, because the
CVQ size always was initialized to 16, an error would be thrown when
sending >16 control messages (as used-ring entry 17 is initialized to 0).
For example, starting a guest with x-svq=on and then executing the
following command would produce the error below:

 # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done

 qemu-system-x86_64: Insufficient written data (0)
 [  435.331223] virtio_net virtio0: Failed to set mac address by vq command.
 SIOCSIFHWADDR: Invalid argument

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 778821bab7d9..c74de1fe6a94 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2276,9 +2276,15 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
 
-	if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
+	if (!is_index_valid(mvdev, idx))
 		return;
 
+        if (is_ctrl_vq_idx(mvdev, idx)) {
+                struct mlx5_control_vq *cvq = &mvdev->cvq;
+                cvq->vring.vring.num = num;
+                return;
+        }
+
 	mvq = &ndev->vqs[idx];
 	mvq->num_ent = num;
 }
@@ -2963,7 +2969,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 		u16 idx = cvq->vring.last_avail_idx;
 
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
-					MLX5_CVQ_MAX_ENT, false,
+					cvq->vring.vring.num, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
-- 
2.39.3

