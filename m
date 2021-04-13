Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF2C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:34:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AC7613C7
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AC7613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C278884527;
	Tue, 13 Apr 2021 19:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZcbGDWdhb7U; Tue, 13 Apr 2021 19:34:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BC5B84525;
	Tue, 13 Apr 2021 19:34:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3430DC000B;
	Tue, 13 Apr 2021 19:34:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B844C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 137DF40604
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4uNR6fKkem7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:34:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0098840603
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618342485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUMDskTlMoyXG03Qzv2sJykQt3gDWIVCZXpcjseuLJI=;
 b=Uh9y5nWdWe5B8lKArAEWhcIyDYkpV6GR4utlHDQ43rekZOzX1sPb6vxLj9ua8W4fOE9l4u
 OM1IXRAJnKwUvMjJ8BIv1llUb8fVxi1xcvwYgdFZgUwp5QW+MH1sc6gw/l61AC2JlixcOe
 wOK+QRCa8ntKjqHura9Z+4qY3YJ5iUs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-jdZy_8-6NrifFBXwBqg7ew-1; Tue, 13 Apr 2021 15:34:44 -0400
X-MC-Unique: jdZy_8-6NrifFBXwBqg7ew-1
Received: by mail-wr1-f70.google.com with SMTP id w1so1023124wrm.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 12:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rUMDskTlMoyXG03Qzv2sJykQt3gDWIVCZXpcjseuLJI=;
 b=ThNybcp3hZZQ8UlSX/KJSsMSwwE9x93NuID0Fw4eVi87RFwqH7Cahv8uIa9zcWpl8O
 0TIVna8yZDJt4fX6GvkALfctk+9FFFKe7yHk12q8Rbyxc9RaxJixhiOMquiJz3z9oFrK
 fzVQbD+/rTNeDljQyX+IjX9KOw7iVdKhQwqa8Vb6GdqIeO3URY/sEjnEAfWShmb/ahdf
 fh92RW66Pmi0/fslmx5VREJG6qmG6D/PZaWOFUhPw19RlKyaOW3rZAQGP4O/vLJKUNf7
 N02u8c9YU3DnZR9jwlLSVf8qQBrwe85mCagRAhYPdVrgnIU0MJykMglDHgz2r1SbMxje
 0wJg==
X-Gm-Message-State: AOAM531sdY6xbdRizyv6TY8WjDEK1Ja0wAxoqxS/Who49hchtLa0i4iJ
 SFLj6tTEKrJEFEgRPk32qdJP2WZbsx5qMFCAKTOc6969hvr7kCGg1iBRqO6f80YLcugQWwMLCCm
 AJkJHQWqcK5CeltSp9DV8MXy2FPxyxzqEgtaD3OPSEQ==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr1440602wmb.183.1618342482959; 
 Tue, 13 Apr 2021 12:34:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZbArAc+T8QG6nMuGSbTU709+g9JEWWp4LeRlXInp+dBjh991nnHPKXLmKpQOGky2lgU6niQ==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr1440589wmb.183.1618342482730; 
 Tue, 13 Apr 2021 12:34:42 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id h2sm3431632wmc.24.2021.04.13.12.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 12:34:41 -0700 (PDT)
Date: Tue, 13 Apr 2021 15:34:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v3 5/5] virtio-net: keep tx interrupts disabled
 unless kick
Message-ID: <20210413153023-mutt-send-email-mst@kernel.org>
References: <20170424174930.82623-1-willemdebruijn.kernel@gmail.com>
 <20170424174930.82623-6-willemdebruijn.kernel@gmail.com>
 <20210413010354-mutt-send-email-mst@kernel.org>
 <CA+FuTSe_iy=vDze=MSca1iRJX+WR=PjG-HoFZ2GBpFaCxE33Fg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSe_iy=vDze=MSca1iRJX+WR=PjG-HoFZ2GBpFaCxE33Fg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
 David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
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

On Tue, Apr 13, 2021 at 10:27:16AM -0400, Willem de Bruijn wrote:
> On Tue, Apr 13, 2021 at 1:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Apr 24, 2017 at 01:49:30PM -0400, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > Tx napi mode increases the rate of transmit interrupts. Suppress some
> > > by masking interrupts while more packets are expected. The interrupts
> > > will be reenabled before the last packet is sent.
> > >
> > > This optimization reduces the througput drop with tx napi for
> > > unidirectional flows such as UDP_STREAM that do not benefit from
> > > cleaning tx completions in the the receive napi handler.
> > >
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  drivers/net/virtio_net.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 9dd978f34c1f..003143835766 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1200,6 +1200,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >       /* Free up any pending old buffers before queueing new ones. */
> > >       free_old_xmit_skbs(sq);
> > >
> > > +     if (use_napi && kick)
> > > +             virtqueue_enable_cb_delayed(sq->vq);
> > > +
> > >       /* timestamp packet in software */
> > >       skb_tx_timestamp(skb);
> >
> >
> > I have been poking at this code today and I noticed that is
> > actually does enable cb where the commit log says masking interrupts.
> > I think the reason is that with even index previously disable cb
> > actually did nothing while virtqueue_enable_cb_delayed pushed
> > the event index out some more.
> > And this likely explains why it does not work well for packed,
> > where virtqueue_enable_cb_delayed is same as virtqueue_enable_cb.
> >
> > Right? Or did I miss something?
> 
> This was definitely based on the split queue with event index handling.
> 
> When you say does not work well for packed, you mean that with packed
> mode we see the consequences of the race condition when accessing vq
> without holding __netif_tx_lock, in a way that I did not notice with
> split queue with event index, right?

I mean curretly packed does not seem to show same performance gains as
a micro-benchmark. Could be due to enabling interrupts more aggressively
there.

> Thanks for looking into this and proposing fixes for this issue and the
> known other spurious tx interrupt issue.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
