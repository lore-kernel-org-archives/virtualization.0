Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F433ECAAD2
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 08:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0113A404C5;
	Mon, 29 Aug 2022 08:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0113A404C5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=8S+WgLcp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lf51JmA94R0N; Mon, 29 Aug 2022 08:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A63AB404AA;
	Mon, 29 Aug 2022 08:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A63AB404AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F955C0033;
	Mon, 29 Aug 2022 08:23:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5844C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 08:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B908960B3A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 08:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B908960B3A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=8S+WgLcp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VRNadkGG3W36
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 08:23:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDB2260AFF
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDB2260AFF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 08:23:27 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 k18-20020a05600c0b5200b003a5dab49d0bso4013681wmr.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=KQoX9g39xf/nWfzltB9kPduB5oZimNGHzPJOz8/DXJg=;
 b=8S+WgLcpPV/6IW9eQx5VGXYikdcR5U1oVA7U5Lcrgx5shE79+uMIkAcMR0TytOvQsT
 Wk38jN0HOxGydtvuniU3+sk2m2/+oQVBE6uibc2BSLgZ2lYk3Wugdi6ggsrZEHzMrbfF
 NIQy7MXcUOixAagx4eivIBCoolhgHsjIAWgsVbkA6Os03WmSI/8VG3dI5T5LJDpD8Sma
 pVocTIxDxiqaJYCi0HrBEsI2TYR9KzgyYnW2L3xWn4M5k/Y84d83IkTJsoyepXrg82mM
 7JtC/o0kLgKIN6j1zPmR5WQbN4/fXp7JYsqR/bdXoeSr1Qi/+ms1oCd5bEZceRUIvgSp
 aCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=KQoX9g39xf/nWfzltB9kPduB5oZimNGHzPJOz8/DXJg=;
 b=QRJEV5yVJdxaTgH60DpjAFYvRxfpN88RDyyOI5SeLkzaHck4QE9XP7Myyoz7H6U18B
 hAbJf3QBphlbk7aShYvZhzZj+3cM9WVZRLXgCsDq/mYjTGlDPvY7CNwQUp7haND2hBpb
 p89PlnZEYNDV5yI9TLo6QSpDT3CbJyxNG4mr3KRC8RdRKY0tSmkiWHH+sMC2fFk26YIR
 OBSUv/S5FMtCI9PvMKtWp6CxeojFrLUR8tIWP6Yl1TU4/IG9wq8RiH6JCBmCIayQd/QT
 qxXCiT+ov2J9HzsmuU3X7B9hwK3AGLaXZPwHTGnEb/AwCTxGivCtBZoxKxFj09/DHZY7
 3/SA==
X-Gm-Message-State: ACgBeo3dRDRpxnpTDAqwhjMvsMYB7ORdI2mHRMLmfJUFwe/6abETGAZE
 jFINIP9QU5wQoz+b+/wO5RVk4/L01XT/4N61
X-Google-Smtp-Source: AA6agR5sUfXvkVPKGATruqvOQdlYA5WSAX53gm+MEzlP9vGtL9rG4p9ZWTv+cLvvvzDOorMcwYSG7w==
X-Received: by 2002:a1c:7707:0:b0:3a5:d953:838f with SMTP id
 t7-20020a1c7707000000b003a5d953838fmr6336873wmi.139.1661761405575; 
 Mon, 29 Aug 2022 01:23:25 -0700 (PDT)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 bx7-20020a5d5b07000000b00226dba960b4sm2146790wrb.3.2022.08.29.01.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 01:23:25 -0700 (PDT)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2] virtio_blk: add SECURE ERASE command support
Date: Mon, 29 Aug 2022 11:23:13 +0300
Message-Id: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
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
---
 drivers/block/virtio_blk.c      | 82 +++++++++++++++++++++++++--------
 include/uapi/linux/virtio_blk.h | 19 ++++++++
 2 files changed, 83 insertions(+), 18 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf18..8a2f00cdf52 100644
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
@@ -1075,6 +1068,57 @@ static int virtblk_probe(struct virtio_device *vdev)
 		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
+		/* The discard alignment value should be the minimum between
+		 * secure_erase_sector_alignment and discard_sector_alignment
+		 * (if VIRTIO_BLK_F_DISCARD is negotiated).
+		 */
+		virtio_cread(vdev, struct virtio_blk_config,
+			     secure_erase_sector_alignment, &v);
+		if (v) {
+			if (discard_granularity)
+				discard_granularity = min(discard_granularity, v);
+			else
+				discard_granularity = v;
+		}
+
+		virtio_cread(vdev, struct virtio_blk_config,
+			     max_secure_erase_sectors, &v);
+		blk_queue_max_secure_erase_sectors(q, v ? v : UINT_MAX);
+
+		/* The max discard segments value should be the minimum between
+		 * max_secure_erase_seg and max_discard_seg (if VIRTIO_BLK_F_DISCARD
+		 * is negotiated).
+		 */
+		virtio_cread(vdev, struct virtio_blk_config,
+			     max_secure_erase_seg, &v);
+		if (v) {
+			if (max_discard_segs)
+				max_discard_segs = min(max_discard_segs, v);
+			else
+				max_discard_segs = v;
+		}
+	}
+
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD) ||
+	    virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
+
+		/* max_discard_seg == 0 or max_secure_erase_seg == 0
+		 * are out of spec but we always handled it.
+		 */
+		if (!max_discard_segs)
+			max_discard_segs = sg_elems;
+
+		blk_queue_max_discard_segments(q,
+					       min(max_discard_segs, MAX_DISCARD_SEGMENTS));
+
+		/* If alignemnt is 0, use block size alignment */
+		if (discard_granularity)
+			q->limits.discard_granularity = discard_granularity << SECTOR_SHIFT;
+		else
+			q->limits.discard_granularity = blk_size;
+	}
+
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
@@ -1170,6 +1214,7 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_SECURE_ERASE,
 }
 ;
 static unsigned int features[] = {
@@ -1177,6 +1222,7 @@ static unsigned int features[] = {
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
