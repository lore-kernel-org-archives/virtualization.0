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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB49EC2D0A8
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 08:39:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6649E207E8
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 08:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8E9zVAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6649E207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1AEE4861A0;
	Mon, 28 Sep 2020 08:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f9y+BbXJIWlX; Mon, 28 Sep 2020 08:39:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97E3686180;
	Mon, 28 Sep 2020 08:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EBFDC0889;
	Mon, 28 Sep 2020 08:39:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89B7BC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 63CD32044B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jjbSN4OpxGps
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:39:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com
 [209.85.221.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 985FC203F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 08:39:30 +0000 (UTC)
Received: by mail-vk1-f196.google.com with SMTP id k78so1357494vka.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P2hn9r7bUHQ5/qOvCxhqCGVg5WiOwDkVWGWEKMyNnY0=;
 b=m8E9zVAi8kq5j5HCZRX3DgXynR+9bcKt9YaJm1xEdTNq2Y1p8cEq3kBZmwZCdZM2At
 jONoxjHFaitcyiSmwSd4SSKleFlrg8NL9yt2hY5YqAWqaV6HKWSXcjb2xwowSiI3sWZ1
 A/fRc1AD6HS3VZRr7caYl6BVV4868ggTY7aC01veJb8EYlhxFEuvaEWHGCxrI1918xDq
 np6D2i0VrSdKmki5ewAoMrpU3+a7XzItHHMMTfEf0q+tjpRxuV+x2voY+lHwuS81xZW3
 59+CU6U5v3PWVkX6tpXOOhB/tLqLlaLFXyWrwmM2RV1o96qZFks+vBKxYExTLUi3Mcfe
 fFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P2hn9r7bUHQ5/qOvCxhqCGVg5WiOwDkVWGWEKMyNnY0=;
 b=Zjk8wukb1xknDfp2OfnmnhcMP7SfUwHIAA4KuhkorFOi7VBf2VXNgJfGsHNUVNcSRa
 XlvNhDuAoKiTuR+BbDdprRDfqyMYdU31+YXEoNmNcaObq0DIUdc1ACgRFph1+piogOY8
 3Y1/ltL08e73kWOFlIWQyGPfaU97mukUxoJR5dNd6r1gp1igVAtr4pP7h61IMJJ2kAxf
 ZqwjtJR1w60LGjiZFHbj9coDr6fcoFh7y8LkalL0w9EuLXGHNW7QCMyZDWyYBxmcahT+
 oXUy0PkGvydUZ5rRWaogtYmx+k8nMr7QztuGu38GxT9nUSjHFCkLmOpDjFiRb0QrlG8R
 jE5A==
X-Gm-Message-State: AOAM533GtYBS929bNDOKpeUVo0xayJsm7nIv6peEmw5i6MFMXIo6vvGo
 XGvUcTyfs3FPpslPP4QFmkO4nVQIRfvqMw==
X-Google-Smtp-Source: ABdhPJy68y+2FBKaAI5gtUEVssWoRX5D5YVPIMxUqESoPZlD5rYSJ59qiNIr9LB60ETqTXzJUJ462g==
X-Received: by 2002:ac5:cced:: with SMTP id k13mr4303302vkn.7.1601282369204;
 Mon, 28 Sep 2020 01:39:29 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53])
 by smtp.gmail.com with ESMTPSA id 103sm24306uau.13.2020.09.28.01.39.28
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 01:39:28 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id 5so272620vsu.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 01:39:28 -0700 (PDT)
X-Received: by 2002:a67:e83:: with SMTP id 125mr4637210vso.22.1601282367887;
 Mon, 28 Sep 2020 01:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
In-Reply-To: <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Sep 2020 10:38:51 +0200
X-Gmail-Original-Message-ID: <CA+FuTSeOzCAVShBa1VTXtkqzc9YFdng_Dk1wVbjVeniTRREM=A@mail.gmail.com>
Message-ID: <CA+FuTSeOzCAVShBa1VTXtkqzc9YFdng_Dk1wVbjVeniTRREM=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: ethtool configurable RXCSUM
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

On Mon, Sep 28, 2020 at 5:42 AM <xiangxia.m.yue@gmail.com> wrote:
>
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>
> Allow user configuring RXCSUM separately with ethtool -K,
> reusing the existing virtnet_set_guest_offloads helper
> that configures RXCSUM for XDP. This is conditional on
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
>  drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 21b71148c532..2e3af0b2c281 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
>                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
>
> +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> +
>  struct virtnet_stat_desc {
>         char desc[ETH_GSTRING_LEN];
>         size_t offset;
> @@ -2526,25 +2528,37 @@ static int virtnet_set_features(struct net_device *dev,
>                                 netdev_features_t features)
>  {
>         struct virtnet_info *vi = netdev_priv(dev);
> -       u64 offloads;
> +       u64 offloads = vi->guest_offloads &
> +                      vi->guest_offloads_capable;
>         int err;
>
> -       if ((dev->features ^ features) & NETIF_F_LRO) {
> -               if (vi->xdp_queue_pairs)
> -                       return -EBUSY;
> +       /* Don't allow configuration while XDP is active. */
> +       if (vi->xdp_queue_pairs)
> +               return -EBUSY;
>
> +       if ((dev->features ^ features) & NETIF_F_LRO) {
>                 if (features & NETIF_F_LRO)
> -                       offloads = vi->guest_offloads_capable;
> +                       offloads |= GUEST_OFFLOAD_LRO_MASK;
>                 else
> -                       offloads = vi->guest_offloads_capable &
> -                                  ~GUEST_OFFLOAD_LRO_MASK;
> +                       offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> +       }
>
> -               err = virtnet_set_guest_offloads(vi, offloads);
> -               if (err)
> -                       return err;
> -               vi->guest_offloads = offloads;
> +       if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> +               if (features & NETIF_F_RXCSUM)
> +                       offloads |= GUEST_OFFLOAD_CSUM_MASK;
> +               else
> +                       offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
>         }

LRO requires receive checksum offload: packets must have their
checksum verified prior to coalescing.

The two features can thus not be configured fully independently.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
