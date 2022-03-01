Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788F2C433F5
	for <virtualization@archiver.kernel.org>; Tue,  1 Mar 2022 15:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AF9D60E5A;
	Tue,  1 Mar 2022 15:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NqyV0SHS28y; Tue,  1 Mar 2022 15:43:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 83CEE605A0;
	Tue,  1 Mar 2022 15:43:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59BA5C0077;
	Tue,  1 Mar 2022 15:43:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1FF3C001A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 15:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9AC2560B2D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 15:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ei0-TBYzp7Am
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 15:43:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2450605A0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646149393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zi/rF6ZbstmVPPcLyO+lYHA/xLDgWYDmluRIslmEBwo=;
 b=UYavwnBf64MszjRAMIuiGMaj8lDjjCnSXRlLHYUMVDsNBtxEB+H8MxJQLS/S0lq8wkF8aq
 ouKmvwT+iO3xpTXoc0byfymDVtZPieXDgWV9TEr1G5TV2k/jIgt08OU8D+xjPTm8NAASEp
 LuuC3lcQGVeoipCPCpF2r5CRljVq/xA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-E5LZgNk7ORue8Zq9gui5WA-1; Tue, 01 Mar 2022 10:43:12 -0500
X-MC-Unique: E5LZgNk7ORue8Zq9gui5WA-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay7-20020a05600c1e0700b003813d7a7d03so1394587wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Mar 2022 07:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zi/rF6ZbstmVPPcLyO+lYHA/xLDgWYDmluRIslmEBwo=;
 b=IOmUjvcvrtqFUCWzvE4oanpZUmYyLp0B6p4qk6VwJgde5TDmeBjayBPuNloYqDXb+G
 7ozp41BqP22wEyXyJ0g/rRePVS8r+IwOVuME0Op33nqqDxnRu1olNqVJaNxOwLZj5nOt
 gF3rJDGIIKFYKD15zBJvySXYvLEejbX/BCk/gwq9Kx2lDH561pr/i715P508cPdyOm2r
 34LPiCrNakpPdcjwa+J28foDtei7Qb1R+9vvaxDTaTU+EeUGoERojsFS2QbiMcb7e/57
 ZR1QbHi4c1olOUZswi0yTg9D36nBFslkGPbtktlHN9vupyZODRsHcwfL2l0XkVE2AaiY
 w5yA==
X-Gm-Message-State: AOAM530vX6dzKphfdQduikdo49T9Ev1tHx1yKpSKK7EZtwU6JfL9ax2Y
 2BDea1bcWB2ywTgRtGtAhjaijaq3v1xheLcf1X+vNoEbXCtyJconrxt5uRqbp5zTPBA5snmwiic
 WLHhhq+PKstjTAR9APH912UVzfadiwOeHINGgvLsKZQ==
X-Received: by 2002:a5d:4578:0:b0:1ed:bf30:40f3 with SMTP id
 a24-20020a5d4578000000b001edbf3040f3mr20424544wrc.669.1646149391305; 
 Tue, 01 Mar 2022 07:43:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRUwQD1hJ1u91M2fQsU2xg9R4HN5NlawjsdCEJ846aEK4fDF9wmsyllywQDwwFcvuwBhdJCQ==
X-Received: by 2002:a5d:4578:0:b0:1ed:bf30:40f3 with SMTP id
 a24-20020a5d4578000000b001edbf3040f3mr20424527wrc.669.1646149391064; 
 Tue, 01 Mar 2022 07:43:11 -0800 (PST)
Received: from redhat.com ([2.53.2.184]) by smtp.gmail.com with ESMTPSA id
 m62-20020a1c2641000000b00380d0cff5f3sm2966744wmm.8.2022.03.01.07.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Mar 2022 07:43:10 -0800 (PST)
Date: Tue, 1 Mar 2022 10:43:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220301104039-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220228065720.100-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> Currently we have a BUG_ON() to make sure the number of sg
> list does not exceed queue_max_segments() in virtio_queue_rq().
> However, the block layer uses queue_max_discard_segments()
> instead of queue_max_segments() to limit the sg list for
> discard requests. So the BUG_ON() might be triggered if
> virtio-blk device reports a larger value for max discard
> segment than queue_max_segments().

Hmm the spec does not say what should happen if max_discard_seg
exceeds seg_max. Is this the config you have in mind? how do you
create it?

> To fix it, let's simply
> remove the BUG_ON() which has become unnecessary after commit
> 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
> And the unused vblk->sg_elems can also be removed together.
> 
> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/block/virtio_blk.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b..a43eb1813cec 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -76,9 +76,6 @@ struct virtio_blk {
>  	 */
>  	refcount_t refs;
>  
> -	/* What host tells us, plus 2 for header & tailer. */
> -	unsigned int sg_elems;
> -
>  	/* Ida index - used to track minor number allocations. */
>  	int index;
>  
> @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_status_t status;
>  	int err;
>  
> -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> -
>  	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>  	if (unlikely(status))
>  		return status;
> @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> -	/* We need extra sg elements at head and tail. */
> -	sg_elems += 2;
>  	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
>  	if (!vblk) {
>  		err = -ENOMEM;
> @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	mutex_init(&vblk->vdev_mutex);
>  
>  	vblk->vdev = vdev;
> -	vblk->sg_elems = sg_elems;
>  
>  	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
>  
> @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		set_disk_ro(vblk->disk, 1);
>  
>  	/* We can handle whatever the host told us to handle. */
> -	blk_queue_max_segments(q, vblk->sg_elems-2);
> +	blk_queue_max_segments(q, sg_elems);
>  
>  	/* No real sector limit. */
>  	blk_queue_max_hw_sectors(q, -1U);
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
