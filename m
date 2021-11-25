Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB43CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6995A4019B;
	Thu, 25 Nov 2021 07:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pToOJl1I30bp; Thu, 25 Nov 2021 07:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B145140018;
	Thu, 25 Nov 2021 07:15:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 861F3C002F;
	Thu, 25 Nov 2021 07:15:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 494B6C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 248CC80DF5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zx0H18DomH2V
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 659C480DE9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637824511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrdfoJuoyuNHgO43HGDwB7KWOWfQOVP7BNUczbuAPp8=;
 b=Csn6QAYanCT42bmVAwdUJmnnmPcCqfb4/x+R8tiF+ct0GfPqtVLv0XtuDxoYxp8rUj21pU
 poP3aW5oOuPnuuwye9Ozd9ng6z2IeeJQSx35kBfD2gCUf235rYuPzBsC1T0jr6nVdK9dfQ
 qs2eRx6Wpl95dhyOJcLtQJpf8M98nlU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-1lOk5a_9PDGSkWRsifrLFw-1; Thu, 25 Nov 2021 02:15:10 -0500
X-MC-Unique: 1lOk5a_9PDGSkWRsifrLFw-1
Received: by mail-ed1-f70.google.com with SMTP id
 v9-20020a50d849000000b003dcb31eabaaso4653335edj.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DrdfoJuoyuNHgO43HGDwB7KWOWfQOVP7BNUczbuAPp8=;
 b=xYvZNUYZSwf+Z6YzxGNUA0N+nOXdu8GxrH/fK9AvGMbLRvABP2ZGRqZE4bded4wm71
 qiYk0T2Pu/yHNbMcSTM5lqTixD0xZwD51kexpon/r0i+AYr33w2bNCwpXJ5sfjLHG+D/
 QY4Oe4QovDXl+hHh0MS58gL+A6ywvPgm2st9C/CAV7pxXoh/YOX9XfJ82ADoRKcmo3S3
 gvQQ3A7If9TPcevsaUvvwbx2P32dxR+SwzgDnSz/dTA/TGj8ySnIRJsi+vgOaF6htZO2
 BT7Rl1Gwyu4+yZFn+wapBpUmNTmfyQLfYIlv/z95gIhJlalIKaa3mlR/KVEmWitGviua
 3Txg==
X-Gm-Message-State: AOAM5323nFJ5bD6Pu1FKNy46FoIv8EVX/pStEorNRoZ5+gfc9OtLaTi+
 H92TOwd0h0hQ7j4qaw0cXjlob7sOTZneCx5fvGmyaVKlVCt86kHEwB4DywWp1iy//iYd6ufC+Br
 ZoQjjbvW1ieBRize8DMLWFBO3KpnKvOOGuhU+w+ltDQ==
X-Received: by 2002:a05:6402:3496:: with SMTP id
 v22mr34843224edc.177.1637824508931; 
 Wed, 24 Nov 2021 23:15:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT4Ux6nJrzHTTYycQkkUo3yCguo+1d6EF1/y5nPdIGUEaoov9qqpPkw+eeVpNdKNDvLUtBeA==
X-Received: by 2002:a05:6402:3496:: with SMTP id
 v22mr34843190edc.177.1637824508772; 
 Wed, 24 Nov 2021 23:15:08 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id m15sm1281606edl.22.2021.11.24.23.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 23:14:55 -0800 (PST)
Date: Thu, 25 Nov 2021 02:14:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125021308-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > large max_mtu. In this case, using small packet mode is not correct
> > > since it may breaks the networking when MTU is grater than
> > > ETH_DATA_LEN.
> > >
> > > To have a quick fix, simply enable the big packet mode when
> > > VIRTIO_NET_F_MTU is not negotiated.
> >
> > This will slow down dpdk hosts which disable mergeable buffers
> > and send standard MTU sized packets.
> >
> > > We can do optimization on top.
> >
> > I don't think it works like this, increasing mtu
> > from guest >4k never worked,
> 
> Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.

OK, even more so then.

> > we can't regress everyone's
> > performance with a promise to maybe sometime bring it back.
> 
> So consider it never work before I wonder if we can assume a 1500 as
> max_mtu value instead of simply using MAX_MTU?
> 
> Thanks

You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?
Maybe ... it will prevent sending large packets which did work ...
I'd tread carefully here, and I don't think this kind of thing is net
material.

> >
> > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > Cc: Eli Cohen <elic@nvidia.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > ---
> > >  drivers/net/virtio_net.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               dev->mtu = mtu;
> > >               dev->max_mtu = mtu;
> > >
> > > -             /* TODO: size buffers correctly in this case. */
> > > -             if (dev->mtu > ETH_DATA_LEN)
> > > -                     vi->big_packets = true;
> > >       }
> > >
> > > +     /* TODO: size buffers correctly in this case. */
> > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > +             vi->big_packets = true;
> > > +
> > >       if (vi->any_header_sg)
> > >               dev->needed_headroom = vi->hdr_len;
> > >
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
