Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCC4C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5663640248;
	Thu, 25 Nov 2021 07:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygHzIEDHpvTP; Thu, 25 Nov 2021 07:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1E3740018;
	Thu, 25 Nov 2021 07:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73AA0C002F;
	Thu, 25 Nov 2021 07:28:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 662BAC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 307164021F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_Aiok3Q3Y-O
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:28:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28B7340018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637825326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAYyix8FJ3fNIZWmvJGEU4BGlkJhgJqUuDlAboJ19Kw=;
 b=cjGAQ7X3lJTjnQMAMPPC0uMAVZk9Oeh0Lw3QfRNXywxgyLksNtXIrNz+Y4NQ/Nvhp5zbMg
 /yED+1ea/d8oS6aJE04vAHITpK/0iyFivmHd2RXRWJ5CP7jcmV1PH4RRlkAnAPHDv3BpH/
 kVdEil/4JkG6ETnqCm6gRUPpakwtsds=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-Ep-k_9ZQORG7amDjjwdUbw-1; Thu, 25 Nov 2021 02:28:44 -0500
X-MC-Unique: Ep-k_9ZQORG7amDjjwdUbw-1
Received: by mail-lf1-f69.google.com with SMTP id
 q26-20020ac2515a000000b0040adfeb8132so2772479lfd.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KAYyix8FJ3fNIZWmvJGEU4BGlkJhgJqUuDlAboJ19Kw=;
 b=D6b4yQElCTwf8hJxmTBFuO4/F5ElqduGM+U950le0y3XDfbMrzGkqQ61opA3I5Zst5
 WByaQrOVtddO8dzVU/TT8iFiugeDSyjpd0Fv+3d4OFmvkwP8FyqWdj+pJ06q1Rqq2xcL
 VRx4fZzpwZmfulVpPAnRH3RQyct1L0wH6yNBvhrnso1frmA1ZR/w43I+YEzqCx+YNjY8
 B8Qpnp5g8K2FWl/sgeMFke1ON6pg3H3mCZOLJc1lwhyuzR5jHX/JT07HTViyvdTb/BPU
 NCQo3H3hT7u4CIqwOvx09jZqC3lJFlTlkfBx1Kb1cDTJlK7o3rLaOyiV23NNer/lOdyo
 mr/w==
X-Gm-Message-State: AOAM5326fCAdqqiuStWE6Cj+VZXAMZHNyTwu8HhNBgSYB++t1LKMBxKW
 UyV3f411N3HCjQsH+Opa/bIqBAM2ryEsUCWmL0gWb4kCNWYdskGCg9rFqsbesU6ovFGIbKEbc+n
 Pd4Jyh00e5ZvV3K5L3lLjB34T8wnVh1t7fKR1hwMwrEK1FJG6+ywL/HIDAw==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr22375080lfh.580.1637825323081; 
 Wed, 24 Nov 2021 23:28:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR0Oj+HYVWJiKnMqDcsVDTqq/srl4I6uPRZ9iNPuv2p0Bkt1dEPXaslgNkp/hh9kpZ3ybmiGxzpKXdjayduxU=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr22375068lfh.580.1637825322885; 
 Wed, 24 Nov 2021 23:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
 <20211125021308-mutt-send-email-mst@kernel.org>
 <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
 <20211125022442-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211125022442-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 15:28:31 +0800
Message-ID: <CACGkMEuos9tVSvrwXxTmh1v5WDYy9mpCagr+mrubY3bSCTBS2A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Nov 25, 2021 at 3:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 25, 2021 at 03:20:07PM +0800, Jason Wang wrote:
> > On Thu, Nov 25, 2021 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> > > > On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > > > large max_mtu. In this case, using small packet mode is not correct
> > > > > > since it may breaks the networking when MTU is grater than
> > > > > > ETH_DATA_LEN.
> > > > > >
> > > > > > To have a quick fix, simply enable the big packet mode when
> > > > > > VIRTIO_NET_F_MTU is not negotiated.
> > > > >
> > > > > This will slow down dpdk hosts which disable mergeable buffers
> > > > > and send standard MTU sized packets.
> > > > >
> > > > > > We can do optimization on top.
> > > > >
> > > > > I don't think it works like this, increasing mtu
> > > > > from guest >4k never worked,
> > > >
> > > > Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.
> > >
> > > OK, even more so then.
> > >
> > > > > we can't regress everyone's
> > > > > performance with a promise to maybe sometime bring it back.
> > > >
> > > > So consider it never work before I wonder if we can assume a 1500 as
> > > > max_mtu value instead of simply using MAX_MTU?
> > > >
> > > > Thanks
> > >
> > > You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?
> >
> > Yes, or fix the issue to let large packets on RX work (e.g as the TODO
> > said, size the buffer: for <=4K mtu continue to work as
> > add_recvbuf_small(), for >= 4K switch to use big).
>
> Right. The difficulty is with changing modes, current code isn't
> designed for it.

I think it might work if we reset the device during the mode change.

Thanks

>
> > > Maybe ... it will prevent sending large packets which did work ...
> >
> > Yes, but it's strange to allow TX but not RX
> >
> > > I'd tread carefully here, and I don't think this kind of thing is net
> > > material.
> >
> > I agree consider it can't be fixed easily.
> >
> > Thanks
> >
> > >
> > > > >
> > > > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > >               dev->mtu = mtu;
> > > > > >               dev->max_mtu = mtu;
> > > > > >
> > > > > > -             /* TODO: size buffers correctly in this case. */
> > > > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > > > -                     vi->big_packets = true;
> > > > > >       }
> > > > > >
> > > > > > +     /* TODO: size buffers correctly in this case. */
> > > > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > > > +             vi->big_packets = true;
> > > > > > +
> > > > > >       if (vi->any_header_sg)
> > > > > >               dev->needed_headroom = vi->hdr_len;
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
