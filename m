Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA90C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D48B4606CA;
	Thu, 25 Nov 2021 07:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUCPEaFdzKRL; Thu, 25 Nov 2021 07:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 886F7607B2;
	Thu, 25 Nov 2021 07:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65A16C002F;
	Thu, 25 Nov 2021 07:20:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF0EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4BCF405F3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uKgFha07j_dY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:20:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A23FC405EE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637824821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0288K9+4rtmWXrgpEnbVI8eRZ9+61SJ6uREF4cND0rE=;
 b=dzRVt3kzMncFQX7rSortv+IDvY2sZ0gVDNqj0R3MLda35m5yOWwlW9ZxRTZin7dMeT2WGP
 9dkf/lP6Qw7nCrhotkB51T3wEL6r6+Im3dgw6GlJifXdFirIZrR8TOvTkCW8DYcQW+nL6R
 nMcbkfqYIQZ0V6W3BtA1dWqfb5i2pVQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-p_MYllhkNciuTMbecy6QZw-1; Thu, 25 Nov 2021 02:20:20 -0500
X-MC-Unique: p_MYllhkNciuTMbecy6QZw-1
Received: by mail-lf1-f69.google.com with SMTP id
 x17-20020a0565123f9100b003ff593b7c65so2768252lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0288K9+4rtmWXrgpEnbVI8eRZ9+61SJ6uREF4cND0rE=;
 b=PDUXWOcDPq9xM37A/SFVA/WHvsp9QAKuSO35cjjsaIU/qKiZncNIyN2hKOcwgYxwWt
 1Cq+CLF63m2oCtD32NnyFxP2m8rNJXJlCEVi6Yt9BtXuHoR3fQyxF7pNLLrXBu6E97ug
 RdnxJDWJo7cmLvA9azRUo+K97llEdtQHBtYngDDXGwXME9/ew8TmWlWVYs+nq6Nl1WnP
 oDEdbEuZ9txAxy7EKYMuLk1hdXpyjnBvtFY8FJJg9KgQtE/8EarWVDuaeFXKDUOdweYv
 i7hW2k0wUuCgvRSo0bij9cuckMXYdCFHS8IXIiV1A8EPq0Ez8vcYfwpmkNrQzOwayT8E
 u4sw==
X-Gm-Message-State: AOAM531F3+HT+62bh44S2o7MBn4juaBawtAabv8SXvycGsnfLCq4K15K
 FULXg3c+m6tuK5UFebIg6dt2cUtis6giyLlP7wC5lJErhJfJTjpJuW9wqX/tG7GyA9jvyIGFuhR
 pUcsYzE28BytFfkgeYlAu3p8sR7TeOOxa01trQLriS7R1PVtinnuIIZR7kg==
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22460229ljg.277.1637824818463; 
 Wed, 24 Nov 2021 23:20:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAc9aUOa9FeX5ZE296oiarTKJZL/BX1S6IHbR96hL/NWmFeWIrJHNjgfGJIWjO7GYJFqI2Mgg4l7eT+hT8wmY=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22460215ljg.277.1637824818275; 
 Wed, 24 Nov 2021 23:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
 <20211125021308-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211125021308-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 15:20:07 +0800
Message-ID: <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> > On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > large max_mtu. In this case, using small packet mode is not correct
> > > > since it may breaks the networking when MTU is grater than
> > > > ETH_DATA_LEN.
> > > >
> > > > To have a quick fix, simply enable the big packet mode when
> > > > VIRTIO_NET_F_MTU is not negotiated.
> > >
> > > This will slow down dpdk hosts which disable mergeable buffers
> > > and send standard MTU sized packets.
> > >
> > > > We can do optimization on top.
> > >
> > > I don't think it works like this, increasing mtu
> > > from guest >4k never worked,
> >
> > Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.
>
> OK, even more so then.
>
> > > we can't regress everyone's
> > > performance with a promise to maybe sometime bring it back.
> >
> > So consider it never work before I wonder if we can assume a 1500 as
> > max_mtu value instead of simply using MAX_MTU?
> >
> > Thanks
>
> You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?

Yes, or fix the issue to let large packets on RX work (e.g as the TODO
said, size the buffer: for <=4K mtu continue to work as
add_recvbuf_small(), for >= 4K switch to use big).

> Maybe ... it will prevent sending large packets which did work ...

Yes, but it's strange to allow TX but not RX

> I'd tread carefully here, and I don't think this kind of thing is net
> material.

I agree consider it can't be fixed easily.

Thanks

>
> > >
> > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >               dev->mtu = mtu;
> > > >               dev->max_mtu = mtu;
> > > >
> > > > -             /* TODO: size buffers correctly in this case. */
> > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > -                     vi->big_packets = true;
> > > >       }
> > > >
> > > > +     /* TODO: size buffers correctly in this case. */
> > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > +             vi->big_packets = true;
> > > > +
> > > >       if (vi->any_header_sg)
> > > >               dev->needed_headroom = vi->hdr_len;
> > > >
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
