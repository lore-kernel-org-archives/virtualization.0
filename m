Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E9207663
	for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255519; cv=none; b=Fpn7E4swlZg7SJpU/F+FrmPWlSjDLRhrGWNzI6gGaU0IAzRdkkHOmFuItq8TIrRj5xPx+MOx0diRi2+fHV5lJpp8XvUQ0iOmCwefHYc4caK3mOSlZohJYa72NLAKVw6lI0a7jOeW3/ZL5wz6O962KS05f3ufR8qXf4X3PmbViF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255519; c=relaxed/simple;
	bh=fPAvW6v8rKvAiHm6YEiYpL6kvJsWGYT/VF3Reb/LCZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaR0FkmnHI9VNohZ/X9dZQYrP3ay7zODYp6O8gln2AiN68OLW37OPJkkuLYbjNDdAIkj3MvmIUeIgxXZ7/0HOfgejB78v8CchxW09bqe/TWtMm4IQLQNaPvyNRALaczYRUPSsmBPqeJCEf3yxKDPUN1I0hyMGUJ95zQNj+0fpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iPbTDVtn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iPbTDVtn"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HLtwV2008470;
	Mon, 17 Mar 2025 23:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=EUSbr
	7qcydtVZL9z8CHMX/8WAisz5QonqiAlJ01a/bo=; b=iPbTDVtnvCEGAM9gBsCjW
	exrQIBRxVwcNKe4xuKplRW9V50u5tzgqfLO7uKDMUd+dYpQOlPnpvHfav6g4k3ap
	PQW6039gKASwwq3e5e+owkqekHzBapgZCYNKyln66PdZqHBGuuyBPL2WRm6vWA6m
	DiZo3i/j7hAYZj94en+7kI339Q8kMFnf0M+7YS+NG6xRTziWdGTHiOZbPavc1F/W
	tqYkYhE6poNY+L3QSYsMid2JvXmcv1xUtOJMxEMeSPxxTlxbdJ+5/8fZXwOD1ugK
	p6utVSkEMdwUxMQXsMfWKpScx/Km3M4Sa8t9DWsnHgMugQcvwBkJiMKm6jv3ZaNW
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8m4fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 23:51:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HMAEnA022461;
	Mon, 17 Mar 2025 23:51:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxeekf9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 23:51:49 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52HNpi2p016519;
	Mon, 17 Mar 2025 23:51:48 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45dxeekf68-6;
	Mon, 17 Mar 2025 23:51:48 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] vhost-scsi: adjust vhost_scsi_get_desc() to log vring descriptors
Date: Mon, 17 Mar 2025 16:55:13 -0700
Message-ID: <20250317235546.4546-6-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250317235546.4546-1-dongli.zhang@oracle.com>
References: <20250317235546.4546-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170173
X-Proofpoint-ORIG-GUID: dIGShqOkswVG0jZ71crEDLULcIEl8gVl
X-Proofpoint-GUID: dIGShqOkswVG0jZ71crEDLULcIEl8gVl

Adjust vhost_scsi_get_desc() to facilitate logging of vring descriptors.

Add new arguments to allow passing the log buffer and length to
vhost_get_vq_desc().

In addition, reset 'log_num' since vhost_get_vq_desc() may reset it only
after certain condition checks.

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/vhost/scsi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 26bcf3a7f70c..3875967dee36 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1063,13 +1063,17 @@ vhost_scsi_send_bad_target(struct vhost_scsi *vs,
 
 static int
 vhost_scsi_get_desc(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
-		    struct vhost_scsi_ctx *vc)
+		    struct vhost_scsi_ctx *vc,
+		    struct vhost_log *log, unsigned int *log_num)
 {
 	int ret = -ENXIO;
 
+	if (likely(log_num))
+		*log_num = 0;
+
 	vc->head = vhost_get_vq_desc(vq, vq->iov,
 				     ARRAY_SIZE(vq->iov), &vc->out, &vc->in,
-				     NULL, NULL);
+				     log, log_num);
 
 	pr_debug("vhost_get_vq_desc: head: %d, out: %u in: %u\n",
 		 vc->head, vc->out, vc->in);
@@ -1237,7 +1241,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 	vhost_disable_notify(&vs->dev, vq);
 
 	do {
-		ret = vhost_scsi_get_desc(vs, vq, &vc);
+		ret = vhost_scsi_get_desc(vs, vq, &vc, NULL, NULL);
 		if (ret)
 			goto err;
 
@@ -1581,7 +1585,7 @@ vhost_scsi_ctl_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 	vhost_disable_notify(&vs->dev, vq);
 
 	do {
-		ret = vhost_scsi_get_desc(vs, vq, &vc);
+		ret = vhost_scsi_get_desc(vs, vq, &vc, NULL, NULL);
 		if (ret)
 			goto err;
 
-- 
2.39.3

