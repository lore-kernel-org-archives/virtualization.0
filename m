Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156472;
	b=dNL5fBwQxtUTKyDDjfXTuaQEBmSLDRjn9zV/40MS6+JGgg4UsR3lNXUb66gaP8EmB8Fc
	 Kp+Atup3zbq9QJoTvcqKUkw8K6Iqou9JqE6kqNNo7ijrc5ipyqUg6brOsFup0Ga8EVPRY
	 CUoD0pJqVyXfIMgcneIcAI+SDhH+M6qbsS1WcXUnA7uR2dCujiYjd3OIv/3+ODXpFoaft
	 DDlP/cMaz+LG2Vlbf43XzUrjUpVzKRFGFbP9Iwn6Gn2BJRRtS8ApvQqji9LPwn8JLckZ6
	 iudY2RAN3aoYG4LzDvOU8rqDO+XJzWHWIUnGNlT1COdcjuS8ZLjIrX7RuzfBxXr+vPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
	b=c9EEVhNmvzEUqEwlSoNunk415264RuX2wUK/qRmh9YlxFd+TiUabbaoaEg+SUeMiS9KY
	 K7BLKzyl0psJFOagpac+3T6irtzavF6kK5GGCzS18XMKNcD9+SfAUk1yM8BcuM0ZpF+6V
	 v4CXnmvZaRR61lAlgCD45UljfN2F3mu7uPgZ4w1sG+EXsNQ81f+dzUdeNi6BcxnDh8E2x
	 zECmmWbpWFgxPnBd5yogCa7wePaHYo3xIhhX2Pfj2jaO8jYbdbFjSiMy/+d5VzuO4KJ/H
	 9ZFLt7G+2bzhjf4IpPssc5s11tCgULTYxmoKeAB+rrhtp6fiujZ11kmtlXm8xkbuK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0yIjIUg;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13E606A326
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 06:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC13E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0yIjIUg
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so1012824c88.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 22:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156471; x=1795761271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
        b=n0yIjIUgyb9Fd3yphphFAb1aljffEmaYVD+FsomTLvS3zeMN3NasuHbQqi96c8bFFh
         fZ3KHRd7w1Vqi/cNCaHMJoiFWHj1BdCsz5SFI1hqqcBz13gUsHxN+/cMv60/G4egtWtd
         OM0V59N7PM/QT1hgWqrafJ0ysmoSExWkTqDpH27rwuD3xPCO1WY+E+vnaPmuGGyMR2Ja
         MDKbXekA3dRCNpOTMT44KIwgBXqvLIPsCaySrCYju39zizyjK+8plBm9XlEZVoVWg9T+
         HPqo/uAvibWWSZuUS2vgTz4/+Sl+3uTD5B9/lk2wgI/fBghgQgypqB4dj8nZHaxnXn3L
         CfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156471; x=1795761271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
        b=wGWf0764PUzafXiEao+9lKLg8+nvCcZ84b2KUOU5eBo9maOdu7btLYi+L+s03SR2D9
         04f2UPKKeNQqQDuGUD62sNgo/b8FV15VYTKjhDsroqmH/Aj1xkOTKI/2aAxofNmlybU/
         ddwcf4W39n8vY9qNSRwJDE44M4Zb5IZVFkmmnA5O4Gks6utYw8RHBheLGHsjC9uJUfja
         3T+AsOn9ZaKbLOiujxDQpzwYtl6l2wQnZFk2rH9FQqGC0JgUbGkLUxaFtGRdSn4lzUds
         9AioQRDLLXv4vB8DEe1JObaiWZK/9L+i1r6l69mA5XOFwAddGvl68TJLFnHEnXsCtLMG
         kRTw==
X-Forwarded-Encrypted: i=1; AL+hErGzdVJzB4IaaQisMn3aPJ/74fQHQD3Y9kf65IiUxCqymhlErnjnrFrDHR2EdrXAYCysxQR8LU2Xv1PaHQX5FA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ubdrBv/h1xZ70vRWD9bu7Ubrbbi63X5OeoSiaelbZ9bOF+Erq
	iqunjrEPHr2C9CdWynnjubDXGGb23bRPWtETud9lfM1keWPpj5RvXKp8
X-Gm-Gg: AZFdTZf4xHxEJrxmaasRBENZRwmwN5pLbcS+9PYsM+m/zjtLT0MZ5Xei8FuLPYt3XK3
	Je4U3GfjLjIJmstAHwLPDAvV8KDEixA57jNtlVaYhqzyJm4LJJw2zORIXgjLT2y3Yh2++I6t92X
	+48PF8XXHYL8EoxHOUjej7UYt9sFeQ9nex3RsgDrv3exvOU6W/KNbGAZXX7wJwzJajC8faCcwLq
	ir06MRQxVIQoZT0r1JewDPvFusyKbn64penmRsgLwvbjAsbgscpmFGCsWNmraYeM8X2PRFsBIeE
	elXFBVpiG8qcxjEK7UV4WGrpWbj7W+aSc42ZdSxDi5MRu0Q6gXV9HMJVWkY5CMweQtfp90RFF0D
	D9R+BAiUPlnudHwwiAcJUJvY/zfQElgq5GkdgZLkhnNaNObfw0kuTZllBJO/IljICd+E+wOAy/8
	2ik4CZmCwJLQc3N1BQdW0w9510eE/w3jktL+mWlfroX0M4+5dSUxk22TQtSZEsnSRzXAc50cAIK
	LLtczylM91zpYR4OzqSQVCpr90ZMxMasVkovPf8ReXC8kqduEFYJCpaIg+vzTuQ2WfiIqjQQ4o0
	KqybvE+eTz6te6/ArVGUd94kTHjCIWWYIfBHyjSD3QDacf6CKDo=
X-Received: by 2002:a05:7300:c01b:20b0:385:4b9:18ea with SMTP id 5a478bee46e88-38571027a68mr2036926eec.35.1795156470715;
        Thu, 19 Nov 2026 22:34:30 -0800 (PST)
Received: from annie-ProLiant-DL380-Gen11.. ([119.204.109.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm4821319eec.14.2026.11.19.22.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:34:30 -0800 (PST)
From: Annie Kim <pulpannie@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: [PATCH] virtio_blk: validate zone append sector from device
Date: Fri, 20 Nov 2026 15:30:39 +0900
Message-ID: <20261120063039.4155597-1-pulpannie@gmail.com>
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

The polling path may batch successful completions, so perform the same
validation before admitting a request to the batch. Invalid append
completions then fall back to the normal completion path and are
completed with an error instead of being reported as successful.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Assisted-by: Codex:GPT-5
Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>
---
Tested on v7.4-rc3+ using modified QEMU backend that returned incorrect
zone-append sectors on a memory-backed null_blk zoned device.

 drivers/block/virtio_blk.c | 50 +++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b462005c..8f88570b4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -331,15 +331,45 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
 	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
 }
 
-static inline void virtblk_update_zone_append_sector(struct request *req,
-						     struct virtblk_req *vbr)
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req,
+				  struct virtblk_req *vbr,
+				  blk_status_t status)
 {
 	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	sector_t req_start, sector, zone_end;
+	unsigned int nr_sectors;
+
+	if (req_op(req) != REQ_OP_ZONE_APPEND || status != BLK_STS_OK)
+		return status;
+
+	req_start = blk_rq_pos(req);
+	sector = virtio64_to_cpu(vblk->vdev, vbr->in_hdr.zone_append.sector);
+	nr_sectors = blk_rq_sectors(req);
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
+	return status;
 }
+#else
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req,
+				  struct virtblk_req *vbr,
+				  blk_status_t status)
+{
+	return status;
+}
+#endif
 
 static inline void virtblk_request_done(struct request *req)
 {
@@ -349,7 +379,7 @@ static inline void virtblk_request_done(struct request *req)
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
-	virtblk_update_zone_append_sector(req, vbr);
+	status = virtblk_update_zone_append_sector(req, vbr, status);
 
 	blk_mq_end_request(req, status);
 }
@@ -1242,7 +1272,6 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 
 		virtblk_unmap_data(req, vbr);
 		virtblk_cleanup_cmd(req);
-		virtblk_update_zone_append_sector(req, vbr);
 	}
 	blk_mq_end_request_batch(iob);
 }
@@ -1260,11 +1289,14 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 
 	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
 		struct request *req = blk_mq_rq_from_pdu(vbr);
-		u8 status = virtblk_vbr_status(vbr);
+		blk_status_t status;
+
+		status = virtblk_result(virtblk_vbr_status(vbr));
+		status = virtblk_update_zone_append_sector(req, vbr, status);
 
 		found++;
 		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, status != VIRTIO_BLK_S_OK,
+		    !blk_mq_add_to_batch(req, iob, status != BLK_STS_OK,
 					 virtblk_complete_batch))
 			virtblk_request_done(req);
 	}
-- 
2.53.0

