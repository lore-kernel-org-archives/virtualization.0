Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812D1DF980
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748370858; cv=none; b=RbWTlbNqnzahDMS5X+yVhGpeKKeKc/Xj5VPVSM14QFfk1T4iNCQiJ9yGn6fmAX3afgzX+SaGvQoa23HDIMSkQzsj/4UROeFYU6/Do5WGuqvEyqg+OTwtDUNDJ085+jk+pFctLDuYPMV2gE1GuOfWxR3eZkd0Iq1ZIzglpTgSf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748370858; c=relaxed/simple;
	bh=apeWV2KikRP7Y7ZK/ul3QuWHJaj3rjI5eXPoIr+OndA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmBT+YiDynxUgaANLRGQxfhNud9pefSaY57sBRkhpQUf52CyWSZ28Hz8cGgbyfk/zc7KdbxaVfp163o2K/ROf7wer2/bwzRLp1KI14l3U3C096UjvczZoPvCmPoMTdaCWk9V6cWBzcMNchrRhyzEf0tgxW0/ylSMc4B5r+zWxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dUpeOct6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dUpeOct6"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RI3glt004787;
	Tue, 27 May 2025 18:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=agvXDC7adX4pwozxL4ua4QG/66yh0
	FaVxLgLJlB3PyE=; b=dUpeOct6dxaC9kNFWEhaThIFes5CouOSflXbHMwl2Y8eL
	y7TRiEW4hVY+eX0MCdRXSHpzs7YPMFbAZbJZSWKveJAYqDc4gsaO5jqhIyuNmpOp
	7yfdNhsn9u+o3sPISeLRig+fxBUJNOsSWcJ5inveX3Arh9OTpq+4wdOOTJNG3m0d
	kJuTU0Q9Jg44hMshTU+MbXTZsOdoGtXj/s+Il0kqPHNlFoj6n+lgOBR0XzFnAUjA
	vXDrdBNiaWLHKWTJPQZDj7+x4o2szFdIZ2p91rMmlz1EmhKiMP/r3RcSUcR5FUt6
	Yni4RDieFS62yo9bRcDbnL2X4bJBXAC+xir6Yj1Ig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcg3gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 18:34:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RHnJob007156;
	Tue, 27 May 2025 18:34:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j9jbur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 18:34:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54RIXHkv028068;
	Tue, 27 May 2025 18:34:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46u4j9jbtx-1;
	Tue, 27 May 2025 18:34:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH 1/3] virtio: Fix typo in register_virtio_device() doc comment
Date: Tue, 27 May 2025 11:33:38 -0700
Message-ID: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-05-27_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270154
X-Proofpoint-GUID: Orq0TjsagQmVgMEoW-LniyTps6y0QGUa
X-Proofpoint-ORIG-GUID: Orq0TjsagQmVgMEoW-LniyTps6y0QGUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE1NCBTYWx0ZWRfX3C6ZIGmLkg5V bTPPFXWM4qDRg5AHW2M0jEKRI1UgY8BUbLzbDpZVAy+YCpBIy3/c19TbtF9WWB3tWrSyP1+01Fv ysCJ8vBw+sAMSuUC7SFJyQiakAozQH5HKnhBwUgMGGecGJIbS1w53QfRO/K7GTe4lUODbABIWqu
 8nnMOt9b8+FFnfBbXTGiLA+LB6qYbUS6Gz2QFt3BgnU9oVrpMu5EOsGxXiE5iE7dv3o0B5Eh2Fi hVb2UY00q9fTY2aFirdBDYUhAEtT1tbDreUxLteTbnPMQtDH/DEPj5kscVcwqDubv75HfjlTiLl 6HOswHJ1yhrELsjt6WoqOa4rmoxufdzc7A8zekBbXlaU1DhArbe0tI1xCpuZopYziyjlWtd2hbh
 Buvm3xgx6iJbn1Qjw3vIdq2xfkb7Ps27MSrXv0b+OwoEx4XcrxR0F1C1cfJ0B6kkvT5CmzZW
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=683605a4 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=I0AHJLkTXb5vcmZNF1wA:9

Corrected "suceess" to "success" in the function documentation
for clarity.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
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

