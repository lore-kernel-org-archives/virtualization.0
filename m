Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8686AECAAD8
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 08:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15B6781A5C;
	Wed, 21 Sep 2022 08:27:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15B6781A5C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7C2bAmZ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q86RRWrU2igG; Wed, 21 Sep 2022 08:27:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 409AD818A1;
	Wed, 21 Sep 2022 08:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 409AD818A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01F37C0033;
	Wed, 21 Sep 2022 08:27:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86743C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D43540B80
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D43540B80
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=7C2bAmZ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qhi0QYGxHKEm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:27:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D837F402E7
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D837F402E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:27:42 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id y5so8629785wrh.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=mNR7Z4W67QTa1jAIIRLa1FR+eSTKMK+ZtxAwJBImeBU=;
 b=7C2bAmZ1Dhje8LEoXYPWw1eyEhXwBtLRmrGgno7w1YLb7tLZXFwl8PyuKd0qk71zfi
 kB+EzFR77rg/niulzUoSqoxI56B7aj6phTL1jY6Gwuaec72ag9LtvZejoebom1mrSLSv
 zyzCZ9wnq4lYmouxiQ0zjUe7kyFogbJZ5gDIvafp7iVf5VZNldeQu8YoTwlAkTJafG+L
 kgpcTwfSNxueOdM1PX4lSEHY2xOYKsv5rF3w5c3zpNsEizE7O4SDEZb+iNeOGMbyYcnj
 gyLRxc9NQcfbmCMtD2qZVh2RWJPcky3FzXfSZ5yF7Cf+rAU5d7AtzbS58ssYzkCc5CIE
 X80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=mNR7Z4W67QTa1jAIIRLa1FR+eSTKMK+ZtxAwJBImeBU=;
 b=N46pdy0OInupIZ1DAwbgPtYj+p4lIQWtIAPXGnrbAFRRTW+DRcWCApduC0Z/QiJHwg
 KvUFqqgigpPUhr/maYKYsobXKBNbe0W/qJd44srPYPqj+J7aj0vx9DvuObfrKdfsxeCi
 7NT5SYfH32VMsBNd0waQmHFUBGqQD/UwkHG26FLdtVlrC0LTc26tmdJSNSepK5SSW393
 R0Py5Aa93F00jBhaK/b+KpTMhfWlNxkfSFoGLcRCDe1rp2YKrEPjf/KVX8jk9kr7xF3i
 +zdOsyKZl/RG6EcfTIlNF1JIUnyf/Z0Oo+t4SFG8CVKlcO7pZEC7tHf5JQzGyH5c4vn3
 qykA==
X-Gm-Message-State: ACrzQf1GU1CNJeaHmgTTNd0Vb443a8S+cOS2qjSr1TzTe6c6WNP4qc5v
 MEk0oe+7iPak6So+h6HU4glJUhuqJGQOVfezmPA=
X-Google-Smtp-Source: AMsMyM6q/Bz2JaiM1gzjyls0A9UbUPGcUrWZg+2WYEzCNVNIpdhcztyEuscr2TuG2blyY7pTdJOB1A==
X-Received: by 2002:a5d:6da9:0:b0:22a:f828:73b5 with SMTP id
 u9-20020a5d6da9000000b0022af82873b5mr9932126wrs.229.1663748860584; 
 Wed, 21 Sep 2022 01:27:40 -0700 (PDT)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adfdfd2000000b0022ad393ba3csm1786654wrn.107.2022.09.21.01.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Sep 2022 01:27:40 -0700 (PDT)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 stefanha@redhat.com
Subject: [PATCH v3] virtio_blk: add SECURE ERASE command support
Date: Wed, 21 Sep 2022 11:27:29 +0300
Message-Id: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Support for the VIRTIO_BLK_F_SECURE_ERASE VirtIO feature.

A device that offers this feature can receive VIRTIO_BLK_T_SECURE_ERASE
commands.

A device which supports this feature has the following fields in the
virtio config:

- max_secure_erase_sectors
- max_secure_erase_seg
- secure_erase_sector_alignment

max_secure_erase_sectors and secure_erase_sector_alignment are expressed
in 512-byte units.

Every secure erase command has the following fields:

- sectors: The starting offset in 512-byte units.
- num_sectors: The number of sectors.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
v2:
	- Set queue max discard segments as the minimum between
	  max_secure_erase_seg and max_discard_seg.
	- Set queue discard granularity as the minimum between
	  secure_erase_sector_alignment and discard_sector_alignment.

v3:
	- Usage of min_not_zero.
	- Fail probe if any of the secure erase parameters in the virtio
	  config is 0.
	- Add a comment explaining why we use the minimum between the discard
	  and secure erase limits.
---
 drivers/block/virtio_blk.c      | 110 ++++++++++++++++++++++++++------
 include/uapi/linux/virtio_blk.h |  19 ++++++
 2 files changed, 111 insertions(+), 18 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf18..dd57612f4a6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -130,7 +130,7 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
 }
 
-static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
+static int virtblk_setup_discard_write_zeroes_erase(struct request *req, bool unmap)
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req);
 	unsigned short n = 0;
@@ -240,6 +240,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		type = VIRTIO_BLK_T_WRITE_ZEROES;
 		unmap = !(req->cmd_flags & REQ_NOUNMAP);
 		break;
+	case REQ_OP_SECURE_ERASE:
+		type = VIRTIO_BLK_T_SECURE_ERASE;
+		break;
 	case REQ_OP_DRV_IN:
 		type = VIRTIO_BLK_T_GET_ID;
 		break;
@@ -251,8 +254,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
 	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
-	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
-		if (virtblk_setup_discard_write_zeroes(req, unmap))
+	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
+	    type == VIRTIO_BLK_T_SECURE_ERASE) {
+		if (virtblk_setup_discard_write_zeroes_erase(req, unmap))
 			return BLK_STS_RESOURCE;
 	}
 
@@ -889,6 +893,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	int err, index;
 
 	u32 v, blk_size, max_size, sg_elems, opt_io_size;
+	u32 max_discard_segs = 0;
+	u32 discard_granularity = 0;
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
@@ -1046,27 +1052,14 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
 		virtio_cread(vdev, struct virtio_blk_config,
-			     discard_sector_alignment, &v);
-		if (v)
-			q->limits.discard_granularity = v << SECTOR_SHIFT;
-		else
-			q->limits.discard_granularity = blk_size;
+			     discard_sector_alignment, &discard_granularity);
 
 		virtio_cread(vdev, struct virtio_blk_config,
 			     max_discard_sectors, &v);
 		blk_queue_max_discard_sectors(q, v ? v : UINT_MAX);
 
 		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
-			     &v);
-
-		/*
-		 * max_discard_seg == 0 is out of spec but we always
-		 * handled it.
-		 */
-		if (!v)
-			v = sg_elems;
-		blk_queue_max_discard_segments(q,
-					       min(v, MAX_DISCARD_SEGMENTS));
+			     &max_discard_segs);
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_WRITE_ZEROES)) {
@@ -1075,6 +1068,85 @@ static int virtblk_probe(struct virtio_device *vdev)
 		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
 	}
 
+	/* The discard and secure erase limits are combined since the Linux
+	 * block layer uses the same limit for both commands.
+	 *
+	 * If both VIRTIO_BLK_F_SECURE_ERASE and VIRTIO_BLK_F_DISCARD features
+	 * are negotiated, we will use the minimum between the limits.
+	 *
+	 * discard sector alignment is set to the minimum between discard_sector_alignment
+	 * and secure_erase_sector_alignment.
+	 *
+	 * max discard sectors is set to the minimum between max_discard_seg and
+	 * max_secure_erase_seg.
+	 */
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
+
+		virtio_cread(vdev, struct virtio_blk_config,
+			     secure_erase_sector_alignment, &v);
+
+		/* secure_erase_sector_alignment should not be zero, the device should set a
+		 * valid number of sectors.
+		 */
+		if (!v) {
+			dev_err(&vdev->dev,
+				"virtio_blk: secure_erase_sector_alignment can't be 0\n");
+			err = -EINVAL;
+			goto out_cleanup_disk;
+		}
+
+		discard_granularity = min_not_zero(discard_granularity, v);
+
+		virtio_cread(vdev, struct virtio_blk_config,
+			     max_secure_erase_sectors, &v);
+
+		/* max_secure_erase_sectors should not be zero, the device should set a
+		 * valid number of sectors.
+		 */
+		if (!v) {
+			dev_err(&vdev->dev,
+				"virtio_blk: max_secure_erase_sectors can't be 0\n");
+			err = -EINVAL;
+			goto out_cleanup_disk;
+		}
+
+		blk_queue_max_secure_erase_sectors(q, v);
+
+		virtio_cread(vdev, struct virtio_blk_config,
+			     max_secure_erase_seg, &v);
+
+		/* max_secure_erase_seg should not be zero, the device should set a
+		 * valid number of segments
+		 */
+		if (!v) {
+			dev_err(&vdev->dev,
+				"virtio_blk: max_secure_erase_seg can't be 0\n");
+			err = -EINVAL;
+			goto out_cleanup_disk;
+		}
+
+		max_discard_segs = min_not_zero(max_discard_segs, v);
+	}
+
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD) ||
+	    virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
+		/* max_discard_seg and discard_granularity will be 0 only
+		 * if max_discard_seg and discard_sector_alignment fields in the virtio
+		 * config are 0 and VIRTIO_BLK_F_SECURE_ERASE feature is not negotiated.
+		 * In this case, we use default values.
+		 */
+		if (!max_discard_segs)
+			max_discard_segs = sg_elems;
+
+		blk_queue_max_discard_segments(q,
+					       min(max_discard_segs, MAX_DISCARD_SEGMENTS));
+
+		if (discard_granularity)
+			q->limits.discard_granularity = discard_granularity << SECTOR_SHIFT;
+		else
+			q->limits.discard_granularity = blk_size;
+	}
+
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
@@ -1170,6 +1242,7 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_SECURE_ERASE,
 }
 ;
 static unsigned int features[] = {
@@ -1177,6 +1250,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_SECURE_ERASE,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9f..58e70b24b50 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -121,6 +122,21 @@ struct virtio_blk_config {
 	__u8 write_zeroes_may_unmap;
 
 	__u8 unused1[3];
+
+	/* the next 3 entries are guarded by VIRTIO_BLK_F_SECURE_ERASE */
+	/*
+	 * The maximum secure erase sectors (in 512-byte sectors) for
+	 * one segment.
+	 */
+	__virtio32 max_secure_erase_sectors;
+	/*
+	 * The maximum number of secure erase segments in a
+	 * secure erase command.
+	 */
+	__virtio32 max_secure_erase_seg;
+	/* Secure erase commands must be aligned to this number of sectors. */
+	__virtio32 secure_erase_sector_alignment;
+
 } __attribute__((packed));
 
 /*
@@ -155,6 +171,9 @@ struct virtio_blk_config {
 /* Write zeroes command */
 #define VIRTIO_BLK_T_WRITE_ZEROES	13
 
+/* Secure erase command */
+#define VIRTIO_BLK_T_SECURE_ERASE	14
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
