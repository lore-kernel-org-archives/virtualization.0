Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76C32B10E
	for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768497; cv=none; b=noM9kBEjatlXL2V5AxoF31MfWn+B1+wEIA2N7Vs7oXknViv7PJ0M38qme1MDcb3wkoAJNBTxMqYm6Y8qJ2D9irSx9BUngzEVayBR2stKtP1GrBaFqwwAvm7pUzn1qvqPqo+Yob0Fv9dxjX0xvcbuP21sba9RDLKj56tiEeeL2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768497; c=relaxed/simple;
	bh=gZkwZs34r2bbac54SVywYC/jPjvgeK3vRDRUywn0qf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YfhfSGb9S6uAlSXtCHKUKtcGD/eZ9N4HuBxuQjXddRvjG1fkqk+WRlQKRHOrOnD3osI0cYSblLBWYy91zaj0JezbzJ3AlXt3UAhyyLyjWMWJExT0VW1QwSnxqNldt2nr24zt2xKehg6M78j36n25H77mG2bVdTocCQQULy9jHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CajiUWsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CajiUWsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781768495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7/6GMFySLjEAnNbADHN8HTqTCVaGwns6zVzwQSvgaU=;
	b=CajiUWsvOUejXNZffh3T5LB9fOTB9KHqE/D1tHu4FrketOf18lBHjusfAX/B1+u3XICN5Y
	gtcpuf/svFE5GttFMBqFHkJeP3fEqDuXX3eM9zUB7yvylH4FcEmplCYSWiVgEGexUNZhKO
	hAQW6K3fWRdGkivRcQ4YYRbNBV1yzR0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-c1yhWlPDMyGNNo4OBGSLaA-1; Thu, 18 Jun 2026 03:41:31 -0400
X-MC-Unique: c1yhWlPDMyGNNo4OBGSLaA-1
X-Mimecast-MFC-AGG-ID: c1yhWlPDMyGNNo4OBGSLaA_1781768490
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so3379795e9.0
        for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 00:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781768490; x=1782373290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7/6GMFySLjEAnNbADHN8HTqTCVaGwns6zVzwQSvgaU=;
        b=jO5cYYKNB6f9uC8AkXagtc3XDWR7ajOm+PT1/A4wmNZzxOguLo0niUJ4dWYWER+0LP
         AWv75oQNUASq+j9pJAzDGfZUt7mEDpZJJGTvQHb3qOv9PxYxb//s/Eads2EAMhPGkAfF
         UIBYbxo072RwUiQUs1nQ16wjBPNkjQAw9eKDVpsWfGBAdGWdu+pm+zUKjC+GomAc9qkm
         T+YsZMshKDq07Fq93EKoJbCWiH2mT9+Bss/kpms0jnTfC9nKQsFrdSYkuA/2jsKt9rKk
         7JkIvbZ8yxq/NsfxiizLNScJcqMnmvD4BzDw+kL0qhEds7DEYYFzZ2ihTNi3wEGH4NQr
         YgGA==
X-Forwarded-Encrypted: i=1; AFNElJ/VaFHxiqORddONJ1YI47Z0mEYi5GCnJOYalUJ8RV+UuNJF1LMsOElIPyPwDHkPz5D8eTTs+qRM6EhiQdyamQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa9anO2g1vQU8Gy1Jd5TN3FBtKI1G/VVU0QEFUQ4uXOMRGQ28V
	Y1VMuTM2oTWmmjiZgrE6ie4ao+uJqSElciLPXC20QcYES2WIOaHvxL5l0lCZ5ej8BaMQORic+mH
	i5BhmkuIRx6FQ/Fw+6FLGwDAPIjcoIhJ9o2j0bGaiUZStjkiKSLG8NaOJttfm9ObBLw6X
X-Gm-Gg: AfdE7clKzHvCl1tbO7e3/0flS0TgpMi+igCukB6yglhNmhZULYUmyTmNIATumlSHDzp
	q8E2R+e4PsHeNIbW93zu7k54/o92Q7dr5IkenyennSbtKKiYyuGfT0F28wwYwc8BHSxV9Nv4Jr4
	766M0095a3z/Vg3+NCMlAlPUsVFdCWB2YZPvMjXLUmHyVFArJoXSFOSwevga2imxdcBhKUKj+SK
	dG8ZCTZq84/+DuGu9SLnAKwcl7028NNmQMUFzd00bci7jvALk0xv2lANEncHFNtWP+9+tGv0Sht
	QZXXv9Sta5lCS/tyvzRwx1glY+S/eH4tMA3PaHzY9kIEzbtLfcZ8DolGOxU9ZHWsZBSAXH0dsoC
	QWhnyNuwOv4LGGz/koHU518uCO9LBBgTQnmyhsGI8a146qde9tZQCnyUcE3Nm
X-Received: by 2002:a05:600c:19d0:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-4923a9d0827mr13387945e9.21.1781768490294;
        Thu, 18 Jun 2026 00:41:30 -0700 (PDT)
X-Received: by 2002:a05:600c:19d0:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-4923a9d0827mr13387535e9.21.1781768489797;
        Thu, 18 Jun 2026 00:41:29 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm384710215e9.14.2026.06.18.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:41:29 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:41:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Dmitry Fomichev <dmitry.fomichev@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: use little-endian types for the zoned fields
Message-ID: <ajOfAcBC6Ea-yfkB@sgarzare-redhat>
References: <20260617151727.4071754-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260617151727.4071754-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6sFt8yEl-ZH8En9y5A9XWEAsI0DffyO0h7klUoVff3E_1781768490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 17, 2026 at 11:17:27AM -0400, Michael Bommarito wrote:
>The zoned block-device fields in the virtio-blk header are typed
>__virtio{32,64}, so their endianness follows VIRTIO_F_VERSION_1. The
>zoned feature is only defined for VIRTIO 1.x devices, and the virtio
>specification defines all of its fields as little-endian. Commit
>b16a1756c716 ("virtio_blk: mark all zone fields LE") tagged them
>__le* for exactly this reason, but commit f1ba4e674feb ("virtio-blk:
>fix to match virtio spec") re-applied the reviewed version of the
>original zoned series -- which predated b16a1756 -- and silently
>restored the __virtio* typing together with the matching
>virtio*_to_cpu() / virtio_cread() accessors in the driver.
>
>Restore the little-endian typing for the zoned configuration-space
>characteristics, the zone descriptor, the zone report header and the
>ZONE_APPEND in-header sector, and read them with le*_to_cpu() and
>virtio_cread_le() to match.
>
>There is no functional change on any spec-compliant device: zoned
>requires VIRTIO_F_VERSION_1, and for a VERSION_1 device
>virtio*_to_cpu() is identical to le*_to_cpu(). The change makes the
>uapi types describe the actual wire format and removes a latent
>endianness mismatch for a (non-conformant) legacy device on a
>big-endian guest.

Not for this patch, but at this point should we do the same also for the 
fields gated by the following features that IIUC are all added in 1.*:
- VIRTIO_BLK_F_MQ
- VIRTIO_BLK_F_DISCARD
- VIRTIO_BLK_F_WRITE_ZEROES
- VIRTIO_BLK_F_SECURE_ERASE

>
>Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>---
>Testing:
> - Builds with no new warnings; sparse endian-clean (C=2,
>   __CHECK_ENDIAN__, CONFIG_BLK_DEV_ZONED=y) both before and after.
> - Booted under QEMU with a host-managed zoned device exposed through
>   virtio-blk. Zone revalidation, blkzone report and a sequential
>   write / write-pointer check return correct values; blktests zbd
>   device tests 001-006 (sysfs+ioctl, report zone, reset, write split,
>   write ordering, revalidate) pass, with results identical before and
>   after this change -- expected, since on a VIRTIO_F_VERSION_1 device
>   virtio*_to_cpu() == le*_to_cpu().
>
> drivers/block/virtio_blk.c      | 38 +++++++++++++++------------------
> include/uapi/linux/virtio_blk.h | 18 ++++++++--------
> 2 files changed, 26 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index b1c9a27fe00f3..5532cfbde7bfe 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -99,7 +99,7 @@ struct virtblk_req {
> 		 * be the last byte.
> 		 */
> 		struct {
>-			__virtio64 sector;
>+			__le64 sector;
> 			u8 status;
> 		} zone_append;
> 	} in_hdr;
>@@ -335,14 +335,12 @@ static inline void virtblk_request_done(struct request *req)
> {
> 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> 	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
>-	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
>
> 	virtblk_unmap_data(req, vbr);
> 	virtblk_cleanup_cmd(req);
>
> 	if (req_op(req) == REQ_OP_ZONE_APPEND)
>-		req->__sector = virtio64_to_cpu(vblk->vdev,
>-						vbr->in_hdr.zone_append.sector);
>+		req->__sector = le64_to_cpu(vbr->in_hdr.zone_append.sector);
>
> 	blk_mq_end_request(req, status);
> }
>@@ -589,13 +587,13 @@ static int virtblk_parse_zone(struct virtio_blk *vblk,
> {
> 	struct blk_zone zone = { };
>
>-	zone.start = virtio64_to_cpu(vblk->vdev, entry->z_start);
>+	zone.start = le64_to_cpu(entry->z_start);
> 	if (zone.start + vblk->zone_sectors <= get_capacity(vblk->disk))
> 		zone.len = vblk->zone_sectors;
> 	else
> 		zone.len = get_capacity(vblk->disk) - zone.start;
>-	zone.capacity = virtio64_to_cpu(vblk->vdev, entry->z_cap);
>-	zone.wp = virtio64_to_cpu(vblk->vdev, entry->z_wp);
>+	zone.capacity = le64_to_cpu(entry->z_cap);
>+	zone.wp = le64_to_cpu(entry->z_wp);
>
> 	switch (entry->z_type) {
> 	case VIRTIO_BLK_ZT_SWR:
>@@ -687,8 +685,7 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
> 		if (ret)
> 			goto fail_report;
>
>-		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
>-			   nr_zones);
>+		nz = min_t(u64, le64_to_cpu(report->nr_zones), nr_zones);
> 		if (!nz)
> 			break;
>
>@@ -698,8 +695,7 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
> 			if (ret)
> 				goto fail_report;
>
>-			sector = virtio64_to_cpu(vblk->vdev,
>-						 report->zones[i].z_start) +
>+			sector = le64_to_cpu(report->zones[i].z_start) +
> 				 vblk->zone_sectors;
> 			zone_idx++;
> 		}
>@@ -725,18 +721,18 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
>
> 	lim->features |= BLK_FEAT_ZONED;
>
>-	virtio_cread(vdev, struct virtio_blk_config,
>-		     zoned.max_open_zones, &v);
>+	virtio_cread_le(vdev, struct virtio_blk_config,
>+			zoned.max_open_zones, &v);
> 	lim->max_open_zones = v;
> 	dev_dbg(&vdev->dev, "max open zones = %u\n", v);
>
>-	virtio_cread(vdev, struct virtio_blk_config,
>-		     zoned.max_active_zones, &v);
>+	virtio_cread_le(vdev, struct virtio_blk_config,
>+			zoned.max_active_zones, &v);
> 	lim->max_active_zones = v;
> 	dev_dbg(&vdev->dev, "max active zones = %u\n", v);
>
>-	virtio_cread(vdev, struct virtio_blk_config,
>-		     zoned.write_granularity, &wg);
>+	virtio_cread_le(vdev, struct virtio_blk_config,
>+			zoned.write_granularity, &wg);
> 	if (!wg) {
> 		dev_warn(&vdev->dev, "zero write granularity reported\n");
> 		return -ENODEV;
>@@ -750,8 +746,8 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
> 	 * virtio ZBD specification doesn't require zones to be a power of
> 	 * two sectors in size, but the code in this driver expects that.
> 	 */
>-	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors,
>-		     &vblk->zone_sectors);
>+	virtio_cread_le(vdev, struct virtio_blk_config, zoned.zone_sectors,
>+			&vblk->zone_sectors);
> 	if (vblk->zone_sectors == 0 || !is_power_of_2(vblk->zone_sectors)) {
> 		dev_err(&vdev->dev,
> 			"zoned device with non power of two zone size %u\n",
>@@ -767,8 +763,8 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
> 		lim->max_hw_discard_sectors = 0;
> 	}
>
>-	virtio_cread(vdev, struct virtio_blk_config,
>-		     zoned.max_append_sectors, &v);
>+	virtio_cread_le(vdev, struct virtio_blk_config,
>+			zoned.max_append_sectors, &v);
> 	if (!v) {
> 		dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
> 		return -ENODEV;
>diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
>index 3744e4da1b2a7..5af2a0300bb9d 100644
>--- a/include/uapi/linux/virtio_blk.h
>+++ b/include/uapi/linux/virtio_blk.h
>@@ -140,11 +140,11 @@ struct virtio_blk_config {
>

To avoid making this mistake again, how about adding a note here to 
clarify that all the fields listed below are defined only for VIRTIO 1.x 
devices and are therefore always little-endian?

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> 	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
> 	struct virtio_blk_zoned_characteristics {
>-		__virtio32 zone_sectors;
>-		__virtio32 max_open_zones;
>-		__virtio32 max_active_zones;
>-		__virtio32 max_append_sectors;
>-		__virtio32 write_granularity;
>+		__le32 zone_sectors;
>+		__le32 max_open_zones;
>+		__le32 max_active_zones;
>+		__le32 max_append_sectors;
>+		__le32 write_granularity;
> 		__u8 model;
> 		__u8 unused2[3];
> 	} zoned;
>@@ -241,11 +241,11 @@ struct virtio_blk_outhdr {
>  */
> struct virtio_blk_zone_descriptor {
> 	/* Zone capacity */
>-	__virtio64 z_cap;
>+	__le64 z_cap;
> 	/* The starting sector of the zone */
>-	__virtio64 z_start;
>+	__le64 z_start;
> 	/* Zone write pointer position in sectors */
>-	__virtio64 z_wp;
>+	__le64 z_wp;
> 	/* Zone type */
> 	__u8 z_type;
> 	/* Zone state */
>@@ -254,7 +254,7 @@ struct virtio_blk_zone_descriptor {
> };
>
> struct virtio_blk_zone_report {
>-	__virtio64 nr_zones;
>+	__le64 nr_zones;
> 	__u8 reserved[56];
> 	struct virtio_blk_zone_descriptor zones[];
> };
>-- 
>2.53.0
>

