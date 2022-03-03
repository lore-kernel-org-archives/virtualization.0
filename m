Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB0C433EF
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 07:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F30B2415CD;
	Thu,  3 Mar 2022 07:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gRFq9_8sKeiq; Thu,  3 Mar 2022 07:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D773415C6;
	Thu,  3 Mar 2022 07:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6502AC0012;
	Thu,  3 Mar 2022 07:22:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5957BC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4779184107
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xejhlsE28-I
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 731AA813E4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646292147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDFPItTCDUnDzD48ZKfCOgOAERl5mtbUoXGLlNyuCC8=;
 b=WbDb3Y4QNXrqCeesJgyWXPmdO7kTWq+4DbPvWPnvnoo4fKnSHWIG5zAt73Gp87oFAcBcRG
 gkv3u/FHgTH5rmARWfeQ6kGz32xXmp9RLq8V7NrbAv+dEZP6+ui6UZCylUnTcFDMLTqPGY
 T60fF3pnoZWQPZ4tw8Wz9dsGdhKN5a0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-6v2q-u_9OzCRRUFDMhZDig-1; Thu, 03 Mar 2022 02:22:26 -0500
X-MC-Unique: 6v2q-u_9OzCRRUFDMhZDig-1
Received: by mail-wr1-f72.google.com with SMTP id
 a5-20020adfdd05000000b001f023fe32ffso1665853wrm.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 23:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CDFPItTCDUnDzD48ZKfCOgOAERl5mtbUoXGLlNyuCC8=;
 b=48l1faCXCEN5Yp9jc8J5q3jmUDpiIkFBwUhoXOlaI9ieY64Z18UIDvSriFnMWH5a4i
 rBQsoh70nQahVpLxg90mz821Cj4p6/afVwfxYx4fvHi7G10Sf9AUUhVx1fhIJR70GwEu
 RCwyW0PjG/UdZTOXqpsF+1Xwy0FqnuItNt6U7/ZoWLaakXBQmjf78se1xcMgu6GpmOw+
 vx0k0feBhJxhi1kb3oZg+0DkY1sFZj6UQAeILe/cGmNBtV9u7eWd893a+tEoRxs0tPwE
 hYplBC7mcHVd16jAwNaXxCRgnVY8qAqh3rePKgf8R4B5YGxDkJozyP6VlvdspvI9RrOH
 SDOA==
X-Gm-Message-State: AOAM530Xg80YLHzW7EHhuCGACoaD1nw55gCA+pAwd4K6d13CtFDWCNAW
 Rlv/lZS2EMJ8tS20cAYCgBhTBLcTJ7Ek1iAqLqvjlKU8iOgM5zVN2Iie9sFv8LMb+3/aJziPU0c
 BDwwVfHgJRUO6Tadq6QbFp4gFtzkvJ6GLTOSI6aav/g==
X-Received: by 2002:a5d:64af:0:b0:1ef:6070:2297 with SMTP id
 m15-20020a5d64af000000b001ef60702297mr21871842wrp.609.1646292145138; 
 Wed, 02 Mar 2022 23:22:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDOWNrHymY+lG7AWIGKBnT14vPEi71FuUfqXiT0gn+BMNgMa2PgpV650Wbvx5TV+C1spWR5g==
X-Received: by 2002:a5d:64af:0:b0:1ef:6070:2297 with SMTP id
 m15-20020a5d64af000000b001ef60702297mr21871826wrp.609.1646292144926; 
 Wed, 02 Mar 2022 23:22:24 -0800 (PST)
Received: from redhat.com ([2.55.143.133]) by smtp.gmail.com with ESMTPSA id
 k15-20020adff5cf000000b001e4b8fde355sm1128053wrp.73.2022.03.02.23.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 23:22:24 -0800 (PST)
Date: Thu, 3 Mar 2022 02:22:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220303021637-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
 <20220302081017-mutt-send-email-mst@kernel.org>
 <8fa47a28-a974-4478-23b6-aea14355a315@nvidia.com>
 <CACycT3ubdASWTW3UN4Wxg2iYnXRaMkrfHty0p6h1E0EYPF82Yw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3ubdASWTW3UN4Wxg2iYnXRaMkrfHty0p6h1E0EYPF82Yw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org
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

On Thu, Mar 03, 2022 at 11:31:35AM +0800, Yongji Xie wrote:
> On Wed, Mar 2, 2022 at 11:05 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >
> >
> > On 3/2/2022 3:15 PM, Michael S. Tsirkin wrote:
> > > On Wed, Mar 02, 2022 at 06:46:03PM +0800, Yongji Xie wrote:
> > >> On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > >>>> Currently we have a BUG_ON() to make sure the number of sg
> > >>>> list does not exceed queue_max_segments() in virtio_queue_rq().
> > >>>> However, the block layer uses queue_max_discard_segments()
> > >>>> instead of queue_max_segments() to limit the sg list for
> > >>>> discard requests. So the BUG_ON() might be triggered if
> > >>>> virtio-blk device reports a larger value for max discard
> > >>>> segment than queue_max_segments().
> > >>> Hmm the spec does not say what should happen if max_discard_seg
> > >>> exceeds seg_max. Is this the config you have in mind? how do you
> > >>> create it?
> > >>>
> > >> One example: the device doesn't specify the value of max_discard_seg
> > >> in the config space, then the virtio-blk driver will use
> > >> MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
> > >> BUG_ON() if the seg_max is less than 256.
> > >>
> > >> While the spec didn't say what should happen if max_discard_seg
> > >> exceeds seg_max, it also doesn't explicitly prohibit this
> > >> configuration. So I think we should at least not panic the kernel in
> > >> this case.
> > >>
> > >> Thanks,
> > >> Yongji
> > > Oh that last one sounds like a bug, I think it should be
> > > min(MAX_DISCARD_SEGMENTS, seg_max)
> > >
> > > When max_discard_seg and seg_max both exist, that's a different question. We can
> > > - do min(max_discard_seg, seg_max)
> > > - fail probe
> > > - clear the relevant feature flag
> > >
> > > I feel we need a better plan than submitting an invalid request to device.
> >
> > We should cover only for a buggy devices.
> >
> > The situation that max_discard_seg > seg_max should be fine.
> >
> > Thus the bellow can be added to this patch:
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index c443cd64fc9b..3e372b97fe10 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -926,8 +926,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> >                  virtio_cread(vdev, struct virtio_blk_config,
> > max_discard_seg,
> >                               &v);
> >                  blk_queue_max_discard_segments(q,
> > -                                              min_not_zero(v,
> > - MAX_DISCARD_SEGMENTS));
> > +                                              min_t(u32, (v ? v :
> > sg_elems),
> > + MAX_DISCARD_SEGMENTS));
> >
> >                  blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> >          }
> >
> >
> 
> LGTM, I can add this in v3.
> 
> Thanks,
> Yongji

Except the logic is convoluted then.  I would instead add

	/* max_seg == 0 is out of spec but we always handled it */
	if (!v)
		v = sg_elems;


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
