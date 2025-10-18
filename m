Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF72286885
	for <virtualization@lists.linux.dev>; Sat, 18 Oct 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814915; cv=none; b=PiDk2J9dn2+e4KYcdJFbFwy3Qro9J+LgiRqzAhLLN/98fc6B+vDj1waciTgcE0IggAbslNYnO8ncTKvfcDEbpq1km/9cLJPxSzh13xNo3tbwcz/gKb0CmVlP/ad4tSm78jshj1whL1le2KhAhldTfF6fDx86fQy7MqPYyUXxmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814915; c=relaxed/simple;
	bh=zgiPqnKILiEslG2KhT67BgQLNK/8F8xwoSIX4V7NEoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0udbNwKbmFp+7KUk1f00DQAxK+fOIwgHSnOSMcl+QqGnRgj5+Xg4AK5f/gDW8HX/AS3/5Cwl2/i5XtO+0w5eeEWwIsmOQz4IrKfqAmjgJZnN4MkapDNEjWT442vRov+4gX34JvZ70/J7CZNPKbhoeKfNHbjcOHIqjFRZp20t+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ct+S7hru; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ct+S7hru"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IDI2Sh030534;
	Sat, 18 Oct 2025 19:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tCu1e6gtg6v/Zg3SP0sH2BMJdRNLb
	ajN0CXEPNLroPw=; b=ct+S7hruN+MDoRnoM3xW7IxBdcGSwyHUBJj7dhAt9T3e1
	K7SnpIkWZgCtJG/30t7PSUApEjeEUoiSg+MHjZvNOmsMx0JWHidowhxdLGODAdUU
	UueTDboMv0sEgl632/ELEY6qQwheYiQJlG2YRBmsvlqxiCYhWjpUlYjY826CIH77
	0t+HITHLpDwgYgNZqd3Aw5B8W4OnqOFgYbJLK0+Vfdzn9jQ9871gYxS00i4Hq2ll
	E/+GsIE7zijclM/cumH1YtL9+xUBRxmpyGA/UB5M3Y9NZaZQvkE41a+KVGoXWdiO
	vtQr8VI42ToHi0olmed2XOFkg7hIBf7nltePQ2zZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3070frh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:15:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IJ0bxV032281;
	Sat, 18 Oct 2025 19:15:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bafb96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:15:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59IJF5HO015524;
	Sat, 18 Oct 2025 19:15:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bafb8e-1;
	Sat, 18 Oct 2025 19:15:04 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: wuzongyong@linux.alibaba.com, arnd@arndb.de, eperezma@redhat.com,
        mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com
Subject: [PATCH] eni_vdpa: improve IRQ error logging for config vector
Date: Sat, 18 Oct 2025 12:15:00 -0700
Message-ID: <20251018191502.1516313-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180139
X-Proofpoint-ORIG-GUID: b9fccIZzutEoME07cHh4WU7HTw3dqbfi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXyAYIfGfimmp1
 OmjNaA8vTcVn52/bH9Lkq+9DrN6R6ck0I5w85MXh7ZhzaE2V34syX52jSjFL8CL/MTf52sLrarQ
 hMjrJSlQ+KD3s7Vaj5LsZ9vlol5Te8qfqLhvcOfYBya1H4XRLxWNWn8HENfLCRdbkq/HNYoqmgF
 8+RPhJ6VRYqLE0Ivk3K57dFSN5M6mbJAiUkFkf3b3QGYosvUT5lC0YxVZOYT+Hg9NnhtOtnGaVi
 IDVLTG1GFpPK14wSCOQAnzr8TpV8cGJIu73UalDLEC8sJaSkfoL7Ntj+/32t6iTQ6TxnIuAaUXj
 b3TIHXUUnWpHTh2CI/bVh4T+1Q6h1O2LWk231D3ra2lGbmiMTmQV5xAdibnp99WiZXkBUQbNPva
 G5uBhI73i43DogZo7Mg3UOPK+RMOM50fAUU8WTrnXSDP/8qCWds=
X-Proofpoint-GUID: b9fccIZzutEoME07cHh4WU7HTw3dqbfi
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f3e73a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=LmU0dL5NnU4aIHVmN9sA:9 cc=ntf awl=host:13624

In eni_vdpa_request_irq(), the error message for requesting the config
vector IRQ prints the loop index i. However, i is only valid inside the
queue setup loop. At the point of requesting the config IRQ, i has gone
out of scope and does not correspond to any vector, which makes the log
misleading.

Update the error message to print the actual return code ret instead of
the stale i value.

Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index e476504db0c8..e3b20ea7c423 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -196,7 +196,7 @@ static int eni_vdpa_request_irq(struct eni_vdpa *eni_vdpa)
 	ret = devm_request_irq(&pdev->dev, irq, eni_vdpa_config_handler, 0,
 			       eni_vdpa->msix_name, eni_vdpa);
 	if (ret) {
-		ENI_ERR(pdev, "failed to request irq for config vq %d\n", i);
+		ENI_ERR(pdev, "failed to request irq for config vector ret=%d\n", ret);
 		goto err;
 	}
 	vp_legacy_config_vector(ldev, queues);
-- 
2.50.1

