Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460DCC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 08:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DACDB80C93;
	Thu, 25 Nov 2021 08:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e3N1vYjevxHB; Thu, 25 Nov 2021 08:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 705DF80C95;
	Thu, 25 Nov 2021 08:13:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DDF7C001C;
	Thu, 25 Nov 2021 08:13:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36F1AC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 247CA40201
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kpb0avWJYool
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:13:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54C32401BC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637828025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZ+thzQkg6Cdn1OMX5Cx+TOEBd23whOs+wYTt44V+WM=;
 b=O3n5AJXKa0GyspCmaCRr9gxdIdx7pcpJ/vAtu1brtklMZ62Mz1a/3TYTdvAJasFSp93JKi
 ZhlLpIRuNSxDuLxeIefCc3O8cc2PLLeXXDDE3VajNPcWr/yj9HKXeDlLLryQZyfL07JZya
 PeTBSZxS+nLiLV6QtjQn3mfkZaAVmkY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-8t4YwMEmMBmenGjL976h7Q-1; Thu, 25 Nov 2021 03:13:44 -0500
X-MC-Unique: 8t4YwMEmMBmenGjL976h7Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 t9-20020aa7d709000000b003e83403a5cbso4767731edq.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 00:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WZ+thzQkg6Cdn1OMX5Cx+TOEBd23whOs+wYTt44V+WM=;
 b=1BGF1mhoWNZmZQY3mTZVuFFW4H8obJRLLpRqPmR/0wJY6/80gabCiJE5seL+heh2CO
 mH+R1SqCu+YFSb/CHj+/wiAWsKwcYXjhBnrtsVegMI+S/bPt/o/qsknKnCm59KyJLr+M
 RV+Al437UYa5yBHe1jxy36gFxn5rIFub1+yizvVoAI7vhQgEBnX3n3p0LCf7lRvv5cxt
 2NdRDSZYwgIT3RkUdoB54QVja5bw6SK923D9gsXRF3q1khwcebUyuw2O+uW8AAuskjNL
 iXyY5+pKgXkY4aw8pJwzF9jCxA1Wvm2GNfh5A/pD6QDieiR3edpY2oWNRCUcL7RamFyS
 Qw6Q==
X-Gm-Message-State: AOAM532/uy3zR0MC2TJe/CL+ECA0jqF+5IvvKojWydIdzj4Ryg8+bMUM
 zjNRDF2+lJQe2WlHImCPKVP1r5tjLXYHz8GiarmrwtZhNmpzRgMuwv5+uPbRRKDJaqEhtver8Sg
 zP9zYatd+otqFgAHG/nV++p5RAh49R4UJvwTwJ5BeXQ==
X-Received: by 2002:a17:906:168e:: with SMTP id
 s14mr28081285ejd.340.1637828022811; 
 Thu, 25 Nov 2021 00:13:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYOQD+i+ueXJv8wQ2hIv3rDAUa4Ml4YdNJcnxE4uaDuCfWulSeHACHF8gzhftP0CtxspQTmg==
X-Received: by 2002:a17:906:168e:: with SMTP id
 s14mr28081261ejd.340.1637828022601; 
 Thu, 25 Nov 2021 00:13:42 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id d18sm1372141edj.23.2021.11.25.00.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 00:13:41 -0800 (PST)
Date: Thu, 25 Nov 2021 03:13:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125031107-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
 <20211125021308-mutt-send-email-mst@kernel.org>
 <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
 <20211125022442-mutt-send-email-mst@kernel.org>
 <CACGkMEuos9tVSvrwXxTmh1v5WDYy9mpCagr+mrubY3bSCTBS2A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuos9tVSvrwXxTmh1v5WDYy9mpCagr+mrubY3bSCTBS2A@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 03:28:31PM +0800, Jason Wang wrote:
> On Thu, Nov 25, 2021 at 3:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 03:20:07PM +0800, Jason Wang wrote:
> > > On Thu, Nov 25, 2021 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> > > > > On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > > > > large max_mtu. In this case, using small packet mode is not correct
> > > > > > > since it may breaks the networking when MTU is grater than
> > > > > > > ETH_DATA_LEN.
> > > > > > >
> > > > > > > To have a quick fix, simply enable the big packet mode when
> > > > > > > VIRTIO_NET_F_MTU is not negotiated.
> > > > > >
> > > > > > This will slow down dpdk hosts which disable mergeable buffers
> > > > > > and send standard MTU sized packets.
> > > > > >
> > > > > > > We can do optimization on top.
> > > > > >
> > > > > > I don't think it works like this, increasing mtu
> > > > > > from guest >4k never worked,
> > > > >
> > > > > Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.
> > > >
> > > > OK, even more so then.
> > > >
> > > > > > we can't regress everyone's
> > > > > > performance with a promise to maybe sometime bring it back.
> > > > >
> > > > > So consider it never work before I wonder if we can assume a 1500 as
> > > > > max_mtu value instead of simply using MAX_MTU?
> > > > >
> > > > > Thanks
> > > >
> > > > You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?
> > >
> > > Yes, or fix the issue to let large packets on RX work (e.g as the TODO
> > > said, size the buffer: for <=4K mtu continue to work as
> > > add_recvbuf_small(), for >= 4K switch to use big).
> >
> > Right. The difficulty is with changing modes, current code isn't
> > designed for it.
> 
> I think it might work if we reset the device during the mode change.
> 
> Thanks

For sure. It's hard to do without races though, and we need to
carefully restore all the programming done so far.
Maybe it will be easier if we do something like disable_irq
to reliably suppress interrupts from hardware.

> >
> > > > Maybe ... it will prevent sending large packets which did work ...
> > >
> > > Yes, but it's strange to allow TX but not RX
> > >
> > > > I'd tread carefully here, and I don't think this kind of thing is net
> > > > material.
> > >
> > > I agree consider it can't be fixed easily.
> > >
> > > Thanks
> > >
> > > >
> > > > > >
> > > > > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 7 ++++---
> > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > > >               dev->mtu = mtu;
> > > > > > >               dev->max_mtu = mtu;
> > > > > > >
> > > > > > > -             /* TODO: size buffers correctly in this case. */
> > > > > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > > > > -                     vi->big_packets = true;
> > > > > > >       }
> > > > > > >
> > > > > > > +     /* TODO: size buffers correctly in this case. */
> > > > > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > > > > +             vi->big_packets = true;
> > > > > > > +
> > > > > > >       if (vi->any_header_sg)
> > > > > > >               dev->needed_headroom = vi->hdr_len;
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
