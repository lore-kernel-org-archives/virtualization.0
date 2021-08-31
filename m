Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34577C432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 12:14:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF36161029
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 12:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF36161029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 885D440300;
	Tue, 31 Aug 2021 12:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3jz_is1wi8zq; Tue, 31 Aug 2021 12:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ECD01402FF;
	Tue, 31 Aug 2021 12:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B66CBC001A;
	Tue, 31 Aug 2021 12:14:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0624C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 12:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0C8C80CF8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 12:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4pgZD4WYbC3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 12:14:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F219F80CA4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 12:14:10 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 v33-20020a0568300921b0290517cd06302dso22424649ott.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LP+SlWXeLYUEVsbGU74FedrspQLG+n2EKXI0i1KDw5o=;
 b=F+I4hvdwU1Wwd7NvT0GzxSct7573fiDdL1wjguUnfbZSHOGkbAvz+PFDC1mB1ivwZC
 C3psMQt6Y+tlO+aLFei/2tdql1EeePG/SlbpXP9ghBfEoL+pO5l+b5bHqq4kTd7t/RAk
 lOHecHOTa4xYuiaGA57Rqo4Mw3rjimeBE8o1tRFGJ378MpPcALnnEqAMG4LQvbHE2NBK
 SE9smhZRWjS7S1BHbl3qaOZe5UyS2nj/3psBP9Ll4VL8OvzPmp0+Q/BMLmISW+LOeT2m
 fXbhr2am13MV5pXW5D2zKNnYwQGG5MxbFVDgONLU4MdkT3rlNK8ZnmiEDgjlmbn/ZklF
 8ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LP+SlWXeLYUEVsbGU74FedrspQLG+n2EKXI0i1KDw5o=;
 b=lZyFjVV7S9bAwRhmOGTh1S5UYQJ2PkyVHgz/9cTlg3Xn6ifeUMy5bT2Fz3tADx2r+p
 Kl5WKGvEQgjis9LBW20BgrVC7O5DncVlEsv3pTVZ/nACxShtv6XP2fJeXYnOyaJMfHel
 Zoyh6zan6tLf3FTMdhkO+B7VjojeGbI2ehVsuNLktAmbZlq1PgAecPuJxVJ1nU4mXoCz
 R9WA/X+hEvBMlZuRUL71if7Vep+DpWdIxUuQO4YoyiHQmLU4vvERNP+77mLcQh1mDy9G
 ufQgIeCEfyQp1F4756S4TAfvwrOJVuN4MsVSTyW3gXy5YsqUmHjsDQ5+hgxdncCLDRns
 OZdg==
X-Gm-Message-State: AOAM531ZUwM+oXnJowKXVT60kmpkvks+wUtsoALwZSTg+x6rrQqHRyIJ
 09Ak2moAHZXM85Di1xVVWhi42ukYGhUistk0XMn6vw==
X-Google-Smtp-Source: ABdhPJz27k582ovsrlMlpC1pbC3WcSC4yaWi4Ks/HXEKAFCQIJ1tFhG3Q+iUPA/lK9qf4BgxHSe2qYScEf4hdVvGtMc=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr25160242otn.5.1630412049851; 
 Tue, 31 Aug 2021 05:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210818175440.128691-1-andrew@daynix.com>
In-Reply-To: <20210818175440.128691-1-andrew@daynix.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 31 Aug 2021 15:10:14 +0300
Message-ID: <CABcq3pEWkZQJwZd7dHuppGkmeHrdLJyQseJn1kw1jKBnW=F3iw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] drivers/net/virtio_net: Added RSS support.
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 davem@davemloft.net, kuba@kernel.org
Cc: Yan Vugenfirer <yan@daynix.com>, netdev@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, linux-kernel@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============3860584688250124428=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3860584688250124428==
Content-Type: multipart/alternative; boundary="00000000000011b89205cad9e35e"

--00000000000011b89205cad9e35e
Content-Type: text/plain; charset="UTF-8"

Hi guys,
Can you please review possible virtio-net driver RSS support?
Do you have any comments or proposals?

On Wed, Aug 18, 2021 at 8:55 PM Andrew Melnychenko <andrew@daynix.com>
wrote:

> This series of RFC patches for comments and additional proposals.
>
> Virtio-net supports "hardware" RSS with toeplitz key.
> Also, it allows receiving calculated hash in vheader
> that may be used with RPS.
> Added ethtools callbacks to manipulate RSS.
>
> Technically hash calculation may be set only for
> SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
> The completely disabling hash calculation for TCP or UDP
> would disable hash calculation for IP.
>
> RSS/RXHASH is disabled by default.
>
> Andrew Melnychenko (3):
>   drivers/net/virtio_net: Fixed vheader to use v1.
>   drivers/net/virtio_net: Added basic RSS support.
>   drivers/net/virtio_net: Added RSS hash report.
>
>  drivers/net/virtio_net.c | 402 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 385 insertions(+), 17 deletions(-)
>
> --
> 2.31.1
>
>

--00000000000011b89205cad9e35e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi guys,</div><div>Can you please re=
view possible virtio-net driver RSS support?</div><div>Do you have any comm=
ents or proposals?<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 18, 2021 at 8:55 PM Andrew Melnyc=
henko &lt;<a href=3D"mailto:andrew@daynix.com">andrew@daynix.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This series=
 of RFC patches for comments and additional proposals.<br>
<br>
Virtio-net supports &quot;hardware&quot; RSS with toeplitz key.<br>
Also, it allows receiving calculated hash in vheader<br>
that may be used with RPS.<br>
Added ethtools callbacks to manipulate RSS.<br>
<br>
Technically hash calculation may be set only for<br>
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.<br>
The completely disabling hash calculation for TCP or UDP<br>
would disable hash calculation for IP.<br>
<br>
RSS/RXHASH is disabled by default.<br>
<br>
Andrew Melnychenko (3):<br>
=C2=A0 drivers/net/virtio_net: Fixed vheader to use v1.<br>
=C2=A0 drivers/net/virtio_net: Added basic RSS support.<br>
=C2=A0 drivers/net/virtio_net: Added RSS hash report.<br>
<br>
=C2=A0drivers/net/virtio_net.c | 402 +++++++++++++++++++++++++++++++++++++-=
-<br>
=C2=A01 file changed, 385 insertions(+), 17 deletions(-)<br>
<br>
-- <br>
2.31.1<br>
<br>
</blockquote></div></div>

--00000000000011b89205cad9e35e--

--===============3860584688250124428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3860584688250124428==--
