Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484185626
	for <virtualization@lists.linux.dev>; Wed,  1 Oct 2025 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346222; cv=none; b=ZF4Reo5u2RqNJ3R0S0F46EYgOdsEXg1bTlUQEnqX2w2q0QblZnB29OSRohGW7dfEJcQOpS1ldCszh8Wd9PCFFeuFk3hi+5RH2o9FCu0q8qbrFAY5GGAHY16lbQsDBogedkrKyZrKdMK4FbyhYfZ5kRRPscL8kvc/9no3z9tpqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346222; c=relaxed/simple;
	bh=QD+2CS5WYsq+yF7x49GXgjmDptCLj73Dl6AujVQN/rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGANIjI6UDptpVwFh6/S4eC+UezMLbJTbz3GTIcsJfTWYUqNi8IKtyiV9ulN8m3uhfpzIHTlFXpe+Oa8sN62nEod2TLLCNm6jCoqeJN6ayQ2wSIW32vrydGQMQ+OGyDUwicn5BjQwUFRNS9IlD68Ks+/5fAMYcTZjV6Ftai4y24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a4fv59BV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a4fv59BV"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591I1Lxn007104;
	Wed, 1 Oct 2025 19:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=z6PtmBeGzMc1ENkGjQvF6qfyhLLPU
	BtoV6yyRMwgP6k=; b=a4fv59BV6h+dBLVAYuMp0zDcglvNdSuTiyA2CXBUHTljj
	e//7X0bI53atRN+9M4qFtDBHDr+EdrXXt1RYBCs4COxUqGju+DvkBcTl5LpQNaZs
	047Ys4LwYGFybsDMBaOEWPga2wW3Yg/FMPcLzTlwUBbO9gK6zVUBbTLwX3JOqayt
	fBkKdtUDL4NLRonhD3f3ms/8ExpVhSnxgFbl3b3eLT72afp1VZRXtcn9YBAlzC7L
	WJPjnRstR9mw0l8t9+8DR9zSS6NpjTl+amWWtDr2gbf56/n4Il5UG47kC/AoQq9z
	eeUz+VuhbtFnyBx9NlfP3jhqiIdVdQqN9zmOYZdqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bj554-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 19:16:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 591IjNke002872;
	Wed, 1 Oct 2025 19:16:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ca3nr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 19:16:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591JGta8031667;
	Wed, 1 Oct 2025 19:16:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49e6ca3nq2-1;
	Wed, 01 Oct 2025 19:16:55 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_vdpa: fix misleading return in void function
Date: Wed,  1 Oct 2025 12:16:50 -0700
Message-ID: <20251001191653.1713923-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010167
X-Proofpoint-GUID: OpshimxygmZO8hLUltBxPUo2nGt7wuee
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dd7e29 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=8Npo_5w1ayzuIXqtqSsA:9 cc=ntf
 awl=host:13622
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfXyp/UBh4+MBRZ
 qT8jRMkAVRvG+xIGJjouKS3Px05Qu5Ril2p93+bV6+x641ks8d/h6jSacJw1rIn0CXFAxV1TEkP
 qDdTtUO5FLUi0qpBHDdE/e/TbjQYjycHUSPAKWSeOd+NL0dzgUUIFMvJaUl32uyJlPK3+MzahrU
 uU8x1g11mtxsax+DftB9QxRRpphq27Eqk3nacUdg1Y4iyVLmoKPEgQKF0hYcgnQZZ+jU4iQeK9r
 SXIlmqmCbbsXMGI+KI9kok7pnXOMH9oS7BRiYwPAjQboOehKDMdxXTU+mx88RnQYRs3bmgvedjp
 sm9ncioVA+RAUHmiF/1D1TfGr0yAHlpRkHKLmsoi/2ie8ViGfjJkJBWaLCT55+qR4I9KZHTQSlU
 If0+whPv+6wppNxfe4TPG3bDu5qKLh51OQJZIjPC2RReK4dAh/s=
X-Proofpoint-ORIG-GUID: OpshimxygmZO8hLUltBxPUo2nGt7wuee

virtio_vdpa_set_status() is declared as returning void, but it used
"return vdpa_set_status()" Since vdpa_set_status() also returns
void, the return statement is unnecessary and misleading.
Remove it.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/virtio/virtio_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 657b07a60788..1abecaf76465 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -80,7 +80,7 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	return vdpa_set_status(vdpa, status);
+	vdpa_set_status(vdpa, status);
 }
 
 static void virtio_vdpa_reset(struct virtio_device *vdev)
-- 
2.50.1

