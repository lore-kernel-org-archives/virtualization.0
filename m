Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B8C4727F
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 05:57:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DE320BED
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 05:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIvi7JKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DE320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8375986F74;
	Tue, 29 Sep 2020 05:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VtDWVQv8CUMB; Tue, 29 Sep 2020 05:57:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0157286DAC;
	Tue, 29 Sep 2020 05:57:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFB16C016F;
	Tue, 29 Sep 2020 05:57:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 477EDC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2D141204AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c+pvSdlcPRKs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:57:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id A40EC20421
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:57:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601359021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7sAUumQ3LtY3a6NnfdifHLAxDChsRCTw8gS8QJu5HtI=;
 b=ZIvi7JKYhaHMuWTHZEnlRUoUT31/jP/nL/L9/S0693mPDtRX4gnGKe40dZbaj9jXJ1Tf0D
 d7A5IvBeBwEKUngexM1Yx7wv3rAkqFego/RBvb7dJyDQpxVIsvEm6TewheKB0frnDtPIr3
 xTu2fgqmckq3j0oCtlafCNRlIdMwZ1g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-KFtZwjJQMR6YQ8P7fYgVHg-1; Tue, 29 Sep 2020 01:56:58 -0400
X-MC-Unique: KFtZwjJQMR6YQ8P7fYgVHg-1
Received: by mail-wr1-f69.google.com with SMTP id h4so1288317wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 22:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7sAUumQ3LtY3a6NnfdifHLAxDChsRCTw8gS8QJu5HtI=;
 b=eb3x1Y6MaTFJJof5q90IBYnRv/QMLKa4LwDGqH5fa0lzAJ1/TWGH2rr+7XF5zpct5V
 QgB0/zsROSZdO+41/P6W78N28bEGU5lcDaU1E60iNzcHqiOLKU0ik37svfRj5Ze8aZHM
 nasyOP3fB2vPg9Va6grtJ1tGD3EaL2ixPe2VjpDUdg/DkblYC1178n0OVxadFruM20QE
 ZUAMRDX34L8MVqM6RpbBjCVCWbagUUfAJWU/bFymX/fm8aR32XVxzEsO3+jdBxXpem0y
 Loht2RMtLVh+0rVDl9ljJ1+bhxinDX2FhXgMBS4RzvH6oBXefD59qFEmtNdx2lze+FBU
 R7Gw==
X-Gm-Message-State: AOAM532O/zAPFHgjAVdtDuDEqWkCXcx/uoX0E0SJNB++zJ9baNuBv1v7
 Zc0wnv0xxP3/J6mtxFft1+wmxRyTFq4hs/BsmuBYHTwn6QjPHWXNn8E9FZ4jjBWiTHxFfOv7sfJ
 1ORIkd61eUw5W8ikHg6Ail++iLTRFFNOPzwz1GflnSg==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr2188240wrw.324.1601359017678; 
 Mon, 28 Sep 2020 22:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM2A/ekxW5Bwb1A1nOpooejEQoSy10eakYmExcJHJ6eZcuPjgYm5pjbcgxCyi02Q40GK45Nw==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr2188227wrw.324.1601359017479; 
 Mon, 28 Sep 2020 22:56:57 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id f14sm4722311wrv.72.2020.09.28.22.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 22:56:56 -0700 (PDT)
Date: Tue, 29 Sep 2020 01:56:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: don't disable guest csum when disable LRO
Message-ID: <20200929015624-mutt-send-email-mst@kernel.org>
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928151531-mutt-send-email-mst@kernel.org>
 <CAMDZJNV_A+EuqFGEhB_-g_5unUJ9TyyDZu1krtxBS22EnW1mAw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDZJNV_A+EuqFGEhB_-g_5unUJ9TyyDZu1krtxBS22EnW1mAw@mail.gmail.com>
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

On Tue, Sep 29, 2020 at 09:40:22AM +0800, Tonghao Zhang wrote:
> On Tue, Sep 29, 2020 at 3:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 11:39:14AM +0800, xiangxia.m.yue@gmail.com wrote:
> > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > >
> > > Open vSwitch and Linux bridge will disable LRO of the interface
> > > when this interface added to them. Now when disable the LRO, the
> > > virtio-net csum is disable too. That drops the forwarding performance.
> > >
> > > Fixes: e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")
> >
> > I am a bit confused by this tag. Did this change bring about
> > disabling checksum when LRO is disabled? I am not sure
> > I follow how ...
> Hi Michael
> It's not right fix tag.
> The commit a02e8964eaf9 ("virtio-net: ethtool configurable LRO"),
> disable the csum, when we disable the LRO

OK then, pls send a correct Fixes tag when you repost this ...

> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
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
