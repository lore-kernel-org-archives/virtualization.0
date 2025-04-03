Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1401A3176
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743661961; cv=none; b=b3Jqg9hmKlCg3rBsnxAeIVohVB9+t1Q3a/0vMMx4HMkwlNcGWre0anGndLVW5xWdxxgUZ9sLze5G80BQ0bXqy9OZcAI53eSoCJKFHIGa67lOPWIgZ3wzOMj5y05IvkDHNgZ7hrHbvW2mUEj50zKAclwSaVq28U5YEgtWA6u4PlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743661961; c=relaxed/simple;
	bh=yV90YJWksWYTKqn8R6TDvCEuz1kJ3ECAZcqHP9HtGgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imMD0REWrFphAnY8T8FGiUfD/qxZ/1SvOUJ7l6pG7IWjdNi8+17xGwMoxinxppUIES3tQFx/J6Z2l1d+cX+k7Ov9PQ+lXC1fyHCYPuT7EwAqAwDjGt2OARyW8ns8FU9Vgqq9dWa+mbBjIAGiUk1yumscYpiSTExyQsoIxs67Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AvqsiqVm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AvqsiqVm"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532NMrcS026560;
	Thu, 3 Apr 2025 06:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=sSDfb
	VzMTxutRDXo9y9hAgFGlDo38W4HpDL8tuNLJk8=; b=AvqsiqVmD4cxAeVFXtq3Z
	8vSxpN2onY8lrbA7rGmu2Vt7rYKDNfE7ZGqdImckxggBhztjxrZrPgocgb/+32hB
	UzImoQdba28/v3LYxVv+P8a+h67m6fV7PnetUjuyI7XR2aaVPLkbYHsfZ3/RMnPZ
	8yCv1XZ4iXuRGqEsCuvao4Zz9oTboQ88sa2meIh4Egf1JiuBuNoPZRhv3ONxX5sI
	tvurVK+5WM89j8rbqMALxXb3fs2jipofKfNL4A2DJ97y9xlkzQLcQvTQdLTUEtgq
	oDsFHdv7wH37R1u+vDI7fLUIfQDLRVLMr0RQ2hdVdywd4kw7+nNut7tLZ28gEx66
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79ccb1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 06:32:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53360Znf002620;
	Thu, 3 Apr 2025 06:32:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45pr8stj8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 06:32:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5336WTxJ032092;
	Thu, 3 Apr 2025 06:32:36 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45pr8stj4h-9;
	Thu, 03 Apr 2025 06:32:36 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] vhost-scsi: log event queue write descriptors
Date: Wed,  2 Apr 2025 23:29:53 -0700
Message-ID: <20250403063028.16045-9-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250403063028.16045-1-dongli.zhang@oracle.com>
References: <20250403063028.16045-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504030033
X-Proofpoint-GUID: bZZI6XIDpePqkqidYvT-cxd6GGhsNtv6
X-Proofpoint-ORIG-GUID: bZZI6XIDpePqkqidYvT-cxd6GGhsNtv6

Log write descriptors for the event queue, leveraging vhost_get_vq_desc()
to retrieve the array of write descriptors to obtain the log buffer.

There is only one path for event queue.

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 1a1a4cd95ace..08e38f866a2c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -571,6 +571,8 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct virtio_scsi_event *event = &evt->event;
 	struct virtio_scsi_event __user *eventp;
+	struct vhost_log *vq_log;
+	unsigned int log_num;
 	unsigned out, in;
 	int head, ret;
 
@@ -581,9 +583,19 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 
 again:
 	vhost_disable_notify(&vs->dev, vq);
+
+	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
+		vq->log : NULL;
+
+	/*
+	 * Reset 'log_num' since vhost_get_vq_desc() may reset it only
+	 * after certain condition checks.
+	 */
+	log_num = 0;
+
 	head = vhost_get_vq_desc(vq, vq->iov,
 			ARRAY_SIZE(vq->iov), &out, &in,
-			NULL, NULL);
+			vq_log, &log_num);
 	if (head < 0) {
 		vs->vs_events_missed = true;
 		return;
@@ -613,6 +625,8 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
 	else
 		vq_err(vq, "Faulted on vhost_scsi_send_event\n");
+
+	vhost_scsi_log_write(vq, vq_log, log_num);
 }
 
 static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
-- 
2.39.3

