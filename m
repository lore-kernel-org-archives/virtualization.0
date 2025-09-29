Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E424339D
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153390; cv=none; b=KUvbkrD3qjSR23iOMJQJw6TeUMdaNV363Ke2xvC9BLlb1x1ygZ/VYRiBAaXGmhL/MDhvdFUm3LzhFBkjMx+nZVg9FLrdtGbBRhm3eD7lLNAaYzbBe32iS6oGsgSRAm/vIHq34B9G1pjeSkDLstZ12xl/t9RO8cZK17yaRsjk9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153390; c=relaxed/simple;
	bh=jW3RYDkCsI4HU2v0AKeCw9W3XjynAogb5adtVbICDDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beec0wcH/BMGFM4Zg+4p4YKHLUHHJaSJEqkwSECa3VmrKQft8FE5UvBxhdpygHoE8R/S/M1xxm/QZj3WeG97dUi1Uvb3Px6efdPbw6nliK3XBLDOJQA1TCWdovDeAU0Um4SMVYojMzB5oC5qebwXT3tNm3OMm/paKalvrBWQVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FB+XVO5O; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FB+XVO5O"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCXXWD026460;
	Mon, 29 Sep 2025 13:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=GAv/A40CU7IZVq8wfyU4O8Dtu7dhT
	FtQYsSoMGmYLFI=; b=FB+XVO5OeLvc2bNY8Ki9sJDclZ8dE+GlHOyefxh7f0bIZ
	YkSq/fTVfSWUyQz+LW+ygZ9xRvdbU0P3zdRGuy2hK3Gtpu/7Lt99bYyE153/823U
	ZEoi1POej6qguW8i4F3RKA65owgEB/rnp7SCAODJwK6BYyglcUjofyRPhkoA5RRN
	bDCQ0UXyHETS+OYM06SvUFjoKjRdB2tWg925YJ8ZT3WDj9ihE4oDCfgvQpK0zYVz
	yxuHrEWnTL4vGpketwxOxWDV4U6ZCWvL0yGn5tCbN3dxRCgjt5miZWc4ei/rJ05+
	lBkSgvjuoubmHTGZD3vQQLGhHSF+vBmvIit2P+LsA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ft7cr59m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:43:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCqEMD000521;
	Mon, 29 Sep 2025 13:43:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c6ffj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:43:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58TDh1oH019670;
	Mon, 29 Sep 2025 13:43:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49e6c6ffgk-1;
	Mon, 29 Sep 2025 13:43:01 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, tariqt@nvidia.com,
        moshe@nvidia.com, kshk@linux.ibm.com, virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: Fix incorrect error code reporting in query_virtqueues
Date: Mon, 29 Sep 2025 06:42:53 -0700
Message-ID: <20250929134258.80956-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-29_04,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290129
X-Authority-Analysis: v=2.4 cv=cruWUl4i c=1 sm=1 tr=0 ts=68da8ce7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=P6Glb_NPlWKY-MYoRREA:9 cc=ntf
 awl=host:12090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyMSBTYWx0ZWRfX6Wugo3vh02tb
 UsqgEGkZ5+qf760C6CnjHSBnxp7r+5KJP82g3lWpyLtaeig0o2W12g+GkTslxdLuBRSedVNUbrY
 IWurY+eg8jwtpJOAH2gvaKh+rzqbgc9bYPta8yqE4L1uQ6xCDEsWiDTf0NMWe4oqRyqZn/33ZBM
 Texo7+7xCvI7pJrxyNBUVL75iKcSRD9eygxvJBQUb6ZUQB6KQkkBzvoPAlW7magHEJGUvMB25ES
 JGqFWirz96pv0dWt2wpcLZRMfTDR18D9NAex4eSwopYLRHSnNSSe1PdWx9Xumv+3keUq1QyoDVO
 sPi1T+55qH6AV1g8aFV5yQx91Iyicx7te2uz5Llmp/eZwbEBa6YyYjK3apZzDUxRmrmGr/r4I7y
 MXT5Dbw7zv1sUavZ7wCPSGXM2OqX9lTT1wFbWMQLq2plRkIH0pg=
X-Proofpoint-GUID: GjHt1xdDzKMVegecyQccoNfNWr1ZS_DT
X-Proofpoint-ORIG-GUID: GjHt1xdDzKMVegecyQccoNfNWr1ZS_DT

When query_virtqueues() fails, the error log prints the variable err
instead of cmd->err. Since err may still be zero at this point, the
log message can misleadingly report a success value 0 even though the
command actually failed.

Even worse, once err is set to the first failure, subsequent logs
print that same stale value. This makes the error reporting appear
one step behind the actual failing queue index, which is confusing
and misleading.

Fix the log to report cmd->err, which reflects the real failure code
returned by the firmware.

Fixes: 1fcdf43ea69e ("vdpa/mlx5: Use async API for vq query command")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0ed2fc28e1ce..b2ebf56b2ea2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1258,7 +1258,7 @@ static int query_virtqueues(struct mlx5_vdpa_net *ndev,
 		int vq_idx = start_vq + i;
 
 		if (cmd->err) {
-			mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d\n", vq_idx, err);
+			mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d\n", vq_idx, cmd->err);
 			if (!err)
 				err = cmd->err;
 			continue;
-- 
2.50.1

