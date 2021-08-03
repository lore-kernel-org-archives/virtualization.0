Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C616CC4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 15:48:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADC161037
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 15:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7ADC161037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 366BF400F2;
	Tue,  3 Aug 2021 15:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SyepVKP2Bn0p; Tue,  3 Aug 2021 15:47:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93BFC4019A;
	Tue,  3 Aug 2021 15:47:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6582CC001A;
	Tue,  3 Aug 2021 15:47:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B4B6C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97AE9404DD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrh_ersrTAOB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CE9F404CF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:47:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFA8961037
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628005676;
 bh=MG4fAieao0UPi4ffT0mbv01ftN/DNkPTsgdtYW/U3b0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JMxzV8817ns0XcLosSwn1TLOGdXCxTTb3nBhRBb1PdBUrW5Nnd/7xx/D7oh3eGvTM
 WK1nrMfIGlBgj7eHwljrNB2a1OnkfMJy7eONBxFJhrggHMOCOUN1B5BN/95IaHuFIu
 bKsNYve1kUpE/mRsq7C2W9RwB3aJbpS5fWCspPTpUnYsLDtpNQ+6joNtsFAUvZpFiS
 Nn4D8Ebal1JPMuyTxipY5u6vuLpi6GcF7JPCcO1X6WZLcUGk2fanMfHA/k8pSD8xs5
 e2NoXPjBkwojqn0SEcGmhOWB4eimT/NVQe+KT65xA4lDP1+U9wKRypiL6AY0r2p3m1
 r3tLen9j4PnBg==
Received: by mail-ed1-f50.google.com with SMTP id y7so27323744eda.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 08:47:56 -0700 (PDT)
X-Gm-Message-State: AOAM533PeVv+3rfmr1Ftg+uNC80Mmd+y7Sr3Bzml4rRLoZXpcywgrif9
 b6/1t+YB40t7dd+28yts+5jkCGwEcsvaHWjMcQ==
X-Google-Smtp-Source: ABdhPJzuBnfkNQtqqLg2h9sTkUQTkdyCINtgxA59VUetynvl9LB1QKx942SZoaOuOW2U1PMG/KLxk/DqtQdWvGwL0ik=
X-Received: by 2002:a05:6402:2043:: with SMTP id
 bc3mr26352466edb.62.1628005675201; 
 Tue, 03 Aug 2021 08:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <acf7402ef4aabc0ad6295c32846f2bef1cd9b56a.1627362340.git.viresh.kumar@linaro.org>
 <YQhKKyPmOUE8z+US@robh.at.kernel.org>
 <20210803043014.paskwghdio6azplp@vireshk-i7>
In-Reply-To: <20210803043014.paskwghdio6azplp@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Aug 2021 09:47:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6_ktTQKiy_xx9DhjQ3=imfvSZpBem5fXwVY7O49EgCw@mail.gmail.com>
Message-ID: <CAL_JsqJ6_ktTQKiy_xx9DhjQ3=imfvSZpBem5fXwVY7O49EgCw@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bill Mills <bill.mills@linaro.org>
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

n Mon, Aug 2, 2021 at 10:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-08-21, 13:40, Rob Herring wrote:
> > Humm, how does one implement interrupts without a parent interrupt? It
> > uses the parent virtio,mmio interrupt?
>
> Kind of, yeah, but not necessarily.
>
> The interrupt information is passed over buffers shared between host and guest.
> Now the guest may process the buffers when it receives a notification from the
> host, that will be at downpath of an interrupt for virtio,mmio. Or the guest may
> poll on the virtqueue and process any buffers as soon as they are made
> available, no interrupts then.

Okay, thanks for the explanation.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
