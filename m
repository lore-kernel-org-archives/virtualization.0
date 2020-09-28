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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F572C2D0A8
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 08:35:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE55206DC
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1n7gT5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE55206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5512A8602E;
	Mon, 28 Sep 2020 08:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFtZVG7XWyv5; Mon, 28 Sep 2020 08:35:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B9A8481DFD;
	Mon, 28 Sep 2020 08:35:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77F77C0889;
	Mon, 28 Sep 2020 08:35:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AD0DC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 39B6920409
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZiKr6YmpeiX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:35:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
 [209.85.217.68])
 by silver.osuosl.org (Postfix) with ESMTPS id BBA1C20402
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:35:05 +0000 (UTC)
Received: by mail-vs1-f68.google.com with SMTP id x203so251491vsc.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K0aYGsIeM1DRZtz0d2V1pRZwao+9KEihDTgnA9Qcu1w=;
 b=n1n7gT5E1CqfMJCTWqyJVXIAuoYqjmQo/vij57GCYi7lxCWWEqr437bBhLwOw8GgFT
 xNiPYf4s5BXKbEE6h9w2QVcygi0NRQF5mLxSwfC9zW+vrddS4etk5tCTKU236vKE8ef6
 MPnZ6k2Elxy0Q/B5TzxWOCi7fxOHyH4frFv3AYgSRhwwELhx/D6afd+ENgna+BWkUo+S
 asbxeQLV/LOaHjiEpuQ6j7yw4gU3IXhidF06nolvbCUUTlV7yuLMzZxPcyp1VrtxNuTs
 QLOKOuyFiLmdMbIVWkd4R0XNPD9aWxODih4Q3V/zQfZbzOBKExbfHruFD66Mw3HYFoJ8
 lA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K0aYGsIeM1DRZtz0d2V1pRZwao+9KEihDTgnA9Qcu1w=;
 b=JQDjIeS2/dtwihyhK/Ifmck5X/MtQNVVUu61dY3uUdacqtVsl/bpHfiIadSoaIDCJN
 x3CFbNaLSIovsrSdQoWyU37DjJQ9AV/XF74WPV7exjH7yLu/GGEkhRzhFIFiLwDWu6/B
 0QPhA+uKdLE2iFAs0Acvs9jsgBLoCfDtNevtPtcoTm586lUGcf1Wr85HK+HQy2O680zR
 N91YMErQaaPvuHpw2YYiy9Y7o3TRLdBRhe9vbR/EXkrsMeBRV3MydBtmxTpL4i2Z67kh
 poGrdOGFgDO2WGOE4LB94tYf1oWtzlkxxONAQ83ILPtDDAqYPF382Pw5P8wXx9paEea1
 vHXg==
X-Gm-Message-State: AOAM532OIT9PhRYZZsvWeeOyijnTEF6osBQbYPU9rNrE+kN49dulnN0L
 ap7nzY4ls8bIkrGoz/almraFKyRfCV93zA==
X-Google-Smtp-Source: ABdhPJyvzK4nlHvF+kQFWmykOhTKtH2R5iVXt3Lj7PkUwJMDF9dley1O+n+f7j5cdvIbO7/TjDzBsw==
X-Received: by 2002:a67:cb02:: with SMTP id b2mr227030vsl.41.1601282104212;
 Mon, 28 Sep 2020 01:35:04 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com.
 [209.85.217.46])
 by smtp.gmail.com with ESMTPSA id p186sm1019948vkf.35.2020.09.28.01.35.02
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 01:35:03 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id a16so250614vsp.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 01:35:02 -0700 (PDT)
X-Received: by 2002:a67:d84:: with SMTP id 126mr223275vsn.51.1601282102334;
 Mon, 28 Sep 2020 01:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
In-Reply-To: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Sep 2020 10:34:25 +0200
X-Gmail-Original-Message-ID: <CA+FuTSe08hRwQ_c1Uk7BzHWL1HwTGWQ7kKG1tfBUifOtayVMGw@mail.gmail.com>
Message-ID: <CA+FuTSe08hRwQ_c1Uk7BzHWL1HwTGWQ7kKG1tfBUifOtayVMGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: don't disable guest csum when disable LRO
To: xiangxia.m.yue@gmail.com
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

On Mon, Sep 28, 2020 at 5:41 AM <xiangxia.m.yue@gmail.com> wrote:
>
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>
> Open vSwitch and Linux bridge will disable LRO of the interface
> when this interface added to them. Now when disable the LRO, the
> virtio-net csum is disable too. That drops the forwarding performance.
>
> Fixes: e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")

Patch looks fine to me, but wrong commit here?

That commit disables csum on purpose when enabling xdp with ndp_bpf.

This patch refines disabling LRO with ndo_set_features.

The relevant commit is a02e8964eaf9 ("virtio-net: ethtool configurable LRO").

If this is a fix, it should target [PATCH net] separately from the
second patch in the patchset, which is a new feature and targets
[PATCH net-next]. They can arguably target net-next together, but then
it should not have a fixes tag.

> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7145c83c6c8c..21b71148c532 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
>         VIRTIO_NET_F_GUEST_CSUM
>  };
>
> +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> +                               (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> +                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> +                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> +
>  struct virtnet_stat_desc {
>         char desc[ETH_GSTRING_LEN];
>         size_t offset;
> @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
>                 if (features & NETIF_F_LRO)
>                         offloads = vi->guest_offloads_capable;
>                 else
> -                       offloads = 0;
> +                       offloads = vi->guest_offloads_capable &
> +                                  ~GUEST_OFFLOAD_LRO_MASK;
>
>                 err = virtnet_set_guest_offloads(vi, offloads);
>                 if (err)
> --
> 2.23.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
