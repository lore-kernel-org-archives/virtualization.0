Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B131F7586
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748370860; cv=none; b=L17H3cLzz/Ph4g9hwM1H7l1HaQQz3VAkOr/gkM4Cdk+Mz2OBvDP1zZg6aBunsTj9ZBVSNntmro6kNamLbbmTlwHG6YetDbd768eZP8RsB4Y8bpPQTUArJgeDDWr79g4oXdzaj7frfIpzrPeLODAZEQe/lOtcLzPR5Ck6JTTNenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748370860; c=relaxed/simple;
	bh=xzK0DQKgDl2VsnhLHps4e+Yb233796ciej6oAyzmsNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxwbZFW9/0FV2wo9PYXN+cTzx9osEqeluHW6bI98wbN6n44JbiaWT++cYUFC7dsXFRwXnVoM7SHw/NIlSAiplwpjuvTg/ZfzocfUcep3cYAWq0Z376O8ubQeFXaWUIyfehJAm+nlDVi9NV7t3Ie6o4kXVwP0Gu+s6u8xkU3G1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fl0pHuJW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fl0pHuJW"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RFu4B5030172;
	Tue, 27 May 2025 18:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6WLXv
	37STlgPCU/WZYgs3c18PPflVknELtcFYO6Y1Sg=; b=Fl0pHuJWlsw+ziUXtD1Ns
	al9USylT3pXpUqzO1+l0x7mfjPfA0PVBZMhjgkJRe1n5BPkY9unRQPG8nM6zQslo
	8DTmLC3+4QnA5F722dMQ6ua+0wEsUg88pmTS5CBKANhBt8nVKo90QxzVdKyIYEKl
	r+S3HFJ97vglSRqy7AHQPqOqPME3zc8WP5uku+iFVJsEbwkIuCnadtggSzBe6BAT
	FuPzCNqYie7upaSTwP+voTLoi2ka65Xn65Xvn1U3ubWxsb8KqrnvYNPC4IhwosTE
	5sGg1IZYkb/qN4bY7y7YxvEsBYM8KTA9BPChCbUzxHaMxL4Ml2e9J0wqLOkea00E
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2c6a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 18:34:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RHtYi3007211;
	Tue, 27 May 2025 18:34:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j9jbx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 18:34:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54RIXHl1028068;
	Tue, 27 May 2025 18:34:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46u4j9jbtx-3;
	Tue, 27 May 2025 18:34:12 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH 3/3] virtio_ring: Fix typos in comments and documentation
Date: Tue, 27 May 2025 11:33:40 -0700
Message-ID: <20250527183407.2093374-3-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
References: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE1NCBTYWx0ZWRfX+BBC7OS4K+2G dspJhq8XrH5lEIHHDrmfMilbjpD0BCQrQs8vud9zb3hsjTnX5XJ+pkKEdG1jq21TJkW3to+ZPve ejdzXQu6hRdbPQm/5TYOIeOKTkpe6T4w53KWPQGIvm8nxoh0Fv4MQbJIj+NeVfEEtws3NdzOr9u
 Q5OjIVYgIkj7ag2W54rUAOtYvkwryVgK+YsouMYOJB0W//PKdZF2n5ZBTKeMUaTjCf4LywhLNHE J6TbzL33BDOtPge4ZTMq27Q5+63TDQ+gniPMw3HOZdGfzVICnN/cZp0yxfdzSL/HmRbl2G1k1GY YDso9za3LDeo7nPJTpndzP3ibaWQcCJxShFRIjLMZUhwPQNt9RjGo9gJ4TT/hSTVUZFERA8887q
 4EXe7XKVwtJX6qcQn1z1IRA5tEWiCePaLcke+drOV+/eU6Jw0rSGNkchosBfpUiyFFNVboN3
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=683605a6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=7WMo7ySrHbDt4XNLRQUA:9
X-Proofpoint-ORIG-GUID: R_PC9h4KTQNo6OlxwVuL9AIDI4HK42e0
X-Proofpoint-GUID: R_PC9h4KTQNo6OlxwVuL9AIDI4HK42e0

Corrected several typos in virtio_ring.c for improved clarity and
consistency. Fixes include:
- "dind't" -> "didn't"
- "use" -> "uses" in DMA mapping context
- "can been used" -> "can be used"
- "buf size for sync" -> "buffer size to synchronize"

No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/virtio/virtio_ring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b784aab66867..e1456ec0db7c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
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

