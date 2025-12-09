Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4932FA2C
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315890; cv=none; b=KA/Q8PM84MIv8zHpTIWCuusdnDRwC/JlN4PtLzYnJOROuLA/er+HYqTXLfbkrABlRmEzznIwyl2EzPDqu857PiZvRIQmjX45+aCsBL3QvZ8rHpUBj5Wf4wwIDe6ZM9q0JG8eVCWmHLR7kUH+tzN1PC7OABAqnp5KQ0XFst1ZI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315890; c=relaxed/simple;
	bh=EQhOMkSfXoXAmhq3shxM5lpqc+94m/4N/Zaz6wAJjY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5h7wDDzDqr0VgSxSk6lb00lJN2S76FC4SlOpZjw/f7FvlVZazIau95X9OduBtFbH9e8GOwFXjTegfDLLiv4maYoVduui+MYvjfIhzKDiK/H/uC6sskJE4BE9Q1vp3Wsl6Ee5RkHXJhJwdo6U7gNiO0VL5fNM7PUTdIYXhX5dUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d0Oq1dQ6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d0Oq1dQ6"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9KpoMX1551957;
	Tue, 9 Dec 2025 21:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tqfGGEDwE8Om7KV8c/tWmkPHGlleY
	SYluSYz4Plvapw=; b=d0Oq1dQ6QkG66py9DOm6k6O2b/BswXd0QckVkyMGDjOta
	vvHBSrbdrioPkUQFq551ooOdlxffrPZj26KyFonTuwNMHI765PkJceOUkz9yoLoz
	f9XHsPtqObFN4OKl04q0/B7n/Nl/t7eekv777jwCDb1GGurUWBTRj1FY5ZFqVAuM
	YgZbLVkBj4fOCrxmxhyXe6P/+aq27uKJzHoRPAkF9cuvFqArUnVRpUX9NZ/h8mA2
	3QKCzpAn0p482iVVlr0XOmCkoRmx2Vn/50v4i0IV3IO9f0VT38PltB6zU/De4yQ0
	CDY4RvTEg+s+b6rpya/lsVxZXaMkJbD2zWM6iFMsQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4axu63r2a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Dec 2025 21:31:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9JiBFc039896;
	Tue, 9 Dec 2025 21:31:15 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxkdsa6-1;
	Tue, 09 Dec 2025 21:31:15 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: david@kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] virtio_balloon: do not set pr_dev_info.report unconditionally
Date: Tue,  9 Dec 2025 13:23:11 -0800
Message-ID: <20251209212311.64885-1-dongli.zhang@oracle.com>
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
 definitions=2025-12-09_04,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=919 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512090166
X-Authority-Analysis: v=2.4 cv=YJaSCBGx c=1 sm=1 tr=0 ts=69389524 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=3oW8Q8UaqLbxhVEU8zwA:9 cc=ntf awl=host:12099
X-Proofpoint-GUID: 77MIoY8kOrSTjYSEVDH_TVlOjHMm1987
X-Proofpoint-ORIG-GUID: 77MIoY8kOrSTjYSEVDH_TVlOjHMm1987
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDE2NyBTYWx0ZWRfX1xHeL7vW5An6
 2vumDWA8FVgveGegejzqBYPGoIcmKbkvaaMW2+vN8+TfxXkO9LFNCTgdEk8zbgr6e3ANnFdPD9l
 CYoi4fVz2O1nzhpyeotht67YIAVGCFTy4+bexUhWk2ch6AH3AUJjss6zpL6CP+TYwaC9ECGrCHK
 +S8HNjEuv9p7jHTiotO2K6VbCO4PWyM8q167ZlhCiAavUCWLVnpkLAl98VBfD9sufU+e2OxlCtr
 vz5f25qRuDRyFUe6CTbrw3RuiTi84AZt3dFiZy9tRJfQhHBy9F4U472n6j9/5WcfmpwDRn/4wdT
 t2cBLzLsugM8eB7K3dBtPzS2+ReYRSm6k5Veg2GLE6O8Dv1yjAdJKv9sRrOCX4Y36PVC4Ob2gvv
 G+TQksMsA5yRUt2ZbCadM0TkSe6vMmYkiv9QOna2eZ+MvrL6Ti4=

Do not set vb->pr_dev_info.report unconditionally if
VIRTIO_BALLOON_F_REPORTING is not available.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
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

