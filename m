Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127C477298
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393077; cv=none; b=A8Ec/Zx6A9FKUQW8s3WckwhaMMxyJnffzQS+YdWPYqV7YdksHMazGzWKzI+vb6erlvw2193VjnYFgbcwW9oAHosB7RgVFM9rzFbWu4qQ/2uaVHrC5x46wPD4FoBQCcRBZ+2cbum/HngyvmQTZKNNpb7DsBJDexV/QywM7LS5rfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393077; c=relaxed/simple;
	bh=YiKh5V+YEc0HG9Sg0HziwaHjw7xOx3e7esxCZsefzTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itwOp1O/oKV0bT+zcBWpsULn2tIYtwKLhJMR/HM/sAYac9hAp3zRyF/61/9+0T3HB6KBscssbIWc7iOgBX2YirV0ZcWEgRJutIcZs8NDOA54hMYLwWuKrGZ5yb4+bbBQLuZXx3dtl1Os+T3ENEHdyAlsp0rsWjqSYRW20hSXFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iQLxKayy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jz9wac1h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQLxKayy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jz9wac1h"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0KEW4090474
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sHzJV7DoUuy
	lvx+MlonA9cvYxJqTQaH9CVz5nVLjKUA=; b=iQLxKayyrgGr0uSMBCH9YPwJbkH
	qN+GNB8V3O16BGXxqxoVCMLFpF4xl6b8Pj2Xl1PgmTWcaT7kkHRCUzKmaOpEAmZM
	csfuQTqLmH4k36T4Yw8knnNdyXLxOzs6ZyCyTmwQUYHn6rHFNy4bnbgTU56La877
	bRX5Qgy1Bc7HcMLY+TYUpjOKhLqq/aQzeopXb0rkJtyAuCG9AmaXtfRQ8EJfpEPI
	uNgbwWHgiSotd4a6e50nYMe9OdyZUotpzBOF1cvZWOLMNsxjJXAN3EH8eIuBeqVZ
	kfNqFnSrj0o4OEJmf/m1S6P63vsgm35f4m+MY/NJLQmF9BG8YIMZa5RxMqg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg1bv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:37:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa4e4684bso78749945ad.2
        for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789393071; x=1789997871; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHzJV7DoUuylvx+MlonA9cvYxJqTQaH9CVz5nVLjKUA=;
        b=jz9wac1hpZ+ahpPqP4FrVu2qmbSSgmYGqCavuQhdAg20WptlehT0SDV6l4jP/s6jGU
         yYKyYLdUahsV2tVs9gXNXloeICz6JpRTz4CAiFjflI7IG7oQdy0ZUDskpc6NjqEQiNl5
         cjPuYL2fg+90ZUYCnztm7Q7/hpgI2JGZV/BT/k0p4gcrANNUNI0UA8WUlJWdPQvwhixY
         QTBdAOqq0X9tUuj1Ga9bAXJ5MQkPV3Xs2estoE+wDJXBNWu4ahrrNH0sa6MFEPCmB1u7
         4kRUJCj7XnVFgmQwZtYeRp8RqaS3W2KL9phU69SNpeeKGJyzCPHytNlQu7/pB+Vjy042
         qDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393071; x=1789997871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sHzJV7DoUuylvx+MlonA9cvYxJqTQaH9CVz5nVLjKUA=;
        b=qi2zBNVUUdyvD2XvZ3RaEdoY19qDc00UXqTF1Jp3udT8AMVO6KXeHisz5cj2GJaT8b
         YJLdAEVMGbLkzpinSvXCAHXNWelh8z1mBGEfQchYjOhW+FByJ8RkbZY+O6WOam6bmBcz
         bW/lU+v+Y2upqpI6kK+PmF4DhKdH9sYrv73Q0EafJXpPU9OFJOiIvo/BS8MyWyfqKMeF
         uVY4YZE7iEd9VGkZx5BLvdxTlR8GmLUl4VvlXYnzD3KQ/WtSzqT4crIt/j2jBlDp8VtD
         W8c+Rm5m5N1VziLIkLB4KD6JFgYiPd6BtJMRPvxdcHSf/J92+tdZ3JJdIM3FxXFAE+/m
         HQiQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4mW6mIGWslZQbwshhUCeRNDBSmSBmSjfoxiQBB+5dcPRPaei2xtQMg7og/9Xu+EdcApKcsTGK3nqqyIe2iw==@lists.linux.dev
X-Gm-Message-State: AFuF++lFPEFX9jsY8dWdsAQw7cP4eEeipBKyd/lAyowX5Isk2M3QEvnF
	6d1tR58u+8DDSbNSBWb5ohaoYwTp6Oq5QyzvaP15558UkkobtoG25lqoowEqPmv73OPsfMDCyIW
	sS3ByCA+ku6Vs3nO+FJBzc3C+UIxHEPlQL/G6HESyEkUyVlJx2LVOqRtrB3akbWVQ9MobpQ==
X-Gm-Gg: AYBFou2MusTbdpRycXBelWsM9peg2+q/EzyBo4mlnRHH4S8zi6IXn5ICh8X5xXe+B3Z
	reFFuZRW52gOAeMuYXgl5M3eU0ZwGVi55LRXFx23ypgZv1winR66yABU/1mu/xITkod97VirTuO
	/VAOcTalDcGzO9hI3M+URtaHiUC654iLthwD4n+6LWa0Atp91/N7ziv3JzmAN9v9kUqTe549qmI
	AVvm3RzHCWhE+CxN03f/uLSKlmk2iSL3WA4VqSDFnBSzIkLnJPzIjmNdujzSbLbca5i+ndkXgY6
	Di642Io61OjoXRLxodtpg24H/iPZFksc/gCyQnKepm4Zt/scvWC6skPLbhjk2pzL7OlI0mAXZM/
	tMq8FMpAXrDWz2LeEm040e7gELzv91rNmFSRDIC30/r4YIum1A6HgpsHanm4=
X-Received: by 2002:a17:902:e744:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2dd6c4835d0mr52450715ad.0.1789393070166;
        Mon, 14 Sep 2026 06:37:50 -0700 (PDT)
X-Received: by 2002:a17:902:e744:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2dd6c4835d0mr52449805ad.0.1789393069350;
        Mon, 14 Sep 2026 06:37:49 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm49132685ad.62.2026.09.14.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:37:48 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] virtio_blk: add inline encryption support
Date: Mon, 14 Sep 2026 06:37:21 -0700
Message-ID: <20260914133733.15429-3-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
References: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa7f8af cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=7cB_SFYodWyvrme8HfkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: -znY4xmgKsTpLAkS0Sv2xd8hKpx4t63I
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfXxKTWgZWGx0J4
 ccX/XZ1c+Q4KPbESxFZgVqhHXatAcNsS/LfFFKIiHoHr0Bdah5g4MaNY5BE/49+/MbyE6u+DgaW
 AyWQJh6FsST36yL5EUDH/frNdT8Mxrs=
X-Proofpoint-GUID: -znY4xmgKsTpLAkS0Sv2xd8hKpx4t63I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfXzcV+ENcgM31Z
 Aw7ubq1bPhVrm5VjfR6mXr/88uAHQbysQNt8p/7MyIiFAbhhrTBq34y3GhgB9so+nkn6BxPHXI0
 dEzsIDiJSfijxj3/xwoBJl+lVAPBbmDqATJDI9PcP7nl3j0dVD8BTXc4YQkttoCZ0J5IA6SsG6+
 iLGR1Z1U4FjJHNLS86vaa+wKTHFgLtYGJj/2axiF8QV+6WsjVkfhTwFY+phw6c7i6ck1E1FDlaY
 8AF7ilP2oLcJnNFQ8/dI17UAqALVS7tnLoHqKfFlg+W1vbgPjVj+FScKmu9+m6FJqZK8pMuUCA7
 axdLV9s0ug/Dq5/lDuUe0i2LIKku9kLWCMNv7J0gCW3AA1CKjxxJlfyQoDLXLiSQnTZtKo2f2s3
 m/0igbGn6IfvdHLCf1ALFhc4h7KQvj+0F+mz99MvmhAxGHD9GSK5/kh6I+pOzi950lQVY9fbXTo
 J8qZ2xI+O+HRZn+MhGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140194

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add support for the virtio-blk inline encryption feature
(VIRTIO_BLK_F_INLINE_ENCRYPTION), which lets the guest offload
per-I/O encryption to the host's inline crypto engine instead of
doing it in software in the guest.

Advertise the device's inline encryption characteristics (key
types, supported crypto modes, max keyslots, DUN size) and wire
them up to a struct blk_crypto_profile so upper layers can attach
encryption contexts to bios as usual. Key management (program,
evict, generate, import, prepare key, derive software secret) is
carried out as control commands over the control virtqueue, and
per-request keyslot and data unit number are carried in an
extended request header for read/write commands.

Inline encryption is only enabled when both the control virtqueue
and inline encryption feature bits are negotiated, and is gated
behind a new VIRTIO_BLK_INLINE_ENCRYPTION Kconfig option that
depends on BLK_INLINE_ENCRYPTION, so kernels that don't select it
are unaffected.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 drivers/block/Kconfig           |  12 +
 drivers/block/virtio_blk.c      | 576 +++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h | 115 +++++++
 3 files changed, 690 insertions(+), 13 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 858320b6ebb7..58bb050d4617 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -372,4 +372,16 @@ config BLK_DEV_ZONED_LOOP
 
 	  If unsure, say N.
 
+config VIRTIO_BLK_INLINE_ENCRYPTION
+	tristate "Virtio block inline encryption support"
+	depends on VIRTIO_BLK && BLK_INLINE_ENCRYPTION
+	help
+	  Say 'Y or M' here will allow the virtio block driver to route crypto
+	  requests to a different operating system in a virtualized
+	  environment. This is useful to encrypt the data stored in the storage
+	  by using storage inline crypto engine. The control queue feature bit
+	  must be negotiated to enable this functionality.
+
+	  If unsure, say N.
+
 endif # BLK_DEV
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 252ec9366153..3fd318e5e1f1 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -17,6 +17,7 @@
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
 #include <uapi/linux/virtio_ring.h>
+#include <linux/blk-crypto-profile.h>
 
 #define PART_BITS 4
 #define VQ_NAME_LEN 16
@@ -94,13 +95,24 @@ struct virtio_blk {
 	/* For zoned device */
 	unsigned int zone_sectors;
 
+	/* For inline encryption support */
+	struct blk_crypto_profile profile;
+	bool crypto_profile_initialized;
+
 	/* Control virtqueue state. */
 	struct virtio_blk_ctrl_vq ctrl_vq;
 };
 
 struct virtblk_req {
 	/* Out header */
-	struct virtio_blk_outhdr out_hdr;
+	union {
+		struct virtio_blk_outhdr base;
+		struct {
+			struct virtio_blk_outhdr base;
+			/* Crypto message (if VIRTIO_BLK_F_INLINE_ENCRYPTION) */
+			struct virtio_blk_crypto_msg msg;
+		} crypto_append;
+	} out_hdr;
 
 	/* In header */
 	union {
@@ -124,8 +136,23 @@ struct virtblk_req {
 };
 
 struct virtblk_ctrl_request {
+	/* Type byte, always its own out-sg for every command. */
 	__virtio32 type;
+	/* Out request, sent as a second, separate out-sg if any. */
+	union {
+		struct virtio_blk_crypto_key_desc key_desc;
+		struct virtio_blk_crypto_key_blob blob;
+	} out_req;
+
+	/* In response */
+	union {
+		struct virtio_blk_crypto_key_blob blob;
+		struct virtio_blk_crypto_sw_secret secret;
+		struct virtio_blk_crypto_modes modes;
+	} in_resp;
+	/* Status byte, always its own in-sg for every command. */
 	u8 status;
+
 	struct completion compl;
 };
 
@@ -159,12 +186,17 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 {
 	struct scatterlist out_hdr, in_hdr, *sgs[3];
 	unsigned int num_out = 0, num_in = 0;
+	size_t out_hdr_len = sizeof(vbr->out_hdr.base);
 
-	sg_init_one(&out_hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
+	if (vbr->out_hdr.base.type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_CRYPTO_IN) ||
+	    vbr->out_hdr.base.type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_CRYPTO_OUT))
+		out_hdr_len = sizeof(vbr->out_hdr.crypto_append);
+
+	sg_init_one(&out_hdr, &vbr->out_hdr, out_hdr_len);
 	sgs[num_out++] = &out_hdr;
 
 	if (vbr->sg_table.nents) {
-		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
+		if (vbr->out_hdr.base.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
 			sgs[num_out++] = vbr->sg_table.sgl;
 		else
 			sgs[num_out + num_in++] = vbr->sg_table.sgl;
@@ -254,6 +286,22 @@ static void virtblk_cleanup_cmd(struct request *req)
 		kfree(bvec_virt(&req->special_vec));
 }
 
+#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)
+static bool is_crypto_request(struct request *req)
+{
+	struct request_queue *q = req->q;
+
+	return q->crypto_profile &&
+	       req->crypt_ctx &&
+	       req->crypt_keyslot;
+}
+#else
+static inline bool is_crypto_request(struct request *req)
+{
+	return false;
+}
+#endif
+
 static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 				      struct request *req,
 				      struct virtblk_req *vbr)
@@ -262,20 +310,27 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	bool unmap = false;
 	u32 type;
 	u64 sector = 0;
+	int i;
 
 	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) && op_is_zone_mgmt(req_op(req)))
 		return BLK_STS_NOTSUPP;
 
 	/* Set fields for all request types */
-	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
+	vbr->out_hdr.base.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
-		type = VIRTIO_BLK_T_IN;
+		if (is_crypto_request(req))
+			type = VIRTIO_BLK_T_CRYPTO_IN;
+		else
+			type = VIRTIO_BLK_T_IN;
 		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_WRITE:
-		type = VIRTIO_BLK_T_OUT;
+		if (is_crypto_request(req))
+			type = VIRTIO_BLK_T_CRYPTO_OUT;
+		else
+			type = VIRTIO_BLK_T_OUT;
 		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_FLUSH:
@@ -328,8 +383,8 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 
 	/* Set fields for non-REQ_OP_DRV_IN request types */
 	vbr->in_hdr_len = in_hdr_len;
-	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
-	vbr->out_hdr.sector = cpu_to_virtio64(vdev, sector);
+	vbr->out_hdr.base.type = cpu_to_virtio32(vdev, type);
+	vbr->out_hdr.base.sector = cpu_to_virtio64(vdev, sector);
 
 	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
 	    type == VIRTIO_BLK_T_SECURE_ERASE) {
@@ -337,6 +392,18 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 			return BLK_STS_RESOURCE;
 	}
 
+	if (type == VIRTIO_BLK_T_CRYPTO_IN || type == VIRTIO_BLK_T_CRYPTO_OUT) {
+		memset(&vbr->out_hdr.crypto_append.msg, 0,
+			sizeof(vbr->out_hdr.crypto_append.msg));
+		vbr->out_hdr.crypto_append.msg.slot =
+			cpu_to_virtio32(vdev,
+				blk_crypto_keyslot_index(req->crypt_keyslot));
+		for (i = 0; i < ARRAY_SIZE(vbr->out_hdr.crypto_append.msg.dun); i++) {
+			vbr->out_hdr.crypto_append.msg.dun[i] =
+				cpu_to_virtio64(vdev, req->crypt_ctx->bc_dun[i]);
+		}
+	}
+
 	return 0;
 }
 
@@ -587,8 +654,8 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 
 	vbr = blk_mq_rq_to_pdu(req);
 	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
-	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
-	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
+	vbr->out_hdr.base.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
+	vbr->out_hdr.base.sector = cpu_to_virtio64(vblk->vdev, sector);
 
 	err = blk_rq_map_kern(req, report_buf, report_len, GFP_KERNEL);
 	if (err)
@@ -836,8 +903,8 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 
 	vbr = blk_mq_rq_to_pdu(req);
 	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
-	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
-	vbr->out_hdr.sector = 0;
+	vbr->out_hdr.base.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
+	vbr->out_hdr.base.sector = 0;
 
 	err = blk_rq_map_kern(req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
@@ -1001,11 +1068,478 @@ static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)
+// Maps VIRTIO_BLK_CRYPTO_MODE_* values to the kernel's internal enum.
+static const enum blk_crypto_mode_num
+	virtio_blk_crypto_mode_map[VIRTIO_BLK_CRYPTO_MODE_MAX + 1] = {
+	[VIRTIO_BLK_CRYPTO_MODE_INVALID]	= BLK_ENCRYPTION_MODE_INVALID,
+	[VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS]	= BLK_ENCRYPTION_MODE_AES_256_XTS,
+};
+
+static int virtblk_get_crypto_modes(struct virtio_blk *vblk,
+				    unsigned int *crypto_modes_supported)
+{
+	unsigned int nr_modes = VIRTIO_BLK_CRYPTO_MODE_MAX + 1;
+	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	unsigned int i;
+	int err;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_CRYPTO_MODES);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&resp_sg, &creq->in_resp.modes, sizeof(creq->in_resp.modes));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &resp_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 1, 2);
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	for (i = 1; i < nr_modes; i++) {
+		u32 mode_mask = virtio32_to_cpu(vblk->vdev,
+						 creq->in_resp.modes.modes[i]);
+		enum blk_crypto_mode_num mode = virtio_blk_crypto_mode_map[i];
+
+		if (!mode_mask)
+			continue;
+		if (!mode) {
+			dev_warn(&vblk->vdev->dev,
+				 "ignoring unknown crypto mode %u\n", i);
+			continue;
+		}
+		crypto_modes_supported[mode] = mode_mask;
+	}
+
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static int set_virtblk_crypto_key_desc(struct virtio_device *vdev,
+				       struct virtblk_ctrl_request *creq,
+				       const struct blk_crypto_key *key,
+				       unsigned int slot)
+{
+	struct virtio_blk_crypto_key_desc *desc = &creq->out_req.key_desc;
+	enum blk_crypto_key_type key_type = key->crypto_cfg.key_type;
+
+	if (sizeof(desc->bytes) < key->size)
+		return -EOVERFLOW;
+
+	memset(desc, 0, sizeof(*desc));
+	desc->slot = cpu_to_virtio32(vdev, slot);
+	memcpy(desc->bytes, key->bytes, key->size);
+	desc->key_size = cpu_to_virtio32(vdev, key->size);
+	desc->crypto_mode = cpu_to_virtio32(vdev, key->crypto_cfg.crypto_mode);
+	switch (key->crypto_cfg.key_type) {
+	case BLK_CRYPTO_KEY_TYPE_RAW:
+		desc->key_type = cpu_to_virtio32(vdev,
+			VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW);
+		break;
+	case BLK_CRYPTO_KEY_TYPE_HW_WRAPPED:
+		desc->key_type = cpu_to_virtio32(vdev,
+			VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	desc->data_unit_size_bits = cpu_to_virtio32(vdev, key->data_unit_size_bits);
+	desc->dun_bytes = cpu_to_virtio32(vdev, key->crypto_cfg.dun_bytes);
+
+	return 0;
+}
+
+static inline struct virtio_blk *virtblk_from_profile(struct blk_crypto_profile *profile)
+{
+	return container_of(profile, struct virtio_blk, profile);
+}
+
+static int virtblk_crypto_keyslot_program(struct blk_crypto_profile *profile,
+					   const struct blk_crypto_key *key,
+					   unsigned int slot)
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	int err;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM);
+
+	err = set_virtblk_crypto_key_desc(vblk->vdev, creq, key, slot);
+	if (err)
+		goto out_free;
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.key_desc, sizeof(creq->out_req.key_desc));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 1);
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static int virtblk_crypto_keyslot_evict(struct blk_crypto_profile *profile,
+					 const struct blk_crypto_key *key,
+					 unsigned int slot)
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	int err;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT);
+
+	err = set_virtblk_crypto_key_desc(vblk->vdev, creq, key, slot);
+	if (err)
+		goto out_free;
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.key_desc, sizeof(creq->out_req.key_desc));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 1);
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static int virtblk_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
+					    const u8 *eph_key, size_t eph_key_size,
+					    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, resp_sg, status_sg, *sgs[4];
+	struct virtblk_ctrl_request *creq;
+	int err;
+
+	if (eph_key_size > VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE
+	    || sizeof(creq->in_resp.secret.secret) < BLK_CRYPTO_SW_SECRET_SIZE)
+		return -EOVERFLOW;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET);
+	memcpy(creq->out_req.blob.key, eph_key, eph_key_size);
+	creq->out_req.blob.key_size = cpu_to_virtio32(vblk->vdev, eph_key_size);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.blob, sizeof(creq->out_req.blob));
+	sg_init_one(&resp_sg, &creq->in_resp.secret, sizeof(creq->in_resp.secret));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &resp_sg;
+	sgs[3] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 2);
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	memcpy(sw_secret, creq->in_resp.secret.secret, BLK_CRYPTO_SW_SECRET_SIZE);
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static int virtblk_crypto_generate_key(struct blk_crypto_profile *profile,
+					u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	unsigned int key_size;
+	int err;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_GENERATE_KEY);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&resp_sg, &creq->in_resp.blob, sizeof(creq->in_resp.blob));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &resp_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 1, 2);
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	key_size = virtio32_to_cpu(vblk->vdev, creq->in_resp.blob.key_size);
+	if (!key_size ||
+		key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE) {
+		dev_err(&vblk->vdev->dev,
+			"backend returned oversized generated key: %u\n", key_size);
+		err = -EOVERFLOW;
+		goto out_free;
+	}
+	memcpy(lt_key, creq->in_resp.blob.key, key_size);
+	err = key_size;
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static int virtblk_crypto_prepare_key(struct blk_crypto_profile *profile,
+				       const u8 *lt_key, size_t lt_key_size,
+				       u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, resp_sg, status_sg, *sgs[4];
+	struct virtblk_ctrl_request *creq;
+	unsigned int key_size;
+	int err;
+
+	if (lt_key_size > VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE)
+		return -EOVERFLOW;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_PREPARE_KEY);
+	memcpy(creq->out_req.blob.key, lt_key, lt_key_size);
+	creq->out_req.blob.key_size = cpu_to_virtio32(vblk->vdev, lt_key_size);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.blob, sizeof(creq->out_req.blob));
+	sg_init_one(&resp_sg, &creq->in_resp.blob, sizeof(creq->in_resp.blob));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &resp_sg;
+	sgs[3] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 2);
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	key_size = virtio32_to_cpu(vblk->vdev, creq->in_resp.blob.key_size);
+	if (!key_size ||
+		key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE) {
+		dev_err(&vblk->vdev->dev,
+			"backend returned oversized prepared key: %u\n", key_size);
+		err = -EOVERFLOW;
+		goto out_free;
+	}
+	memcpy(eph_key, creq->in_resp.blob.key, key_size);
+	err = key_size;
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static int virtblk_crypto_import_key(struct blk_crypto_profile *profile,
+				      const u8 *raw_key, size_t raw_key_size,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, resp_sg, status_sg, *sgs[4];
+	struct virtblk_ctrl_request *creq;
+	unsigned int key_size;
+	int err;
+
+	if (raw_key_size > VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE)
+		return -EOVERFLOW;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY);
+	memcpy(creq->out_req.blob.key, raw_key, raw_key_size);
+	creq->out_req.blob.key_size = cpu_to_virtio32(vblk->vdev, raw_key_size);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.blob, sizeof(creq->out_req.blob));
+	sg_init_one(&resp_sg, &creq->in_resp.blob, sizeof(creq->in_resp.blob));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &resp_sg;
+	sgs[3] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 2);
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	key_size = virtio32_to_cpu(vblk->vdev, creq->in_resp.blob.key_size);
+	if (!key_size ||
+		key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE) {
+		dev_err(&vblk->vdev->dev,
+			"backend returned oversized imported key: %u\n", key_size);
+		err = -EOVERFLOW;
+		goto out_free;
+	}
+	memcpy(lt_key, creq->in_resp.blob.key, key_size);
+	err = key_size;
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static const struct blk_crypto_ll_ops virtblk_crypto_ops = {
+	.keyslot_program	= virtblk_crypto_keyslot_program,
+	.keyslot_evict		= virtblk_crypto_keyslot_evict,
+	.derive_sw_secret	= virtblk_crypto_derive_sw_secret,
+	.generate_key		= virtblk_crypto_generate_key,
+	.prepare_key		= virtblk_crypto_prepare_key,
+	.import_key		= virtblk_crypto_import_key,
+};
+
+static int virtblk_init_crypto(struct virtio_blk *vblk)
+{
+	struct virtio_device *vdev = vblk->vdev;
+	unsigned int crypto_modes_supported[BLK_ENCRYPTION_MODE_MAX] = { 0 };
+	unsigned int key_type_supported = 0;
+	u16 max_slots = 0;
+	/* virtio_cread() requires the variable size to match the config field exactly */
+	u8 max_dun_bytes = 0, key_types = 0;
+	int err;
+
+	virtio_cread(vdev, struct virtio_blk_config,
+		     enc_characteristics.max_slots, &max_slots);
+	virtio_cread(vdev, struct virtio_blk_config,
+		     enc_characteristics.max_dun_bytes, &max_dun_bytes);
+	virtio_cread(vdev, struct virtio_blk_config,
+		     enc_characteristics.key_types, &key_types);
+
+	dev_info_once(&vdev->dev,
+		 "max_slots = %u, max_dun_bytes = %u, key_types = 0x%x\n",
+		 max_slots, max_dun_bytes, key_types);
+
+	if (!max_slots)
+		return -EINVAL;
+
+	/*
+	 * struct virtio_blk_crypto_msg.dun is a fixed array of four __virtio64
+	 * values (32 bytes total), matching the size of
+	 * blk_crypto_ctx::bc_dun[4].  Refuse to advertise more than that as
+	 * supported, or blk-crypto could negotiate a larger dun_bytes with the
+	 * filesystem and have the high-order bytes of req->crypt_ctx->bc_dun
+	 * silently dropped in virtblk_setup_cmd().
+	 */
+	if (max_dun_bytes > sizeof_field(struct virtio_blk_crypto_msg, dun))
+		return -EINVAL;
+
+	if (key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW)
+		key_type_supported |= BLK_CRYPTO_KEY_TYPE_RAW;
+	if (key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
+		key_type_supported |= BLK_CRYPTO_KEY_TYPE_HW_WRAPPED;
+	if (!key_type_supported)
+		return -EINVAL;
+
+	err = virtblk_get_crypto_modes(vblk, crypto_modes_supported);
+	if (err) {
+		dev_err(&vdev->dev, "get crypto modes failed: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * Use the plain (non-devm) initializer: vblk->profile is embedded in
+	 * struct virtio_blk, whose lifetime is tied to the gendisk, not to
+	 * &vdev->dev. Tying destruction to the vdev via devm would run the
+	 * destroy callback after virtblk_remove() has already freed vblk.
+	 * virtblk_free_disk() calls blk_crypto_profile_destroy() explicitly
+	 * instead, guarded by crypto_profile_initialized below.
+	 */
+	err = blk_crypto_profile_init(&vblk->profile, max_slots);
+	if (err) {
+		dev_err(&vdev->dev, "crypto profile initialization failed: %d\n", err);
+		return err;
+	}
+
+	vblk->profile.ll_ops = virtblk_crypto_ops;
+	vblk->profile.max_dun_bytes_supported = max_dun_bytes;
+	vblk->profile.key_types_supported = key_type_supported;
+	vblk->profile.dev = &vdev->dev;
+	memcpy(vblk->profile.modes_supported, crypto_modes_supported,
+	       BLK_ENCRYPTION_MODE_MAX * sizeof(unsigned int));
+
+	vblk->crypto_profile_initialized = true;
+
+	dev_info(&vdev->dev, "inline crypto profile initialized\n");
+
+	return 0;
+}
+
+static void virtblk_destroy_crypto(struct virtio_blk *vblk)
+{
+	if (vblk->crypto_profile_initialized)
+		blk_crypto_profile_destroy(&vblk->profile);
+}
+#else
+
+static inline int virtblk_init_crypto(struct virtio_blk *vblk)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void virtblk_destroy_crypto(struct virtio_blk *vblk)
+{
+}
+#endif /* CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION */
+
 static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
 
 	ida_free(&vd_index_ida, vblk->index);
+	virtblk_destroy_crypto(vblk);
 	mutex_destroy(&vblk->ctrl_vq.mutex);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
@@ -1698,6 +2232,19 @@ static int virtblk_probe(struct virtio_device *vdev)
 		err = blk_revalidate_disk_zones(vblk->disk);
 		if (err)
 			goto out_cleanup_disk;
+	} else if (IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION) &&
+		   virtio_has_feature(vdev, VIRTIO_BLK_F_INLINE_ENCRYPTION) &&
+		   virtio_has_feature(vdev, VIRTIO_BLK_F_CTRL_VQ)) {
+		err = virtblk_init_crypto(vblk);
+		if (!err) {
+			if (!blk_crypto_register(&vblk->profile, vblk->disk->queue))
+				dev_warn(&vdev->dev,
+					 "failed to register inline crypto profile\n");
+		} else {
+			dev_warn(&vdev->dev,
+				 "inline crypto init failed: %d, continuing without inline crypto support\n",
+				 err);
+		}
 	}
 
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
@@ -1798,6 +2345,9 @@ static int virtblk_restore_priv(struct virtio_device *vdev)
 	virtio_device_ready(vdev);
 	blk_mq_unquiesce_queue(vblk->disk->queue);
 
+	if (vblk->profile.slots)
+		blk_crypto_reprogram_all_keys(&vblk->profile);
+
 	return 0;
 }
 
@@ -1842,7 +2392,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
-	VIRTIO_BLK_F_CTRL_VQ,
+	VIRTIO_BLK_F_CTRL_VQ, VIRTIO_BLK_F_INLINE_ENCRYPTION,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 0a16972a1535..952534e2b489 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -43,6 +43,7 @@
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
 #define VIRTIO_BLK_F_CTRL_VQ			22	/* Control queue */
+#define VIRTIO_BLK_F_INLINE_ENCRYPTION		23	/* Inline encryption */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -58,6 +59,10 @@
 
 #define VIRTIO_BLK_ID_BYTES	20	/* ID string length */
 
+/* Key type bitmask for VIRTIO_BLK_F_INLINE_ENCRYPTION */
+#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW	(1 << 0)
+#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED	(1 << 1)
+
 struct virtio_blk_config {
 	/* The capacity (in 512-byte sectors). */
 	__virtio64 capacity;
@@ -149,6 +154,15 @@ struct virtio_blk_config {
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
+
+	/* Inline Encryption device characteristics (if VIRTIO_BLK_F_INLINE_ENCRYPTION) */
+	struct virtio_blk_enc_characteristics {
+		__virtio16 max_slots;
+		__u8 max_dun_bytes;
+		/* Bitmask of supported key types: VIRTIO_BLK_CRYPTO_KEY_TYPE_* */
+		__u8 key_types;
+		__virtio32 unused3;
+	} enc_characteristics;
 } __attribute__((packed));
 
 /*
@@ -207,6 +221,33 @@ struct virtio_blk_config {
 /* Reset All zones command */
 #define VIRTIO_BLK_T_ZONE_RESET_ALL 26
 
+/* Inline-encrypted write: crypto_msg set in outhdr */
+#define VIRTIO_BLK_T_CRYPTO_OUT		27
+
+/* Inline-encrypted read: crypto_msg set in outhdr */
+#define VIRTIO_BLK_T_CRYPTO_IN		28
+
+/* Get inline crypto modes */
+#define VIRTIO_BLK_T_GET_CRYPTO_MODES	29
+
+/* Program a key into the keyslot */
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM	30
+
+/* Evict a key */
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT	31
+
+/* Derive the software secret from a hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET	32
+
+/* Generate a new hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_GENERATE_KEY	33
+
+/* Import a raw key as a hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_IMPORT_KEY		34
+
+/* Convert a long-term wrapped key to its ephemerally-wrapped form */
+#define VIRTIO_BLK_T_CRYPTO_PREPARE_KEY	35
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -226,6 +267,80 @@ struct virtio_blk_outhdr {
 	__virtio64 sector;
 };
 
+/*
+ * Crypto message descriptor, appended to the outhdr of a
+ * VIRTIO_BLK_T_CRYPTO_OUT or VIRTIO_BLK_T_CRYPTO_IN request.
+ */
+struct virtio_blk_crypto_msg {
+	/* virtual key slot index */
+	__virtio32 slot;
+	__u8 unused[4];
+	/* data unit number (DUN / IV) for this request */
+	__virtio64 dun[4];
+};
+
+/*
+ * Inline crypto key descriptor. Request part for
+ * VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM/KEYSLOT_EVICT.
+ */
+/* Must be >= BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in include/linux/blk-crypto.h */
+#define VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE		128
+
+struct virtio_blk_crypto_key_desc {
+	__virtio32  slot;
+	__u8        bytes[VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE];
+	__virtio32  key_size;
+	__virtio32  crypto_mode;
+	__virtio32  key_type;
+	__virtio32  data_unit_size_bits;
+	__virtio32  dun_bytes;
+};
+
+/*
+ * A raw or hardware-wrapped key blob, used as the request and/or reply part
+ * of the VIRTIO_BLK_T_CRYPTO_GENERATE_KEY/IMPORT_KEY/PREPARE_KEY/
+ * DERIVE_SW_SECRET commands.
+ */
+struct virtio_blk_crypto_key_blob {
+	__virtio32 key_size;
+	__u8 key[VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE];
+};
+
+/* Must match BLK_CRYPTO_SW_SECRET_SIZE in include/linux/blk-crypto.h */
+#define VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE	32
+
+/* Reply to a VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET request. */
+struct virtio_blk_crypto_sw_secret {
+	__u8 secret[VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE];
+};
+
+/*
+ * Crypto mode numbers used in VIRTIO_BLK_T_GET_CRYPTO_MODES replies and in
+ * indexing struct virtio_blk_crypto_modes.modes[] below. These numbers are
+ * assigned by the virtio spec and are stable: a number is never reused for
+ * a different crypto mode, and additional crypto modes are assigned new,
+ * higher numbers.
+ */
+enum {
+	VIRTIO_BLK_CRYPTO_MODE_INVALID,
+	VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS,
+	__VIRTIO_BLK_CRYPTO_MODE_MAX,	/* sentinel: always one past the last real mode */
+};
+
+/* Highest crypto mode number defined by this version of the header. */
+#define VIRTIO_BLK_CRYPTO_MODE_MAX (__VIRTIO_BLK_CRYPTO_MODE_MAX - 1)
+
+/* Reply to a VIRTIO_BLK_T_GET_CRYPTO_MODES request. */
+struct virtio_blk_crypto_modes {
+	/*
+	 * modes[N], for crypto mode number N <= VIRTIO_BLK_CRYPTO_MODE_MAX, is
+	 * a bitmask of the data unit sizes with which crypto mode N can be
+	 * used: bit i is set if a data unit size of (1 << i) bytes is
+	 * supported. modes[0] is reserved and always 0.
+	 */
+	__virtio32 modes[__VIRTIO_BLK_CRYPTO_MODE_MAX];
+};
+
 /*
  * Supported zoned device models.
  */
-- 
2.34.1

