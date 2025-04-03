Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC71A071C
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743661961; cv=none; b=gRWvSTmhX8uSw3DWh40mFJIZni8TrIq45vkrecZoZRJP9Ygvk3ij3wJxzBbZ6pitPSiHSLrJ0hg4B01cQmDxKOvVQpQXwtQXKOHzcaIgt7JrfR/6O8HqJHKJ8936PHLYw3O9Pm59feUd9+0AhBnqg9PmQhMCMTekjWxWiIQWMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743661961; c=relaxed/simple;
	bh=4wOS5sHOmvnfXtHSGkFMfSiDIN9wQWOfZ+EPk1Bo/Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leIAZ6powWXf1Vdk2+H2TDvod6M2LfnK9CGKTpRzp/ToXA7y6BpGt//t6c8dv8OOY0MGFVzuPKIZc9QnDIRLok15LZyXSELi5Jlm6VRBqAC/1B88ZGTX/ybsELyHt0pgbDXJUswvOO4umJ6c0mqqJpfCe7Vw20Qs1qUlLnRnP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jg9fSW1/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jg9fSW1/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532NMrgV007998;
	Thu, 3 Apr 2025 06:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=TfOAj
	a7vYtxMX1s3s/mziHpOzKnd1ckBKO6SVb+MqbE=; b=Jg9fSW1/OiSyH/DOWbvDl
	ipYcYpv5t39ocZpAeESWzHLRomXT9gicBnlfHWek2d7VLVeuWU1UN9DnzVEQy7aT
	cChsTHDOi1E7ZioUg+CSR4jpBG7rLkxBvXIXKfZUFH3gn//VoymANTA4C7V6iIwq
	5ACc3ExyuCGDBtLshnj41x/9J/ZvpfXJuFztzWa1txNEbjPQF1cf8TiQUTiXj/+x
	hm5T4yQsYlQdc5g+THYwYxD/pzJG2KX2DM7ycfS/1mQgMVa5XWeQJn5WEBUAqFbe
	ussSf781VKARW3So6XNcQyuJBO+qy/KiRKKGp1UXVFeG5Fi3be87kXd7uovXCuiw
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2cfs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 06:32:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5334pSjb002575;
	Thu, 3 Apr 2025 06:32:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45pr8stj7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 06:32:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5336WTxD032092;
	Thu, 3 Apr 2025 06:32:33 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45pr8stj4h-6;
	Thu, 03 Apr 2025 06:32:33 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] vhost-scsi: adjust vhost_scsi_get_desc() to log vring descriptors
Date: Wed,  2 Apr 2025 23:29:50 -0700
Message-ID: <20250403063028.16045-6-dongli.zhang@oracle.com>
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
X-Proofpoint-ORIG-GUID: NBjbf5nsC2bhktv-aOKRF79d_nGGkkLd
X-Proofpoint-GUID: NBjbf5nsC2bhktv-aOKRF79d_nGGkkLd

Adjust vhost_scsi_get_desc() to facilitate logging of vring descriptors.

Add new arguments to allow passing the log buffer and length to
vhost_get_vq_desc().

In addition, reset 'log_num' since vhost_get_vq_desc() may reset it only
after certain condition checks.

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
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

