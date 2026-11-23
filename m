Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423630;
	b=igOkUzVmJIjadrzXNVz3vCYDTIOHxHWH+sQlVTZTHnknUeZiF9LrrkcDF7DV3XlR+/Ij
	 mQM3+t2LqnJazngzzAnxNjbfae4NXRkW4SjceSIiFUB3DqkUZoDDWJ8M0DEksEPHbUWT7
	 Lftd0INjxoQtCKhieuVsIrWS8V0HvkHDOHwSiuenSzoWAwyvHGMLM0tYkbGPwaPSEAnqm
	 ubXrZeKOnv7cAcAV0Uq0JnmpXL3JgYPsdj1m9NgFGYsxOksPh0e4Bv6Fig1SbKX23oneZ
	 hqkhGk7TDZPskRW6Q4GGD/1vzG8gBntk3pKgb75peEN8RjeqDHB1Y8Fj9knzGTfH62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6TuXSWDdixhSOXgwiZNhSVNfQgsPxpgQ0Wl0SXXvDBk=;
	b=EOfGOhd2QWohUURDA6/RK8dd6GyYOeXDTcYLJlG2bWoVOUDqa7CYsqTj2+HJ/7znRBZ4
	 S2ZJSCsJZbvsMAgGkWHOp4G7BmrAJvBAIRetEjnNSbMxCyX43KcENUUC14JMNElyszAOb
	 Ysmgp5tnKNEnwM/CFiLI52s5XFJ04lGoOGojIjqHGbxTjkCTqYpclS2nv2l9qTdwxKGFt
	 0yitk0ERuvDzJyzwDMYwOH3SGWNPtIi3dsue9NXT/JVxHknjOuXrH9p+uTNHIXBCKB9a9
	 D9Jmgod9l4w2Uz61cvanHcVRzd7NpXLWDTZ8XunFa4nqaHv3o5k9lSC3r9LhGrfDtuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0M13Uf3G;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD0606A32E
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 08:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55FD0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0M13Uf3G
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38699cf08dfso2686435eec.1
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 00:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795423629; x=1796028429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6TuXSWDdixhSOXgwiZNhSVNfQgsPxpgQ0Wl0SXXvDBk=;
        b=0M13Uf3GHEynZ6F1ICFL+pYdmLa87yHa+qH1quk2DCV0TmtAoCHQ/ZH9clywsoGp9q
         FaLJxeRfdrfmj0v+ER2fc5IxDEFTUIFIpOxXhcjIld1jTJ/7znt+jUy/WOcv/oRkvCxV
         PKZOk5BimYeS2cPVtV7CoOj8j5gNTEec6lafOlUbJDTFUZQschmp279UEjnbNgT8Pr90
         DzduMJ8vs3QiMmC+WDAQnEKew2dIEYT7ne3Xgc9WSoIu1cuDuaXerfruXVG4b7GYLn/H
         s4nh/PpYIf/5Ldel1wXkXuLyoabotEAw5SUvn5G/Nw9QOOYinL+4OWH+xuhK5Zd93ftC
         Ak6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795423629; x=1796028429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TuXSWDdixhSOXgwiZNhSVNfQgsPxpgQ0Wl0SXXvDBk=;
        b=noqoHrWCJv1tmUmXQeo+SqqiE0sNHdLiOkNHvrW/lj169exjuV0o3LS80PMrQxZo5A
         e7swUqjHqlO/mOV9j20Sj4BnEUoSCab2iVu4PEwUkPXUSJeg0oT+FzFWCa8f4ie5rB8L
         Z/XTL2mAK0Yny42n/AzClqQl4dCh1pjyJwqMEaXVfJlsvRkwGAksVPq9iHY6zzFlFVrK
         Z0xBb14q+Vi1+AvoxgzYCz4OXHkKoxWJzfDrFTAic+IvbMto0SSqeM/qiWAvMeFyZjRi
         6plypYBBSRnKU38N8/ZxfPNbPtCmGpXZuZqCdImhbAx89HNnHv6Pjb9kcTvz2cNP5QYQ
         z0BA==
X-Forwarded-Encrypted: i=1; AL+hErHtwY45eW/7U1z4pdYIOaz1AABU4bIm8NSsR58ymjAnYdYfR6IeGkYMAyKtpgvlxHPR3hnFSSPa2OLp+gtSaA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Mt7M8CnEQbpfJGo0QiTg2jhjV3YvsQwHeaFun1SGPOgdrLyn1
	HCImTXtSdF7SpHSGC7wckTaol9NSxRnH96UBqXA+s38BNaPpemBDhkd6
X-Gm-Gg: AZFdTZfm54k/E+4ESbpKqPLfVLRbQzqIb/a7GkowNSmhRQE2atObG98v3WOcl5WqgqW
	8NnifpiFc/KBwE1ATVLRfP04knzEj/SWqLg6k21ZjhS/vXssJ6dA0nyJSkVnvDcsI7lcSqJw7Zs
	GCv1IVAdjj5JIhyMiLzcw5guMucEaOhz0U9BHSfTo8sqLvOiHgCfslvgEXN8NAyWze+DMkyu+eq
	S0xqNkdudN+cs0zLt0reCDZZlezngeXYqii+RAvBZ9BW6n0nHuqu1e/nOJ46vCKI60ywHFM0C3j
	PBJ2J3z6IXN+pspISDNXBm1NZe7vbWQAXPZkCX3rPIEwKZAQC23UcVcLr7A2mx2KJMORodhwJJG
	vDluirmCUlbMz8jZ18yq8AOFELUZuzHpBF740dXTATdDk3KowoFv83GmcUEMr9HkoIMM87URPLD
	LZiNStyDUriKZtXXt8yI1Zql9ftntzk58/BDUewvpB9aBoaDYFDBbDv+BV7D6lXvw1op/NFOT9d
	tfJRgOFNkbXO/PJPLy41Tf1yMUt2+lxXYF9qH3mGUKCLoPXgYqV0RK92I2HPe5Q7UsgRCHjRjal
	c+L3HFL3YEWB2MNos9QRknmlGTRFyTmrhTEG3VKSWcCtTrm+BM3zElTQpfyOAw3wKpE+3is=
X-Received: by 2002:a05:7301:6187:10b0:386:a193:7eeb with SMTP id 5a478bee46e88-386a1938b8dmr5853810eec.30.1795423629042;
        Mon, 23 Nov 2026 00:47:09 -0800 (PST)
Received: from annie-ProLiant-DL380-Gen11.. ([119.204.109.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm36040839eec.6.2026.11.23.00.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:47:08 -0800 (PST)
From: Annie Kim <pulpannie@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Hyokyung Kim <pulpannie@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_blk: validate zone append sector from device
Date: Mon, 23 Nov 2026 17:46:59 +0900
Message-ID: <20261123084701.2616027-1-pulpannie@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyokyung Kim <pulpannie@gmail.com>

The device reports the starting sector for REQ_OP_ZONE_APPEND completions,
and virtio_blk copies it into req->__sector without checking that it
still refers to the requested zone. A buggy or malicious device can
therefore make upper layers believe the append landed at an arbitrary
location.

Validate successful zone append completions before updating
req->__sector. The returned sector must not precede the request start
and the entire request must fit within the zone writable capacity.
Reject invalid completions with BLK_STS_IOERR.

The polling path may batch successful completions, and a batch can only
be completed as successful. Perform the same validation in
virtblk_poll() before admitting a request to the batch, so that invalid
zone append completions are not batched and are completed with an error
instead. Move the request completion into __virtblk_request_done(),
which takes the status from its caller, so that a polled completion that
is not batched is not validated a second time.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>
---
Damien, thank you so much for the thoughtful review of v1. As a beginner
contributor I learned a lot from your comments :).

Changes in v2:
- Check the request op and status in the callers and drop the status
  argument of virtblk_update_zone_append_sector() (Damien). The function
  still returns blk_status_t, since the callers need to fail the request
  when the reported sector is invalid.
- Initialize req_start and nr_sectors at declaration (Damien)
- Drop the Assisted-by tag (Damien)
- Fix the sector being validated twice for polled requests that were not
  batched (Sashiko). virtblk_poll() now completes those requests through
  __virtblk_request_done(), which does not validate again.
- Link to v1: https://lore.kernel.org/lkml/20261120063039.4155597-1-pulpannie@gmail.com/

Tested on v7.4-rc3+ using modified QEMU backend that returned incorrect
zone-append sectors on a memory-backed null_blk zoned device.

 drivers/block/virtio_blk.c | 63 +++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b462005cdb6..547291c3ab99 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -331,29 +331,60 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
 	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
 }
 
-static inline void virtblk_update_zone_append_sector(struct request *req,
-						     struct virtblk_req *vbr)
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req, struct virtblk_req *vbr)
 {
 	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	sector_t req_start = blk_rq_pos(req);
+	unsigned int nr_sectors = blk_rq_sectors(req);
+	sector_t sector, zone_end;
+
+	sector = virtio64_to_cpu(vblk->vdev, vbr->in_hdr.zone_append.sector);
+	zone_end = req_start + disk_zone_capacity(vblk->disk, req_start);
+
+	if (zone_end < req_start || sector < req_start || sector >= zone_end ||
+	    nr_sectors > zone_end - sector) {
+		dev_err_ratelimited(&vblk->vdev->dev,
+				    "zone append sector %llu + %u outside valid range [%llu, %llu)\n",
+				    (u64)sector, nr_sectors,
+				    (u64)req_start, (u64)zone_end);
+		return BLK_STS_IOERR;
+	}
 
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = virtio64_to_cpu(vblk->vdev,
-						vbr->in_hdr.zone_append.sector);
+	req->__sector = sector;
+	return BLK_STS_OK;
+}
+#else
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req, struct virtblk_req *vbr)
+{
+	return BLK_STS_OK;
 }
+#endif
 
-static inline void virtblk_request_done(struct request *req)
+static inline void __virtblk_request_done(struct request *req,
+					  blk_status_t status)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
-	virtblk_update_zone_append_sector(req, vbr);
-
 	blk_mq_end_request(req, status);
 }
 
+static inline void virtblk_request_done(struct request *req)
+{
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
+
+	if (req_op(req) == REQ_OP_ZONE_APPEND && status == BLK_STS_OK)
+		status = virtblk_update_zone_append_sector(req, vbr);
+
+	__virtblk_request_done(req, status);
+}
+
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
@@ -1242,7 +1273,6 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 
 		virtblk_unmap_data(req, vbr);
 		virtblk_cleanup_cmd(req);
-		virtblk_update_zone_append_sector(req, vbr);
 	}
 	blk_mq_end_request_batch(iob);
 }
@@ -1260,13 +1290,18 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 
 	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
 		struct request *req = blk_mq_rq_from_pdu(vbr);
-		u8 status = virtblk_vbr_status(vbr);
+		blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
 
 		found++;
-		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, status != VIRTIO_BLK_S_OK,
+		if (blk_mq_complete_request_remote(req))
+			continue;
+
+		if (req_op(req) == REQ_OP_ZONE_APPEND && status == BLK_STS_OK)
+			status = virtblk_update_zone_append_sector(req, vbr);
+
+		if (!blk_mq_add_to_batch(req, iob, status != BLK_STS_OK,
 					 virtblk_complete_batch))
-			virtblk_request_done(req);
+			__virtblk_request_done(req, status);
 	}
 
 	if (found)
-- 
2.43.0

