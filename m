Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D32EE608
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568102; cv=none; b=njgZ0/zAi5uL9SccYWKMeCc9TK4Lf0oh+Oc2zURZmd2nLxnqt6SoiHP9hEsn4eaDcSqtHSYdcJLv/pLpvVnYhJHDKyrBcdqp/0QCD6iRNd3s8WXAdFlYIlqFFffXsTd8c/Au5a1eNTXofT3MmguXpWkUZyF5VXNTQoshzGi+FK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568102; c=relaxed/simple;
	bh=f+YKeZAIOKpe4IOOCJkOaTbVPzoBz7x86e7aLQ/US/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbbQ1v3+K7s1Q5v6yyelbynVXyPSnbIejNY6LP6RnPj7nlr1x/tJ4p68e2uwsU55XSj5P+Z/WcwqcUg9ieVTeZRa6iOniw0kvJCUugtV4ZnqVM4MbgPgz3u8lAJV3c7PvYaA8zwiG1zQ4GulQf8LFTIMPZBQTf4ySHrdjLxk9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lvIAazU5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lvIAazU5"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEg2NX005162;
	Wed, 19 Nov 2025 16:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=zJqmgID/UApX5tZzYlIOWoNzGs8F4
	tmAV7ATY3h1Glk=; b=lvIAazU5uFiZciMf2op2qnzI5xmJfZzXjXMFCnknD9Axs
	+xhaarplD/8LjVge8BpGPYdloo9S1VlARkXSe1dNy/oHpmbYAOzTX3UwH74Whmo7
	GcHSE7R+lC3qx2JiNMiH/r30PRGHnFfOo0V1N9jc+1pqYDxIEwo5bivP0cNHSIEN
	CMLjhLJHJkLIjtRuzuz0tQW7o74h6eKIalnbnpA3iQSTq1uFC5QeBRiA5gKtU7Xf
	3nW/J7f3Az5pOlcycWHagQZSc/QoXqhJjGNH0UmKNTH1J2GETb95xC1EtqWseTXI
	qe42SjvozfLMDHxb8HKfQ7n7fvsrnyffjBszMVJaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej907dx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:01:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEcfAX037155;
	Wed, 19 Nov 2025 16:01:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyn20se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:01:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AJG1TiT030495;
	Wed, 19 Nov 2025 16:01:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aefyn20re-1;
	Wed, 19 Nov 2025 16:01:29 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
        alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com
Subject: [PATCH v2 next] eni_vdpa: improve IRQ error logging for config vector
Date: Wed, 19 Nov 2025 08:01:20 -0800
Message-ID: <20251119160125.299594-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190126
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691de9da b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ZO39oCByR73J6G4eHakA:9 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: w17j6mUZ5dS5gUXAlWGsZlzSw_k_SnxJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXxzEjRp12jImM
 UcDLVO+7kQNlKD1XmhOcaRYdfFXBqS1mSxqN4qUgn8UJNdavvuqXs8yRa7WRnJzCovhsReiPJSz
 CepBNJSn0LEQrfNTuY2AhSHVD25QhyX9SZkgAIIafdvu553fPCx/hCXbTT/TTuyl+4izgbDpllp
 llEhgOJXa/JU5sINDLVQP16SyA4/9t2U9tFv6akIo4mnsp0JuIYNDdxIP9JrrqaQItc2yM/WZkd
 SQHS18y8ir1+HsU/OzjFXcAZqmarQXrR88MaLUa7jvhue/v6AVoeYWdADG2KTsjpaLwgTKthm3o
 aYjQdm+lin1OymAdpPBPqmNO1+fGaCpoBrYTgmlypmminINxKHSIR5izc+MrotfKz/nVMNoIvdJ
 DIrm1xazx5HDF7tqtoSEAE0MTwyQgIul3dMrcdiwT90gHVa13cw=
X-Proofpoint-GUID: w17j6mUZ5dS5gUXAlWGsZlzSw_k_SnxJ

The error log used the loop index 'i' outside the loop when reporting a
config IRQ request failure, which is misleading. Replace it with 'queues'
which represents the config vector and rephrase the log message.

This is a non-functional change that improves readability and clarifies
the code intent.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
target for next and print queues instead of ret
---
 drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index e476504db0c8..d8f8406ade98 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -196,7 +196,7 @@ static int eni_vdpa_request_irq(struct eni_vdpa *eni_vdpa)
 	ret = devm_request_irq(&pdev->dev, irq, eni_vdpa_config_handler, 0,
 			       eni_vdpa->msix_name, eni_vdpa);
 	if (ret) {
-		ENI_ERR(pdev, "failed to request irq for config vq %d\n", i);
+		ENI_ERR(pdev, "failed to request irq %d for config\n", queues);
 		goto err;
 	}
 	vp_legacy_config_vector(ldev, queues);
-- 
2.50.1

