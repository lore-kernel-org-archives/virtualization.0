Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D935C49361
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:14:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05119613E9
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05119613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B808F403C7;
	Fri, 18 Jun 2021 09:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H2n197h06Q0M; Fri, 18 Jun 2021 09:14:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2E84B403F8;
	Fri, 18 Jun 2021 09:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D61ECC000D;
	Fri, 18 Jun 2021 09:14:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10DCCC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CDD683AC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iV7bs58gAIPs
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:14:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1315F83ABB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:14:10 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id q23so2610178ljh.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fk/g4Uf4e6ndK9NTLJ4fya67I6nyHsWdWmINzLkYxxQ=;
 b=Ej/kae+4z4muiWg6EWVSQJZ0hKf207pahpJvxNxI5rzvReNLTOakQyMu0hPKFKQapC
 KdfIPU1/IY5qQj8piocGrYiAvwhAsKgD6Aac0EfK5OBIgHBnb0t9I5fWbElLuPl9j7uG
 f8EsIa72iX68DlTtcVZ2ZytW6itc2zcRTL2NmByb6VBTT/40OIdIokHxEx3crUwnaeej
 do28bIC90BwWHOqkQQANMqlKuQAUvGklT9o4LJ+nOW/mFuWiHSGCUkSA0RXj+USUl5Zu
 gL+aEhP1YsJsUvXvI7EYMZVd4VlDwDMgbNhmdQLYBjLy9adLLvADaViX2g39cl3yZ8oY
 AMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fk/g4Uf4e6ndK9NTLJ4fya67I6nyHsWdWmINzLkYxxQ=;
 b=QTyrppBmVCB7vOt1sIBZ0cG0XiUqcOBBWwEDITCFJ2zbWfDdqpUUmIMsaHdAAl4Es+
 bHbXuRRePsjBOF7gcMx929ngeCGuGsKiqbvIAnV00f0XAHA83Y7lcxalHhtyRbvSWkAN
 idLnbqD/9/ZxoQVqDZxofvT0YfxnT+i5q+EHdrxGD8TyWhx8r9Up2uNPKnSraXL0PAuT
 wlQ2kTGreESHfNcqjqks7Mk9h7Bij6GJR1bZGUw4+ar4JIBhCgM7ADarIVmGhTR6OPrr
 sWzLd1oEg6zejUXgE0NnD9T6dreL9rRFmhE9+PTmBjs3kb+2AP0Ws0qCU18keyz0O7Uj
 ST1A==
X-Gm-Message-State: AOAM531dQoOSSuRB+FWzmPtFgvFRE23LliDz+4iLmiDCJ9ObfJo/nYNt
 NugB3hsv6TnYiMKizfEmLGzj16A/Cp5SioW+Uwm7Hg==
X-Google-Smtp-Source: ABdhPJxO5angft3VVWPEspBXdSa1jj492/Lqu/sjYy6Szkm5Bb7VcFbM7lZNp02NJxKP3yiLMp83/cpYtRf0ZvPmzDg=
X-Received: by 2002:a2e:95d8:: with SMTP id y24mr2468745ljh.368.1624007648913; 
 Fri, 18 Jun 2021 02:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <YMlwTiN4Y9bK3M4Q@yoga> <8d58da79-8e54-048b-db89-8c1caaa0320f@metux.net>
In-Reply-To: <8d58da79-8e54-048b-db89-8c1caaa0320f@metux.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 18 Jun 2021 11:13:57 +0200
Message-ID: <CACRpkda9g5JJyroTWi4C=2+YCABhKTyxvwvo3C4zGa=+xGWWfg@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>,
 stratos-dev@op-lists.linaro.org
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

On Wed, Jun 16, 2021 at 5:52 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 16.06.21 05:30, Bjorn Andersson wrote:
>
> > Combined with the virtio-i2c effort this could provide an alternative by
> > simply tunneling the busses and GPIOs into Linux and use standard iio
> > drivers, for cases where this suits your product requirements better.
>
> So, you wanna use virtio as logical interface between the two CPUs ?
> Interesting idea. Usually folks use rpmsg for those things.

rpmsg is using shared memory as transport mechanism and virtio
is providing this. rpmsg is conceptually a child of virtio: when the
subsystem was proposed by TI Arnd noted that virtio has large
similarities in shared memory transport and as the potential reuse
for buffer handling etc was excellent virtio was used as
a base for rpmsg/remoteproc work.

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
