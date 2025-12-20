Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B15221282
	for <virtualization@lists.linux.dev>; Sat, 20 Dec 2025 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766191188; cv=none; b=h9H1Lv4HCrDyx3g93cntn1VX6EGPInTJ7gHRhNSHN8Ip8gQkwrhAhm3/usk++BEKPy+4St6g/V10CRwBgZe9SW0FKXJTCWNT+kJsN7OWFOmyrTR2lDB2MvoEPnoUc2FK1w2dfeKFCCZTQ7+xH6NF4tdPAiQL7Q8jr+FsjGA9s7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766191188; c=relaxed/simple;
	bh=O9+KBOfLsYRVDwpsPamNEN4ttQMMBTyBR8PxneT3/6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhULNaPIw16AM2DBwN5AVXLhkeOo3yotpRXOAsWINu3FLb+PUbvS/wo3dS1XmzGkiN6MMj3zVTY1NNm3OXraXVg2ha/+XbRftIS/jvHzj2yTKIv220S+Hba81McJjZ0KDvE6IOYltedSJ/ZO8zmO2sMaag3EWli5cSBeos6/DEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MIqhbaRk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MIqhbaRk"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJLdkUB483666;
	Sat, 20 Dec 2025 00:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=rQzJdkenehIJmUTWv3ML541tTh5tt
	QPhfpO9VWl7+RQ=; b=MIqhbaRkVSIcTAxWAe3RjnCk052n+PkJc9DAXXGLI7M2J
	CNdluq3O1o5l0OE1XNcKW2xgiQeuOUjh3D9m4h4rqqyPs8GDfGe2z+2/9uRb6sNA
	g4VIYr6K8lK54oG6OaVFGZEOLAotpCRni5EeVxD4b3Fjc7VGdKzmqyOrMN36sU1q
	AtR+nOrvajURqneeZs45q/1ilaK1u20vCW03bGGbs7aLrlD4Mnp4e725kRsymoW9
	Qns6pBMLICEOQxo2/8UYy9jd8HM8uZghHI+4bvQzgWW6vPZjFRgmj4ICPHC88RTq
	De+fCAqME7/xS+Xqkx2XqZnKG+y/98q30qjt2Kv8g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b5etnr50b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Dec 2025 00:39:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BK0bWSa035634;
	Sat, 20 Dec 2025 00:39:38 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4b4qttewks-1;
	Sat, 20 Dec 2025 00:39:38 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: david@kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, mhklinux@outlook.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] virtio_balloon: pr_dev_info.report initialization cleanup
Date: Fri, 19 Dec 2025 16:30:12 -0800
Message-ID: <20251220003012.78394-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_08,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512200002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDAwMiBTYWx0ZWRfX466prun1tSNA
 rkRG6TgSCv+h85j4J3xNKfkMrvCdhT42WH7nVRyFnVmvhJ8bAZxs71futMMboPeY6nKDKpw1qD9
 er0zRyDfoY6kWI/KduLVLEMUl0zZc5SpnokniIhVHrjHozfJXzKtSZfu1DAAxGNUkVfgE4x+KuW
 /a1rxnpkOmhhLqRo3b1/+kzMfAvi9ugPfbsh9VkLeZcWdQ7tLOXc6h7hQUfigu+HTJMjq2GCuIA
 6TlWruTe0mtjNmNepAsxaK4sAfXHVXs7+a+88XlWVkgROH5w2yhtSCHY8M/X+54EAH6dYv4yNdF
 dvc+yUg5ufkrJKXpwZkrkIsblDwBYv35rj3sU664ZiPQfSSOJ2gCSRw7Dyl4VkvAObxjp04NRoF
 WE2knj+ETIpQUq2JhqJ+WuAZTuE7TT/5cbDiZukXXVCdkW6WHHjUiUv+PRX+jkjwQElDJdG6XE/
 NEnIbzmYc9bfc7n/L5J4W7W5jxBb/cqQOtRvAr4M=
X-Proofpoint-ORIG-GUID: BRwaqyF1NAc5tHIqakgispHRPEuDc2qB
X-Authority-Analysis: v=2.4 cv=R9wO2NRX c=1 sm=1 tr=0 ts=6945f04b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=7iXlQH44bEMWhY90aHYA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: BRwaqyF1NAc5tHIqakgispHRPEuDc2qB

The virtio_balloon vb->pr_dev_info is used as argument for
page_reporting_register() only when the VIRTIO_BALLOON_F_REPORTING feature
is available. There is no need to initialize vb->pr_dev_info.report if this
feature is unavailable.

Similarly, the Hyper-V balloon driver sets dm_device.pr_dev_info.report
only when the corresponding feature is present. If
page_reporting_register() fails, it even resets pr_dev_info.report back to
NULL.

No functional change. Only for cleanup.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  - Add commit message to explain why we would want to do that.

 drivers/virtio/virtio_balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a78c..0c39f2415324 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1034,7 +1034,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 				 poison_val, &poison_val);
 	}
 
-	vb->pr_dev_info.report = virtballoon_free_page_report;
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
 		unsigned int capacity;
 
@@ -1044,6 +1043,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.report = virtballoon_free_page_report;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.39.3

