Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4796BC433FE
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:30:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D462D61039
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D462D61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AA2560B2F;
	Thu, 28 Oct 2021 02:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cCPH_4IOaE4E; Thu, 28 Oct 2021 02:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C73C60682;
	Thu, 28 Oct 2021 02:30:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC42C0019;
	Thu, 28 Oct 2021 02:30:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E60EAC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCA2540150
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxmEZ5V-H05G
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:30:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E57A6400C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635388248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q3qRktrDZtvaYh1K6rXXgHvHdfmThWB3M78MTr+j2As=;
 b=gyPK/qTZEYUP8P9a/a+Y/NoIm4+XeG/TKI4Y/6CQVRasbuK6kazRwpeBcW2p5EhxSibcdY
 v/LJzeaJnczu9dBGO9VlkOp6ZF50rx+fW2ikyOGeu4jpQgD/9Rchhix7w+aAp5Wawl4068
 yvtD34dtvrZ5+KEEYflaXeF3sNZa/i0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-2pA6N6SkNe-8O2c6KTeZgw-1; Wed, 27 Oct 2021 22:30:47 -0400
X-MC-Unique: 2pA6N6SkNe-8O2c6KTeZgw-1
Received: by mail-lj1-f200.google.com with SMTP id
 n9-20020a2e9049000000b00212acec7473so663586ljg.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q3qRktrDZtvaYh1K6rXXgHvHdfmThWB3M78MTr+j2As=;
 b=yLFn5jWjOwK+ZenwVew1GLWrHARPS8Uqhe3YfcaYGGj7GVzZESomYVsJ02rLhkb1xz
 OoTnjjI1ylepHCDXDVuQ5z9oI1ZDbALsLxDQrZTS3a/2ZmqVeWoZhIDbkFCOYd8YXZvs
 WV7vQEVt5yDRUvZ20ufT+EtpkXtN181G2Jm9oRx/Y+knVWDV5lYhkwpNX7DvlC7zYp0y
 vtS5KkQzlDxzAy5qebwxVipgCup6e+T3zIYTWw1xlIzxSbJli+npGy7AIJzEz+4pwwec
 XV4CWsZy1D3C4Es6B71XziUCbY566ooGbfYXnv4D4nOyl1pp8XB3oYd0LWPvfiM6aptS
 6/lA==
X-Gm-Message-State: AOAM532C3FEY7XWjkHcIQS571pwteCHAhvos8Ro2qWNaLn3YwYR50nSV
 yGm9hDHPMsQceXkzv9Ct7rnaHCTPSGxASZ08agEnxh9rQGgyCDUUVDarmYTkiUQd2/n5HRTEJ9L
 H9MmLiSRPZFSUpBknlwuG8KZkqgPfIJDUQ25ttvVDVwSv4OTgdNAkExD/bw==
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr1462665lfs.84.1635388245950; 
 Wed, 27 Oct 2021 19:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv40ZuZY7bdVdkZG2ijgIgHr8upPl1ETTaDY/LJKvRVhoK0WuC8SyD/3/Y9K6G6AJO+LYjny9BO9rozIKbw2Y=
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr1462642lfs.84.1635388245770; 
 Wed, 27 Oct 2021 19:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211027152012.3393077-1-kuba@kernel.org>
 <20211027113033-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211027113033-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Oct 2021 10:30:34 +0800
Message-ID: <CACGkMEtSTf3xiBaUeoyW4B=uTst5B3Ew2yfWe7bcpiLm4FiHYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: virtio: use eth_hw_addr_set()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Oct 27, 2021 at 11:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Oct 27, 2021 at 08:20:12AM -0700, Jakub Kicinski wrote:
> > Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> > of VLANs...") introduced a rbtree for faster Ethernet address look
> > up. To maintain netdev->dev_addr in this tree we need to make all
> > the writes to it go through appropriate helpers.
> >
> > Even though the current code uses dev->addr_len the we can switch
> > to eth_hw_addr_set() instead of dev_addr_set(). The netdev is
> > always allocated by alloc_etherdev_mq() and there are at least two
> > places which assume Ethernet address:
> >  - the line below calling eth_hw_addr_random()
> >  - virtnet_set_mac_address() -> eth_commit_mac_addr_change()
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

>
> > ---
> > v2: - actually switch to eth_hw_addr_set() not dev_addr_set()
> >     - resize the buffer to ETH_ALEN
> >     - pass ETH_ALEN instead of dev->dev_addr to virtio_cread_bytes()
> >
> > CC: mst@redhat.com
> > CC: jasowang@redhat.com
> > CC: virtualization@lists.linux-foundation.org
> > ---
> >  drivers/net/virtio_net.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c501b5974aee..cc79343cd220 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3177,12 +3177,16 @@ static int virtnet_probe(struct virtio_device *vdev)
> >       dev->max_mtu = MAX_MTU;
> >
> >       /* Configuration may specify what MAC to use.  Otherwise random. */
> > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> > +             u8 addr[ETH_ALEN];
> > +
> >               virtio_cread_bytes(vdev,
> >                                  offsetof(struct virtio_net_config, mac),
> > -                                dev->dev_addr, dev->addr_len);
> > -     else
> > +                                addr, ETH_ALEN);
> > +             eth_hw_addr_set(dev, addr);
> > +     } else {
> >               eth_hw_addr_random(dev);
> > +     }
> >
> >       /* Set up our device-specific information */
> >       vi = netdev_priv(dev);
> > --
> > 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
