Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650C2DEA7B
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536019; cv=none; b=a9QvUISYR4encGOkjElUiWEV1/Y9CMrrgZBs+AIUUV5D2FmkidNFQZeSMyKVzdWYxRPb2RRwvUjqS01yqP3Gq/ONJsBfEjWSmTD1rG/PyLyWxWh8AKjpX4LdEjcIqTTwI6ak4uj5H2vd3EI2vHYKwqIt3d2GpxzCGrfVnEYF8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536019; c=relaxed/simple;
	bh=uj1F/cpMTObq5HK3aHXGqdVv7tyfxY7N7imH5LcYTIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MC9zW3sF2q7cofOsKQLv8ZgEiqpJD4syT9dwe3WWO8Es6rTKyEJLzIQ0fIR6Pn/k+9EcwQ2fGGhEs25ypT8o6lQ1oCxSc8m1r33o2fHouEp8RoJRfSTG78+qFwQvkvDl/mWOu6UxMWafxNnDnZ/ohVrAnBkR/9fn8t6ZOLzQbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V2hYPoq9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V2hYPoq9"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VJtWfA556801;
	Fri, 31 Jul 2026 22:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=l/Oeh7aiJ4wgj9UZYxrPtACq6kt8F
	MXBzr0Jw40bOMw=; b=V2hYPoq9ZcGIoOG3ed0grq2EZXsAZdCVxSEskdxfQ5bCx
	7OdZp5vuyG/9xeB808fKd9Y2TEPiT4oM8SadVBY6iaAD6rQX/ekh5JasHt2uNz+h
	RWXxkE5gcf9yiqJa0icUFTYYgFDL62ufqNlNkoGa7/6+9nTuuaRf1w1tcjIHpnZ/
	sho80RI8W1lJxB/ZHNVPaztYnzTCLRypurufYCnLFAtUGsHTtDuTSGB/1VGZO4IT
	x+rdFtSPWMsxmo/qVleUCpRqA70evU3SuOYtji9BO+WHnZJYKfj2ehVt01StWpwW
	FAwmvvPEyYDJqyZ5RxFVDUXWYyVWtyE0Do1FxQZkg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr3pv3bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 22:13:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VMA6ru007731;
	Fri, 31 Jul 2026 22:13:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fnheq8a96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 22:13:36 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66VMDZB5018145;
	Fri, 31 Jul 2026 22:13:35 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fnheq8a8s-1;
	Fri, 31 Jul 2026 22:13:35 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        kvm@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH 0/2] vhost-scsi: fix max_io_vqs handling
Date: Fri, 31 Jul 2026 15:10:22 -0700
Message-ID: <20260731221116.236791-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=870
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310167
X-Proofpoint-GUID: zGfZHVW9PbkSeDW9tgZqBVP4gUn7ftwD
X-Proofpoint-ORIG-GUID: zGfZHVW9PbkSeDW9tgZqBVP4gUn7ftwD
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=6a6d1e10 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=W1Wc-le84Cf0Po2QwqYA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2NyBTYWx0ZWRfXyVOUSG3C25Ek
 DaSlTRWGWIh3QfAQ9uhp/txe0xWoRn0tF1wexCPzB6CSwQf0ZwqoZHG+ehEU01wyr0pa18BZFqW
 gORBsxzpiok9HiHs8CPVjcWbeE9hwtOccTUsY5d4oxK5rnAJaBKCjMl74+VnJdpV3ufl0NshjDm
 rgvbjjucyZ6mqef8NIMwc07hW1TCh2p4v5BYak/GmBfhK5CwXwhFvO5V7cim7V/2SBwuPlopQW+
 CyEIrQmp0OOFlTgrKrVLOOpbH/boQKMDgR9yDRyvmTeoFWTs7NadCy2/Ha2tcLGyS20wzytruFq
 cUYhaAg7MuGk1+zHDGkqIwCvYz4vFK03pGJyKdZnrEKaqvZo6Gy8dLgH8x4IbpzxSTXKjYDFblz
 vpVl5/ttlWyrQZT5bAbPJ7eQmM/nAcdcSYeVXdFLll9xfKSLtD90MFkPzOG8WvG3tPlbr0KG5+C
 zIxqvzYip73s6gisJHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2NyBTYWx0ZWRfX3MhI7VXSWOvU
 4IjchoaQIl8srR2mONpXcZbeo/9dkucuqha5b2HZi0LRSyEnUgKzO3+3lNKoT268X7WvTRnhHXI
 kuK94dpargr0hZJTF8DI5eODt/iL1f13/HfL7Iwtxh66kNEQkpJM

Avoid high-order kmalloc() allocations for the vhost-scsi virtqueue array,
and reject invalid max_io_vqs updates so the stored value remains within
the supported range.

Dongli Zhang (2):
  vhost-scsi: use kvzalloc for vq array allocation
  vhost-scsi: reject invalid max_io_vqs module parameter

 drivers/vhost/scsi.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4

Thank you very much!

Dongli Zhang

