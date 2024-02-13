Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7395810D
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834365; cv=none; b=KvUiEk4epX1sww8QXnhWjgLQYETt+J7p/5zwsFqs04lkO6v4YI5Omg6KVeYxINTUCStLKdgR6neNCGxYtqwH2HKuJEd6qqty/K/6/m9KaPd9R4lukULkMxaEx814JN5dGmbR8y12kPRzRWbKNTszGRU4IFBaletvC0Y/dSVLvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834365; c=relaxed/simple;
	bh=5Sxu7vk0RgDuyxfPAVYOqd8ty37LyCj1c00JhxqqCsw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dG/njnAtd6rtfRCUt8YNW2dC3IrHIVycjgsjG26mUPyBO4fWsohkPssXUf5zlSoNIjECWlHNkkPQAPhyLFmat/vrtFdp4J5NwtzoXbLMl4dAYCKIb6FkHCBluHYJDwL00xeL1BWjpksHjwVo94UBpF2lsAjcznNFY50L1RX4BUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m4wwgZrR; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4wwgZrR"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0F04414C1
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZqmmVd3goHrx
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 14:26:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E68B940929
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E68B940929
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=m4wwgZrR
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E68B940929
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:26:01 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DE1e2R003550;
	Tue, 13 Feb 2024 14:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=xn+jQYpVDm0LrE2BS/+92v/4tL5PF4w1LwRpKfG4228=;
 b=m4wwgZrRO/vJsAVAP9JvnxBG8a2Ec8fIysDW7PdExgWKlRdM3HR7ZnbjxFEORv9VapYr
 3rlzZlUnd6HexgXStnVjdCA8krlqZuSrqXEARafBTspAUCC7Bt+oo6wocNMkeHUJ6plr
 s1FLaeY3UmxCVsBy8XHzpEmCQUq3SHajzjXhdyz2PpOW66MyJLWrNiBPzMp+YzHC1c0Z
 YjVHuZJdM5A5Fv1oRgUepM0Tu88TOMuTQ2wFRVqkjAYRah5W5AQSYyTLUPtDXPLRlbcC
 hv3Gx+5hDyV31VTYfp8NrWDfF+c26rKNK/OAsHE7bcgjt7we5ReV8tIcBAWTVYsGnnzg cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w89tm82jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 14:26:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DDDpH0015119;
	Tue, 13 Feb 2024 14:26:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7dj41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 14:26:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DEPxE2036697;
	Tue, 13 Feb 2024 14:25:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk7dj34-1;
	Tue, 13 Feb 2024 14:25:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2] vdpa: skip suspend/resume ops if not DRIVER_OK
Date: Tue, 13 Feb 2024 06:25:58 -0800
Message-Id: <1707834358-165470-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130114
X-Proofpoint-ORIG-GUID: ZRIAUdXa9O3X2mLqtThzhFrXMtU4y15M
X-Proofpoint-GUID: ZRIAUdXa9O3X2mLqtThzhFrXMtU4y15M
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

If a vdpa device is not in state DRIVER_OK, then there is no driver state
to preserve, so no need to call the suspend and resume driver ops.

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bc4a51e4638b..aef92a7c57f3 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -595,6 +595,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 	const struct vdpa_config_ops *ops = vdpa->config;
 	int ret;
 
+	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
+		return 0;
+
 	if (!ops->suspend)
 		return -EOPNOTSUPP;
 
@@ -615,6 +618,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
 	const struct vdpa_config_ops *ops = vdpa->config;
 	int ret;
 
+	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
+		return 0;
+
 	if (!ops->resume)
 		return -EOPNOTSUPP;
 
-- 
2.39.3

