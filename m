Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28385C433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 08:27:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E67D64F6A
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 08:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E67D64F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E14934EC72;
	Fri, 19 Mar 2021 08:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YEWSVi8pC55A; Fri, 19 Mar 2021 08:27:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 482254C62F;
	Fri, 19 Mar 2021 08:27:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28660C000B;
	Fri, 19 Mar 2021 08:27:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D2F1C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 08:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66F53400FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 08:27:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CiZGF80Czxa1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 08:27:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37E5D400A8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 08:27:31 +0000 (UTC)
Received: from mail-oi1-f170.google.com ([209.85.167.170]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrhLw-1lzn4X1bLI-00nfEy for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 09:27:29 +0100
Received: by mail-oi1-f170.google.com with SMTP id m13so3940786oiw.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 01:27:29 -0700 (PDT)
X-Gm-Message-State: AOAM533GK6C3RF+U1e7YbUi8Ia7zjqGE81rtPczkJSlY46Kd5EBG15Au
 WzNE+ua9+ODyKsxKkkgvEjvdKvzTI7YTp6rq13o=
X-Google-Smtp-Source: ABdhPJy2jQ9JuAxE+K1J1eCBybf0lxeN3IOFfRQ13WdcK8b0FXfVMfx6yj7r4z+BrbUCgKPvSM0RF3ODSeFZepyRCyI=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr177972oie.4.1616142448131; 
 Fri, 19 Mar 2021 01:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
 <20210316074409.2afwsaeqxuwvj7bd@vireshk-i7>
 <0dfff1ac-50bb-b5bc-72ea-880fd52ed60d@metux.net>
 <CAK8P3a3f9bKdOOMgrA9TfeObyEd+eeg8JcTVT8AyS1+s=X2AjQ@mail.gmail.com>
 <20210319035435.a4reve77hnvjdzwk@vireshk-i7>
 <b135b474-b167-67ad-588c-b0cfe8dc2998@intel.com>
 <20210319054035.47tn747lkagpip6v@vireshk-i7>
 <834186be-71b1-a67c-8dee-b90527b459c8@intel.com>
 <20210319063553.eq5aorcyiame6u2e@vireshk-i7>
In-Reply-To: <20210319063553.eq5aorcyiame6u2e@vireshk-i7>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 19 Mar 2021 09:27:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0cBdBF6aHj-QMu1jwerYxFVyABm=r4SsyQkOBkbW=ZZg@mail.gmail.com>
Message-ID: <CAK8P3a0cBdBF6aHj-QMu1jwerYxFVyABm=r4SsyQkOBkbW=ZZg@mail.gmail.com>
Subject: Re: [PATCH v8] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
X-Provags-ID: V03:K1:VC6jHH7GCo6k3axBBN0YsextDu9UU9Bwhmr4GWKfHpasJEIaeio
 FpB646JOXFE5umePr9OTaUAcVEY4l5iMwYMg6ZBM5BcSSVidZMdYSQbtVKocjprrMlIRZhw
 zkLF2LiLdX6fl56Tsiw5oUqeRuKUBqFfiZ+8991RUDZ6eF4dKMH5gWp3vN9/wTX96KPhGCJ
 hxAI1aA4p6Ys0KBtYt1IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C9ZrG4VwyKo=:MgX9PyjxXOalXCJoUMC4RR
 PLXXd+cpcO3C6jykNjeLsoGzR1ShHic87s5FYY3QhKGo5bI2VcommTux9u+6Rmrh1k/7dvvLe
 qGLm714aEokvuP7YHWhpZP8VAp0KPenMKD1WzqiDht+yw8OL80Sd1kh0ozHNQ9+OHzpVvneYy
 EpXALQe1Miz/KOqLPlGkbRhuu2FOrw8kblMcBto50UzHemZvMdJPZZzxEb0eZvBoB3VRPNX/H
 AR+PMKPPx0v+el9LHcQeAqdX6OYMWZ89fj3GSQ2urUUGAFrtGhxC7bnUqq8egkNt2k9pechqc
 rix15EF2Bn36gMoDbgIMA6h+umCblq49Y58NjftKAA73VIkhgelK+QZdiC1PFmunL7tbuF3Ev
 PJnNj5+uUiI8ca1siER/5diXimDuT4nBujIly75YpA0iUQM8S2+WVnZU1y86LnO0fCuCsd0b9
 I5EvAf/tur6ZoqqbXPe1Jp/kkPcaOOGgkOtU5MOC4c3lcEVz2wxEe/oXSHa20onrfj8acUe3J
 zx+WQUFBDw9+euSuYkLkA116JUlUCVmvP5laGoPnJke
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, loic.poulain@linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

On Fri, Mar 19, 2021 at 7:35 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-03-21, 14:29, Jie Deng wrote:
> > I also see example drivers/i2c/busses/i2c-xiic.c. Some people might think
> > this way is more clearer than
> >
> > updating each member in probe. Basically, I think it's just a matter of
> > personal preference which doesn't
>
> Memory used by one instance of struct i2c_adapter (on arm64):
>
> struct i2c_adapter {
...
> };
>
> So, this extra instance that i2c-xiic.c is creating (and that you want to
> create) is going to waste 1KB of memory and it will never be used.
>
> This is bad coding practice IMHO and it is not really about personal preference.

Agreed. At the minimum, it should have been written as an explicit
memcpy() in the few drivers that have that pattern instead of a benign
looking struct assignment, but even then there is nothing good about it
really. Notably, the largest member by far is the 'struct device', and
that by itself should be a red flag as a device is never meant to be
allocated statically (this used to be common in pre-DT days, but
even then was considered bad style).

I suppose the i2c_add_adapter()/i2c_add_numbered_adapter()
interface could be redesigned to handle this better, since every
driver needs to set the same few fields. That however requires finding
someone to spend the effort on coming up with a nice design and
converting lots of drivers over.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
