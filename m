Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5AC433FE
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:25:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4706109E
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C4706109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08B0380D9E;
	Wed, 27 Oct 2021 07:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uTFrCalMjhxE; Wed, 27 Oct 2021 07:25:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB66B80D8C;
	Wed, 27 Oct 2021 07:25:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D105C0012;
	Wed, 27 Oct 2021 07:25:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B096AC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99547606D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qH6OOOnkGIvJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:25:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0459660676
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635319510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbPmqjJWgzA3Y/zZgHiZJYXUBsMyJrhMz63cdq96J9s=;
 b=imsanZlIUuTx0b31Hdsfo8zscFxaPSw4fFuGPIxb3p88A25DVe6bcYxgVosG8dPN3li/9N
 mAAfyVNEltsXUw2oJnuIQXv0sAh7/Dy8CSgdzxfBaCIpSuXZsqIIhxk7+a7MHTVbIV+DKg
 6hExEqOjS+GFZUjoQhXkfVR49Qt6sco=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-nCkxWB8OMlqZGSw8AeuKoA-1; Wed, 27 Oct 2021 03:25:08 -0400
X-MC-Unique: nCkxWB8OMlqZGSw8AeuKoA-1
Received: by mail-lj1-f200.google.com with SMTP id
 d24-20020a2eb058000000b00211892e18f2so293500ljl.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 00:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DbPmqjJWgzA3Y/zZgHiZJYXUBsMyJrhMz63cdq96J9s=;
 b=F+XJ03JFRjaZma/VjkkMjYYJ5f6gBdHmSO4nhbXNpz4D3W2s6gcQWDy/XkDTeZJCws
 FYk3SgbClxA6yxR+AanR43NNVncUbt6tfrpSjqs9EsEdlzMIosQEVIqss5M9o7TJCGat
 OCDP9m6I1rexPm2krA5l/enJlWbAGQlb09Uupc+yyrBewdlGNWl/lY1ilYgIT5Awuest
 M77tL+wmAXCT7qltT4Z6rOUaZ836OIzSZCC1yjsrWO/Twoo3hjU1LOF9VhaoK3sV1jFL
 4Za5OsrVOLeAqJDU0m1i85ioe9KaSXm/7iZDbCeFpQ6/qzz6njaywsRLB4KT693lmVqh
 HQOw==
X-Gm-Message-State: AOAM5319ZM37Mrg3a/VOKA1eEHi1K/dMKxcvIl5YuomNF5hHhi1tF4/P
 dOlLIpNM0wca09A3vpmABPWJ9tR4L8KanNJQmUXrzshre9rHohfOq5iAdHBpOCLA0Lu7Wh44pqy
 jAfI7o+UPomW5+w+GO/2R2M/0MeuCTZNHGUmCrqBMmi7F7zD/TCEjD7F9cw==
X-Received: by 2002:a2e:5344:: with SMTP id t4mr31144648ljd.362.1635319506837; 
 Wed, 27 Oct 2021 00:25:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx60K3agBV72twigmEzIG4Fvw5bMCI5GhxSGQ19U5tE6uaE7t6SoxPwUooNXl7eML2YSuLhLTyhqBbs6SAqrUA=
X-Received: by 2002:a2e:5344:: with SMTP id t4mr31144627ljd.362.1635319506634; 
 Wed, 27 Oct 2021 00:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211026175634.3198477-1-kuba@kernel.org>
 <CACGkMEu6ZnyJF2nKS-GURc2Fz8BqUY6OGFEa71fNKPfGA0Wp7g@mail.gmail.com>
In-Reply-To: <CACGkMEu6ZnyJF2nKS-GURc2Fz8BqUY6OGFEa71fNKPfGA0Wp7g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 15:24:55 +0800
Message-ID: <CACGkMEvWKOLWEuexbdZozYzzRWPM-Wnf8ms4wLk6gX76hWmzwA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: virtio: use eth_hw_addr_set()
To: Jakub Kicinski <kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 davem <davem@davemloft.net>, mst <mst@redhat.com>
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

On Wed, Oct 27, 2021 at 10:45 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Oct 27, 2021 at 1:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> > of VLANs...") introduced a rbtree for faster Ethernet address look
> > up. To maintain netdev->dev_addr in this tree we need to make all
> > the writes to it go through appropriate helpers.
>
> I think the title should be "net: virtio: use eth_hw_addr_set()"

I meant "dev_addr_set()" actually.

Thanks

>
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > CC: mst@redhat.com
> > CC: jasowang@redhat.com
> > CC: virtualization@lists.linux-foundation.org
> > ---
> >  drivers/net/virtio_net.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c501b5974aee..b7f35aff8e82 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3177,12 +3177,16 @@ static int virtnet_probe(struct virtio_device *vdev)
> >         dev->max_mtu = MAX_MTU;
> >
> >         /* Configuration may specify what MAC to use.  Otherwise random. */
> > -       if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> > +               u8 addr[MAX_ADDR_LEN];
> > +
> >                 virtio_cread_bytes(vdev,
> >                                    offsetof(struct virtio_net_config, mac),
> > -                                  dev->dev_addr, dev->addr_len);
> > -       else
> > +                                  addr, dev->addr_len);
> > +               dev_addr_set(dev, addr);
> > +       } else {
> >                 eth_hw_addr_random(dev);
> > +       }
>
> Do we need to change virtnet_set_mac_address() as well?
>
> Thanks
>
> >
> >         /* Set up our device-specific information */
> >         vi = netdev_priv(dev);
> > --
> > 2.31.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
