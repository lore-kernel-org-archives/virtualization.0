Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB0C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:40:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102D86109E
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 102D86109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1EED60631;
	Wed, 27 Oct 2021 07:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HHAzf2yk8_Jj; Wed, 27 Oct 2021 07:40:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67F6D607DA;
	Wed, 27 Oct 2021 07:40:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D3FDC0012;
	Wed, 27 Oct 2021 07:40:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43614C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 322D160631
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fZFwPzcZqdr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 797066058F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635320431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEMdpklZCdrGSBmQUj25Y0ktpMBCup6v7uzdSdkzaUk=;
 b=V9dPGyQTGMIDYQqgEuls5sHP/8L9NbKPf1x1pfFPG6UnW7q34g517Cc/atyKE5WiXWTFOs
 LC7l7zcWuPjgZBwoH2UwpxBpNUUe+Mg2Ww8vFYUsx1KhS7TKT94a+5sZ4a8GYbMTQPL8YR
 s0RzpPCBwREARWmda2f/z6wMg983vyA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-3YJaa75ENtGFJ0QnpwEGnA-1; Wed, 27 Oct 2021 03:40:30 -0400
X-MC-Unique: 3YJaa75ENtGFJ0QnpwEGnA-1
Received: by mail-wm1-f71.google.com with SMTP id
 b81-20020a1c8054000000b0032c9d428b7fso888754wmd.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 00:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TEMdpklZCdrGSBmQUj25Y0ktpMBCup6v7uzdSdkzaUk=;
 b=7jBx2DY8aW2a7BBfMzrvYI9xWAP32NU6iPMm9fMXLHH0gh29TlQmpcDxj+oUETerZu
 ArilSexPRRPGp7ss7wynxVQK9ihvBqaHIEZlYsCHh76nH6VZ+MTIVvf1M/u4rlvMY6v+
 PLH/LmcyJ0TYulZRl+qI+xwFBZMz/Xt7CLvkmrELnt/JqPQeuQNx6XBRmyl/OMGvnGS1
 5Q6V1V3pDW87s+DBLbvRlQRi3MFaUx2HRGCTnOTecKZC/azYciFzgxHOy1wXpXnyMNG/
 gim+2lIWIrxEEernYcFKvttZa7DjKeTMdzwzLgoX9lxFwkY/ewzoTfoYe1irHjF8N7DO
 jYfA==
X-Gm-Message-State: AOAM531IDbz3BcFYXc8iYxR5ELWTTCAWDspkSTPXp4YWYiLuepC7DJ1Y
 RDs5WReLuUAvzEAp913Nik2cYy61KmjS2wXVB0y9S3z6R8HbVNWTk4MYkuL6rE7SyLDzGZKkfSU
 qTgAXLM/qChhxDVlPsv+IzelWbD5fejoul5TDip+hag==
X-Received: by 2002:adf:e412:: with SMTP id g18mr3753003wrm.432.1635320429111; 
 Wed, 27 Oct 2021 00:40:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXkAgCBgSDgFmaA5XGsk/PKUZtfwuVXsdd5KlKKdpYl/Yabs7af1uQPQN6+bhbIMXZyAywnA==
X-Received: by 2002:adf:e412:: with SMTP id g18mr3752995wrm.432.1635320428972; 
 Wed, 27 Oct 2021 00:40:28 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
 by smtp.gmail.com with ESMTPSA id q14sm11526705wrv.55.2021.10.27.00.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 00:40:28 -0700 (PDT)
Date: Wed, 27 Oct 2021 03:40:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next] net: virtio: use eth_hw_addr_set()
Message-ID: <20211027033958-mutt-send-email-mst@kernel.org>
References: <20211026175634.3198477-1-kuba@kernel.org>
 <CACGkMEu6ZnyJF2nKS-GURc2Fz8BqUY6OGFEa71fNKPfGA0Wp7g@mail.gmail.com>
 <CACGkMEvWKOLWEuexbdZozYzzRWPM-Wnf8ms4wLk6gX76hWmzwA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvWKOLWEuexbdZozYzzRWPM-Wnf8ms4wLk6gX76hWmzwA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 davem <davem@davemloft.net>, netdev <netdev@vger.kernel.org>
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

On Wed, Oct 27, 2021 at 03:24:55PM +0800, Jason Wang wrote:
> On Wed, Oct 27, 2021 at 10:45 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Oct 27, 2021 at 1:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> > > of VLANs...") introduced a rbtree for faster Ethernet address look
> > > up. To maintain netdev->dev_addr in this tree we need to make all
> > > the writes to it go through appropriate helpers.
> >
> > I think the title should be "net: virtio: use eth_hw_addr_set()"
> 
> I meant "dev_addr_set()" actually.
> 
> Thanks


Good point, this confused me too. Could be fixed up when applying?

> >
> > >
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > > CC: mst@redhat.com
> > > CC: jasowang@redhat.com
> > > CC: virtualization@lists.linux-foundation.org
> > > ---
> > >  drivers/net/virtio_net.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c501b5974aee..b7f35aff8e82 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3177,12 +3177,16 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >         dev->max_mtu = MAX_MTU;
> > >
> > >         /* Configuration may specify what MAC to use.  Otherwise random. */
> > > -       if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> > > +               u8 addr[MAX_ADDR_LEN];
> > > +
> > >                 virtio_cread_bytes(vdev,
> > >                                    offsetof(struct virtio_net_config, mac),
> > > -                                  dev->dev_addr, dev->addr_len);
> > > -       else
> > > +                                  addr, dev->addr_len);
> > > +               dev_addr_set(dev, addr);
> > > +       } else {
> > >                 eth_hw_addr_random(dev);
> > > +       }
> >
> > Do we need to change virtnet_set_mac_address() as well?
> >
> > Thanks
> >
> > >
> > >         /* Set up our device-specific information */
> > >         vi = netdev_priv(dev);
> > > --
> > > 2.31.1
> > >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
