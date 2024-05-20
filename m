Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A6136E05
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218477; cv=none; b=gciJLdBb97O/LpnZ3PrRDNKGnJ89hBpiYEcSZCvIRHA7/9Dp1KjagHot2tzW6MFPCBbA97Yg6QmQ1ALvHKKbXqqtPiGVFs93RfBHC1VVEIHhpzOKFz18QKUXPLSR6Ca8sNPVuY2GQdhVAwvpTod17feagWVFIBz57tND/rgrnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218477; c=relaxed/simple;
	bh=/3brYIh4ncfYVMXJoPhV83VZYuPd5O5RDQ/MbvSpQEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qml1X6/QW+Y6kCwYqdzuBDk2st/+UQ2q4trjHG0D38Qz8Xp+Oe567INXRvBJ4TjP0mdgiJrRNHQWCGMASIFQL2xbmVS5cB0jBx7JyFE2hV8/LTJ6ULVmjbhFGWgn66aF5bSOR+sJWk/s2IDGWrQuYeInh4J449OFF7MICtHW/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IKqncCq0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKqncCq0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E3E581CA5
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kg9fBXarZelz for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 15:21:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BDF6A81C44
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDF6A81C44
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=IKqncCq0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDF6A81C44
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:14 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEISnf012978;
	Mon, 20 May 2024 15:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=nghfDIm9aaZnyFv3eR1D94oo2A5AFx5js+8s3mtdwrM=;
 b=IKqncCq05zoMKCpHMQL5opifFSneKn3B+g9AmKdLdHhiV3OiSTx2q9Az9a7evNNT7OCT
 uRX0wqKVT8ZPbrO5vISzeFt+C6HZDsJJPSHZhMXVHcGLsy2UY0hfXm0M61CG64IP6kIm
 gnTrB09scg1b+bvqygv8KzaImOhm9i80ohLCH12yJM+jqyJAhey+Vtyp2fYNuzEdA1ZK
 qEu4o9gr8xmVyxzDDS9CMtg2ZDmr1aH2HkydjmQ/PuBWIPh/UJdJwxgfrJgDgy6RKUw4
 fLUnthJMzZ1swsCFWJJ7oEyi34XfkNOj09+imPD149BRFJX2w09DC20cqwYu+DcnYtJc xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k462yb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KDofkx002667;
	Mon, 20 May 2024 15:21:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6cy8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KFK19Z038962;
	Mon, 20 May 2024 15:21:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js6cy5w-2;
	Mon, 20 May 2024 15:21:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 1/3] vhost-vdpa: flush workers on suspend
Date: Mon, 20 May 2024 08:21:00 -0700
Message-Id: <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200122
X-Proofpoint-ORIG-GUID: FEWjuJD8h_Agj9XKmCL28DK9qdJ5pDiv
X-Proofpoint-GUID: FEWjuJD8h_Agj9XKmCL28DK9qdJ5pDiv

Flush to guarantee no workers are running when suspend returns.

Fixes: f345a0143b4d ("vhost-vdpa: uAPI to suspend the device")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vhost/vdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ba52d128aeb7..189596caaec9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -594,6 +594,7 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	int ret;
+	struct vhost_dev *vdev = &v->vdev;
 
 	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
 		return 0;
@@ -601,6 +602,8 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 	if (!ops->suspend)
 		return -EOPNOTSUPP;
 
+	vhost_dev_flush(vdev);
+
 	ret = ops->suspend(vdpa);
 	if (!ret)
 		v->suspended = true;
-- 
2.39.3

