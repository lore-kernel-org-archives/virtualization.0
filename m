Return-Path: <SRS0=0GV8=DF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C022C47423
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 09:23:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE3521D95
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 09:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE0/6giF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE3521D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 973CC84AE3;
	Mon, 28 Sep 2020 09:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HdhTwTNG5PTV; Mon, 28 Sep 2020 09:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E732484789;
	Mon, 28 Sep 2020 09:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D72FFC016F;
	Mon, 28 Sep 2020 09:23:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0B74C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DFA7B8701E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id avZXJpIr8NSA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 140CE86FCD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:23:32 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id i1so527582edv.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=49UgUsuSZpbxMCQ1i25UEUHUhYi5jAwhqJAxsLMJJbA=;
 b=JE0/6giF4HuaBufvw1jiR/Z4QVqaUyASMznriiZ4ifjR9k4FiKXxGOW8ql3eVeumaE
 NcEJV866hSqG5MwWxiYng0XMqXN8vPt44auPNIJ6m5fipoh8bsAXNwOoSOoH1YR6gIqz
 CRHtByztVrfPIy5QygCOFLFZdIW3sttFKeuNyAWxAM+ZMCEuF28Z6HlqwfDb8HklLj+K
 t5zMvq+rBd6QD58bqv4l/CH1tFf6xvxuO3mlYvhfdjHBEWX/JGbcTapp3bAYLE6TKBAA
 bx1iw60ffR19Fg7kRfxNU1izEP018UGdKDWxTRuIu0vhNitR09CRS1+7HTC1k/6jGrl4
 SUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=49UgUsuSZpbxMCQ1i25UEUHUhYi5jAwhqJAxsLMJJbA=;
 b=lceK6di4jB1jk8HUfLcDrhwQYMtu1hPQJZLDZxbFvQBCNcWu8oGe3akp5+7PTHhgwe
 wpWbmj2cQbiazOBKYdR/b9Eh4RvZ40aesPP3lgss9SaJXW7h5d5TvR8NoglYKwBtf1hO
 ZW4rzbJkaTXtyGJiuYRBJCOZMQHTEOOnE0/OiViSeyxvKQTJAl1IT4jTHSh5IqRVAiah
 eQEdZmhbqJ5Ig2Pw8dLQzIiUN72N/zZNHdzKSF6+a8HZU9rbPLcM9puBmYNCdLN8agWm
 ELZRTARTqa0bLdKXB50IUBFTaVmephaDTBQaFbkddoP19+RyejVDyLDNhZ/ZLVcLQaNf
 e9iQ==
X-Gm-Message-State: AOAM532vLHS2LC6P57CV0lwX6p4Qiwo9wuPfYgnc2LFM0SGGWy/aqQaN
 vrELukAqHFbvRVbQQNNaFl1ntWvjMv3yT8IGqdY=
X-Google-Smtp-Source: ABdhPJz+24UgqtQiE8ggUQSe1O6SQ1aOICXYByjZaTiGIUF4g0xhjoIeDoIOqrSJY6Ir1FZm9dcTspBNQgJUARtI9g8=
X-Received: by 2002:aa7:de82:: with SMTP id j2mr691360edv.3.1601285010642;
 Mon, 28 Sep 2020 02:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <CA+FuTSe08hRwQ_c1Uk7BzHWL1HwTGWQ7kKG1tfBUifOtayVMGw@mail.gmail.com>
In-Reply-To: <CA+FuTSe08hRwQ_c1Uk7BzHWL1HwTGWQ7kKG1tfBUifOtayVMGw@mail.gmail.com>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Mon, 28 Sep 2020 17:21:18 +0800
Message-ID: <CAMDZJNX2yUv9rL4v++SnL34bcKRiX2zJ2Qnjni4U_SDtjeOLWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: don't disable guest csum when disable LRO
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Sep 28, 2020 at 4:35 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 5:41 AM <xiangxia.m.yue@gmail.com> wrote:
> >
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > Open vSwitch and Linux bridge will disable LRO of the interface
> > when this interface added to them. Now when disable the LRO, the
> > virtio-net csum is disable too. That drops the forwarding performance.
> >
> > Fixes: e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")
>
> Patch looks fine to me, but wrong commit here?
Yes, I will change the tag.
> That commit disables csum on purpose when enabling xdp with ndp_bpf.
>
> This patch refines disabling LRO with ndo_set_features.
>
> The relevant commit is a02e8964eaf9 ("virtio-net: ethtool configurable LRO").
>
> If this is a fix, it should target [PATCH net] separately from the
> second patch in the patchset, which is a new feature and targets
> [PATCH net-next]. They can arguably target net-next together, but then
> it should not have a fixes tag.
Thanks, I will send first patch for net, and next one to net-next.
>
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
> >         VIRTIO_NET_F_GUEST_CSUM
> >  };
> >
> > +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > +                               (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> > +                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > +                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > +
> >  struct virtnet_stat_desc {
> >         char desc[ETH_GSTRING_LEN];
> >         size_t offset;
> > @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
> >                 if (features & NETIF_F_LRO)
> >                         offloads = vi->guest_offloads_capable;
> >                 else
> > -                       offloads = 0;
> > +                       offloads = vi->guest_offloads_capable &
> > +                                  ~GUEST_OFFLOAD_LRO_MASK;
> >
> >                 err = virtnet_set_guest_offloads(vi, offloads);
> >                 if (err)
> > --
> > 2.23.0
> >



-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
