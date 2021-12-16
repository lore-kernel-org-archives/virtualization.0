Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988B8C433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Dec 2021 03:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D18B40ACE;
	Thu, 16 Dec 2021 03:24:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H8GP-rKNbMqO; Thu, 16 Dec 2021 03:24:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A48F40587;
	Thu, 16 Dec 2021 03:24:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D3D9C001E;
	Thu, 16 Dec 2021 03:24:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10965C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 03:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC895416A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 03:23:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i_z7xqVPCqwy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 03:23:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 692204169B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 03:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639625036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NpP4+hk92r4w2B9+P9RZxFn4KHsmw9feHBEAh+dzxBI=;
 b=ciZucP3fpuFk/k6QW8FK3ztj/sIuT8G5g2aYtjrvs+q+YUS38kNGwugQbR1NBjJON0cGB2
 SzqChuAlPLV5XvfF0m6113299k3oHecODYvqa4fTnLEnRMZCFwQRlp3EfO7B7/hIPZ2d2F
 RaOqoxNVuJ182C701sV70vGfMi4gNdA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-q1HAojLiMjieU1pCoLyfVQ-1; Wed, 15 Dec 2021 22:23:55 -0500
X-MC-Unique: q1HAojLiMjieU1pCoLyfVQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 o15-20020a2e90cf000000b00218dfebebdeso7914508ljg.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 19:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NpP4+hk92r4w2B9+P9RZxFn4KHsmw9feHBEAh+dzxBI=;
 b=TtAsgCz/QOdmDrHjDE/UdxHtLwZUJrreW7TwQ7175q1qN2l63kZkRJXxpcVlyb2HwQ
 3aLvWX1KOBB9IhDcUB+HFm1/ksU8l1HCPxvqBwyraKNLOZqjB0Xcq8MldgJvNba/kZD9
 /qD1e/ddv2DHCfWWtTZyeU0J93v1iXt5SfxOjF5A/o4j2t26u8X6mhhlFFzaGm1j4NpI
 L9k9MdVeiVlqxmrIm8Qc3mxxTtaj6Zsl2wZhShp8S5qIczSCEfP3FECx5NFigh6cioGY
 f1Za8k0K0S21RkrvRrv7zE8WjLy3hiMljOCAkMZi6cEtSFXdxxE6N5LlrtDO9bKeup/2
 8hhg==
X-Gm-Message-State: AOAM5303balQjlslt1i22K69Evh6Jyv5xUWpOW+hJelZ2ph/2ruMK5AD
 SQ2TPDHwXQeczzilm2s69B6uIM+GANE+i34vz4a9uH9jJYyFQ3F0uTVE58R9Ecq+BpgN4ezCHIE
 TPZGyPjoTU8Vv0mtbbZQHQZBOHOkm8EpKWPDnH7pjdu5j3IVQqJ5FuZcshQ==
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr13762191ljk.420.1639625033575; 
 Wed, 15 Dec 2021 19:23:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBMixYaEZyd4edEWw5Bj/aizM8U5Uj0hSuNa6Ik2s82KlOktsgxUZAtKHuh6rOaExNcjN8fE1mOpyHnQE3Im8=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr13762176ljk.420.1639625033370; 
 Wed, 15 Dec 2021 19:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
In-Reply-To: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Dec 2021 11:23:42 +0800
Message-ID: <CACGkMEtPkybSyPRXqcqtBGbEHvMEw04dcWpUDswuXgwEnshBSA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: fix rx_drops stat for small pkts
To: Wenliang Wang <wangwenliang.1995@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, davem <davem@davemloft.net>
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

On Thu, Dec 16, 2021 at 11:12 AM Wenliang Wang
<wangwenliang.1995@bytedance.com> wrote:
>
> We found the stat of rx drops for small pkts does not increment when
> build_skb fail, it's not coherent with other mode's rx drops stat.
>
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/net/virtio_net.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 55db6a336f7e..b107835242ad 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -733,7 +733,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>                 pr_debug("%s: rx error: len %u exceeds max size %d\n",
>                          dev->name, len, GOOD_PACKET_LEN);
>                 dev->stats.rx_length_errors++;
> -               goto err_len;
> +               goto err;
>         }
>
>         if (likely(!vi->xdp_enabled)) {
> @@ -825,10 +825,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
>
>  skip_xdp:
>         skb = build_skb(buf, buflen);
> -       if (!skb) {
> -               put_page(page);
> +       if (!skb)
>                 goto err;
> -       }
>         skb_reserve(skb, headroom - delta);
>         skb_put(skb, len);
>         if (!xdp_prog) {
> @@ -839,13 +837,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
>         if (metasize)
>                 skb_metadata_set(skb, metasize);
>
> -err:
>         return skb;
>
>  err_xdp:
>         rcu_read_unlock();
>         stats->xdp_drops++;
> -err_len:
> +err:
>         stats->drops++;
>         put_page(page);
>  xdp_xmit:
> --
> 2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
