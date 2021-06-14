Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF59C48BE6
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 08:12:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19A7613B8
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 08:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19A7613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E5C8401C7;
	Mon, 14 Jun 2021 08:12:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8oVdJfWndgkN; Mon, 14 Jun 2021 08:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C1D540100;
	Mon, 14 Jun 2021 08:12:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1078C000E;
	Mon, 14 Jun 2021 08:12:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F397EC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 08:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D266340130
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 08:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WHYMe0ah2fvX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 08:12:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5258640100
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 08:12:25 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id i34so7988536pgl.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Vv3hBAQ8kpZIe+1+G82nUGelWzwqMrss8OA+ER4ISc=;
 b=c4fGtjeg/GfqEDJFxCfTs2qulnbzuKMp0HYaOci+oQWvyQM4dQ7rcIDbSs28NollGJ
 3TfnXLmrNnyCeUoYBrT6kPf1LySbpdqm9+fZ2yBD2Hw1Z4k4R7o3l6UidYHfhxQ151m/
 MD5wP9xxOkMmZWiml42sWS2OMHvvYyzQqZJyMvE87DohZjCJMRmcXWLybcsRYqwQ3gyK
 eCVWaiYa9epVi8oi50IEWlMypfrBpZ9vwUq1IZ2ShmB3bjAIM1O3NOwjfIh0U78zqhMr
 mK9GFJFicIgurMGWWACJqLodhke8XP+w8c/DqpaxgC9Zt/Mdm02QiaZdUXTBg6yZW/DE
 aJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Vv3hBAQ8kpZIe+1+G82nUGelWzwqMrss8OA+ER4ISc=;
 b=E3+ab7jTxLf9v17nyqrouxotRkMTndPgUFzdJCv8XndS4wh7GPD3EjUt4Psb8vCwmP
 ++Bf0kqJCflOtmwWExcwv8KwrMubna/Bch7Jtm8/2rphwCDH3POWaHB6RxsClSPEHbPe
 qOP3dEG0ReSczW7gXqrn6RWmfj7zuESXLZ3KR03KH2VDSMaucly6tMEthhu9O2VgSMr1
 eGenxzMtBc6C7ZsoEkEBzQGQUs3R2Ne2ug1w+4d1QNGAbSx2XbabsqtM8i3/ZA84Qy4T
 ZUTjlu860CYa5LwETVnTgRgrJm5UiSuyw6sPT2XmZGHHAE4yTSNCFZd9f/Sk5U4VUTJ2
 afTQ==
X-Gm-Message-State: AOAM532QtIvc5oijAGznhwA/KDrgoDE2kNMRmG5fx7bL+UpjkqW1KYt4
 +97fV2b6EO4aYbGJ4iil7qM1+fhgsloL3KtNn0k=
X-Google-Smtp-Source: ABdhPJxhe15j5OGsgf6ubg65hqo067+sEZz2F1/eOHojX+9gZ7QSWo1iAgCyufmjG6vo/Icejnu1ejDf08TGvFILI5M=
X-Received: by 2002:a05:6a00:139c:b029:2f7:102c:5393 with SMTP id
 t28-20020a056a00139cb02902f7102c5393mr13962018pfg.40.1623658344790; Mon, 14
 Jun 2021 01:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <0478822f-9d10-deb8-86ae-3b4ac3bb0c6c@metux.net>
In-Reply-To: <0478822f-9d10-deb8-86ae-3b4ac3bb0c6c@metux.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Jun 2021 11:12:08 +0300
Message-ID: <CAHp75Vf0+bCnnD3wtkrPvFbr2k3A0r3eWNp87PyksiC7euaqdw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, stratos-dev@op-lists.linaro.org,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bill Mills <bill.mills@linaro.org>
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

On Mon, Jun 14, 2021 at 11:08 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 11.06.21 10:01, Viresh Kumar wrote:
>
> > No, QEMU passes the raw messages to the backend daemon running in host
> > userspace (which shares a socket with qemu). The backend understands
> > the virtio/vhost protocols and so won't be required to change at all
> > if we move from Qemu to something else. And that's what we (Linaro)
> > are looking to do here with Project Stratos.
>
> Note that this is completely different from my approach that I've posted
> in autumn last year. Viresh's protocol hasn't much in common with mine.

That's why we have a thing called standard. And AFAIU virtio API/ABIs
should be officially registered and standardized.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
