Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1808C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 15:51:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6634864E6F
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 15:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6634864E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF5C186EA0;
	Thu, 18 Feb 2021 15:51:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id USfAmad1308Q; Thu, 18 Feb 2021 15:51:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 520A986E67;
	Thu, 18 Feb 2021 15:51:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40BB8C000E;
	Thu, 18 Feb 2021 15:51:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF65C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6B4BE8697D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sG84UPBx7Scr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:51:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB35986972
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:51:17 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id jt13so6496238ejb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vRWwBoukUWpf3kaTTQrlN4IVGff71cdIbdnfQeS/5Ko=;
 b=ZVoi+oDtUzlcdEftLSGeZhPJ2XfgGG18MLP6hZBH6xqL/SbYLgcIyQcpiW7B3eIVHg
 JTUcIBighF7XrK/6WhbfwshV0nZbSMWBiaUICBZhk3Zz6+RZ4mgQXDccbbV+Ow6Cca7x
 HPHX1sO/l0NCL0FBm5ZR3SVOcOtNa3KF4lq3tJX8OcmA4w7fxoo69WX2hWcOlOlwBIpV
 RM36Jnkn3ChZmluCRMIg0UHhZsykSrg5Uo4Ygwbd/nJYp9c3aBYyL544OtNbLVYi5oxD
 tlih6vyHpTm8EAkuDky1TDHxk5jpzgSpksejmXWGu07y959dgwi9LT3ZSSTET4WstBVK
 /stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vRWwBoukUWpf3kaTTQrlN4IVGff71cdIbdnfQeS/5Ko=;
 b=tVonA5UV8wWN/uAa/KqhVeMvumlpTx+c2dJrklaMQgrngBgP9LPn0fpUCXqnIRqqWu
 Uamcr4NuumU1kzCxnEB8n7YSfIKTeTEus7ZBE54TNBp8jd4EOWZuPAtDfKeuuvrEEslc
 cv/H5xt/xRWJ/kfHAp5ndcSpCl7F/ZQLZybL+L5SmdjaFoCbUkf6BlMdcCH1Igh79DPp
 5el9WuzV5Fchz/pvLFor8ui5jvqAXRIWQvbAo9pbh42e53zyyS4gRKCJw5mFybOW3kR8
 tZHtuH6BETFmVf/1+zTSJPOvnBo4Bh5TN/VlkVnj1Q65PzRVlrI19YMLHS+Fc0V7mc0w
 DLcA==
X-Gm-Message-State: AOAM532rHaFL8FCmR+aNpYXVD+T2pQOH7084zE5ar+AXqCyg4LoIJzyw
 mUz/11Ub2HiLZwWcoZeFiYctrKqxdLA=
X-Google-Smtp-Source: ABdhPJzra3Qdp0hcedtJDJ8/6wFBsVoqoJ59mk3Ols3t6P3UjhQmOygjrBaYLNmjRXt3f6rzADQWUA==
X-Received: by 2002:a17:906:cc91:: with SMTP id
 oq17mr4493523ejb.45.1613663476010; 
 Thu, 18 Feb 2021 07:51:16 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41])
 by smtp.gmail.com with ESMTPSA id bn2sm2828741ejb.35.2021.02.18.07.51.14
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Feb 2021 07:51:15 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id u14so3520236wri.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 07:51:14 -0800 (PST)
X-Received: by 2002:a5d:4b84:: with SMTP id b4mr5020550wrt.50.1613663474248;
 Thu, 18 Feb 2021 07:51:14 -0800 (PST)
MIME-Version: 1.0
References: <5e910d11a14da17c41317417fc41d3a9d472c6e7.1613659844.git.bnemeth@redhat.com>
In-Reply-To: <5e910d11a14da17c41317417fc41d3a9d472c6e7.1613659844.git.bnemeth@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 18 Feb 2021 10:50:37 -0500
X-Gmail-Original-Message-ID: <CA+FuTSe7srSBnAmFNFBFkDrLmPL5XtxhbXEs1mBytUBuuym2fg@mail.gmail.com>
Message-ID: <CA+FuTSe7srSBnAmFNFBFkDrLmPL5XtxhbXEs1mBytUBuuym2fg@mail.gmail.com>
Subject: Re: [PATCH] net: check if protocol extracted by
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

On Thu, Feb 18, 2021 at 10:01 AM Balazs Nemeth <bnemeth@redhat.com> wrote:
>
> For gso packets, virtio_net_hdr_set_proto sets the protocol (if it isn't
> set) based on the type in the virtio net hdr, but the skb could contain
> anything since it could come from packet_snd through a raw socket. If
> there is a mismatch between what virtio_net_hdr_set_proto sets and
> the actual protocol, then the skb could be handled incorrectly later
> on by gso.
>
> The network header of gso packets starts at 14 bytes, but a specially
> crafted packet could fool the call to skb_flow_dissect_flow_keys_basic
> as the network header offset in the skb could be incorrect.
> Consequently, EINVAL is not returned.
>
> There are even packets that can cause an infinite loop. For example, a
> packet with ethernet type ETH_P_MPLS_UC (which is unnoticed by
> virtio_net_hdr_to_skb) that is sent to a geneve interface will be
> handled by geneve_build_skb. In turn, it calls
> udp_tunnel_handle_offloads which then calls skb_reset_inner_headers.
> After that, the packet gets passed to mpls_gso_segment. That function
> calculates the mpls header length by taking the difference between
> network_header and inner_network_header. Since the two are equal
> (due to the earlier call to skb_reset_inner_headers), it will calculate
> a header of length 0, and it will not pull any headers. Then, it will
> call skb_mac_gso_segment which will again call mpls_gso_segment, etc...
> This leads to the infinite loop.
>
> For that reason, address the root cause of the issue: don't blindly
> trust the information provided by the virtio net header. Instead,
> check if the protocol in the packet actually matches the protocol set by
> virtio_net_hdr_set_proto.
>
> Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>
> ---
>  include/linux/virtio_net.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index e8a924eeea3d..cf2c53563f22 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -79,8 +79,13 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                 if (gso_type && skb->network_header) {
>                         struct flow_keys_basic keys;
>
> -                       if (!skb->protocol)
> +                       if (!skb->protocol) {
> +                               const struct ethhdr *eth = skb_eth_hdr(skb);
> +

Unfortunately, cannot assume that the device type is ARPHRD_ETHER.

The underlying approach is sound: packets that have a gso type set in
the virtio_net_hdr have to be IP packets.

>                                 virtio_net_hdr_set_proto(skb, hdr);
> +                               if (skb->protocol != eth->h_proto)
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
