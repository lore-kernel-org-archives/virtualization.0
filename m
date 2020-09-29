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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD7AC4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:32:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D438A207F7
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx5Q8lrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D438A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4A7D6866E2;
	Tue, 29 Sep 2020 07:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zbOj7sti4kte; Tue, 29 Sep 2020 07:32:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3C960866D9;
	Tue, 29 Sep 2020 07:32:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CAD8C0890;
	Tue, 29 Sep 2020 07:32:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A69FC016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1927786FED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jUf7LgaU8Cni
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:32:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
 [209.85.217.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7150986FC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:32:02 +0000 (UTC)
Received: by mail-vs1-f66.google.com with SMTP id e2so2362223vsr.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kqGHxvLut0c3Qv4bId0WIqz7ueuiNhUcIgNgX6FtrLc=;
 b=Rx5Q8lrOPfcBq82BZDnLwdmzhc8lnrn8nvRZEQzUGR2Efsjtjfxh8S8+Bve6xwf5dn
 d6qnVhYnQKRGOOehc03UMQ/Kno1uB0WQ+FjHOR/+ja+MpWz2dFnHT8Vf50GRtIcKHoPU
 gq5mZdn5apqOP77gj5Y9kk8qsp865sENGF/qarlR3E6gnMZeOb0H2h5+KNd4g51zb436
 EHfENUJJKrdSacii4Dd2mFTQhvJkSAoxmY0QdUdEvp+3fxUlX1WZ5J9qI5GO8Vb/XZSv
 cma8TDlxwm8JUzpv5JvJ5WiD7ng3pxyf2BaL4vWWdA91RLDL8CZ17/7tPofgK7DpxgHr
 r3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kqGHxvLut0c3Qv4bId0WIqz7ueuiNhUcIgNgX6FtrLc=;
 b=YN2//T7wDPQlGCKQ+yx56L0vPCngf7XRuSvjllwLfWAuqAnNceIakpCw3MsPK94YFR
 bkQ7pdNQOzm84/v06kLNFE8T+0L6ZzQtMJE3uGX1wYteWgvV0jmChom604M+LOkT7mSL
 B1KrtzPA6g06aLk2gZshavxC/odKhugSywO9MCHVN2XdIffYfEFEUQdqs0UTGCDBFImC
 NCGRFhzKWr3zeH4hbFKpGN9rTd5CTpy5BAlQaaQNouJ47zO54uXxbSbZVGztdXhmqcFW
 XiWcLpLVjzI3ioTf8YuppUogRcBf6/0gTQkHFQJa8Hm6a39UZqyCIMJKqo6nTpKKQUN3
 FY3A==
X-Gm-Message-State: AOAM532qZDfSj/h2pkMZVeCC4mHLrnYrzgG5TYk4x2vxRhHAmACzh5db
 dVDLJe5yWhlzE1fbXR3owqh0jUDk5scakA==
X-Google-Smtp-Source: ABdhPJxfVtjrElPdAImqyppuW8O0vk9/Rp9AP4kvdEPfvFKnMvDutEit7SRTmwZOB+GxZy8dE6Oy4Q==
X-Received: by 2002:a67:b60a:: with SMTP id d10mr658742vsm.35.1601364720743;
 Tue, 29 Sep 2020 00:32:00 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177])
 by smtp.gmail.com with ESMTPSA id b140sm439901vsd.14.2020.09.29.00.31.59
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 00:31:59 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id c25so2194754vkm.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:31:59 -0700 (PDT)
X-Received: by 2002:a1f:1f0d:: with SMTP id f13mr1757897vkf.1.1601364719268;
 Tue, 29 Sep 2020 00:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
In-Reply-To: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 29 Sep 2020 09:31:23 +0200
X-Gmail-Original-Message-ID: <CA+FuTSebRQ=2VfT0KnM6ChjMg0j3NWJDPwn9S=aQk8tbNrUt6w@mail.gmail.com>
Message-ID: <CA+FuTSebRQ=2VfT0KnM6ChjMg0j3NWJDPwn9S=aQk8tbNrUt6w@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: don't disable guest csum when disable
 LRO
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
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

On Tue, Sep 29, 2020 at 4:00 AM <xiangxia.m.yue@gmail.com> wrote:
>
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>
> Open vSwitch and Linux bridge will disable LRO of the interface
> when this interface added to them. Now when disable the LRO, the
> virtio-net csum is disable too. That drops the forwarding performance.

I had focused on the code previously.

The s/w checksum verification cost is significant in a VM with traffic
to local destinations. A bridge does not verify transport layer
checksums OTOH?

> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
> v2:
> * change the fix-tag
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
