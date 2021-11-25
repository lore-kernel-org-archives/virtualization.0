Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A842CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AA58405EE;
	Thu, 25 Nov 2021 07:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3qtQ6BVy9VHr; Thu, 25 Nov 2021 07:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7AA5405BC;
	Thu, 25 Nov 2021 07:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C14B9C002F;
	Thu, 25 Nov 2021 07:26:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95911C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70767608DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J9as0wjD8MzQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:26:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1BE2608D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637825182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KCI9CPt99xPAxo4OPIihJLE+9ULo5GUcCD2zEw3zAm0=;
 b=MmAOUjSXwHGYgLyON40rZREWkuxvRJQzAlU4tSMhh5eNMxeNaLbCsB7MWR57ov7HNBRfbE
 1LDGY+U2pRQS3FyOvwiLyVzUgcX22bQnelvoWiasyBsV5MdFor4CgibkV5nEYWRuEDjeuc
 NL7gKQEEY9LJ274R1S3uMdktx4YevbM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-th-m8P2OPeadog5WKyWxHA-1; Thu, 25 Nov 2021 02:26:21 -0500
X-MC-Unique: th-m8P2OPeadog5WKyWxHA-1
Received: by mail-wm1-f70.google.com with SMTP id
 g81-20020a1c9d54000000b003330e488323so2360837wme.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KCI9CPt99xPAxo4OPIihJLE+9ULo5GUcCD2zEw3zAm0=;
 b=wtyWrB5/uZKssgxj83sJqDkAloczpwEaZjcXCTy6H5NHFnkr5wAlh+qOQQMVAcpEyy
 rS5c6hETTH8KkdaNtnzzoYF2xDqfii9QQdH9JNU6FcCdRadRej8jE7Nle90S/eF9Id7h
 +EZcENZnOux/S+j7sNl8c3E3FdVAxJkrCxBnWjqh9D3wuWqld2ogSZOVrSDvRzt1/gc6
 ez4NT7JLYrblEhDfCiW2ID0IPSHxpeZPFudAjNUHFYmc/GmvQIyPloGyftAKh/2m9500
 Zy7NMOIusr59EKsnbfmNYI7HjtK81DSF7M2wEaN3CgInKwXWvIR+noIC3494/sS96iDG
 b90Q==
X-Gm-Message-State: AOAM533z8PsbIwux+SXxzEMY8g+MN4Xkq3IwZI0zh8DTqj5u3HBppOcC
 6yPYnypb8NB4kdLd4bPrcTTbG+/xmSg6hDRo1A+eFMW9NTqbOfnMA+7e9UN3tkj+/oMqv3buh1u
 BsSOrwFGGw4fPQHkoDK2tIbFkTRzv2RBppotYGcwXbA==
X-Received: by 2002:adf:b18e:: with SMTP id q14mr4435684wra.477.1637825180316; 
 Wed, 24 Nov 2021 23:26:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzM6lbQ3uDZ5zJpkNVH+bqgGz375VJK1frTc+q8xHT9a96tyQUcZyAB+1UDheXMUsphwXYylg==
X-Received: by 2002:adf:b18e:: with SMTP id q14mr4435665wra.477.1637825180075; 
 Wed, 24 Nov 2021 23:26:20 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id f19sm9035167wmq.34.2021.11.24.23.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 23:26:19 -0800 (PST)
Date: Thu, 25 Nov 2021 02:26:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125022442-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
 <20211125021308-mutt-send-email-mst@kernel.org>
 <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 03:20:07PM +0800, Jason Wang wrote:
> On Thu, Nov 25, 2021 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> > > On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > > large max_mtu. In this case, using small packet mode is not correct
> > > > > since it may breaks the networking when MTU is grater than
> > > > > ETH_DATA_LEN.
> > > > >
> > > > > To have a quick fix, simply enable the big packet mode when
> > > > > VIRTIO_NET_F_MTU is not negotiated.
> > > >
> > > > This will slow down dpdk hosts which disable mergeable buffers
> > > > and send standard MTU sized packets.
> > > >
> > > > > We can do optimization on top.
> > > >
> > > > I don't think it works like this, increasing mtu
> > > > from guest >4k never worked,
> > >
> > > Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.
> >
> > OK, even more so then.
> >
> > > > we can't regress everyone's
> > > > performance with a promise to maybe sometime bring it back.
> > >
> > > So consider it never work before I wonder if we can assume a 1500 as
> > > max_mtu value instead of simply using MAX_MTU?
> > >
> > > Thanks
> >
> > You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?
> 
> Yes, or fix the issue to let large packets on RX work (e.g as the TODO
> said, size the buffer: for <=4K mtu continue to work as
> add_recvbuf_small(), for >= 4K switch to use big).

Right. The difficulty is with changing modes, current code isn't
designed for it.

> > Maybe ... it will prevent sending large packets which did work ...
> 
> Yes, but it's strange to allow TX but not RX
> 
> > I'd tread carefully here, and I don't think this kind of thing is net
> > material.
> 
> I agree consider it can't be fixed easily.
> 
> Thanks
> 
> >
> > > >
> > > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >               dev->mtu = mtu;
> > > > >               dev->max_mtu = mtu;
> > > > >
> > > > > -             /* TODO: size buffers correctly in this case. */
> > > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > > -                     vi->big_packets = true;
> > > > >       }
> > > > >
> > > > > +     /* TODO: size buffers correctly in this case. */
> > > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > > +             vi->big_packets = true;
> > > > > +
> > > > >       if (vi->any_header_sg)
> > > > >               dev->needed_headroom = vi->hdr_len;
> > > > >
> > > > > --
> > > > > 2.25.1
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
