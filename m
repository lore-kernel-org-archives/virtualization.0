Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8194FC32771
	for <virtualization@archiver.kernel.org>; Sun, 18 Sep 2022 13:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B7A419A9;
	Sun, 18 Sep 2022 13:30:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00B7A419A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOukQPt0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tkvKeDXLO87W; Sun, 18 Sep 2022 13:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 860564198D;
	Sun, 18 Sep 2022 13:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 860564198D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 572A8C0032;
	Sun, 18 Sep 2022 13:30:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49395C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 13:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2440183F63
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 13:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2440183F63
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOukQPt0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SP5EYrZU-kSU
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 13:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B60883F3C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B60883F3C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663507818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UmJYT09QVw3D5zyOGPAB0JIlDIzikbUkUdo1Kw9f52E=;
 b=VOukQPt0mpHwH86aYOQgrkFThgkHUtHFMtMDSJ3YHX16pqzksUv8OrBtC/FEH6Cysad7xV
 yWw1fPl6Mo2MREomObqN5szjYNkE2oKAZz9RbEKVPHvaT6cA10SmVrxzo0WdHns9UgJ1H1
 Av9f1uromMnADPTEBreVTAy2YbKdWk4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-KlfEjYi-P-eOpSg1Fi5iFg-1; Sun, 18 Sep 2022 09:30:16 -0400
X-MC-Unique: KlfEjYi-P-eOpSg1Fi5iFg-1
Received: by mail-wm1-f70.google.com with SMTP id
 g8-20020a05600c4ec800b003b4bcbdb63cso3696010wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 06:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=UmJYT09QVw3D5zyOGPAB0JIlDIzikbUkUdo1Kw9f52E=;
 b=3IwuKNyhLWenjPoMrA4lTKW1adnWUaBf6dLE9KskwuW4yHJ437bSKPBOvD0DnMrLeF
 ljbkdUwyABWk3XMbnMl4rL5VhnzNXntVWf7RWdalkYcUrOE0zBKL+UzyauwRAzVyXxHN
 W+iypvrPsGQYGirBusFDhaNup48ziCJKRGDA2O+9aSSoSF5RbmEeSCdY86EtYnJ6cHIg
 TkFbNs+e0Y829u1ccZXob12IVnFsD7b1gWb0ahjLCnQZl08zNkfONTd7V70KpAoJZR+r
 KFos6goK+S7kT13NL3knTQL4sjSXKNMa/T187PEySGSHUD3DicGiSUOEK+ZRpDuwMwwO
 4W2w==
X-Gm-Message-State: ACrzQf24YeOCWt8vfq8EIqlvtxSBWIQ/H3osMQFLlCggNEy2Zzr1Ztz+
 XnNn9VymbytWNHRLUR+MGbz2BvxxJIVRnNmx4TnGj0fnuSfo6AQQ2xG/6o7ELWPjqtG0YyyO2Xr
 2XFoGQAKVhjFDIYOfr7Ip/ENv6tV0qlfm7g0PzEXihA==
X-Received: by 2002:a05:600c:21c3:b0:3b4:7e47:e3a with SMTP id
 x3-20020a05600c21c300b003b47e470e3amr9091261wmj.167.1663507815586; 
 Sun, 18 Sep 2022 06:30:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6rnC1JyqcMWAlR/kAN3CgtZIJyawC5E+7BVjGbyGnGMQJLmMPhb12xHFNBS5VL9N8OYXZiTg==
X-Received: by 2002:a05:600c:21c3:b0:3b4:7e47:e3a with SMTP id
 x3-20020a05600c21c300b003b47e470e3amr9091252wmj.167.1663507815323; 
 Sun, 18 Sep 2022 06:30:15 -0700 (PDT)
Received: from redhat.com ([2.52.4.6]) by smtp.gmail.com with ESMTPSA id
 x1-20020adfdd81000000b002205cbc1c74sm6481615wrl.101.2022.09.18.06.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Sep 2022 06:30:14 -0700 (PDT)
Date: Sun, 18 Sep 2022 09:30:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
Message-ID: <20220918091848-mutt-send-email-mst@kernel.org>
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Mon, Aug 29, 2022 at 11:23:13AM +0300, Alvaro Karsz wrote:
> Support for the VIRTIO_BLK_F_SECURE_ERASE VirtIO feature.
> 
> A device that offers this feature can receive VIRTIO_BLK_T_SECURE_ERASE
> commands.
> 
> A device which supports this feature has the following fields in the
> virtio config:
> 
> - max_secure_erase_sectors
> - max_secure_erase_seg
> - secure_erase_sector_alignment
> 
> max_secure_erase_sectors and secure_erase_sector_alignment are expressed
> in 512-byte units.
> 
> Every secure erase command has the following fields:
> 
> - sectors: The starting offset in 512-byte units.
> - num_sectors: The number of sectors.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Review from storage maintainers before I queue this?

Thanks!

> ---
> v2:
> 	- Set queue max discard segments as the minimum between
> 	  max_secure_erase_seg and max_discard_seg.
> 	- Set queue discard granularity as the minimum between
> 	  secure_erase_sector_alignment and discard_sector_alignment.
> ---
>  drivers/block/virtio_blk.c      | 82 +++++++++++++++++++++++++--------
>  include/uapi/linux/virtio_blk.h | 19 ++++++++
>  2 files changed, 83 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30255fcaf18..8a2f00cdf52 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -130,7 +130,7 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>  	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
>  }
>  
> -static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> +static int virtblk_setup_discard_write_zeroes_erase(struct request *req, bool unmap)
>  {
>  	unsigned short segments = blk_rq_nr_discard_segments(req);
>  	unsigned short n = 0;
> @@ -240,6 +240,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  		type = VIRTIO_BLK_T_WRITE_ZEROES;
>  		unmap = !(req->cmd_flags & REQ_NOUNMAP);
>  		break;
> +	case REQ_OP_SECURE_ERASE:
> +		type = VIRTIO_BLK_T_SECURE_ERASE;
> +		break;
>  	case REQ_OP_DRV_IN:
>  		type = VIRTIO_BLK_T_GET_ID;
>  		break;
> @@ -251,8 +254,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
>  	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
> -	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
> -		if (virtblk_setup_discard_write_zeroes(req, unmap))
> +	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
> +	    type == VIRTIO_BLK_T_SECURE_ERASE) {
> +		if (virtblk_setup_discard_write_zeroes_erase(req, unmap))
>  			return BLK_STS_RESOURCE;
>  	}
>  
> @@ -889,6 +893,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	int err, index;
>  
>  	u32 v, blk_size, max_size, sg_elems, opt_io_size;
> +	u32 max_discard_segs = 0;
> +	u32 discard_granularity = 0;
>  	u16 min_io_size;
>  	u8 physical_block_exp, alignment_offset;
>  	unsigned int queue_depth;
> @@ -1046,27 +1052,14 @@ static int virtblk_probe(struct virtio_device *vdev)
>  
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
>  		virtio_cread(vdev, struct virtio_blk_config,
> -			     discard_sector_alignment, &v);
> -		if (v)
> -			q->limits.discard_granularity = v << SECTOR_SHIFT;
> -		else
> -			q->limits.discard_granularity = blk_size;
> +			     discard_sector_alignment, &discard_granularity);
>  
>  		virtio_cread(vdev, struct virtio_blk_config,
>  			     max_discard_sectors, &v);
>  		blk_queue_max_discard_sectors(q, v ? v : UINT_MAX);
>  
>  		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
> -			     &v);
> -
> -		/*
> -		 * max_discard_seg == 0 is out of spec but we always
> -		 * handled it.
> -		 */
> -		if (!v)
> -			v = sg_elems;
> -		blk_queue_max_discard_segments(q,
> -					       min(v, MAX_DISCARD_SEGMENTS));
> +			     &max_discard_segs);
>  	}
>  
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_WRITE_ZEROES)) {
> @@ -1075,6 +1068,57 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
> +		/* The discard alignment value should be the minimum between
> +		 * secure_erase_sector_alignment and discard_sector_alignment
> +		 * (if VIRTIO_BLK_F_DISCARD is negotiated).

why minimum?

> +		 */
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     secure_erase_sector_alignment, &v);
> +		if (v) {
> +			if (discard_granularity)
> +				discard_granularity = min(discard_granularity, v);
> +			else
> +				discard_granularity = v;
> +		}
> +
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_secure_erase_sectors, &v);
> +		blk_queue_max_secure_erase_sectors(q, v ? v : UINT_MAX);
> +
> +		/* The max discard segments value should be the minimum between
> +		 * max_secure_erase_seg and max_discard_seg (if VIRTIO_BLK_F_DISCARD
> +		 * is negotiated).

why is that?

> +		 */
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_secure_erase_seg, &v);
> +		if (v) {
> +			if (max_discard_segs)
> +				max_discard_segs = min(max_discard_segs, v);
> +			else
> +				max_discard_segs = v;

is this logic repeating code from below?

> +		}
> +	}
> +
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD) ||
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
> +
> +		/* max_discard_seg == 0 or max_secure_erase_seg == 0
> +		 * are out of spec but we always handled it.

Always? What's going on here?
which versions handled max_secure_erase_seg == 0?


> +		 */
> +		if (!max_discard_segs)
> +			max_discard_segs = sg_elems;
> +
> +		blk_queue_max_discard_segments(q,
> +					       min(max_discard_segs, MAX_DISCARD_SEGMENTS));
> +
> +		/* If alignemnt is 0, use block size alignment */
> +		if (discard_granularity)
> +			q->limits.discard_granularity = discard_granularity << SECTOR_SHIFT;
> +		else
> +			q->limits.discard_granularity = blk_size;
> +	}
> +
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> @@ -1170,6 +1214,7 @@ static unsigned int features_legacy[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +	VIRTIO_BLK_F_SECURE_ERASE,
>  }
>  ;
>  static unsigned int features[] = {
> @@ -1177,6 +1222,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +	VIRTIO_BLK_F_SECURE_ERASE,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9f..58e70b24b50 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
>  
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -121,6 +122,21 @@ struct virtio_blk_config {
>  	__u8 write_zeroes_may_unmap;
>  
>  	__u8 unused1[3];
> +
> +	/* the next 3 entries are guarded by VIRTIO_BLK_F_SECURE_ERASE */
> +	/*
> +	 * The maximum secure erase sectors (in 512-byte sectors) for
> +	 * one segment.
> +	 */
> +	__virtio32 max_secure_erase_sectors;
> +	/*
> +	 * The maximum number of secure erase segments in a
> +	 * secure erase command.
> +	 */
> +	__virtio32 max_secure_erase_seg;
> +	/* Secure erase commands must be aligned to this number of sectors. */
> +	__virtio32 secure_erase_sector_alignment;
> +
>  } __attribute__((packed));
>  
>  /*
> @@ -155,6 +171,9 @@ struct virtio_blk_config {
>  /* Write zeroes command */
>  #define VIRTIO_BLK_T_WRITE_ZEROES	13
>  
> +/* Secure erase command */
> +#define VIRTIO_BLK_T_SECURE_ERASE	14
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000
> -- 
> 2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
