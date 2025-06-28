Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83931C8626
	for <virtualization@lists.linux.dev>; Sat, 28 Jun 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751135653; cv=none; b=YBwifRtkWnSCxOj8VG08vWjRrk5w5Tlc39fbXiSy3l0bEhs2Z13OIcqp3dX9BipoU7+6NJ7hnYD8zDyIEzNeB7q8N6T1gFiHiBjW3VYwPdmAxC4xUO30sxSGcHcrLkHxAzvbKJF98+4qvKAA0qy/07mXfalwS1NYgSXyGcQ//vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751135653; c=relaxed/simple;
	bh=w8jYnIjaUFwlYoBv8vq/TaGytJQbaOCBQSQujAsVOjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmb1HVVFhuaB4Su5ho1kWbQNJknmovRO5QNDq+aOWlN1ij49JSSlJ+RuQJyQuGMPwmIc60HpKUxK8hDlj2W6a7/5ZISx1TM8cFpEzi0z/UMudbIWoB1qxgsd76h4j9aOmCGatCnVDRftZsv8kxW/en+Y5q7BraghAm2fsDrc2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y6jULMqz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6jULMqz"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55SIMucv028453;
	Sat, 28 Jun 2025 18:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=SwGkhS6oU7gBULo49D78+Thb7S/MP
	pWv2fV2FOTEQw4=; b=Y6jULMqz7yLkO3VSer/QgePL9a1WlJRM4NqBma112Sq1T
	KP7DSrT7s/L7pWfP4nJl8zUMo0zpqqP4uzNh3ttFapKE8+r0Orh2TjfK524lEPjv
	Y+HwvSXyTlOrJd/Hh2Fm2AwUZg/qwb/1dF3Ul9UyPjpVDJOHRaJLHNdnZVibRcpD
	pkgZ1ViQzD7mNeuae5DZ5YTW4/O1OvyyHSBJ8m2M/TdwVtO08VokOhfVZnufERdj
	G3+ym/TnoQi4m6b3ohn9bhbNGnZdYDpYUp5e7rAh5OLCByMhPPV+bHAk8k3bVLU0
	5RquboZN9oc+Poupoarinl+oKMThskagX2YUeCcnQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w0ej3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 18:34:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55SHMKxc014097;
	Sat, 28 Jun 2025 18:34:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u702ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 18:34:08 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55SIY8E1017095;
	Sat, 28 Jun 2025 18:34:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47j6u702hw-1;
	Sat, 28 Jun 2025 18:34:08 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, darren.kenny@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] vhost-scsi: Fix check for inline_sg_cnt exceeding preallocated limit
Date: Sat, 28 Jun 2025 11:33:53 -0700
Message-ID: <20250628183405.3979538-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506280156
X-Proofpoint-GUID: 1QAJbHjjGQ0clRYnLvVijptxGqammU92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDE1NSBTYWx0ZWRfX5dgC6S8BhIpe 0spaA5wkFe3suwBjGQr30+0Qxek3KiEL6ZLIx5w5Z8UlTVS+PR1rhTCslOX4CVutKUADM64qppx e70GPA1UuSSBJhg3BN1LYfpWjj/uUebPzxwD0Cbo9l07RbGbqWJ+zT5XTZbWX01PsqaRsPjJQzV
 0ig9DL5L2RQKDhTb+m2XZf0wO1VSG+nOqjmaVva4fCYWiyPPsQKIZlSzUSdlf1XoyXxTlJWMOBz lOUp03bLMuTmHfFhZrMwAyLWOZI1N73G16Pzk/QwzUFApyWC+xPguNrCWOIJNVga8XLT1OtGiiI MeLzIhA31/NHbyEZ0gEFCXOP67OtNDFjAi2t9s6nGyzN1fJxmvnI0jrN6mKtDBZER5UJLqT5DZI
 E8gzwIu55XuJ21Lsk/BC4Xu24gqdD4wVjU+fy8eI3aM8T7PhjnTjR/f5+ZZXobNnrxNIPkHM
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=686035a2 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=n7_sAU11hH57P2nxMxEA:9 cc=ntf awl=host:14723
X-Proofpoint-ORIG-GUID: 1QAJbHjjGQ0clRYnLvVijptxGqammU92

The condition comparing ret to VHOST_SCSI_PREALLOC_SGLS was incorrect,
as ret holds the result of kstrtouint() (typically 0 on success),
not the parsed value. Update the check to use cnt, which contains the
actual user-provided value.

prevents silently accepting values exceeding the maximum inline_sg_cnt.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
added Reviewed-by Mike Christie and Stefan
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index c12a0d4e6386..8d655b2d15d9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -71,7 +71,7 @@ static int vhost_scsi_set_inline_sg_cnt(const char *buf,
 	if (ret)
 		return ret;
 
-	if (ret > VHOST_SCSI_PREALLOC_SGLS) {
+	if (cnt > VHOST_SCSI_PREALLOC_SGLS) {
 		pr_err("Max inline_sg_cnt is %u\n", VHOST_SCSI_PREALLOC_SGLS);
 		return -EINVAL;
 	}
-- 
2.47.1

