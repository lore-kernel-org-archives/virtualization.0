Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B1AC07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 21:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21EA540909;
	Tue, 27 Sep 2022 21:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21EA540909
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YBIfZafX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSX5Pgg-8b91; Tue, 27 Sep 2022 21:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 824C340902;
	Tue, 27 Sep 2022 21:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 824C340902
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B569C0032;
	Tue, 27 Sep 2022 21:38:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3DE6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 21:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAA61400E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 21:38:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAA61400E7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YBIfZafX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2vHLAHcA1YB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 21:38:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCAC3400A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCAC3400A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664314679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D5ZIksmGurvYC/iOAqtPVWbeUblsOdJ5xwGtu/IzOWI=;
 b=YBIfZafXPewAOPCwMwlF2w2DlDD21qltDYr2cFEMVrVtmC51dGFTeKdAXiJtPaqx9yq9Cp
 1HrshBShVhgvqNhy5iLFSavwN+Xt14nTLUwA6xhnRIjgMImWL1QeLhi/5X4kCLAk1uzMhj
 MZTuB/yV+8ihcPCiACSikzeV3XfNNVk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-2QK5exyFPeWH-zQ4FRBWug-1; Tue, 27 Sep 2022 17:37:58 -0400
X-MC-Unique: 2QK5exyFPeWH-zQ4FRBWug-1
Received: by mail-wr1-f70.google.com with SMTP id
 h20-20020adfaa94000000b0022cc1de1251so770582wrc.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 14:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=D5ZIksmGurvYC/iOAqtPVWbeUblsOdJ5xwGtu/IzOWI=;
 b=yO3u37x2w1X+LHlEctZfTIYYaqS1DdpOC0vlgBpn2tmMQuDXi0DNnAOxkxbqChtIsm
 QppGflQnt5Ucd2SXh9PpJUGZmCCw6TkJM824eGfvvZ32p/FS5OaDnfI/ip7ktOIibzuL
 KbQZGYmDHARFMvfgrKzjOD4A/in+4ZiWht91e/dc3G0adczcgq0Aya79cduJs8as/eiQ
 00wgdvxrOci8gEfDR1dQaUjOk10t4hRqjQCizVcFlWxpvO7Im3kLlcR6B04ejHjDI+5U
 XQvL5Z4DDK31Equ9Bb0SxsDBWnYslx9gtWYbfCn3HQY0+TTHrsV2zT54Tiw+pjRX3sRZ
 My6Q==
X-Gm-Message-State: ACrzQf3k8WX66Phk/+imF/2A76c5cRj0aIW5gSzIdQci2eLZ9WCW9ZVk
 arNIKskl1DAR7naXbTnhvZ/aggxC3JgbVk1t0ouHA6Z1RdDCR9QKrztjLBykgmV6Fe9/Z4Z/5AL
 ejjr41iWnn3qdtV2MTKVnYWKt4zAauT+HRafSZ1cFDg==
X-Received: by 2002:a05:6000:2ce:b0:22a:f2dc:1531 with SMTP id
 o14-20020a05600002ce00b0022af2dc1531mr18614991wry.370.1664314677227; 
 Tue, 27 Sep 2022 14:37:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM75GZrpOIjx3Y8daQH5gD30RRG235Fd/YqvwBOi/XGXrLC5i+WLs9D44hdtjOnyVVgkm68Sog==
X-Received: by 2002:a05:6000:2ce:b0:22a:f2dc:1531 with SMTP id
 o14-20020a05600002ce00b0022af2dc1531mr18614976wry.370.1664314677008; 
 Tue, 27 Sep 2022 14:37:57 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 n3-20020a5d4203000000b0022acb7195aesm2708029wrq.33.2022.09.27.14.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 14:37:56 -0700 (PDT)
Date: Tue, 27 Sep 2022 17:37:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 3/8] virtio_blk: Add support for provision requests
Message-ID: <20220927173658-mutt-send-email-mst@kernel.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-4-sarthakkukreti@google.com>
MIME-Version: 1.0
In-Reply-To: <20220915164826.1396245-4-sarthakkukreti@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, Bart Van Assche <bvanassche@google.com>,
 Mike Snitzer <snitzer@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Andreas Dilger <adilger.kernel@dilger.ca>,
 Daniil Lunev <dlunev@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-ext4@vger.kernel.org,
 Evan Green <evgreen@google.com>, Alasdair Kergon <agk@redhat.com>
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

On Thu, Sep 15, 2022 at 09:48:21AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Adds support for provision requests. Provision requests act like
> the inverse of discards.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/block/virtio_blk.c      | 48 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_blk.h |  9 +++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30255fcaf181..eacc2bffe1d1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -178,6 +178,39 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
>  	return 0;
>  }
>  
> +static int virtblk_setup_provision(struct request *req)
> +{
> +	unsigned short segments = blk_rq_nr_discard_segments(req);
> +	unsigned short n = 0;
> +
> +	struct virtio_blk_discard_write_zeroes *range;
> +	struct bio *bio;
> +	u32 flags = 0;
> +
> +	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	__rq_for_each_bio(bio, req) {
> +		u64 sector = bio->bi_iter.bi_sector;
> +		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +		range[n].flags = cpu_to_le32(flags);
> +		range[n].num_sectors = cpu_to_le32(num_sectors);
> +		range[n].sector = cpu_to_le64(sector);
> +		n++;
> +	}
> +
> +	WARN_ON_ONCE(n != segments);
> +
> +	req->special_vec.bv_page = virt_to_page(range);
> +	req->special_vec.bv_offset = offset_in_page(range);
> +	req->special_vec.bv_len = sizeof(*range) * segments;
> +	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> +
> +	return 0;
> +}
> +
>  static void virtblk_unmap_data(struct request *req, struct virtblk_req *vbr)
>  {
>  	if (blk_rq_nr_phys_segments(req))
> @@ -243,6 +276,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	case REQ_OP_DRV_IN:
>  		type = VIRTIO_BLK_T_GET_ID;
>  		break;
> +	case REQ_OP_PROVISION:
> +		type = VIRTIO_BLK_T_PROVISION;
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
> @@ -256,6 +292,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  			return BLK_STS_RESOURCE;
>  	}
>  
> +	if (type == VIRTIO_BLK_T_PROVISION) {
> +		if (virtblk_setup_provision(req))
> +			return BLK_STS_RESOURCE;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1075,6 +1116,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_PROVISION)) {
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_provision_sectors, &v);
> +		q->limits.max_provision_sectors = v ? v : UINT_MAX;
> +	}
> +
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> @@ -1177,6 +1224,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +	VIRTIO_BLK_F_PROVISION,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..184f8cf6d185 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_PROVISION	15	/* provision is supported */
>  
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -120,6 +121,11 @@ struct virtio_blk_config {
>  	 */
>  	__u8 write_zeroes_may_unmap;
>  
> +	/*
> +	 * The maximum number of sectors in a provision request.
> +	 */
> +	__virtio32 max_provision_sectors;
> +
>  	__u8 unused1[3];
>  } __attribute__((packed));
>  
> @@ -155,6 +161,9 @@ struct virtio_blk_config {
>  /* Write zeroes command */
>  #define VIRTIO_BLK_T_WRITE_ZEROES	13
>  
> +/* Provision command */
> +#define VIRTIO_BLK_T_PROVISION	14
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000


Feature bit has to be reserved in the virtio spec.
Pls do this through the virtio TC mailing list.

> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
