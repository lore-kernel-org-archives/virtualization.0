Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B71534EC
	for <virtualization@lists.linux.dev>; Sat, 18 Oct 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809635; cv=none; b=UagWwVIZKf2cpfE69rrzJLSySFhcZH+jpScttbh4GaSyyAWRrqeu/R21m+qwE+7I1yp686be0P4d571CDjam3D1FoGjxnyG/Uqwh65ZyvIwL0RmcRQARtFgVfBzA7oEC5i3nNV+zVHvXBTNti31aSf9Zlq8tb+0feePmjgDMh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809635; c=relaxed/simple;
	bh=Lfon7ZsxMTwu6nscIEg9jOAf/yTOZGzyDLKKJZTyKes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSSS3V8buXV9TKR29gBD44wN8xub67MqDE58TJNHfopQU+rGr36ku+hfKWMovIgeffT2ZcpVEQ3+lEdewc0aXFzwcmh8a4x3Z9FLxSspIVT+0ilekvw2XNBmORj+IEnrGxgHhAPXl5pHvyNZUOjUhh9xeFfnD5O1/6lUWx4yJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VHNiyPlb; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VHNiyPlb"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ICgqh7016900;
	Sat, 18 Oct 2025 17:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=RMdeQ57pBgz+oj9DsiPVm19wRGmgW
	xnL4y27ggDSy6g=; b=VHNiyPlbzybuBsjh9Yk1Gj7uz786Q5HnttsH17lQixBCm
	1F+mAO6GM96jKtLnigYul4as5ehe8JOZULvh7r0L9JZ7CnCsslmB6pd/UhjQm5L7
	ntlj6q0E8JX4+gAGX8sfBXRpwjTU/DC/jkruCHmTTN0VGLHl5exCv2c9TUtyGHQL
	PpQVImhWU4cBSydbObgzs53qH9LuG6uYtBlHtUWDREpORgzrOhWZBZzEkAHPE1R2
	YvAKaeXdJY0F9iibywPlZwyJU1ZAHuzZ02JaIM1ylYdDAlZRHoE65uDEchJVCLO8
	GZkfhzWrtWyg9uANObUezwn3wFd5fl0WTqCy95X+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3esgdrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 17:47:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59ID2Idm013933;
	Sat, 18 Oct 2025 17:47:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9e603-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 17:47:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59IHl89s005608;
	Sat, 18 Oct 2025 17:47:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1b9e5yv-1;
	Sat, 18 Oct 2025 17:47:08 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: shannon.nelson@amd.com, brett.creeley@amd.com, eperezma@redhat.com,
        mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/pds: use %pe for ERR_PTR() in event handler registration
Date: Sat, 18 Oct 2025 10:46:46 -0700
Message-ID: <20251018174705.1511982-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180128
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f3d29d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=IuYCNSHuUhu7DeKkFBsA:9
X-Proofpoint-ORIG-GUID: QFLnKTeG0VwYYKRC_Pi6WQvrKFo_rro5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX4lGQB9PVwaCb
 poja4Qbj0gh6CrRF4O5ZwY3gCHUtCxJEqCBj84oRedYmsozZ4rvCuY50gCFsY/uIBMPv/Avq2xJ
 NYxjZcKgsx5NrRRoWD7ESbyu5Bjx5+Pyhh5Z3hGtZBtS7vwV28YcQ/1enn/gq3kZZWv0SQ+pjXt
 Zaf/CIbwR6VaVaDnJNI0uHCNCMxNGvSkP4jShx4qkqkEvr5EfA0OEa/h6q1v0E23BNE2gZesZpf
 Ov/C0H4TvwQ4lT0Xglw6/fSYhiFLzGkQVd49fs5P4VO/b9cfYixAsp39C/2xV2BKiN68KfOzzlh
 6Hz7ByBJeOBBqPTbk1WrgeotpnToTMOamxQuI6mDZjIZBrF0/g7OsZ0+1fBdPEGbyuwifvquK9u
 Ko6ivNDHzdewOFuq1VFAbqxDafWZ0g==
X-Proofpoint-GUID: QFLnKTeG0VwYYKRC_Pi6WQvrKFo_rro5

Use %pe instead of %ps when printing ERR_PTR() values. %ps is intended
for string pointers, while %pe correctly prints symbolic error names
for error pointers returned via ERR_PTR().
This shows the returned error value more clearly.

Fixes: 67f27b8b3a34 ("pds_vdpa: subscribe to the pds_core events")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 36f61cc96e21..43426bd971ac 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -51,7 +51,7 @@ static int pds_vdpa_register_event_handler(struct pds_vdpa_device *pdsv)
 		err = pdsc_register_notify(nb);
 		if (err) {
 			nb->notifier_call = NULL;
-			dev_err(dev, "failed to register pds event handler: %ps\n",
+			dev_err(dev, "failed to register pds event handler: %pe\n",
 				ERR_PTR(err));
 			return -EINVAL;
 		}
-- 
2.50.1

