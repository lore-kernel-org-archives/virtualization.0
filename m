Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE373184
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691693; cv=none; b=VJKgxCpba/kOljJLNvNE4zFQXPCb/t4AFwNMQpZExcNyKKptsyoeLMBF+cAr4v6px0ciUjEDn0IdNv4pDPHqt4X/iUsTwjIZ+ArnCiFuTP3XXoKgl3GsRLbOPRsAlNg2wKGGwT43ZQq5K6AysmSBmcvTAuX1Pex+eV9V2m2/rJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691693; c=relaxed/simple;
	bh=mDq3AWn/JwiacVYVkvzK7pYEiWzF+qv3b+wSIDweVlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cg4VYyd5AAEiQeRRL/s75hb2nm9vcbKQ4f/e+S/S72wo6HLw79e8jTKfwJRTBYbs+lL6jOm3yS39pu+H8sAo0XkNxB9BoXNeMsFGAm4bpWQufFhypFiG7fnL+YdxsU5iTbA81NgEjWb8rMTePcujVVz6Y+6sccF8Sj5B4mRiCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WOe3N3r0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WOe3N3r0"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672DU2qR805819;
	Sun, 2 Aug 2026 17:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=zn46TrKj46C6dHGtkHwecJrsSVP/U
	eTDJC37sPVWJ0s=; b=WOe3N3r0j+O2SHptWtVywuIoZ0Y4NSY1rn2GzJ5DQqGIF
	F/7WxYC/7A8sIKKsf32n0am9QEWqtOmZW75sv4NmyKJB2lp9C6q2J42pPSudMgr+
	WkLOBr8buZMbpZ7BVdlEioMn04fBArxRHym37cKy3jOFdR69vOqjXUmF/G0xweoq
	6282jwE3GYy84l8SBoIUxYNsM1UxPnTMgrWcGIgfMicaonegX0lVg/QirG4lODEX
	Jj1f8oGipAitg79T9+nxVNDglpf9FRJtQ510CwmlyiVQuNQ2dy/GhtUfTsJ+5pnX
	LF9FZp+2aGQBeo7xPBKDxr8Zim647iAdvbclCntwA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7qa31sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 17:28:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 672HPpm1027653;
	Sun, 2 Aug 2026 17:28:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78r0h6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 17:28:09 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 672HS8PC032953;
	Sun, 2 Aug 2026 17:28:08 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fs78r0h6r-1;
	Sun, 02 Aug 2026 17:28:08 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        kvm@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH v2 0/2] vhost-scsi: fix max_io_vqs handling
Date: Sun,  2 Aug 2026 10:24:54 -0700
Message-ID: <20260802172534.260047-1-dongli.zhang@oracle.com>
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
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=897 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608020159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1OSBTYWx0ZWRfX8YjciiN+5qGn
 bN163RsuS9HuUi7lKcnxXlTjeyZYlnKdQdQYFON7pEky+TDaS8OLRzxLSMKvbOOqbH1gFdTS9Ex
 AfzV5dNGbPxYEk2TJAfk5Gtyw1Q+dHPFlLxijNqvWuBv08BOmW9xtmN4l4cbjjrUBfVdx4B/s8r
 zysf2T5iYP6251dhWiG1MC3g12TFBWBKNyvuL+USzDveAigX/TPEQG1SSWmVjF4YWXQSlwYX7Tw
 DZRwTBHBt8Z24lBlmyBgxCTA6VLaGsJ5U2R7Q+CZYUBhli0jBWLECpyVnBjmq3oXIICvZVU/8Ef
 6XC2VECJSKVTxykFwlsXjOvMljdkJqF4vR3HvXjPWJbVvZP4EP/X2FHwfU14P2QTyxCBPqkkqu7
 eYaZBGGTjXMtVwOktuVN3Lu+eAUWA9MSQqzG2yNX2uT9IlO6eYrgh8VAzy5/TtSjMW84bCuDI36
 C3w45Hs01qYLLL3FHXpwZdwYSDJKHbQGF2z4HCAw=
X-Proofpoint-GUID: FQmet4nVhuCggHhm_Nnsa7eEJxeJRe2i
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a6f7e2a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=-s18Wruy92E9eT26p_4A:9 a=zZCYzV9kfG8A:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13517
X-Proofpoint-ORIG-GUID: FQmet4nVhuCggHhm_Nnsa7eEJxeJRe2i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1OSBTYWx0ZWRfX0RV84wRX7ENC
 Z5ieF8m38+P5ZPGPr+CyGls2n610+277v1CMNi3H1qUs+KTVEG5jW/LdXsuWTKIhVIysbk+kN7X
 UeGnHeqBkynjIUjG2pCgBGWBYMjRteA07YSRFzXgiOPXJS69SIos

Avoid high-order kmalloc() allocations for the vhost-scsi virtqueue array,
and clamp out-of-range max_io_vqs updates so the stored value remains
within the supported range.

v1->v2:
  - Access vhost_scsi_max_io_vqs with READ_ONCE().
  - Clamp out-of-range max_io_vqs values instead of rejecting them.

Dongli Zhang (2):
  vhost-scsi: use kvzalloc for vq array allocation
  vhost-scsi: vhost-scsi: clamp max_io_vqs module parameter

 drivers/vhost/scsi.c | 49 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952

Thank you very much!

Dongli Zhang

