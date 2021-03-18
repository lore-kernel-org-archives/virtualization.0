Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A95C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 14:53:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C359E64F01
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 14:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C359E64F01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7632D4EE1A;
	Thu, 18 Mar 2021 14:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VX6rQrXPzqb2; Thu, 18 Mar 2021 14:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D86D44ED39;
	Thu, 18 Mar 2021 14:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2596C000A;
	Thu, 18 Mar 2021 14:53:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19155C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 14:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E57F34EE16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 14:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vuO9nyokZT5R
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 14:53:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97B254ED39
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 14:53:01 +0000 (UTC)
Received: from mail-ot1-f54.google.com ([209.85.210.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MStKw-1lGkPF1Kbm-00UJpG for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 15:52:59 +0100
Received: by mail-ot1-f54.google.com with SMTP id
 l23-20020a05683004b7b02901b529d1a2fdso5422765otd.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 07:52:59 -0700 (PDT)
X-Gm-Message-State: AOAM533C+nOdr+Eh8pA/5WUYpbyb3DOGu2YfNUcVj1/5Ko1Tkb+/y+TG
 IcADIwyos7sf10JcQKfIjJXutNoTDSSrwEcyS3U=
X-Google-Smtp-Source: ABdhPJw7Eug2yd9ucu2dKZlBIqyoyljV2ZH8YZeMrPCW0lZjBwbRWIkmu8XcOw0kOzzkDzHjb1kP6HgcXNEyY4KVhCY=
X-Received: by 2002:a05:6830:14c1:: with SMTP id
 t1mr7894612otq.305.1616079178056; 
 Thu, 18 Mar 2021 07:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
 <20210316074409.2afwsaeqxuwvj7bd@vireshk-i7>
 <0dfff1ac-50bb-b5bc-72ea-880fd52ed60d@metux.net>
In-Reply-To: <0dfff1ac-50bb-b5bc-72ea-880fd52ed60d@metux.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Mar 2021 15:52:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3f9bKdOOMgrA9TfeObyEd+eeg8JcTVT8AyS1+s=X2AjQ@mail.gmail.com>
Message-ID: <CAK8P3a3f9bKdOOMgrA9TfeObyEd+eeg8JcTVT8AyS1+s=X2AjQ@mail.gmail.com>
Subject: Re: [PATCH v8] i2c: virtio: add a virtio i2c frontend driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
X-Provags-ID: V03:K1:JMtjHkwY5q7XuvLPOW8/1ltOkcVhwTHciQxHVaNybKdkMTGTl90
 cSf8vuby0GTJzDI7W0rTxDg8nzkLqLfHhc3+VeeBcwF3ixFEdYq10Ix5TS3Wc/cAqm0FKrl
 IFBLVfSbMJnyPUiBUnu0bpwA6tgrakbhb026SccobOOzkM9vw4xrr1ZyAG7CoVSKiTc4uk3
 7ftSL02QMgH5A+tNlom4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kujqYQcRlmM=:3xDpASHJRxeYmIHee/K/Ji
 EZ1t+oqONcfXgcDTWK/fcKD8EY9eTnM8RXj/wSxj8gkO+fbUlgJcLih1oRuwADjJlPSWjQ224
 wEmrHrRtHSJssBhaaVVBcVX6pX9hLe8m+N1XTIeNhBYDOU45+UBKVqvFczh+GL7hoyZhPiWtf
 /6tNuHrkHf11pQFu/W4soOKrnUjxLaZli/yqcWp0/nQjGiDjS7yCRYjXhqEDQCt0eD9DVkqZy
 GdDx5+75UAIQDnFuExdKYINhi1KSrgsT4+cPhzg8A1UqL4HuE1HbnaWPyLNa0KEcwxYNhVG5q
 ft6/sLv68FFqt0hbBh579g/iQHz4AyQOdUmSTs0X6Bniem3l6MjzY1SknyK8qKm1xCXHEKw1R
 xf549iYHYuDQpN7tz6kioH+nOnjarpeFjwvjmyKY7hbtI+XK7caP7H65JuLaxzCseAB0yqxOi
 EYiC3rDU7ksCg2XVF0rZboBZWl1JoWQaitWvo+OuWGsG2trphPYmCTd52wd7bFkj11zG1zdyX
 iA1G0Lub95aA0TtFKmDqR+ge+y0/ddxc5ilip3eBYay7P+cOA/xke+7rXkkofnujw==
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
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

On Thu, Mar 18, 2021 at 3:42 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 16.03.21 08:44, Viresh Kumar wrote:
>
> > FWIW, this limits this driver to support a single device ever. We
> > can't bind multiple devices to this driver now. Yeah, perhaps we will
> > never be required to do so, but who knows.
>
> Actually, I believe multiple devices really should be possible.
>
> The major benefit of virtio-i2c is either bridging certan real bus'es
> into a confined workload, or creating virtual hw testbeds w/o having to
> write a complete emulation (in this case, for dozens of different i2c
> controllers) - and having multiple i2c interfaces in one machine isn't
> exactly rare.

Allowing multiple virtio-i2c controllers in one system, and multiple i2c
devices attached to each controller is clearly something that has to work.

I don't actually see a limitation though. Viresh, what is the problem
you see for having multiple controllers?

         Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
