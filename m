Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE11D69E
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437932; cv=none; b=T2/SHn7/j8QpxHs41lu4IjFF8gqm6cfS9/BEQdG18cRcRGmwa1di/P2VmNpIzY4N0G1uMd7aSDwbo4Let7jmSCcD/6UczoJKx5FQpNU90G6VHhGASCnRSnx173e0cmExGONrBwktnf5oUAOVVU+MO7NN04oxvmVEEHE1xRJQe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437932; c=relaxed/simple;
	bh=Z4sdTlWK0s6YNRFo3wTMCa7eu6YrluhEMgXvgThsqo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMyzGcVjXk3hdT995ICecuQXj1gOJMVQPalIF3eiQ5nPtPLWQ5VMvIozISTJux8Do3kZaqPMQnwa7hHrYEBlnUQyDvEhZ77QgF/jCpZ0sPxIg8FVrqV8NEV8P+GDgGemLr3X/cWZSaImVnX57OWvWX+4SR3dISQNbTvbLk3dcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SLTU8Rh6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SLTU8Rh6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6A6F607EB
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 01:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.49
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FXkWjnbyaEN for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 01:38:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2A2E06064B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A2E06064B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=SLTU8Rh6
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A2E06064B
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 01:38:49 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Jte6v015081;
	Wed, 9 Oct 2024 01:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=urI8f
	vzVu8Sz9K3oGAQsWulgrw2PEyIJpu++JnkiE7E=; b=SLTU8Rh6pZIWVKCjbbOXk
	7lwQBu38tkGE0UI3/c+8yRWmkUo0w/GyNEO8TnjsDALOTsbWaXvV5/wRo2yiDnNo
	DYoRmsKUHJKt4SHnOehkMvX6ifOsuapKZaSmybTKhXna+2D8kQ2jBA4SMwK6hnXV
	r+uq8hTq7i8vf7nnqg4wwkBd4lND7/Te+JojSkF8pNWR5yys9NfQXq9vM+Jim/JR
	tLZ/JdbryPKhZoDWm31+PR+DvXLyiD7nf922X7N9qzc2yhec5Gh7p17JmMy3GG+/
	eMy8addCjir6Sa3uhXVjvBsTF06/mjQyAlfEpF6hR/cmKwVS57vr7NKemF9jqowM
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dq512-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 01:38:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498NDWh1011358;
	Wed, 9 Oct 2024 01:38:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwe899e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 01:38:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4991chj8024787;
	Wed, 9 Oct 2024 01:38:46 GMT
Received: from mnc-mac.us.oracle.com (dhcp-10-65-182-164.vpn.oracle.com [10.65.182.164])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwe897c-2;
	Wed, 09 Oct 2024 01:38:46 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, pbonzini@redhat.com, target-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/8] vhost-scsi: Allocate T10 PI structs only when enabled
Date: Tue,  8 Oct 2024 20:38:32 -0500
Message-ID: <20241009013839.88593-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241009013839.88593-1-michael.christie@oracle.com>
References: <20241009013839.88593-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_24,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090009
X-Proofpoint-ORIG-GUID: 9B4WIxsdXigk2TGXQvPNjArEw0-9PjXg
X-Proofpoint-GUID: 9B4WIxsdXigk2TGXQvPNjArEw0-9PjXg

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
index 0cfa56d08450..776051577a5f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1648,12 +1648,14 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
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

