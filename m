Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5E21A928
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508243; cv=none; b=d93vMmL0+wUDsP3A3yQxjIUBRk6il/aTDrBB5+1ISOPFxZ5JFXRSsgmSkIiUB9lpb1YY2gJ58SSZvU6ZqaiXxs5FyRzGEvT2nteHI753Bcm7ha6oVVT/mREjXTnKj9EwlApMtxDhIYVQrEZIhP3/etz2/c1C6klO6WdUBlo/TvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508243; c=relaxed/simple;
	bh=cMupIyLWkOwhU/lK/gE/vHs9tZg6GcMRQtYn2ghpvuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDc4rZDNJN/4cetJ7JqPuepOHEHNbmO/d9D7J9xti3tPmYy5AnsbxoCKYHHZybT4TbLiOG5jiZcggN1/NnIivp+ge+UjhvaIsyPbXpx37CCWmIwppEe3zz4fdp+MdQ0lJHXXKWUTYEVpUARtNKt8AQis7Z//B+H/akKZb/GqwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FVwB+yA9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FVwB+yA9"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7ttJI012434;
	Thu, 29 May 2025 08:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=rqTTt5ooBmhNVWuObRjCfOVajUVwS
	wrWO9x79Cc9FkA=; b=FVwB+yA91uo0kCov22zGKpCq12viBlynZ35UTo3SjacvP
	kbWiqJIzzB7XveBgZUOA8PgTnfXYtGG9M/Z4+2yc/ZhGPKd9h8ZFN03EVxYUFWZd
	oBzyu5ZwVKUVEaAE1dGvynmLjTDGceE9AtzS7E2k8CUdD+AO23NKaDx3KtsrODnn
	4/of+91n+4J5SbDmyLlphZioKWZRxz+sQ1yPB7Xt5Qvm3mVuEXiiqAfDuY3NDcBZ
	egmC4dMSjaSfkfhsqrxQAcC71TeZ6eaIrc5rxT7ItUR2iGzNr22+f1r4B3OlgkrY
	XCTGz4cZtjX5ZDvYzdZ797NSmX5TCCYGcAIs8ehBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s7nx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 08:43:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54T79n0Q023863;
	Thu, 29 May 2025 08:43:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jbe7ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 08:43:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T8hsd2040383;
	Thu, 29 May 2025 08:43:54 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jbe7xf-1;
	Thu, 29 May 2025 08:43:54 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH v2 1/3] virtio: Fix typo in register_virtio_device() doc comment
Date: Thu, 29 May 2025 01:42:39 -0700
Message-ID: <20250529084350.3145699-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA4NCBTYWx0ZWRfX0hXwiBIZDQFG nN1f5tddJlPJG9rDJq00B0PURCsrDUQMEe92Yj782s4HY6GcrSGL7VlHzxXUljH3J0QDkIkHDAh LSDgX75vTYMoTbisP3maaXQ+cxowCOzr+MblUJH77IsUKJ6ATJw2qSIMZMyQMRlgPuWFjHw2Nw2
 mxhmyne+1rd2XuJu/W6vWJ688AMsYiA473rmZ4T5UH93hYMP2Z65tivR1yh1b+WivBBimrszNFW 0SToNGLRj3yErfSuXPwHFjbEkA3zXhzWTOUh6DAbdUqKFBph6DeD7yCpNw6QnRQiw+U+tGXHnnJ bt2eWjidN8sYB1IBZWrurPvKDEinPZK4FEpL3IUh5U+rB0I4VNwPoZq1FhxqV6qEbeILh781Smk
 ruwOAM+t89eOBbkmml3lIY3Wy600KRIxRko0wbQyD6BZRIAviZWYIzb+pdIk5LXcXjQP4VWG
X-Proofpoint-GUID: s1CeNgac6D1N1EKmPrf14k0DZerfFLl_
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68381e4b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=8LfaPh_PYp2Xb3PZftUA:9 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: s1CeNgac6D1N1EKmPrf14k0DZerfFLl_

Corrected "suceess" to "success" in the function documentation
for clarity.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v1 -> v2
No changes; only added Acked-by: Jason Wang.
---
 drivers/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 95d5d7993e5b..2c022640ec4b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -506,7 +506,7 @@ static int virtio_device_of_init(struct virtio_device *dev)
  * On error, the caller must call put_device on &@dev->dev (and not kfree),
  * as another code path may have obtained a reference to @dev.
  *
- * Returns: 0 on suceess, -error on failure
+ * Returns: 0 on success, -error on failure
  */
 int register_virtio_device(struct virtio_device *dev)
 {
-- 
2.47.1

