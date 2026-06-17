Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158A480327
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709458; cv=none; b=u9m6kqXBEQ3OjXtirztgwiEaU+GrznYUs83VB/wV56MCMXAZHr1V/+Txq/bPjwTsqJ0e1IRN1ZO+56g5VwpKckmfs5MnG8nnN4/lrdXctvThEUCACsDQ6mJMWW7E0wcozQHTtaF8kqdvcaDU1WPiC6vPnFvzCJcxGdGScapccug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709458; c=relaxed/simple;
	bh=ZiZeqj5W4TjeYd1jGBGSd3ef16TSkam+PtO0+bHiYNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9E11RDkJdfxKS2L3l3jw+N5BaFbP6hHE75iWYiGHTc5RpSLpbbzqgxVsfaANI2Ko3gSB4SsyW4a76cKygMDUwsfMoYHD9u4TgrKtOFNI5YtnYZjRJA1NihKcvBGxwx5tl1p/B4tBvOCUYfP4tURswkFZm3CVp0EaxSyV4tA1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiNE9Sss; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiNE9Sss"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91587626a3eso616563185a.2
        for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781709454; x=1782314254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwJ11BUFvQpn5D9oDUa4PWQ9xRUr33OFEcUVw3lutuo=;
        b=MiNE9Sss3db7+Cq5y885NThJqXAznhpBTqFjXiWQ4cVpZLGk8Z4R95NSZGeTrgk1xo
         PFW6P8Wjl3ctHfG8VddKBV4J3cQzKBeX1rhRQM8UVSEcOXXCONVpasU39THYhutkC+cJ
         alqJbOEf9WbmjzgCCah/jiqfDCF+DbM2ek+P3Y8lEyC0zPtH+XzfwMdqfnSxYNJ/lEsZ
         +TQftraKhzG3zCKVKfKkcsx0P8C/YoDkRU3TInhL+AkGo4qP3VwnaNnDQSre9xeGSa7M
         pVQ3w3cZHHlGmEXeWKFeDurPDA3wVt0bhKbfpl6RnXKY3xlxGd0rGjSEBXkIMWb4Emkg
         SULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781709454; x=1782314254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwJ11BUFvQpn5D9oDUa4PWQ9xRUr33OFEcUVw3lutuo=;
        b=LKRDeAUM9pKk8dEObQq4u/z4kEpOQe2cymleMV9Em5CuGtzDgylbr8Uicf6bA8vK92
         LbRcHSU33HcBgcp/uMRe3rcJoamK7/bW0rmfJZsjL8af5ubjdRuZVBZh7/HcvrD8YHOx
         U0hcWrWOPnJcdxQlopiggeLKt/+dRIqrOoP4zRsJpXp5G860dd8qtX998+hemkfjiXHa
         F5mZiuMc0s0G/dzPJN8h9xcOVdzw1YOEct70wBATnUlIhGf9p78ZxPQfbKymsprnOMBo
         TzNnZO6H7tGdIpa7xaeC4JQh7N9JqAyitBW8l2KEOQBMXNCtib0fhjGbg/30udHMY9BK
         105A==
X-Forwarded-Encrypted: i=1; AFNElJ8lmclyQCRHnj6Ku20gKnVj+9pheZ7J1j+3wTeyYTG+BSgMeuSo5RZZrIGKZCir7gTjdbHERN+zoSAOLLix2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoOqUzXo71/5UCcvaR3CKkrALETuKiaslsON7ou2h3o2ACIky1
	zqZ5nrFukPQNMxfIdz7YNyvPyKUD/67JBFhFazXTFgXRSdY//YtnW0sP
X-Gm-Gg: Acq92OFiEiktVDnKDcjnKSPKhVrrgZpgXml/Qafo2m54gkltN9/jms9uwH58EIOvfcN
	eXyEDrqBMoyJ1ChXe0gSZ4MAtziH8GUbFjsduQNxua9vAGPj8Q9ZH2Ytqeb7KIMhaSvp441TP8j
	mDfbgWinVwW4Ap6syyY6apyJxrrGdGr/XoZ3M4noLaz1qqqdHp7YzmS9tcTlra8Zh9wQHnouS7s
	078XmHedLSjjM4oO/XMJZXYCmLOvuFT/RrZ3BIUaGT/vQWk3FNJ+VmG50ac6SndfS1uvryEHqcM
	cryagfj9EOggLS39/Th+iuiSIa7RuGc8sGKSRHrOFMLYgvQVFR1FutH2A0p/mT2gwEa+TFfujRD
	msRgZ4VZXc2Iyk2R3GKarFzZJEnDEAtBxmSyoq4o+QhrAy/26E98CsPezXBkXxrDq+TLqZyBVzf
	ql5LwYFUBN+Jvgn3hNgW5BUwlloHGt5BK8SQ/I6g0Ru1bc+ZNUD7+0H0kzh6bKijXLAcVz6+D3y
	GBZMXPvUpfWfVOb2h0KJ+ZMkLvvaL9k
X-Received: by 2002:a05:620a:444f:b0:915:b9f6:71ab with SMTP id af79cd13be357-91dbcf10e12mr600897885a.44.1781709454250;
        Wed, 17 Jun 2026 08:17:34 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a061028sm1787280985a.42.2026.06.17.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:17:33 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-blk: use little-endian types for the zoned fields
Date: Wed, 17 Jun 2026 11:17:27 -0400
Message-ID: <20260617151727.4071754-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The zoned block-device fields in the virtio-blk header are typed
__virtio{32,64}, so their endianness follows VIRTIO_F_VERSION_1. The
zoned feature is only defined for VIRTIO 1.x devices, and the virtio
specification defines all of its fields as little-endian. Commit
b16a1756c716 ("virtio_blk: mark all zone fields LE") tagged them
__le* for exactly this reason, but commit f1ba4e674feb ("virtio-blk:
fix to match virtio spec") re-applied the reviewed version of the
original zoned series -- which predated b16a1756 -- and silently
restored the __virtio* typing together with the matching
virtio*_to_cpu() / virtio_cread() accessors in the driver.

Restore the little-endian typing for the zoned configuration-space
characteristics, the zone descriptor, the zone report header and the
ZONE_APPEND in-header sector, and read them with le*_to_cpu() and
virtio_cread_le() to match.

There is no functional change on any spec-compliant device: zoned
requires VIRTIO_F_VERSION_1, and for a VERSION_1 device
virtio*_to_cpu() is identical to le*_to_cpu(). The change makes the
uapi types describe the actual wire format and removes a latent
endianness mismatch for a (non-conformant) legacy device on a
big-endian guest.

Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Testing:
 - Builds with no new warnings; sparse endian-clean (C=2,
   __CHECK_ENDIAN__, CONFIG_BLK_DEV_ZONED=y) both before and after.
 - Booted under QEMU with a host-managed zoned device exposed through
   virtio-blk. Zone revalidation, blkzone report and a sequential
   write / write-pointer check return correct values; blktests zbd
   device tests 001-006 (sysfs+ioctl, report zone, reset, write split,
   write ordering, revalidate) pass, with results identical before and
   after this change -- expected, since on a VIRTIO_F_VERSION_1 device
   virtio*_to_cpu() == le*_to_cpu().

 drivers/block/virtio_blk.c      | 38 +++++++++++++++------------------
 include/uapi/linux/virtio_blk.h | 18 ++++++++--------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1c9a27fe00f3..5532cfbde7bfe 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -99,7 +99,7 @@ struct virtblk_req {
 		 * be the last byte.
 		 */
 		struct {
-			__virtio64 sector;
+			__le64 sector;
 			u8 status;
 		} zone_append;
 	} in_hdr;
@@ -335,14 +335,12 @@ static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
-	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = virtio64_to_cpu(vblk->vdev,
-						vbr->in_hdr.zone_append.sector);
+		req->__sector = le64_to_cpu(vbr->in_hdr.zone_append.sector);
 
 	blk_mq_end_request(req, status);
 }
@@ -589,13 +587,13 @@ static int virtblk_parse_zone(struct virtio_blk *vblk,
 {
 	struct blk_zone zone = { };
 
-	zone.start = virtio64_to_cpu(vblk->vdev, entry->z_start);
+	zone.start = le64_to_cpu(entry->z_start);
 	if (zone.start + vblk->zone_sectors <= get_capacity(vblk->disk))
 		zone.len = vblk->zone_sectors;
 	else
 		zone.len = get_capacity(vblk->disk) - zone.start;
-	zone.capacity = virtio64_to_cpu(vblk->vdev, entry->z_cap);
-	zone.wp = virtio64_to_cpu(vblk->vdev, entry->z_wp);
+	zone.capacity = le64_to_cpu(entry->z_cap);
+	zone.wp = le64_to_cpu(entry->z_wp);
 
 	switch (entry->z_type) {
 	case VIRTIO_BLK_ZT_SWR:
@@ -687,8 +685,7 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 		if (ret)
 			goto fail_report;
 
-		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
-			   nr_zones);
+		nz = min_t(u64, le64_to_cpu(report->nr_zones), nr_zones);
 		if (!nz)
 			break;
 
@@ -698,8 +695,7 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 			if (ret)
 				goto fail_report;
 
-			sector = virtio64_to_cpu(vblk->vdev,
-						 report->zones[i].z_start) +
+			sector = le64_to_cpu(report->zones[i].z_start) +
 				 vblk->zone_sectors;
 			zone_idx++;
 		}
@@ -725,18 +721,18 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 
 	lim->features |= BLK_FEAT_ZONED;
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.max_open_zones, &v);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.max_open_zones, &v);
 	lim->max_open_zones = v;
 	dev_dbg(&vdev->dev, "max open zones = %u\n", v);
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.max_active_zones, &v);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.max_active_zones, &v);
 	lim->max_active_zones = v;
 	dev_dbg(&vdev->dev, "max active zones = %u\n", v);
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.write_granularity, &wg);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.write_granularity, &wg);
 	if (!wg) {
 		dev_warn(&vdev->dev, "zero write granularity reported\n");
 		return -ENODEV;
@@ -750,8 +746,8 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 	 * virtio ZBD specification doesn't require zones to be a power of
 	 * two sectors in size, but the code in this driver expects that.
 	 */
-	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors,
-		     &vblk->zone_sectors);
+	virtio_cread_le(vdev, struct virtio_blk_config, zoned.zone_sectors,
+			&vblk->zone_sectors);
 	if (vblk->zone_sectors == 0 || !is_power_of_2(vblk->zone_sectors)) {
 		dev_err(&vdev->dev,
 			"zoned device with non power of two zone size %u\n",
@@ -767,8 +763,8 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 		lim->max_hw_discard_sectors = 0;
 	}
 
-	virtio_cread(vdev, struct virtio_blk_config,
-		     zoned.max_append_sectors, &v);
+	virtio_cread_le(vdev, struct virtio_blk_config,
+			zoned.max_append_sectors, &v);
 	if (!v) {
 		dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
 		return -ENODEV;
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a7..5af2a0300bb9d 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -140,11 +140,11 @@ struct virtio_blk_config {
 
 	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
 	struct virtio_blk_zoned_characteristics {
-		__virtio32 zone_sectors;
-		__virtio32 max_open_zones;
-		__virtio32 max_active_zones;
-		__virtio32 max_append_sectors;
-		__virtio32 write_granularity;
+		__le32 zone_sectors;
+		__le32 max_open_zones;
+		__le32 max_active_zones;
+		__le32 max_append_sectors;
+		__le32 write_granularity;
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
@@ -241,11 +241,11 @@ struct virtio_blk_outhdr {
  */
 struct virtio_blk_zone_descriptor {
 	/* Zone capacity */
-	__virtio64 z_cap;
+	__le64 z_cap;
 	/* The starting sector of the zone */
-	__virtio64 z_start;
+	__le64 z_start;
 	/* Zone write pointer position in sectors */
-	__virtio64 z_wp;
+	__le64 z_wp;
 	/* Zone type */
 	__u8 z_type;
 	/* Zone state */
@@ -254,7 +254,7 @@ struct virtio_blk_zone_descriptor {
 };
 
 struct virtio_blk_zone_report {
-	__virtio64 nr_zones;
+	__le64 nr_zones;
 	__u8 reserved[56];
 	struct virtio_blk_zone_descriptor zones[];
 };
-- 
2.53.0

