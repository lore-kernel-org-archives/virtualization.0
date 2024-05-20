Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08B136E26
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218479; cv=none; b=WpQD04KEa9GxhK5a4rkVRsgcSmJD1tjDv2D5sM4WGZR+aiDfejaj44ubPl0mur1F9zJguO62AZYNn5UKhflihiQCZqrAuw8e9FMezQoRMuS4bbx/cchbU5rzqog3KfJwWG8N9setq68n5b/RHW0p5bSwr3fI655mkP/3FlG+EAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218479; c=relaxed/simple;
	bh=HrG1frKSm9Ao52Qtu4zIFLvSeb/ikKJa5HWbYe126cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J3OHz2zAWMFw1A/PB119gxvHHR1Ryy8mxa3h12xvE6e1w0u7KSfgh5O1/KRM/932bql3oyf59xfiuII9ys/EHJQWcaKe/Xmx3NI1TvKf8K5nEbU5CJBQNY23lO2Zy5jCxC3+Zc/lfP7zHpyPSfVOdbmoMI2aGMDAlj+EGi38+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l2Gr2h7X; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l2Gr2h7X"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADEAC60611
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNC5LmpXWo-0 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 15:21:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E9075605F2
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9075605F2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=l2Gr2h7X
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9075605F2
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:16 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEEcPT007287;
	Mon, 20 May 2024 15:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=o334WAUhRrMsc9og5ljSkGlZxzW6jxl5NiSFCIJGl0E=;
 b=l2Gr2h7XeTcVZ2X6kHXk6kF1ZHhkPIG6Y4y/hFcNltvxKFnG5tL24VSdbYRsFqSIbQ4+
 R8UwW6Pa0K6QxYqLRhcwIz52dnZBS6uYJ7vT5ouXrWrhPZEDsD8xDG+zK5Nx3DFeZvMQ
 Z+FMAltAf+RBzF4NuTabA8lbUjShsOgKmH2GrAd08R8EjH5KUt9mTZwv5U5AD0T+4pmW
 tTb/T7+0Daq+NyJPQQ0g1uOPsrLpysHcHRES00/xeCoVeIFUqt+3+2yy01Q5LwgCtcsi
 t1NYXRN6SxJhWOURIghlIQnI+o4EZ6nNDYCnLCnpVFMtKKGxkVarqjgzPqgzY4G73KH0 MQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv2wby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEKAo7002729;
	Mon, 20 May 2024 15:21:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6cy9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KFK19b038962;
	Mon, 20 May 2024 15:21:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js6cy5w-3;
	Mon, 20 May 2024 15:21:06 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 2/3] vduse: suspend
Date: Mon, 20 May 2024 08:21:01 -0700
Message-Id: <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200122
X-Proofpoint-ORIG-GUID: L_TSt-mL4E8q1G8zZpmwZq9sQzrx6nbr
X-Proofpoint-GUID: L_TSt-mL4E8q1G8zZpmwZq9sQzrx6nbr
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Support the suspend operation.  There is little to do, except flush to
guarantee no workers are running when suspend returns.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 73c89701fc9d..7dc46f771f12 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -472,6 +472,18 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	up_write(&dev->rwsem);
 }
 
+static void vduse_flush_work(struct vduse_dev *dev)
+{
+	flush_work(&dev->inject);
+
+	for (int i = 0; i < dev->vq_num; i++) {
+		struct vduse_virtqueue *vq = dev->vqs[i];
+
+		flush_work(&vq->inject);
+		flush_work(&vq->kick);
+	}
+}
+
 static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 				u64 desc_area, u64 driver_area,
 				u64 device_area)
@@ -724,6 +736,17 @@ static int vduse_vdpa_reset(struct vdpa_device *vdpa)
 	return ret;
 }
 
+static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	down_write(&dev->rwsem);
+	vduse_flush_work(dev);
+	up_write(&dev->rwsem);
+
+	return 0;
+}
+
 static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
@@ -806,6 +829,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
+	.suspend		= vduse_vdpa_suspend,
 	.set_map		= vduse_vdpa_set_map,
 	.free			= vduse_vdpa_free,
 };
-- 
2.39.3

