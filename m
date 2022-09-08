Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126E1C54EE9
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 20:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9618581CD0;
	Thu,  8 Sep 2022 20:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9618581CD0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=jKhP/Ykf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5qMKsr5EGLi; Thu,  8 Sep 2022 20:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E6CC81B01;
	Thu,  8 Sep 2022 20:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E6CC81B01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06E75C0032;
	Thu,  8 Sep 2022 20:23:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55FBFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F4C7410C2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:23:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F4C7410C2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=jKhP/Ykf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XC3OBqrv1jwO
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:23:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6480410C1
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6480410C1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:23:34 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 x10-20020a4a410a000000b004456a27110fso3132804ooa.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Sep 2022 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=ejDQxdZ4Qg5U+Lwtd5v3XArCobKY1X4cdGX+F5+IEYg=;
 b=jKhP/Ykfjcogl0cntL3IZHZafWe4kkcaNAAoHe0fvpVmVx5N9BTq5VDUXackqIxa9X
 jKQ5MZ7rXs/IDfIGIIj9hdY9SXXRjMk9avJupj888NQKwtDEoApnjbGpJhSzwvk9kuIC
 OR4L5D/e51/aj/ul5ZYCcxQSf1NJurMt6JnnBq5kGSiwsJ0TeahAJtUq9oktlA0vK2Rc
 9ac1VrTBcsDD4RYA2M5GslqPiekWgf37oJx34paM7sjXGuNKTHQqyCgkrlsuia+5AbcQ
 LUCYj+cgFOhLM6w8iuXvYXQ6rFi6+2QtjfdYEs+zSaXbj9ASjc0bURVUJsdXhbbnjXdd
 0ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=ejDQxdZ4Qg5U+Lwtd5v3XArCobKY1X4cdGX+F5+IEYg=;
 b=gzjXYVlR4ImjDuoGAgEPCSmw4fMXmzIAmf16txW9VyYksBuMS9x0nsgREo6mf1RvoK
 tcyUiLuKs2bAbpAE4i0+ML+TfK7Z0Q58Lc1JIYPguleTptV3iGWplADzRhwaoAyKuP4Y
 FQz9keNX0tqveY8PGIFwDNXRQjiCiMB9t0W6K3jjK8kS6552aJX8r432LmD9F/gGYnYz
 XZHCCno5UzHBz+4i/6Xx/Pfx7BoQwjY3F6JOrEP6tW1ErLaKSsH/HmgTz7yA8kJFf3fQ
 uxETpTqsb/xorMXAlj3BTQr1fWUxXCeG8Uq27tqYvuiFkuvvMfYzwdLnpAWyNvyyVSkc
 ukpg==
X-Gm-Message-State: ACgBeo1PquQfgd+727eAFCswTQIOSXRPa2dYSNGw4BAGhsopxXqRL1bS
 /kagRH5y48mnbZ/b4GIh03XxO04TItAgAVVG6GAvtA==
X-Google-Smtp-Source: AA6agR5IagjO74tDyXGwM67VEwLddpkc8dPouPyHGcwzWBoYBX5/0Nn4OrrCdKdqm1H9X247p/t1NLtV1atfoLbgCQE=
X-Received: by 2002:a4a:e1ad:0:b0:448:b28c:5fe3 with SMTP id
 13-20020a4ae1ad000000b00448b28c5fe3mr3639821ooy.21.1662668610979; Thu, 08 Sep
 2022 13:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220907125048.396126-1-andrew@daynix.com>
 <20220907125048.396126-2-andrew@daynix.com>
 <f59a8400-54ba-62eb-2e9b-b8a6b7533f90@kernel.org>
In-Reply-To: <f59a8400-54ba-62eb-2e9b-b8a6b7533f90@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 8 Sep 2022 23:10:14 +0300
Message-ID: <CABcq3pGKN5ovHC77HZJOK6sjpzsOKStmy4sTmaMq2EMkc0CoQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] udp: allow header check for dodgy GSO_UDP_L4
 packets.
To: David Ahern <dsahern@kernel.org>
Cc: mst@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 yuri.benditovich@daynix.com, edumazet@google.com, yan@daynix.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Hi all,

On Thu, Sep 8, 2022 at 3:40 AM David Ahern <dsahern@kernel.org> wrote:
>
> On 9/7/22 6:50 AM, Andrew Melnychenko wrote:
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 6d1a4bec2614..8e002419b4d5 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -387,7 +387,7 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
> >       if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> >               goto out;
> >
> > -     if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
> > +     if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 && !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
>
> that line needs to be wrapped.

Ok, I'll wrap it.

>
> >               return __udp_gso_segment(skb, features, false);
> >
> >       mss = skb_shinfo(skb)->gso_size;
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
