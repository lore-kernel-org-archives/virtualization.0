Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3312C4727D
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:23:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3544A207F7
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UseAeJr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3544A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EFC1420481;
	Tue, 29 Sep 2020 07:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQaGuRdA7rct; Tue, 29 Sep 2020 07:23:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6DD581FEAB;
	Tue, 29 Sep 2020 07:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F3BBC0890;
	Tue, 29 Sep 2020 07:23:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23BE6C016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 12D3985108
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i0VChCmZzUEi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:23:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8B6D68487A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:23:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DkxDE/GfK+LWdfYX0Hon0sHSmMWfOnLZHyrioNnimaM=;
 b=UseAeJr18uhxVujj/h4VqkyE/ciaTUePUITyUWTjFoSmjcgX/V80LSzJDSiLcJK36rgdzK
 pm/4fze+M3l9KtoJ/L5L9gsYgj94Z3s4YClQ/9TKIArzcfeoh+mXLcYZghPcVZPIV+ecB0
 NaBzf54zT3KiQRvhsyr0by8+0EHd8mw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-Le3BLzEdO4-dC3nnvtfuKA-1; Tue, 29 Sep 2020 03:21:59 -0400
X-MC-Unique: Le3BLzEdO4-dC3nnvtfuKA-1
Received: by mail-wr1-f69.google.com with SMTP id f18so1357972wrv.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DkxDE/GfK+LWdfYX0Hon0sHSmMWfOnLZHyrioNnimaM=;
 b=aYMFOOUwuajGbY26VRX9PgOIImUPli4zAvXLP206ToIPSovCbpt6RmyxsTxRyKZY50
 XiVUHFEuXARoyfBLotXAiThH8SpSETJThdVuqouN6cl9Yya81SZ8DjOQSbvH7tvz/FE9
 hpUxc3kaNzQHkMCuH/FeSEh8aQfcUv2nAkYDEX3saJBufHoM2GpuaQHCBOqNgY5lDl/i
 6SSYFQnzx1Aga7hDrx6yhbU43VpMt8qxrKn64fBL9NFP9N1qiGMh6zzzXAwimvSKKAlp
 Otp0RpnvCMHort7mVvzEsMrcOOwLvC7juwuVs222QWAU96HE7QAsHBZ2/KZd3SWcz515
 nNag==
X-Gm-Message-State: AOAM533i+tc4uSXer/Dy/dpHfbzg24TMcSwJBqxR6linWK3n4g9UqCgL
 YCgtzTNko0FwXLYMwz92zWiy655UwdnzN+r0nLR/3sliRNcAjPTPRdOvH8eRNhKrW9uUNAR+PR9
 FCyrv/eJrXfuCSvCH/8NI9kUDujEiPgHnTED4KXoByg==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr2567221wrw.294.1601364118118; 
 Tue, 29 Sep 2020 00:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGtzPdArh0eM4rppGx9qZiRUi92ATAXBOK4TCSCvWZu7TS6qA/fpQQUdNfu1bm57pomibcFQ==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr2567206wrw.294.1601364117946; 
 Tue, 29 Sep 2020 00:21:57 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id n4sm4598775wrp.61.2020.09.29.00.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:57 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: Re: [PATCH net v2] virtio-net: don't disable guest csum when disable
 LRO
Message-ID: <20200929031754-mutt-send-email-mst@kernel.org>
References: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
 <20200929022246-mutt-send-email-mst@kernel.org>
 <CAMDZJNWM7eBkrYk9nkEvPyHW7=kt_hTHGQCDB1CPRz=EV6vJcQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDZJNWM7eBkrYk9nkEvPyHW7=kt_hTHGQCDB1CPRz=EV6vJcQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org
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

On Tue, Sep 29, 2020 at 02:59:03PM +0800, Tonghao Zhang wrote:
> On Tue, Sep 29, 2020 at 2:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 09:58:06AM +0800, xiangxia.m.yue@gmail.com wrote:
> > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > >
> > > Open vSwitch and Linux bridge will disable LRO of the interface
> > > when this interface added to them. Now when disable the LRO, the
> > > virtio-net csum is disable too. That drops the forwarding performance.
> > >
> > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > ---
> > > v2:
> > > * change the fix-tag
> > > ---
> > >  drivers/net/virtio_net.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7145c83c6c8c..21b71148c532 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
> > >       VIRTIO_NET_F_GUEST_CSUM
> > >  };
> > >
> > > +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > > +                             (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> > > +                             (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > > +                             (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > +
> >
> > I think I'd rather we open-coded this, the macro is only
> > used in one place ...
> Yes, in this patch, it is used only in one place. But in next patch
> [1], we use it twice and that make the code look a bit nicer.
> Would we open-coded this in this patch ?
> 
> [1] - http://patchwork.ozlabs.org/project/netdev/patch/20200928033915.82810-2-xiangxia.m.yue@gmail.com/

OK then maybe keep this in a series like you did with v1.



> > >  struct virtnet_stat_desc {
> > >       char desc[ETH_GSTRING_LEN];
> > >       size_t offset;
> > > @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
> > >               if (features & NETIF_F_LRO)
> > >                       offloads = vi->guest_offloads_capable;
> > >               else
> > > -                     offloads = 0;
> > > +                     offloads = vi->guest_offloads_capable &
> > > +                                ~GUEST_OFFLOAD_LRO_MASK;
> > >
> > >               err = virtnet_set_guest_offloads(vi, offloads);
> > >               if (err)
> >
> > > --
> > > 2.23.0
> >
> 
> 
> -- 
> Best regards, Tonghao

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
