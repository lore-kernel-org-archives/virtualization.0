Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC1C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:02:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79256521D
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79256521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC2B06F477;
	Mon,  8 Mar 2021 16:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hBNfKJ6YBBbk; Mon,  8 Mar 2021 16:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46E7E6F4DC;
	Mon,  8 Mar 2021 16:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB8BC000A;
	Mon,  8 Mar 2021 16:02:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3D40C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB9F4499F3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qaKnowloiO3t
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:02:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B1944954E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:02:18 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id jt13so21475864ejb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Mar 2021 08:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NxiEy8ngZSokddcTCYt4nwbLH8RmaBWtr4TL2Y05SAk=;
 b=saj2O1QdxK6slYJFU1OOFaCUnduRugIlRrckll+J7guPfb2NP8uN3xVMlAJuW8kE/1
 yOxLpDxeUqurKTGsL9bh9pHi9R3GYLFqJgW+GttJ9QaaepqCydx35O57yyeqv/WZ7A86
 G0k8y6bzsEm9SYx1NGh66aoWZAw/79OvaV7AOaGrLpifMFgHZciNwEDKGg17t2Pjmy87
 IX5p+k1sYcLPuRW2PC9eXIP2JRoVUn3lf8l/w/5rn5QJMXYofAuDp1f7QUhDMxX5e/hP
 Ne8Tply/7orVzVAgwypbC2CvEn35RLbdRZ5fNtw08EIjS0ka+n0+UG+livh+IApV52XN
 vssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NxiEy8ngZSokddcTCYt4nwbLH8RmaBWtr4TL2Y05SAk=;
 b=PVkc4wm+8asAgPzUrtzFoc0WAgN8Lxq3m0FzeV09P1uFSJD/s3QKgSuprV4qE71YVn
 h3EVbzR3roHex4CtYNgkQ+lHop7BABgJqwJr8VXPkf71dYcN3vVekR73P8GiKCwcrkaq
 hw7Nln6btTae4RvZA2wAA9EFTeYSxAFrae1xeGSKIB3tw7Pssm3jSOLTAeP629gFQqCR
 WegS3uc2HhZwz7zOHUVdbj/b4q4ffDqL53xLPdtBAnSZaAXNWY/QbpETwcyy/gK+ydlG
 yokf3gKBY4z/Dq/eFhkn3mKPDzQlQO41zsqsqZCKKpu+EJbNf005Cz8ScTV+KRosuNIj
 ubIQ==
X-Gm-Message-State: AOAM532JDxvJxqtjMkyY6l9eTl2w6uBmq4Bpt/3FnvdCqNu7Wjp4SlM9
 TnEJGyhngocY5s//R5zVejlj7ox1miI=
X-Google-Smtp-Source: ABdhPJyXYrgpPb2llmjj/iFVGV5PTrGdAUxPBHmmDx24fS0jDW2x+1Jvq2PJ/4sUNWktvnYN0H1Abg==
X-Received: by 2002:a17:906:414e:: with SMTP id
 l14mr15043032ejk.406.1615219336333; 
 Mon, 08 Mar 2021 08:02:16 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id r17sm6678827ejz.109.2021.03.08.08.02.14
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Mar 2021 08:02:15 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id
 c76-20020a1c9a4f0000b029010c94499aedso4116878wme.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Mar 2021 08:02:14 -0800 (PST)
X-Received: by 2002:a05:600c:198c:: with SMTP id
 t12mr22392924wmq.183.1615219334650; 
 Mon, 08 Mar 2021 08:02:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615199056.git.bnemeth@redhat.com>
 <8f2cb8f8614d86bba02df73c1a0665179583f1c3.1615199056.git.bnemeth@redhat.com>
In-Reply-To: <8f2cb8f8614d86bba02df73c1a0665179583f1c3.1615199056.git.bnemeth@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 8 Mar 2021 11:01:35 -0500
X-Gmail-Original-Message-ID: <CA+FuTSduKqeLB8wcLxiZXHgQF6y596F-nt+UwzUZngdTWwZ_rA@mail.gmail.com>
Message-ID: <CA+FuTSduKqeLB8wcLxiZXHgQF6y596F-nt+UwzUZngdTWwZ_rA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To: Balazs Nemeth <bnemeth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
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

On Mon, Mar 8, 2021 at 5:32 AM Balazs Nemeth <bnemeth@redhat.com> wrote:
>
> For gso packets, virtio_net_hdr_set_proto sets the protocol (if it isn't
> set) based on the type in the virtio net hdr, but the skb could contain
> anything since it could come from packet_snd through a raw socket. If
> there is a mismatch between what virtio_net_hdr_set_proto sets and
> the actual protocol, then the skb could be handled incorrectly later
> on.
>
> An example where this poses an issue is with the subsequent call to
> skb_flow_dissect_flow_keys_basic which relies on skb->protocol being set
> correctly. A specially crafted packet could fool
> skb_flow_dissect_flow_keys_basic preventing EINVAL to be returned.
>
> Avoid blindly trusting the information provided by the virtio net header
> by checking that the protocol in the packet actually matches the
> protocol set by virtio_net_hdr_set_proto. Note that since the protocol
> is only checked if skb->dev implements header_ops->parse_protocol,
> packets from devices without the implementation are not checked at this
> stage.
>
> Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>

Going forward, please mark your the patch as targeting the net tree
using [PATCH net]

> ---
>  include/linux/virtio_net.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index e8a924eeea3d..6c478eee0452 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -79,8 +79,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                 if (gso_type && skb->network_header) {
>                         struct flow_keys_basic keys;
>
> -                       if (!skb->protocol)
> +                       if (!skb->protocol) {
> +                               const struct ethhdr *eth = skb_eth_hdr(skb);

eth is no longer used.

> +                               __be16 etype = dev_parse_header_protocol(skb);

nit: customary to call this protocol. etype, I guess short for
EtherType, makes sense, but is not commonly used in the kernel.

> +
>                                 virtio_net_hdr_set_proto(skb, hdr);
> +                               if (etype && etype != skb->protocol)
> +                                       return -EINVAL;
> +                       }
>  retry:
>                         if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
>                                                               NULL, 0, 0, 0,
> --
> 2.29.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
