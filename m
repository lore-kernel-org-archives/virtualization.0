Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27307C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FEA240179;
	Fri, 24 Mar 2023 06:09:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FEA240179
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VtAxFvQK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kFfW601UPVpJ; Fri, 24 Mar 2023 06:09:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 212F0401AD;
	Fri, 24 Mar 2023 06:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 212F0401AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05372C0071;
	Fri, 24 Mar 2023 06:09:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59BFEC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E00982138
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:09:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E00982138
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VtAxFvQK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Po1CRnVJoapd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:08:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7C8882118
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7C8882118
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679638138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GaaEY4H15KWNoSziTd+hgiA9Y9SMayy770FfjBkX9Cg=;
 b=VtAxFvQKm8vVnimEr+SegPyXXXWwvb1UDZwl8faOxdMue6k930C7L6RWLGOqbdlAvylWeD
 UszLYi5+drZ/YKV7VnL6p3yzLVc2cAldp36fMOSghQ0E78WSmb0uOv8/gTD4bwacaT1Vv7
 +4plSJ4irt1V8rHuArh7acM5xHjgqzQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-fV1wteN7N72v6dQNS804OA-1; Fri, 24 Mar 2023 02:08:57 -0400
X-MC-Unique: fV1wteN7N72v6dQNS804OA-1
Received: by mail-wm1-f69.google.com with SMTP id
 u6-20020a05600c19c600b003ed7cb98a8dso319232wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 23:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679638136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GaaEY4H15KWNoSziTd+hgiA9Y9SMayy770FfjBkX9Cg=;
 b=Ld5pEeNmOJpXqiPyfoSN8hfiOjPAa/NTjspjLbs5wO/EGhCoHeY2A/inpi9zrD90ev
 J4rjlMwoKk/wrH6Sb12+gm2QSQiWNOyiFRwzVieQHd5bjSweRiJ/u2auDxFOwSVe0Hrq
 no6OCzsFueb3Xws5j0Dght2TIzcQRNbJdc9AndrZ0gyoMflMpqe+A9yYBQ6WsrQauSvD
 PxDo8l4gDjOwX4wvtYiu3G3blV0H1Tik0IKkXP/S4HgNWWHFRvusDkhTi596SQ00k2uQ
 KUrqxAfR61yy/5xgtluMzfoIp6xMhpwkkvoobvtIXRAo+kv+f1Q5kyg2ZrSNPj9sseFZ
 xDsg==
X-Gm-Message-State: AAQBX9ewt4v55jKer9nXrIx0bNKAtBWDNjbO7J3uvid1WgwSEKmnxwft
 TvdhtlNvZo33deQlBhXBIdNBRSpdj6pNwn+aO50KF/HbyM2G/Z0tVqDcgXTqkBi2BgsZNkN4Jw5
 La/ONe5Zz/N42ZyrzZsQwIPHTZ9GpeGoq+NN4oA5FAQ==
X-Received: by 2002:adf:f8d2:0:b0:2d7:452f:79ec with SMTP id
 f18-20020adff8d2000000b002d7452f79ecmr1004812wrq.7.1679638136114; 
 Thu, 23 Mar 2023 23:08:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zte+yhwOuXp0n1DsXAlkdtZgqKOrWQD5KEI1UhnnB0Txz009uzHbrWUXvpfB2oH3nVFUeNQQ==
X-Received: by 2002:adf:f8d2:0:b0:2d7:452f:79ec with SMTP id
 f18-20020adff8d2000000b002d7452f79ecmr1004799wrq.7.1679638135745; 
 Thu, 23 Mar 2023 23:08:55 -0700 (PDT)
Received: from redhat.com ([2.52.12.190]) by smtp.gmail.com with ESMTPSA id
 p14-20020a5d48ce000000b002d45575643esm15608669wrs.43.2023.03.23.23.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 23:08:55 -0700 (PDT)
Date: Fri, 24 Mar 2023 02:08:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [PATCH] virtio_ring: Suppress tx interrupt when napi_tx disable
Message-ID: <20230324015954-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230321085953.24949-1-huangjie.albert@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

Thanks for the patch!
I picked it up.
I made small changes, please look at it in my branch,
both to see what I changed for your next submission,
and to test that it still addresses the problem for you.
Waiting for your confirmation to send upstream.
Thanks!


On Tue, Mar 21, 2023 at 04:59:53PM +0800, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> 
> if we disable the napi_tx. when we triger a tx interrupt, the
> vq->event_triggered will be set to true. It will no longer be
> set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> or virtqueue_enable_cb_prepare
> 
> if we disable the napi_tx, It will only be called when the tx ring
> buffer is relatively small:
> virtio_net->start_xmit:
> 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> 		netif_stop_subqueue(dev, qnum);
> 		if (!use_napi &&
> 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> 			/* More just got used, free them then recheck. */
> 			free_old_xmit_skbs(sq, false);
> 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> 				netif_start_subqueue(dev, qnum);
> 				virtqueue_disable_cb(sq->vq);
> 			}
> 		}
> 	}
> Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This will bring more interruptions.
> 
> if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
> or vq->packed.vring.driver->off_wrap
> 
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 307e139cb11d..f486cccadbeb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> +			&& (vq->event_triggered == false))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
>  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call.
>  	 */
> -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> +	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
> +			&& (vq->event_triggered == false))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
>  				cpu_to_le16(vq->last_used_idx));
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
