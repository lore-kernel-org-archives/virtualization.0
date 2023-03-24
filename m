Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF387C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84B2082120;
	Fri, 24 Mar 2023 06:37:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84B2082120
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QAIVFX+z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rb3EXOr7HfGd; Fri, 24 Mar 2023 06:37:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 174A48200C;
	Fri, 24 Mar 2023 06:37:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 174A48200C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9AA1C0035;
	Fri, 24 Mar 2023 06:37:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72F6AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A4D840236
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:37:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A4D840236
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QAIVFX+z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W_gIDyIFAtK3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:37:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67DD0401AD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67DD0401AD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679639833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTHEkG0veS3WOnmD1zcIed5zrYB8TJOmsb7HBmnzkgQ=;
 b=QAIVFX+zSTqhCOV3EMEb9LLacgtxRLWpoDp7vZZwUzetrv7ac8j4HJR10DshLuZ0msMlIZ
 4RJBxUvk9nj9TXUsUaXRLdvC/H9kLRTBTdbZj+0FV36QyFJKhrFMqIrFJowGRgtVNjbMsL
 2n6QgMw0qCJU3UScZtfJYPO/Erct+o4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-qNr8d1OJMG2PNTrdqPe-Aw-1; Fri, 24 Mar 2023 02:37:11 -0400
X-MC-Unique: qNr8d1OJMG2PNTrdqPe-Aw-1
Received: by mail-wm1-f70.google.com with SMTP id
 m27-20020a05600c3b1b00b003ee502f1b16so538559wms.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 23:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679639830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTHEkG0veS3WOnmD1zcIed5zrYB8TJOmsb7HBmnzkgQ=;
 b=WY24MtpmBOMkWD/njqD+kdUMgnhoB5BXBrvyP3wK//empf2Fbfytag7qTAANg9qQAc
 FSKsbEIhCun1Z2n4dNUa1Y8LWBlIKARE9zcdEZVGUISAgJBwc4RD6J/pwAdtC0FYMVms
 7xI0fj4P9j3z0jLR1BWbj9eDrfdZoE9juVmcrpQ6FAZr6PPgYa+cF7fai2HMKFvhfJTQ
 Mf4PO5G2zGof+Acw+xUqOft4I7Frah836WxFvoax4Ms+rSljSlj5VzOmxrs+Mejxp//Y
 lrwaX45qNy6WebAi/gybK6z6Vd1mG/rCNE9cs4ZlENqZxHUuCVQ59HWY+QG3LVAIjw3m
 wWlA==
X-Gm-Message-State: AO0yUKUcZK7pFTPr2MZpe2R3ny80kkenu3ONChxWzk/+rracPfbEl1Yl
 YbSgRP1+MwG2TEHr3U1Jtd6aK3cfVFT6sh/XZPGqRJG3iFohXvuL2Bp+Gsj+/Tda5RbFweZPXqq
 pXT1i9ixPvyzWW7N18OvG5becOxN/UKlZv8kJHmmHNQ==
X-Received: by 2002:a05:600c:285:b0:3ee:e978:51d8 with SMTP id
 5-20020a05600c028500b003eee97851d8mr1309965wmk.16.1679639830158; 
 Thu, 23 Mar 2023 23:37:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set9jCSGKCzz7i9696EMOlfmBSZxXJ+g69JqLl6rKpJZbW2idUaifH/ggXl2FMWciUlQ+Ph+YNA==
X-Received: by 2002:a05:600c:285:b0:3ee:e978:51d8 with SMTP id
 5-20020a05600c028500b003eee97851d8mr1309954wmk.16.1679639829854; 
 Thu, 23 Mar 2023 23:37:09 -0700 (PDT)
Received: from redhat.com ([2.52.12.190]) by smtp.gmail.com with ESMTPSA id
 o15-20020a1c750f000000b003ee1acdb036sm3954941wmc.17.2023.03.23.23.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 23:37:09 -0700 (PDT)
Date: Fri, 24 Mar 2023 02:37:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [PATCH] virtio_ring: Suppress tx interrupt when napi_tx disable
Message-ID: <20230324023552-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <20230324015954-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230324015954-mutt-send-email-mst@kernel.org>
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

Hmm I sent a bit too fast, and my testing rig is down now.
So please do send a new version, I sent comments on what to fix
in this one.

On Fri, Mar 24, 2023 at 02:08:55AM -0400, Michael S. Tsirkin wrote:
> Thanks for the patch!
> I picked it up.
> I made small changes, please look at it in my branch,
> both to see what I changed for your next submission,
> and to test that it still addresses the problem for you.
> Waiting for your confirmation to send upstream.
> Thanks!
> 
> 
> On Tue, Mar 21, 2023 at 04:59:53PM +0800, Albert Huang wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > 
> > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > 
> > if we disable the napi_tx. when we triger a tx interrupt, the
> > vq->event_triggered will be set to true. It will no longer be
> > set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> > or virtqueue_enable_cb_prepare
> > 
> > if we disable the napi_tx, It will only be called when the tx ring
> > buffer is relatively small:
> > virtio_net->start_xmit:
> > 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > 		netif_stop_subqueue(dev, qnum);
> > 		if (!use_napi &&
> > 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > 			/* More just got used, free them then recheck. */
> > 			free_old_xmit_skbs(sq, false);
> > 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > 				netif_start_subqueue(dev, qnum);
> > 				virtqueue_disable_cb(sq->vq);
> > 			}
> > 		}
> > 	}
> > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > every time we call virtqueue_get_buf_ctx.This will bring more interruptions.
> > 
> > if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
> > or vq->packed.vring.driver->off_wrap
> > 
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 307e139cb11d..f486cccadbeb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >  	/* If we expect an interrupt for the next entry, tell host
> >  	 * by writing event index and flush out the write before
> >  	 * the read in the next get_buf call. */
> > -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > +	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> > +			&& (vq->event_triggered == false))
> >  		virtio_store_mb(vq->weak_barriers,
> >  				&vring_used_event(&vq->split.vring),
> >  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	 * by writing event index and flush out the write before
> >  	 * the read in the next get_buf call.
> >  	 */
> > -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > +	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
> > +			&& (vq->event_triggered == false))
> >  		virtio_store_mb(vq->weak_barriers,
> >  				&vq->packed.vring.driver->off_wrap,
> >  				cpu_to_le16(vq->last_used_idx));
> > -- 
> > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
