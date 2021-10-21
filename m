Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D40C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 11:02:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB92610CF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 11:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AB92610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0BA483C24;
	Thu, 21 Oct 2021 11:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZy7LtJapZIs; Thu, 21 Oct 2021 11:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6916283C04;
	Thu, 21 Oct 2021 11:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23C01C0033;
	Thu, 21 Oct 2021 11:02:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7368CC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DEA14085F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9CXNtyrsy3Ja
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:02:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AF004085E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:02:47 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id u5so273787uao.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 04:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o0/uJXapAU5mNKKcxBTRMfYrMyIyw+LndiogB9Grn7Y=;
 b=Uoq7oxLlppPai7rCCf/5U99AvGGEnKx2A7s95zMEiiMRYvrLJClu/iQ7cx8ypT0MYn
 XH2tKcfVkMKiFzIiP/5JU7Wkg7I6wkII021a4Z5GyUoxPHEgVbRfw1dJCMWNbRsafqz6
 02kXX88UXVbsq+m3/IWXVChoBJjN+ch3QEyQzITJLA7DfuTHxRs53C3BGZpjdmPQ7+kn
 KW65puK1yFeyzjKGV5oet6/qIjH+wcBqQf51CXQOmggqXXnw8QqP3G1Urttk1wA1UjiS
 TJLovTSMc91PQqKgye7YKiaVILU75Iw7XqQWG/5HCd40FKDaIp0udoNDQ6d0wAANU3zx
 OrPw==
X-Gm-Message-State: AOAM530j4u1cUQjMRzRhivIlpejJFS/yDcAhSVkBuB22NF4v5CH/rthf
 3tEvfQ+k7FODxSriu7WDbiMbiLVIXINHJw==
X-Google-Smtp-Source: ABdhPJy0y08W9vgxKLnCJabUPTiNnsO4qH0o2RVhzhIc2UPBhxZA40Qo8nxHS3HTxNu0QwxIc1hmOQ==
X-Received: by 2002:ab0:a96:: with SMTP id d22mr5053305uak.45.1634814166404;
 Thu, 21 Oct 2021 04:02:46 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com.
 [209.85.222.43])
 by smtp.gmail.com with ESMTPSA id o196sm3077263vkc.51.2021.10.21.04.02.44
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Oct 2021 04:02:45 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id r22so299837uat.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 04:02:44 -0700 (PDT)
X-Received: by 2002:ab0:3154:: with SMTP id e20mr5379353uam.14.1634814164305; 
 Thu, 21 Oct 2021 04:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
 <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
 <CAMuHMdWDRGmxt55vvRTnyu5SwXCDtkcOLmKA87cd4SSa8S+Z=Q@mail.gmail.com>
 <20211021104950.nhvify5lo7y5fdfh@vireshk-i7>
In-Reply-To: <20211021104950.nhvify5lo7y5fdfh@vireshk-i7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Oct 2021 13:02:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUutrjVRv7QOjQ3dKqWxAD6fQu4QqXvOjCREj3guGi6xA@mail.gmail.com>
Message-ID: <CAMuHMdUutrjVRv7QOjQ3dKqWxAD6fQu4QqXvOjCREj3guGi6xA@mail.gmail.com>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bill Mills <bill.mills@linaro.org>
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

Hi Viresh,

On Thu, Oct 21, 2021 at 12:49 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-10-21, 12:07, Geert Uytterhoeven wrote:
> > On Thu, Oct 21, 2021 at 11:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > The structure will get aligned to the size of largest element and each
> > > element will be aligned to itself. I don't see how this will break
> > > even in case of 32/64 bit communication.
> >
> > Structures are not aligned to the size of the largest element, but
> > to the largest alignment needed for each member.
>
> Right, I was talking in terms of the structures we have here for GPIO.
> The biggest member here (for any structure) is 32bits long, and
> compiler shouldn't add extra padding here.
>
> > This can be smaller than the size of the largest element.
> > E.g. alignof(long long) might be 4, not 8.
>
> Right.
>
> > And m68k aligns to two bytes at most.
>
> Interesting, I assumed that it will be 4bytes for 32 bit systems. So
> in case of m68k, we will see something like this ?
>
> struct foo {
>     u8 a;       // aligned to 2 bytes
>
>                 // padding of 1 byte
>
>     u32 b;      // aligned to 2 bytes
> }

Exactly.  And on CRIS (no longer supported by Linux), there won't
be any padding.

So I recommend to always add explicit padding, to make sure all
members are aligned naturally on all systems.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
