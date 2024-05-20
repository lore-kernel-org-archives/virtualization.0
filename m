Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADB136E3D
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218481; cv=none; b=ZHj78AbhSFhbKBmvZwpgyfWc5aaY4U6b4jno1vzUx/VGG+C/uO9wppDT6k5N4M/xqZVmnE2XEZDlvNUdZ2UYIPNOkMslHotGxv9IXES1aEV8bw1DysEcv5IjP8eu3aLtuqu1WQlAPOHIPkB7TNvNko7FilsxvqKak1fTHANkwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218481; c=relaxed/simple;
	bh=1Ie0VYID0/xUJRKDRvyDar8Mu+/VDQvE4b530gQ8yB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lcYvlvq2n5YZFxsdFgOWb7xOuRNN6Vl2MB+R/fermrpwdWXKAIiK8jmptoTzyPxyQMsaSW6yMYgKgiMGHsujA+yTL2SRn9XiXPNJuIVAj3eRShieCH+cHFaQddoTy08rKlklF6OLxbS1TPvPg1Vnt5YRBFoYSQuDo7rePpjZIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TVyLs57L; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TVyLs57L"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 572D34052E
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpgNR1bwSlL0 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 15:21:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6576040536
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6576040536
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=TVyLs57L
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6576040536
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:17 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEEcdb007298;
	Mon, 20 May 2024 15:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=nfzq6tEmp2Q89g33znNEwGSUnngv4O1I4ljx3zbDuCk=;
 b=TVyLs57LoVyupW4SaJMUTok/AMfpqkF/kyP8ypBS4faFKnA3/Pl+s2RRDT6A5LoFUPrd
 PMrw57kg8Cz0CfzQDKjLVVA35V8OMfAP7YGNq9iXT5P/g0LpMYb9ytre3/LVhV557gZT
 fZ+kbH6Gxth6m35r9s3bd4CAoEepAprIwzPgAE9l6ig5vopSdmeSk9sWLxfeZs2T0oT+
 JgD0tFwIkMGwyrYlRtxQ/VnZljL3yQARFma4rgySLaHj5MNFkGNKyJ/4tGK1v8yzWP9t
 kNLUlaiPt2JQH6JpDM6Wa5ZmMKi9h/qdSDx/dTsELueF0GHkEKbeWSlEsqz72kSdRYUO fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv2wc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KETIfg002745;
	Mon, 20 May 2024 15:21:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6cyan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KFK19d038962;
	Mon, 20 May 2024 15:21:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js6cy5w-4;
	Mon, 20 May 2024 15:21:07 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 3/3] vdpa_sim: flush workers on suspend
Date: Mon, 20 May 2024 08:21:02 -0700
Message-Id: <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: oP9sXgCGj8LQZwW0uhy1kNIupgTo22EF
X-Proofpoint-GUID: oP9sXgCGj8LQZwW0uhy1kNIupgTo22EF
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Flush to guarantee no workers are running when suspend returns.
Add a lock to enforce ordering between clearing running, flushing,
and posting new work in vdpasim_kick_vq.  It must be a spin lock
because vdpasim_kick_vq may be reached va eventfd_write.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 16 ++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8ffea8430f95..67ed49d95bf0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -322,7 +322,7 @@ static u16 vdpasim_get_vq_size(struct vdpa_device *vdpa, u16 idx)
 		return VDPASIM_QUEUE_MAX;
 }
 
-static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
+static void vdpasim_do_kick_vq(struct vdpa_device *vdpa, u16 idx)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
@@ -337,6 +337,15 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
 		vdpasim_schedule_work(vdpasim);
 }
 
+static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	spin_lock(&vdpasim->kick_lock);
+	vdpasim_do_kick_vq(vdpa, idx);
+	spin_unlock(&vdpasim->kick_lock);
+}
+
 static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 			      struct vdpa_callback *cb)
 {
@@ -520,8 +529,11 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	mutex_lock(&vdpasim->mutex);
+	spin_lock(&vdpasim->kick_lock);
 	vdpasim->running = false;
+	spin_unlock(&vdpasim->kick_lock);
 	mutex_unlock(&vdpasim->mutex);
+	kthread_flush_work(&vdpasim->work);
 
 	return 0;
 }
@@ -537,7 +549,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 	if (vdpasim->pending_kick) {
 		/* Process pending descriptors */
 		for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
-			vdpasim_kick_vq(vdpa, i);
+			vdpasim_do_kick_vq(vdpa, i);
 
 		vdpasim->pending_kick = false;
 	}
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index bb137e479763..5eb6ca9c5ec5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -75,6 +75,7 @@ struct vdpasim {
 	bool pending_kick;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
+	spinlock_t kick_lock;
 };
 
 struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
-- 
2.39.3

