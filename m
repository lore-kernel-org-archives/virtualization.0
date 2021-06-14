Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B99C48BE6
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 09:12:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8227D6128B
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 09:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8227D6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 482B260666;
	Mon, 14 Jun 2021 09:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sh6aEUfDeyld; Mon, 14 Jun 2021 09:12:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B50D760642;
	Mon, 14 Jun 2021 09:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75F7DC000D;
	Mon, 14 Jun 2021 09:12:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F227C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D78E83A70
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zc9-KYagT4Oy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:12:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B16C483A6F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:12:21 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id x16so5872715pfa.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4yyICwHMIJCbXq2c7BEGBVunI5RWt4gLljDerJ9bJhA=;
 b=ET+yJ2YpQh1nx70SZ+2L3LmRnVHxt0PqmvwWpzaonmZgwK4v58J+iDsJArycAeunGg
 tKgrNB2bx3GXCj4hriyFV3gIyPygHrpBHUbvrpyBJx0c+pLO24tErnSVRq/ELWYzqPf7
 wFHnJZzy8YFgD4BOv+2lw0abWp1Zja88mP2l5qzb7AemZVmlcJwIDfsqwA47CKvxPEZX
 +I9XRGd6O22GfnSveAE7svaFLPZk+JTEP2fIzFbkLcVBK+NzeGZEgz8lh+JI/O+XZRn4
 5JcTugxdxoBehzQMuVxsBu+CLmUBV38tQqd7r6WFQa+9Bx2Cm/L3tjvZ9BCBzNQJvQ+T
 HQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4yyICwHMIJCbXq2c7BEGBVunI5RWt4gLljDerJ9bJhA=;
 b=mbOSPWh3eagCFk702VhH6DEKleCJJSpm78jsGu98v2w0C2n9/5R8H9pOkWUhuAkmJp
 7JEwcjPqlScRCCEGWO2lms5uvGmvJWXqOwRm2RTRhH8hU8IuJoZChC2GxEdJcQENHeIS
 wVg5UXmGAm+frxh0KQofZS8Wuyo7Bs/ug+9rPoG381K0m7tRb4YABKugH7IqCZj2nFoy
 3dp34PeEvfWSbN0C86vFNAdRFzXqTOSsoOY5CD9j6E2xL4mcc4WOswNYkST9uAM0GDla
 F80BzYpePvKZh4SVDyCOEQ0RjD0QJoKj9BchMOPbRw8H7q7z00eWnww/WPPyPMoxRirg
 EiLQ==
X-Gm-Message-State: AOAM530YBe3kD8RjDNhr1VZLNVxSICa3OEdaMa57eK+3SE03Q+uFLOkk
 hatwl3J+vU/Ys3iFO7ghD2f5lw==
X-Google-Smtp-Source: ABdhPJzowyA4WkHFIZhVs8SkkNub47xJidNz0hMfmu9V1ygHyOQLgkMNrgUWSu8Xb77+wTBgpgZOOw==
X-Received: by 2002:a62:e404:0:b029:2ee:f086:726f with SMTP id
 r4-20020a62e4040000b02902eef086726fmr20669526pfh.7.1623661941123; 
 Mon, 14 Jun 2021 02:12:21 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id q23sm12331418pff.175.2021.06.14.02.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 02:12:20 -0700 (PDT)
Date: Mon, 14 Jun 2021 14:42:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210614091218.mj5hdx4xhy4vho5x@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <0478822f-9d10-deb8-86ae-3b4ac3bb0c6c@metux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0478822f-9d10-deb8-86ae-3b4ac3bb0c6c@metux.net>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 stratos-dev@op-lists.linaro.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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

On 14-06-21, 10:07, Enrico Weigelt, metux IT consult wrote:
> On 11.06.21 10:01, Viresh Kumar wrote:
> 
> > No, QEMU passes the raw messages to the backend daemon running in host
> > userspace (which shares a socket with qemu). The backend understands
> > the virtio/vhost protocols and so won't be required to change at all
> > if we move from Qemu to something else. And that's what we (Linaro)
> > are looking to do here with Project Stratos.

This is one of the ways of using it, via a backend running in host
userspace, maybe there are other ways of making this work which I may
not have explored, like handling this within qemu.

> Note that this is completely different from my approach that I've posted
> in autumn last year. Viresh's protocol hasn't much in common with mine.

The protocol hasn't changed in a sense on how it can be used. Yes few
things have moved around, new operations were introduced, but nothing
that will make a change at this level. We are trying to use the
protocol in one of the possible ways and yours can be different.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
