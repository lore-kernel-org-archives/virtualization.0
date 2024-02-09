Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7C38DE3
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517807; cv=none; b=cTB9cphkvrpa1A/IFdgU5k38an/OtnpLEYxkr8l0oOxL0AYe3MB+xBBUcoOTeJNhWiEcuWlGB5OAutXgKNlc3Z3q5qeRh0A/OPMj8xr7klEbl+Y/pJ5VqW0uvckZcz1GO77epzRS79yWDktdqUI1SMRk+MCyLY4QdM4IEQkSnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517807; c=relaxed/simple;
	bh=ooUz90FvJ7Ve9JtszMBy/Igkiq4pVXCMiFPkjlO56gY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nY68yBRMHtb1fC7lR8RzPfuI6MubBGxDTIvXQtHWolFZgHVCuPjrCIwXl5aYl0udccbxHJQXyN02j2zjLfpaCUGWPBRTSe/ogbkofYbVVyXSBMFsoRGoOOF3v8HtVwjWmhIfzG2YKadbXRIBarjhR57UTY0qFMzQ2mQyuf38r5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OE55qmYS; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OE55qmYS"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8370784E75
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 22:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3BD69F9CYqI
	for <virtualization@lists.linux-foundation.org>;
	Fri,  9 Feb 2024 22:30:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1277584E60
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1277584E60
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=OE55qmYS
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1277584E60
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 22:30:03 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419MTKZd010579;
	Fri, 9 Feb 2024 22:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=s0m3RONhBuuYD1488q0tsj2Vaijgp+sUXmdY6l8Ots8=;
 b=OE55qmYSiGTrZaoWFoc7rlvMso6YEb3gF8ktcFDFCVqVrGluR0srYN5rSMoP+Koan5AD
 CQsWAC2SzQQhiROSFTpEHS++rNx5gVPX5f5WGfiw7xMusud3gUj33StwxFeAOCBFBMQb
 BPaO0kBS4TjmpPQhPN/djU/qDneBHhATVh14T8UO4AW0TUa0jYqg3MiYjLL7nQ+tUT0a
 uTRxyXm73/u/JvBSIW9Kj3cEbTHUluMJhtw/RZATp+lfFLIW7SvpmSoF5I8qz/xgFsAM
 lKzJ8ZCSPYr7o/mzuHqeJ6MpF31mUxeymsb+g6OXM/CdgDiBtxAjCfxrXveax8sGwXQb qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5vvtr01p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 22:30:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419L4QXO019970;
	Fri, 9 Feb 2024 22:30:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxk3485-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 22:30:01 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419MU0us010656;
	Fri, 9 Feb 2024 22:30:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w1bxk347k-1;
	Fri, 09 Feb 2024 22:30:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Date: Fri,  9 Feb 2024 14:29:59 -0800
Message-Id: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090165
X-Proofpoint-GUID: UF_PWOtqDGzOFjyBCkXV-8xHPbfQRzOT
X-Proofpoint-ORIG-GUID: UF_PWOtqDGzOFjyBCkXV-8xHPbfQRzOT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
vdpa devices.

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bc4a51e4638b..ce1882acfc3b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 	if (!ops->suspend)
 		return -EOPNOTSUPP;
 
+	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
+		return -EINVAL;
+
 	ret = ops->suspend(vdpa);
 	if (!ret)
 		v->suspended = true;
@@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
 	if (!ops->resume)
 		return -EOPNOTSUPP;
 
+	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
+		return -EINVAL;
+
 	ret = ops->resume(vdpa);
 	if (!ret)
 		v->suspended = false;
-- 
2.39.3

