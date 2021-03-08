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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16EDC433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:07:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E18565224
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18565224
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FB8849DB8;
	Mon,  8 Mar 2021 16:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O32bysggl6XW; Mon,  8 Mar 2021 16:07:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96C7F49921;
	Mon,  8 Mar 2021 16:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 778B8C000B;
	Mon,  8 Mar 2021 16:07:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE51C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED8716F4C5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RZU20hf0eqpK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:07:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A23BF6F4C1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:07:52 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id p8so21433507ejb.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Mar 2021 08:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9fWdVn7nLt3E3L4QID9g8tlOiKwr5cryDbVteVsjhto=;
 b=hby+9gRwE9g9hGAihLCdCtBZ+y4eU1Zfe61MagbI6fqe4FrPk/dLp7WrdubLG93OD4
 xs6lPQ1gHQheNmcoCu6iCEgcfHG9g7FxaBOxs8BB5gxPKEvR1YTBtFilN6gcbe1qPGol
 D1kArFIP6UYLue+0sZkge50+rXKAFp+ylwJ0rVzlyX/UmyDc0tzOPaL6pGW42eG2hSZ5
 dXvgTuHFS/YR8OBxpnDOBvgzZXiuIp//VjqV9BVEjoAlxoX8AodWem+MR0qvm79GGDEu
 DrJvlQdq/Oo/XWQVkj5+PHPoz+34btM4p7tCUKmuKJ7GvdUaDMYsSCQeLQr2jw/AtUJi
 b1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9fWdVn7nLt3E3L4QID9g8tlOiKwr5cryDbVteVsjhto=;
 b=DFdZ28c4OBTbWlHbVrcdqPwTSewJ/2QBEcYAtwr9AfLa4cNyU2fUSKUPNT8KLiA7jC
 e4ZK3ZW4Q2geUJFa7S+Wy8VNCh7gHnm/5EPojphtFfwY9e6u+gBVC9pkXA61C3bGn2t6
 uYa/aibevffBR8fXPsjPfF256QAu8Zj9yr+10b4L1GH7oT4Q6wQmgM49dCiReDDOyhs1
 yP9sWkZEpoWllEYMMqbu+ePOQsRBS00HcLrdDJSWicPsJ0658zPVg3vnk2TK2Pr+SEOD
 aDPG07DU9KwDMOzF4kyjznvVAm8SJP7D8pqX/faZA1rTKGyL/aS8rHZdneZzd1FpRH87
 hhiQ==
X-Gm-Message-State: AOAM531MV1p+HpslXqemIwfEhDuXQZFof/qpRtw6xDt+hv8T7jNEB7ln
 xGffX7ye+YSKNWkwpY1kPT40c/wrEhs=
X-Google-Smtp-Source: ABdhPJxa5Zns62uBbAiYgfoubFGCWCGnreoE6RrK5NoiZIY4Kr+M/sxwg9ymafmJEg69mDqGLFYCoQ==
X-Received: by 2002:a17:906:18f1:: with SMTP id
 e17mr15269821ejf.372.1615219670668; 
 Mon, 08 Mar 2021 08:07:50 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48])
 by smtp.gmail.com with ESMTPSA id t12sm1632263edy.56.2021.03.08.08.07.50
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Mar 2021 08:07:50 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id
 t5-20020a1c77050000b029010e62cea9deso4138121wmi.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Mar 2021 08:07:50 -0800 (PST)
X-Received: by 2002:a05:600c:4150:: with SMTP id
 h16mr21312488wmm.120.1615219669904; 
 Mon, 08 Mar 2021 08:07:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615199056.git.bnemeth@redhat.com>
 <85e04e1e6367f19c8f538d145b32f5bb93788d8a.1615199056.git.bnemeth@redhat.com>
In-Reply-To: <85e04e1e6367f19c8f538d145b32f5bb93788d8a.1615199056.git.bnemeth@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 8 Mar 2021 11:07:10 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
Message-ID: <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: avoid infinite loop in mpls_gso_segment when
 mpls_hlen == 0
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
> A packet with skb_inner_network_header(skb) == skb_network_header(skb)
> and ETH_P_MPLS_UC will prevent mpls_gso_segment from pulling any headers
> from the packet. Subsequently, the call to skb_mac_gso_segment will
> again call mpls_gso_segment with the same packet leading to an infinite
> loop.
>
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>
> ---
>  net/mpls/mpls_gso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
> index b1690149b6fa..cc1b6457fc93 100644
> --- a/net/mpls/mpls_gso.c
> +++ b/net/mpls/mpls_gso.c
> @@ -27,7 +27,7 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
>
>         skb_reset_network_header(skb);
>         mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
> -       if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
> +       if (unlikely(!mpls_hlen || !pskb_may_pull(skb, mpls_hlen)))
>                 goto out;

Good cathc. Besides length zero, this can be more strict: a label is
4B, so mpls_hlen needs to be >= 4B.

Perhaps even aligned to 4B, too, but not if there may be other encap on top.

Unfortunately there is no struct or type definition that we can use a
sizeof instead of open coding the raw constant.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
