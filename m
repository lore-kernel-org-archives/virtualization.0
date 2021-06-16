Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A486C48BE6
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 21:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F891613DE
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 21:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F891613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oasis-open.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CACDC40153;
	Wed, 16 Jun 2021 21:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCVuWEyoV3Yf; Wed, 16 Jun 2021 21:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35091404B9;
	Wed, 16 Jun 2021 21:19:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09F36C000D;
	Wed, 16 Jun 2021 21:19:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB65C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 21:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D00640558
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 21:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=oasis-open-org.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rrVeo6agmZ2s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 21:18:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C4F340547
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 21:18:59 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id r7so950560edv.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oasis-open-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GuOvoVr42fUF6RXYTBLS9z75Ir34nLmbD9ONF5A+weo=;
 b=c1mEftNOY2KGbd1EJ4ng6DNY44RCr6bREnVo0Cy8kWQlFsHkGqMCG9l7PsfazdX6AV
 Y3LZcT5VWP5xEOBGZnrvOG77/JYRrfapCq9AtTYw2fY/bag0uFj2bdkHOH7Xm1T9ol1m
 iOAc1XumUkndPoqfAKIDPGKjk6UmFCRvbz3M81vty93fzWy84faPqF2WvY89xQQsSAQp
 CGArxqM+J7xfoYzzwBcDvhjrYAtyajWtMmflQ7S27BZaxrfkWvEqqLLPw74t8XIcQqf3
 Hx18q230DzZqBsV5rZZH46T/fg+WzxhqMUUQ1qjcLhY3r4RuZK6SQR0hcgPt+cGAly0V
 FNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GuOvoVr42fUF6RXYTBLS9z75Ir34nLmbD9ONF5A+weo=;
 b=b0iRq4l+pLBhR7t43zQKul+LugefiKZ6ruN+adGiobZd9+mZ8EnfzFA/56h6mHLLuE
 K+xkXNp2dURBnSAqnQ+1KXw7qHs7i0OmwC3TUTsebr5cEa5uiU3o3VVYHvHyBrnOgQVB
 TYh9/syE92qa+y61AcneVkCT5U2Cr7IlwLxTbcuBPoDlCZ6hW90w+I3GUYAaO2d3Xsns
 mYGKPbiFYN4O7Ij6TjVELMiEhJCiatEgJmCDIBGrgfIWE2Q+QMEgOVjiikCTTs/7ZYc2
 RmiXghh4BMLAGNtSWgt2j+j+21iMbJCwmobH1Fj5Ek24l6rf8O3j6PTUMjmFLRXI2v3v
 YFMg==
X-Gm-Message-State: AOAM531AyyAKJWhMyqhTTmURlLs8s1SQA9HiYYULXJUnJZ0xlxgn98Ne
 Cu5W8kVipNHn9Tz+Lnf+S2RkreNmcUT97nA+FttL
X-Google-Smtp-Source: ABdhPJxOkycxelMkO/j14113S4EcbSnS8ppWgMEgn6s1Eo+gj/5FsMyctRdlx8b3j2hZrBbhK4USCXyJ9vc4eEVcJuQ=
X-Received: by 2002:aa7:ccd4:: with SMTP id y20mr2071339edt.151.1623878337794; 
 Wed, 16 Jun 2021 14:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210615174911.973-1-info@metux.net>
 <CACRpkdbwLOOT6nuhpkT5x-AZVipsD2qG8Qu4xoiRotHQNknwzw@mail.gmail.com>
 <c4b3b9b1-7665-c4a1-8a53-33f9481d7488@metux.net>
In-Reply-To: <c4b3b9b1-7665-c4a1-8a53-33f9481d7488@metux.net>
From: Chet Ensign <chet.ensign@oasis-open.org>
Date: Wed, 16 Jun 2021 17:18:46 -0400
Message-ID: <CAAwgnnNMVk8eznio6spnBoOktvuMhmQjPcCJwe6ArBjNDz-4=Q@mail.gmail.com>
Subject: Re: [virtio-dev] banned on virtio list ? [Re: [PATCH] drivers: gpio:
 add virtio-gpio guest driver]
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: virtio-dev@lists.oasis-open.org, Anton Vorontsov <anton@enomsg.org>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Tony Luck <tony.luck@intel.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Colin Cross <ccross@android.com>,
 linux-riscv <linux-riscv@lists.infradead.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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
Content-Type: multipart/mixed; boundary="===============2298597607234753567=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2298597607234753567==
Content-Type: multipart/alternative; boundary="0000000000007ba97005c4e8a31a"

--0000000000007ba97005c4e8a31a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi mtx -

I checked our logs and I don't see you as subscribed to either list. That
should explain why you're being blocked.

To subscribe to virtio-comment, follow the instructions at
https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=3Dvirtio

To subscribe to virtio-dev, you can send a blank email to
virtio-dev-subscribe@lists.oasis-open.org

If those don't resolve the problem, let me know and I will investigate
further.

/chet

On Wed, Jun 16, 2021 at 2:47 PM Enrico Weigelt, metux IT consult <
lkml@metux.net> wrote:

> On 16.06.21 10:31, Linus Walleij wrote:
>
> Hi folks,
>
>
> <snip>
>
> interesting: trying to post my tex'fied spec to virtio-dev and
> virtio-comment quite some time now, but always being blocked. What's
> going on there ?
>
>
> --mtx
>
> --
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--=20
Chet Ensign

Chief Technical Community Steward

OASIS Open

+1 201-341-1393 <+1+201-341-1393>
chet.ensign@oasis-open.org
www.oasis-open.org

--0000000000007ba97005c4e8a31a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi mtx -=C2=A0<div><br></div><div>I checked our logs and I=
 don&#39;t see you as subscribed to either list. That should explain why yo=
u&#39;re being blocked.=C2=A0</div><div><br></div><div>To subscribe to virt=
io-comment, follow the instructions at=C2=A0<a href=3D"https://www.oasis-op=
en.org/committees/comments/index.php?wg_abbrev=3Dvirtio">https://www.oasis-=
open.org/committees/comments/index.php?wg_abbrev=3Dvirtio</a></div><div><br=
></div><div>To subscribe to virtio-dev, you can send a blank email to <a hr=
ef=3D"mailto:virtio-dev-subscribe@lists.oasis-open.org">virtio-dev-subscrib=
e@lists.oasis-open.org</a></div><div><br></div><div>If those don&#39;t reso=
lve the problem, let me know and I will investigate further.=C2=A0</div><di=
v><br></div><div>/chet</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jun 16, 2021 at 2:47 PM Enrico Weigel=
t, metux IT consult &lt;<a href=3D"mailto:lkml@metux.net">lkml@metux.net</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
16.06.21 10:31, Linus Walleij wrote:<br>
<br>
Hi folks,<br>
<br>
<br>
&lt;snip&gt;<br>
<br>
interesting: trying to post my tex&#39;fied spec to virtio-dev and<br>
virtio-comment quite some time now, but always being blocked. What&#39;s <b=
r>
going on there ?<br>
<br>
<br>
--mtx<br>
<br>
-- <br>
---<br>
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert<br>
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren<br=
>
GPG/PGP-Schl=C3=BCssel zu.<br>
---<br>
Enrico Weigelt, metux IT consult<br>
Free software and Linux embedded engineering<br>
<a href=3D"mailto:info@metux.net" target=3D"_blank">info@metux.net</a> -- +=
49-151-27565287<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><table cellspacing=3D"0" cellpa=
dding=3D"0" style=3D"font-family:Arial;vertical-align:-webkit-baseline-midd=
le"><tbody><tr><td width=3D"70" style=3D"vertical-align:middle"><span style=
=3D"margin-right:5px;display:block"><img src=3D"https://drive.google.com/uc=
?id=3D1hIW4KA06CCJq7fj33aZ_yzDDDxaXDW8c" width=3D"70" height=3D"70" style=
=3D"max-width: 70px;"></span></td><td style=3D"vertical-align:middle"><h3 s=
tyle=3D"margin:0px;font-size:16px;color:rgb(0,0,0)">Chet=C2=A0Ensign</h3><p=
 style=3D"margin:0px;color:rgb(0,0,0);font-size:12px;line-height:20px">Chie=
f Technical Community Steward</p><p style=3D"margin:0px;color:rgb(0,0,0);fo=
nt-size:12px;line-height:20px">OASIS Open</p></td><td width=3D"30">=C2=A0</=
td><td width=3D"1" style=3D"width:1px;border-bottom:none;border-left:1px so=
lid rgb(34,72,229)">=C2=A0</td><td width=3D"30">=C2=A0</td><td style=3D"ver=
tical-align:middle"><table cellspacing=3D"0" cellpadding=3D"0" style=3D"ver=
tical-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr style=3D"=
vertical-align:middle"><td width=3D"30" style=3D"vertical-align:middle"><ta=
ble cellspacing=3D"0" cellpadding=3D"0" style=3D"vertical-align:-webkit-bas=
eline-middle;font-family:Arial"><tbody><tr><td style=3D"vertical-align:bott=
om"><span style=3D"display:block;background-color:rgb(34,72,229)"><img src=
=3D"https://cdn2.hubspot.net/hubfs/53/tools/email-signature-generator/icons=
/phone-icon-2x.png" width=3D"13" style=3D"display: block;"></span></td></tr=
></tbody></table></td><td style=3D"padding:2px;color:rgb(0,0,0)"><a href=3D=
"tel:+1+201-341-1393" style=3D"color:rgb(0,0,0);font-size:12px" target=3D"_=
blank">+1 201-341-1393</a></td></tr><tr style=3D"vertical-align:middle"><td=
 width=3D"30" style=3D"vertical-align:middle"><table cellspacing=3D"0" cell=
padding=3D"0" style=3D"vertical-align:-webkit-baseline-middle;font-family:A=
rial"><tbody><tr><td style=3D"vertical-align:bottom"><span style=3D"display=
:block;background-color:rgb(34,72,229)"><img src=3D"https://cdn2.hubspot.ne=
t/hubfs/53/tools/email-signature-generator/icons/email-icon-2x.png" width=
=3D"13" style=3D"display: block;"></span></td></tr></tbody></table></td><td=
 style=3D"padding:2px"><a href=3D"mailto:chet.ensign@oasis-open.org" style=
=3D"color:rgb(0,0,0);font-size:12px" target=3D"_blank">chet.ensign@oasis-op=
en.org</a></td></tr><tr style=3D"vertical-align:middle"><td width=3D"30" st=
yle=3D"vertical-align:middle"><table cellspacing=3D"0" cellpadding=3D"0" st=
yle=3D"vertical-align:-webkit-baseline-middle;font-family:Arial"><tbody><tr=
><td style=3D"vertical-align:bottom"><span style=3D"display:block;backgroun=
d-color:rgb(34,72,229)"><img src=3D"https://cdn2.hubspot.net/hubfs/53/tools=
/email-signature-generator/icons/link-icon-2x.png" width=3D"13" style=3D"di=
splay: block;"></span></td></tr></tbody></table></td><td style=3D"padding:2=
px"><a href=3D"https://www.oasis-open.org" style=3D"color:rgb(0,0,0);font-s=
ize:12px" target=3D"_blank">www.oasis-open.org</a></td></tr></tbody></table=
></td></tr></tbody></table></div></div>

--0000000000007ba97005c4e8a31a--

--===============2298597607234753567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2298597607234753567==--
