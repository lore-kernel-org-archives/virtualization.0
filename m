Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E121A452
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508244; cv=none; b=TdF6dIs+a79dC8ARjBbiqYs+mpu08nc6bVepXL1YlYOmsw5yyxYbsaKPQNTveQXmFxovVso3Z2JKTekJF5VvUgDLwc5vneDtTsXhH7MH1eEz8exyCvhfGLEuK6FqYoKoU6B1cDCMqtgogscls1S5+/8t1huwcJAyOUA2O3ZvSNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508244; c=relaxed/simple;
	bh=f0mQOn68gPkN2HKKNtY2Irrn0U1K3r/S9xRkX/YnIbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJvyzF03vQFvFWY50YDf52cJpsqUWjNi1V4onqvKOz1JwcYx0x3ScIXgK8b0gorl/nX5A5KUze6pd7+QPdLnBBPR86iVxcb4m6ZtTMMiCUZzFmbk/+QonLO1sFCgiD+6HgcX9c/BPruALrElgujO8k2hp/pe6WvfNynFbcA33UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L73g76A/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L73g76A/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7u6dl019896;
	Thu, 29 May 2025 08:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+54GY
	hE1xK/Sj86KJ8lWPpCJ00kJW/dBVRkVLERxvHI=; b=L73g76A/iqRmQE/8XBM+x
	Crh8KYsarwMPEfyXU5UNrZ/RxI/Wn6n8CJG2xgcf1z40uwu9eHjoXjnp4MuPhd8Z
	04BSy4amy2t0p+UVG2oK7nIwlYBSrU6817NFspBZw850sA8/TNPru35/F3O4S5U2
	AazoDIoFgGsfTxug3hdaRH+9WHgFG5vA4wmfW/X7les9wSzxo/EmhlpcggM0cnvc
	0YydQ18mPk+UBJDQi6F12JQnCdgwcDOfOmfZQqD715m/7InEPhX4j+xe+MCbSbqE
	lkh1dKL6jF8LHWNwB8JO1craFqZl1cL7g/GmbzDPfkF734nbmWVJi0uQzw59+lUD
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcksj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 08:43:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7MFnE023699;
	Thu, 29 May 2025 08:43:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jbe81s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 08:43:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T8hsd6040383;
	Thu, 29 May 2025 08:43:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jbe7xf-3;
	Thu, 29 May 2025 08:43:57 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH v2 3/3] virtio_ring: Fix typos in comments and documentation
Date: Thu, 29 May 2025 01:42:41 -0700
Message-ID: <20250529084350.3145699-3-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250529084350.3145699-1-alok.a.tiwari@oracle.com>
References: <20250529084350.3145699-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-GUID: 63juKeAdWK1YDrQUyqKOsap0GDZSS2Tz
X-Proofpoint-ORIG-GUID: 63juKeAdWK1YDrQUyqKOsap0GDZSS2Tz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA4NCBTYWx0ZWRfX/txF8Rh4Xw5c 2vZDTt9J2BigTOempsFltJiVO1flwcjNXSEEPT79hns4F0F+yVmFlQauxK3IRIwEe8/zgJDFWeM oOeHTaHNx0sePwv5PwC7jIiGcAxfZnHccSPUxGOfNrt4sZ3lAfRktpfuDi7Bxd90JtjCsTGDQEe
 HYE3vFa7HWb0c27L8n7kgueEtKQzC6gaowZA7l8Qe5bdUvmUPMQqyqPS2dygkQVprjKJ7NILoXz xw7r2LQ4lf3Ku9j1SY5JgcwaZjBA5h42cHvKcEceuNOjFSe89aOck7Al8x8nl8KLdwWM2nEM2ke SElNkZ5kNnlneMYa0lZlP8/arNwlWeq/zhY14fGsbXnBudHZxWYaZsqymNg95ZYs5cDGSnHj8CR
 FuZF4q4j7HVFeSCW8UYb21FZwcl7mMKFUuJZYv8TrpAo6R/dlduVyLcMClglndxsQSWxjEaJ
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=68381e4e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=7WMo7ySrHbDt4XNLRQUA:9 cc=ntf awl=host:14714

Corrected several typos in virtio_ring.c for improved clarity and
consistency. Fixes include:
- "dind't" -> "didn't"
- "use" -> "uses" in DMA mapping context
- "can been used" -> "can be used"
- "buf size for sync" -> "buffer size to synchronize"

No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
corrected "dind't" to "didn't",
which was missed in the previous patch.
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b784aab66867..3191fb2a9a01 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -320,7 +320,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			*dma_handle = (dma_addr_t)phys_addr;
 
 			/*
-			 * Sanity check: make sure we dind't truncate
+			 * Sanity check: make sure we didn't truncate
 			 * the address.  The only arches I can find that
 			 * have 64-bit phys_addr_t but 32-bit dma_addr_t
 			 * are certain non-highmem MIPS and x86
@@ -606,7 +606,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 			prev = i;
 			/* Note that we trust indirect descriptor
-			 * table since it use stream DMA mapping.
+			 * table since it uses stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
 						     VRING_DESC_F_NEXT,
@@ -623,7 +623,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 			prev = i;
 			/* Note that we trust indirect descriptor
-			 * table since it use stream DMA mapping.
+			 * table since it uses stream DMA mapping.
 			 */
 			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
 						     VRING_DESC_F_NEXT |
@@ -2438,7 +2438,7 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
  * virtqueue_dma_dev - get the dma dev
  * @_vq: the struct virtqueue we're talking about.
  *
- * Returns the dma dev. That can been used for dma api.
+ * Returns the dma dev. That can be used for dma api.
  */
 struct device *virtqueue_dma_dev(struct virtqueue *_vq)
 {
@@ -3225,7 +3225,7 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  * @offset: DMA address offset
- * @size: buf size for sync
+ * @size: buffer size to synchronize
  * @dir: DMA direction
  *
  * Before calling this function, use virtqueue_dma_need_sync() to confirm that
@@ -3252,7 +3252,7 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  * @offset: DMA address offset
- * @size: buf size for sync
+ * @size: buffer size to synchronize
  * @dir: DMA direction
  *
  * Before calling this function, use virtqueue_dma_need_sync() to confirm that
-- 
2.47.1

