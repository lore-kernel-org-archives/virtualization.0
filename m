Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A08C4727C
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 01:42:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2D8206C3
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 01:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrBpM1Pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2D8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B2B3486FB0;
	Tue, 29 Sep 2020 01:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bDZ6DlBuH4qT; Tue, 29 Sep 2020 01:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1AB2E86F74;
	Tue, 29 Sep 2020 01:42:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F14A8C0891;
	Tue, 29 Sep 2020 01:42:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18C1CC016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 008E6866A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OBtsGr0NgUcN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:42:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 058338669D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:42:48 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id b12so4525107edz.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IQKWtC0wIHlSJXdfuyYSbunoEcU6dfwYtAy5hCXjdZ8=;
 b=NrBpM1Pu4gPdmggMcZ8OxQ/ECw5kW4etkMwgZvySzOblDj4FUJwORp/LkrTWrpnrkV
 W5jH8xHGLT5lVqELy/zvIUC7u3ZTmBJWCn0QdISXTjIWbyC4VCoXen1apEzowuKTq64m
 FaWjVeIxTldjKwxjfoEdTcrrHk7XwDzucdLWewkjNscz8vrUigsHHrrBq7DV7F5/V7dk
 Wb85rVrqoJxhd2soAN8QK+tawYf6dPYOxQOsh9ZNm2uhXlw7onghNTqGJRFZjh70vy9F
 rPPeGtEw5lCzL18umFYymXqo+GjFWrbQGiIefwY3eCVmhPJh9OC53/p2yFibNHDfDDRL
 YuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IQKWtC0wIHlSJXdfuyYSbunoEcU6dfwYtAy5hCXjdZ8=;
 b=Mblp0MD+4ziZc4UzZgkurnXxKJCg0sELFgqjeG7VFBzPUagZ7/lolxZ7KVj+aRF/5k
 KqEoj8j85naIHb/Jjbtx+V5N/FCWArASBaVifJhHtzvMZlno9h/sL43StnILmLekVwba
 s0N5Uyz1sUmTR67cKAF8iCK/Q23uEAvbeO9rBUsKC9vPcp6XfSCy3ZhziYjtWXhGNlDS
 yyC5K+OBcaAIq53fB2n2BYawb06FBF8U0mtklIhopM/K7wg24fZdhA8V3lKwMXN7WnLJ
 4NPL3McUb83hAXe3vNuWkF+NNf1E/nyGtIUuTG7rvuZ6fRvRMMr4S7XGIcuTZ1kY1hAh
 E9ig==
X-Gm-Message-State: AOAM531Hh58mx+V0kG1Hdxq088D+kCRBBWQnByUGnUXP9s417/Z1Bluc
 c04Z008OPDv/3QwXTMA4kqRBf9U0gDjcrcYNeWo=
X-Google-Smtp-Source: ABdhPJxWP+vDQBZIyhqtl/TJR0OyD55XOIXLvNoXKt1oybE+bSm9jtwbhrvExc8KL6cFbnfaY5ZQWkamrUbHYzePfnM=
X-Received: by 2002:a05:6402:2c3:: with SMTP id
 b3mr796758edx.213.1601343766492; 
 Mon, 28 Sep 2020 18:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928151531-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200928151531-mutt-send-email-mst@kernel.org>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Tue, 29 Sep 2020 09:40:22 +0800
Message-ID: <CAMDZJNV_A+EuqFGEhB_-g_5unUJ9TyyDZu1krtxBS22EnW1mAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: don't disable guest csum when disable LRO
To: "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Sep 29, 2020 at 3:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 28, 2020 at 11:39:14AM +0800, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > Open vSwitch and Linux bridge will disable LRO of the interface
> > when this interface added to them. Now when disable the LRO, the
> > virtio-net csum is disable too. That drops the forwarding performance.
> >
> > Fixes: e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")
>
> I am a bit confused by this tag. Did this change bring about
> disabling checksum when LRO is disabled? I am not sure
> I follow how ...
Hi Michael
It's not right fix tag.
The commit a02e8964eaf9 ("virtio-net: ethtool configurable LRO"),
disable the csum, when we disable the LRO

> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7145c83c6c8c..21b71148c532 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
> >       VIRTIO_NET_F_GUEST_CSUM
> >  };
> >
> > +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > +                             (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> > +                             (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > +                             (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > +
> >  struct virtnet_stat_desc {
> >       char desc[ETH_GSTRING_LEN];
> >       size_t offset;
> > @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
> >               if (features & NETIF_F_LRO)
> >                       offloads = vi->guest_offloads_capable;
> >               else
> > -                     offloads = 0;
> > +                     offloads = vi->guest_offloads_capable &
> > +                                ~GUEST_OFFLOAD_LRO_MASK;
> >
> >               err = virtnet_set_guest_offloads(vi, offloads);
> >               if (err)
> > --
> > 2.23.0
>


-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
