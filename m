Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E478F39
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760208043; cv=none; b=fm29eplq7a6L9pqNvoZfka5hVVf2YBZZMfonOxYvLl9XxFMlZ50NAIHnHvu2atQhH6Kl3DZlW/3HU0CL2vblK01tK74o+EQgbJNW4RMTkyORpqsk3Ap4wovfLHjHX/87hhCNYrxjhZNvqcRLnTKwPHeWgpHrPWamrEdPwLm3JCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760208043; c=relaxed/simple;
	bh=pO7KNdAOsuji38pm2Lu9N5Pz4CdKc7UKPBBoeNts2+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egWaIM35I2y75+qS/mgZAjMSJa9wxVaq6EV3GJJdNdYwcg0v1JQtlhGRWr5HxMaZAA/1DzxHqaqSCpufbqFRoaJvxlGTndEj5fla9A9WVgJHBb7BvOJlnFubVbUeoHGVoiruBq7pIZiNIRjY2lDoF6SdIEwxKm5Un+iKjzqEhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CVweedLz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CVweedLz"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BFbTan006769;
	Sat, 11 Oct 2025 18:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=aQ6zLQ2hYaS0Ge5ungKTmqoAWJhfR
	ULBrc+DvtUdyUA=; b=CVweedLzMkUlWyRA1oblakAKQAo75bFJXKLbBV0+To7NV
	SnlX95s7sV5pYiF2KKr6Mz/M0EH8xyPm8ChgtmrKD5vtsAoLPQ8gPnj+IKeWS/ek
	V2/1+x8vOkZMwjxctQEtEeCF+IPuvPjALlohNx3G0F2RlSz3EspOnKZhZxyM4b39
	J03ZWFnnI915U8LlAP26x2y2BISDzUTAESbbbD/4Vr2PztgdmS27ZXpznRoeKHKg
	Excy2rySo7g7gUHz68/OF/L518iesLX+wE3nzEM70TPWTKt41oLlAChh/Tu12b2b
	1rewCrwdJj75uxdDjS/02lrSwOx3iBsXe4k28VZxQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47gg4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 18:40:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59BCYdTJ009793;
	Sat, 11 Oct 2025 18:40:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpc6kkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 18:40:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59BIebGa007943;
	Sat, 11 Oct 2025 18:40:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdpc6kkp-1;
	Sat, 11 Oct 2025 18:40:37 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: david@redhat.com, eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-mem: fix typos in virtio_mem struct comments
Date: Sat, 11 Oct 2025 11:40:28 -0700
Message-ID: <20251011184033.616751-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510110106
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68eaa4a7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=ep7tjsRKnRn20hCSCwQA:9 cc=ntf
 awl=host:12092
X-Proofpoint-GUID: 9TXDq4_2dfbjp8rTuqYhev3PhkGXW-qY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX//z2fEkkoUNL
 QxusU/+Dd86AMgxirCg5h2Rh9+f2jOdtF5tPZ4rW2CeFhvOto1FY2KQ5caJM5zAHCOevkFuzibu
 Rs7c24Si+BrZU+hMA9Ky+TBcJq/yo/OJFnu8j5Rz0Zbh7ZbQ4XX2V8t4LQsDDhazPtcDIuHOqts
 qqF1Z38QbQEMUBUQk7VGdr9TvCj1LoQB3HbcvsiCW3A3ak26v0VB0IIWMxgPE/h3iHqCxFb75KK
 QFVDd3gheRi7ADbUvZ2+9surlAbZHPiX7k6tV13k/W5ftv9YrUl7HzIoJxYoQegpv3Ft7jKgCPb
 pCICNh++i3GrAFF+V4Riimkqk8YG4khtFTE7H0ioSe9QUAT5zbNhRTfaJ1spkh64MTwwAXaTSDs
 qg2strmZzcL26KNB6INvAti3vbKPLwiCPcUZT7zvwSaqWqrn68k=
X-Proofpoint-ORIG-GUID: 9TXDq4_2dfbjp8rTuqYhev3PhkGXW-qY

Correct minor typos in comments within the virtio_mem driver:
- "bock" -> "block"
- "valued" -> "value"
- "actipn" -> "action"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/virtio/virtio_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1688ecd69a04..800cc7f9805d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -164,7 +164,7 @@ struct virtio_mem {
 			unsigned long first_mb_id;
 			/* Id of the last usable memory block of this device. */
 			unsigned long last_usable_mb_id;
-			/* Id of the next memory bock to prepare when needed. */
+			/* Id of the next memory block to prepare when needed. */
 			unsigned long next_mb_id;
 
 			/* The subblock size. */
@@ -240,7 +240,7 @@ struct virtio_mem {
 	/* An error occurred we cannot handle - stop processing requests. */
 	bool broken;
 
-	/* Cached valued of is_kdump_kernel() when the device was probed. */
+	/* Cached value of is_kdump_kernel() when the device was probed. */
 	bool in_kdump;
 
 	/* The driver is being removed. */
@@ -1080,7 +1080,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * Start adding more memory once we onlined half of our
-		 * threshold. Don't trigger if it's possibly due to our actipn
+		 * threshold. Don't trigger if it's possibly due to our action
 		 * (e.g., us adding memory which gets onlined immediately from
 		 * the core).
 		 */
-- 
2.50.1

