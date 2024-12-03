Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC013B2B8
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Dec 2024 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253436; cv=none; b=u7DG1BCuPnhpDZmOP3QmKigaSfa7U/H3STvUjMkB+Tjo2tioBWhOq2OzwGrHUp9EhanWo49x0EHOcZLzWV75JUVp/ey1y7f1n07QxOyoixQaYgEuzryIX3FbgdRptYoq4Sbddq38oJZISJMNMCWWyXM/VL0VV3mVxDgM2FMI/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253436; c=relaxed/simple;
	bh=H/1gr4VaKNoGODypChOGc4OjXFVLRq837Q3U63BqhFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvxS/oPMo6SQ/JjhTw/cEOTGirAQp9X8cpJmMZIIKdxboS6Vtw2Kk/qTe/jM7+xyxmDKVHLV299RTAIP5r2akoRnO6TIT4GcvnZiJhSbN74cY7Q+4805569hZRNoEajXl448Va3hOPG+zCDmwuHSCI03nOyx0qmUTo2cs+1N5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H+AryZE0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H+AryZE0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 273B242D28
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Dec 2024 19:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.49
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HpeGH3BAH8N for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Dec 2024 19:17:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 566C542D1E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 566C542D1E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=H+AryZE0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 566C542D1E
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Dec 2024 19:17:13 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtXWK006127;
	Tue, 3 Dec 2024 19:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=8V8VB
	cnUEQPnkibYRDceX41FTQxdvQE9Earg84J5Gkc=; b=H+AryZE0+/xH+FYQgsPN3
	Cd4Ie7kaP8SmrcrTFZEZqPm8VC4x+DFCKWsFG8EW8K66E5ObC/Ij1EVvtvb9Gcp0
	ipJfPP1P+mnIs5uv7RYywNcdKOWlxaijbHHLZaHRd1WHKBXiS+UBP4ZZg0kg1s8L
	tAlpSN0VxaQvf+RWic7usgo22cjig5z7n4DM3mrevMyNMkE2kQuLwTPSz3HNQxQw
	yOnszXXtxnw4Fs1pGPQp3V0bVoqaN4MZOFzTfiUC+2fDJAMz5JSIluBdfVrL3noP
	FNCU0coJUYL5D48syqZP/+dJCL+aurqkBv5s1czYVd/9tA5XGWVF1qe1UZcKmRQa
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbpw22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 19:17:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3JAiOc001877;
	Tue, 3 Dec 2024 19:17:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s58akct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 19:17:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B3JH9MC021603;
	Tue, 3 Dec 2024 19:17:11 GMT
Received: from mnc-mac.us.oracle.com (dhcp-10-65-163-31.vpn.oracle.com [10.65.163.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 437s58ak94-3;
	Tue, 03 Dec 2024 19:17:11 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, pbonzini@redhat.com, target-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 2/8] vhost-scsi: Allocate T10 PI structs only when enabled
Date: Tue,  3 Dec 2024 13:15:09 -0600
Message-ID: <20241203191705.19431-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203191705.19431-1-michael.christie@oracle.com>
References: <20241203191705.19431-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_08,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030159
X-Proofpoint-GUID: jLToRsmT4qXtFBbh-InWIOzODuV0fRAH
X-Proofpoint-ORIG-GUID: jLToRsmT4qXtFBbh-InWIOzODuV0fRAH

T10 PI is not a widely used feature. This has us only allocate the
structs for it if the feature has been enabled. For a common small setup
where you have 1 virtqueue and 128 commands per queue, this saves:

8MB = 32 bytes per sg * 2048 entries * 128 commands

per vhost-scsi device.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index adb3cd47b4e3..99e008219e6c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1651,12 +1651,14 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
 			goto out;
 		}
 
-		tv_cmd->tvc_prot_sgl = kcalloc(VHOST_SCSI_PREALLOC_PROT_SGLS,
-					       sizeof(struct scatterlist),
-					       GFP_KERNEL);
-		if (!tv_cmd->tvc_prot_sgl) {
-			pr_err("Unable to allocate tv_cmd->tvc_prot_sgl\n");
-			goto out;
+		if (vhost_has_feature(vq, VIRTIO_SCSI_F_T10_PI)) {
+			tv_cmd->tvc_prot_sgl = kcalloc(VHOST_SCSI_PREALLOC_PROT_SGLS,
+						sizeof(struct scatterlist),
+						GFP_KERNEL);
+			if (!tv_cmd->tvc_prot_sgl) {
+				pr_err("Unable to allocate tv_cmd->tvc_prot_sgl\n");
+				goto out;
+			}
 		}
 	}
 	return 0;
-- 
2.34.1

