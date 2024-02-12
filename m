Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C93F8C2
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758191; cv=none; b=HpvBKc8UCAX+ItdszctPhPU6QuS2PvfojNIUWDZFq6xjaoypvoNWQrYm5/qm0BZAt3ziUMPXe9ViyReAguQDvvvZVKPATYYAgLiOl21RjCsCktxm8O8gvNxb5klYJkCt+TBEuQtLDn8IYPBpAbhgf+r+CqmlcZARwoZTV2Y97Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758191; c=relaxed/simple;
	bh=8YvGJ2ZZyQiC7K2q187z+72Db2SHCfeV/AIbRS4MrO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rfy7tQm1yjs1rcrKX6ciCdQNFGYaX0p1Vao+PyxQQ/J/u456XpHfZgO3hMF7RfOxRH+AYm6Os99nx6ixPTa1hDjC5HgRzDDueFSciqO5efRdvAObA8FxhF3hFGaVH/baV/iEauda+qZW0UyN+nbU8WkPFyu8tfL6F3Er06UTOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lrk7C3Xm; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lrk7C3Xm"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CACBB400CB
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 17:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIe_zSfkE3vI
	for <virtualization@lists.linux-foundation.org>;
	Mon, 12 Feb 2024 17:16:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C463F40459
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C463F40459
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=lrk7C3Xm
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C463F40459
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 17:16:28 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CH8lKn017068;
	Mon, 12 Feb 2024 17:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=fhdNJEwldjv6IUUX+AIoeSMZpJt3+JWrlmxQbPSV190=;
 b=lrk7C3XmHpr9hqdFhIHIUkxs3jui7oXu7hf/Y9opTu9qbbHvVKIrGMVpwBodB+cD+S1u
 EvyIsa6q+RhAgu01Omd9xmE9pmh+DJzSnP+TZBqEAtDwGUFvho9FpRCgHD0ZAVALaFWR
 YrrBnZJJLAr7l3AHnCmFZosfelAS5IOkAKkZAJxtJ2qKX+GDA9lh3vK6wBBmDpNgOhTS
 DA+VPhumPPGHkXzmPby1zUpPSqLaw0nLQOs6d/PKR4DS6AXOcJF72FLUDiSg+0zMLE8d
 2Iv6VmKs3AYIUfgJn/2dyv9Z9tLw+0VymDWz2Bmv9i+0V7OFJISVEG2KiBmGg7civ+ZP KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mpqggaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGHEXh031321;
	Mon, 12 Feb 2024 17:16:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk620g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHGFCE019216;
	Mon, 12 Feb 2024 17:16:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk620cq-4;
	Mon, 12 Feb 2024 17:16:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
Date: Mon, 12 Feb 2024 09:16:14 -0800
Message-Id: <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120131
X-Proofpoint-GUID: djMs8rQaCzFpOPn0bvE4a5muSqxH_YcW
X-Proofpoint-ORIG-GUID: djMs8rQaCzFpOPn0bvE4a5muSqxH_YcW
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Flush to guarantee no workers are running when suspend returns.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..a662b90357c3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpasim *vdpasim,
 	kthread_flush_work(work);
 }
 
+static void flush_work_fn(struct kthread_work *work) {}
+
+static void vdpasim_flush_work(struct vdpasim *vdpasim)
+{
+	struct kthread_work work;
+
+	kthread_init_work(&work, flush_work_fn);
+	kthread_queue_work(vdpasim->worker, &work);
+	kthread_flush_work(&work);
+}
+
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 {
 	return container_of(vdpa, struct vdpasim, vdpa);
@@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 	vdpasim->running = false;
 	mutex_unlock(&vdpasim->mutex);
 
+	vdpasim_flush_work(vdpasim);
+
 	return 0;
 }
 
-- 
2.39.3

