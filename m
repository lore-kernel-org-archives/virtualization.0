Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0333C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 16:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2957F60DFF;
	Mon,  5 Dec 2022 16:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2957F60DFF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=L6XDMvs5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGQTNsKCvYyd; Mon,  5 Dec 2022 16:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8BA1760706;
	Mon,  5 Dec 2022 16:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BA1760706
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44976C0033;
	Mon,  5 Dec 2022 16:20:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83D5FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D7AA60A80
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D7AA60A80
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tzw9wkDECxiK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:20:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0623D60706
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0623D60706
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 16:20:40 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id f18so19387897wrj.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ficp9YnxtYUVosXmAWDNlYqnWO69Vk0MG7GW8V0nNo4=;
 b=L6XDMvs5y72VwZ+hJbbJCeY6uEkjV7yGvT3o2KU3CngYCoXS/tsUIZTc7piZ9W2Xug
 Hoh8eu7wOVlALCSnDq/1cJeTvPsAetfHT4Y0XI+qM+3OFCgHavmUvrOZR4SZ/q00Omps
 ataPrsuv0Lp1GGafViym93soHyHipmEEF4I6n9joXP1HGuGMf42ybu3zVXq+p+e2b83n
 BuiC659II3YNws0++EK3BafQ6y1KAQY7gz3nWHDSyw6gHXYcC4VxHVTOAVY9cOP0n58Q
 Yh0TjikQ7mcNn5KbuDv5R2a+1bRkdN3iR7EDdLvvTd7T1PW1wbG3zvX9e/2tQbLgiL9A
 cjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ficp9YnxtYUVosXmAWDNlYqnWO69Vk0MG7GW8V0nNo4=;
 b=vEEAWAZ5u8hQM44QfSzPpPWnKXuNZYwHKvdXvYOv3uNGxOd091u1NyHy9gy1kFCR4X
 X+38zPG+8BlxHO6v997NzKl0h8XnPTF2GQrOYIoyN/nY088SztctrbYOiTnSW56J+2em
 wE4VL74acPDV+3oyjlUJGYSd6CumfCEqgo5dDefCFPgCxDxXlQbyqweGk24ebIGjN8OB
 WU1Pml5gqAvCVIw6YIYStf5vX51k6noGX2tnXCAr2ILHb77DZqPKULN18oHaNYcc17h1
 D026ECbEwmX/cmwAGGmL1jtQsKLm5f+1WuuU2OJqFSWkmrllA1KQge/vi0GJfxRQ0zNY
 aruQ==
X-Gm-Message-State: ANoB5pk/x32e3DC9yyznZ9tEqm+7DQo87fAumCQJIFLCPomCo/oBjhib
 hEIOOzb/YtRRzYb/4RF5Bp5zqlB7kxIaP0orQ98=
X-Google-Smtp-Source: AA0mqf49u7SktyNNs0t8+g6HVZk+8T/Ivq5svMIZrXvPl798MUnRShoJMB1JcN8K1mqX6Fote2xpBQ==
X-Received: by 2002:a5d:5957:0:b0:22e:3e9:ba15 with SMTP id
 e23-20020a5d5957000000b0022e03e9ba15mr48747236wri.180.1670257238839; 
 Mon, 05 Dec 2022 08:20:38 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 bg9-20020a05600c3c8900b003cf483ee8e0sm23775783wmb.24.2022.12.05.08.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 08:20:38 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Date: Mon,  5 Dec 2022 18:20:34 +0200
Message-Id: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

Implement the VIRTIO_BLK_F_LIFETIME feature for VirtIO block devices.

This commit introduces a new ioctl command, VBLK_LIFETIME.

VBLK_LIFETIME ioctl asks for the block device to provide lifetime
information by sending a VIRTIO_BLK_T_GET_LIFETIME command to the device.

lifetime information fields:

- pre_eol_info: specifies the percentage of reserved blocks that are
		consumed.
		optional values following virtio spec:
		*) 0 - undefined.
		*) 1 - normal, < 80% of reserved blocks are consumed.
		*) 2 - warning, 80% of reserved blocks are consumed.
		*) 3 - urgent, 90% of reserved blocks are consumed.

- device_lifetime_est_typ_a: this field refers to wear of SLC cells and
			     is provided in increments of 10used, and so
			     on, thru to 11 meaning estimated lifetime
			     exceeded. All values above 11 are reserved.

- device_lifetime_est_typ_b: this field refers to wear of MLC cells and is
			     provided with the same semantics as
			     device_lifetime_est_typ_a.

The data received from the device will be sent as is to the user.
No data check/decode is done by virtblk.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
--
v2:
	- Remove (void *) casting.
	- Fix comments format in virtio_blk.h.
	- Set ioprio value for legacy devices for REQ_OP_DRV_IN
	  operations.

v3:
	- Initialize struct virtio_blk_lifetime to 0 instead of memset.
	- Rename ioctl from VBLK_LIFETIME to VBLK_GET_LIFETIME.
	- Return EOPNOTSUPP insted of ENOTTY if ioctl is not supported.
	- Check if process is CAP_SYS_ADMIN capable in lifetime ioctl.
	- Check if vdev is not NULL before accessing it in lifetime ioctl.
--
---
 drivers/block/virtio_blk.c      | 106 ++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_blk.h |  32 ++++++++++
 2 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd73..392d57fd6b7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -101,6 +101,18 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
 	}
 }
 
+static inline int virtblk_ioctl_result(struct virtblk_req *vbr)
+{
+	switch (vbr->status) {
+	case VIRTIO_BLK_S_OK:
+		return 0;
+	case VIRTIO_BLK_S_UNSUPP:
+		return -EOPNOTSUPP;
+	default:
+		return -EIO;
+	}
+}
+
 static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
@@ -218,6 +230,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	u32 type;
 
 	vbr->out_hdr.sector = 0;
+	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
@@ -244,15 +257,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		type = VIRTIO_BLK_T_SECURE_ERASE;
 		break;
 	case REQ_OP_DRV_IN:
-		type = VIRTIO_BLK_T_GET_ID;
-		break;
+		/* type is set in virtblk_get_id/virtblk_ioctl_lifetime */
+		return 0;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
 	}
 
 	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
-	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
 	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
 	    type == VIRTIO_BLK_T_SECURE_ERASE) {
@@ -459,12 +471,16 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	struct virtio_blk *vblk = disk->private_data;
 	struct request_queue *q = vblk->disk->queue;
 	struct request *req;
+	struct virtblk_req *vbr;
 	int err;
 
 	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
+
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
 		goto out;
@@ -508,6 +524,85 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return ret;
 }
 
+/* Get lifetime information from device */
+static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned long arg)
+{
+	struct request_queue *q = vblk->disk->queue;
+	struct request *req = NULL;
+	struct virtblk_req *vbr;
+	struct virtio_blk_lifetime lifetime = {};
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* The virtio_blk_lifetime struct fields follow virtio spec.
+	 * There is no check/decode on values received from the device.
+	 * The data is sent as is to the user.
+	 */
+
+	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
+	 * feature is negotiated.
+	 */
+	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
+		return -EOPNOTSUPP;
+
+	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	/* Write the correct type */
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
+
+	ret = blk_rq_map_kern(q, req, &lifetime, sizeof(lifetime), GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	blk_execute_rq(req, false);
+
+	ret = virtblk_ioctl_result(blk_mq_rq_to_pdu(req));
+	if (ret)
+		goto out;
+
+	/* Pass the data to the user */
+	if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+out:
+	blk_mq_free_request(req);
+	return ret;
+}
+
+static int virtblk_ioctl(struct block_device *bd, fmode_t mode,
+			 unsigned int cmd, unsigned long arg)
+{
+	struct virtio_blk *vblk = bd->bd_disk->private_data;
+	int ret;
+
+	mutex_lock(&vblk->vdev_mutex);
+
+	if (!vblk->vdev) {
+		ret = -ENXIO;
+		goto exit;
+	}
+
+	switch (cmd) {
+	case VBLK_GET_LIFETIME:
+		ret = virtblk_ioctl_lifetime(vblk, arg);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+exit:
+	mutex_unlock(&vblk->vdev_mutex);
+	return ret;
+}
+
 static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
@@ -520,6 +615,7 @@ static void virtblk_free_disk(struct gendisk *disk)
 static const struct block_device_operations virtblk_fops = {
 	.owner  	= THIS_MODULE,
 	.getgeo		= virtblk_getgeo,
+	.ioctl		= virtblk_ioctl,
 	.free_disk	= virtblk_free_disk,
 };
 
@@ -1239,7 +1335,7 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE,
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
 }
 ;
 static unsigned int features[] = {
@@ -1247,7 +1343,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE,
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 58e70b24b50..e755d62d2ea 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_LIFETIME	15 /* Storage lifetime information is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 
 /* Legacy feature bits */
@@ -165,6 +166,9 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Get lifetime information command */
+#define VIRTIO_BLK_T_GET_LIFETIME 10
+
 /* Discard command */
 #define VIRTIO_BLK_T_DISCARD	11
 
@@ -206,6 +210,30 @@ struct virtio_blk_discard_write_zeroes {
 	__le32 flags;
 };
 
+/* Get lifetime information struct for each request */
+struct virtio_blk_lifetime {
+	/*
+	 * specifies the percentage of reserved blocks that are consumed.
+	 * optional values following virtio spec:
+	 * 0 - undefined
+	 * 1 - normal, < 80% of reserved blocks are consumed
+	 * 2 - warning, 80% of reserved blocks are consumed
+	 * 3 - urgent, 90% of reserved blocks are consumed
+	 */
+	__le16 pre_eol_info;
+	/*
+	 * this field refers to wear of SLC cells and is provided in increments of 10used,
+	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
+	 * are reserved
+	 */
+	__le16 device_lifetime_est_typ_a;
+	/*
+	 * this field refers to wear of MLC cells and is provided with the same semantics as
+	 * device_lifetime_est_typ_a
+	 */
+	__le16 device_lifetime_est_typ_b;
+};
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 struct virtio_scsi_inhdr {
 	__virtio32 errors;
@@ -219,4 +247,8 @@ struct virtio_scsi_inhdr {
 #define VIRTIO_BLK_S_OK		0
 #define VIRTIO_BLK_S_IOERR	1
 #define VIRTIO_BLK_S_UNSUPP	2
+
+/* Virtblk ioctl commands */
+#define VBLK_GET_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)
+
 #endif /* _LINUX_VIRTIO_BLK_H */
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
