Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16418C11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 08:32:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952C761CC6
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 08:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952C761CC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50047606A3;
	Wed, 30 Jun 2021 08:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1DSeOSSUcFvc; Wed, 30 Jun 2021 08:32:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03D8560666;
	Wed, 30 Jun 2021 08:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA007C001A;
	Wed, 30 Jun 2021 08:32:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23DF1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFEE4403AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ygMHgVG9Ll2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:32:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4721340184
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:32:16 +0000 (UTC)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MGA0o-1lzZyt0lAK-00GbiG for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 10:32:15 +0200
Received: by mail-wr1-f48.google.com with SMTP id i94so2559168wri.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 01:32:15 -0700 (PDT)
X-Gm-Message-State: AOAM532VT+XYJMc1/+h8XiiVOzZQ3QWcmKnjzf1gtvUIgHpLyvEHQdzG
 /t4F7dqQVcM7wnGdFqQ6GjoMTeuRFTF7JgRGPy0=
X-Google-Smtp-Source: ABdhPJy+MGLGtZBULVT9Dq0Wsw+8kotCQEn+TV7Gj+Esc9Dq1TbrZjPLHyuAOFtqReu5JqSeSkHTDFb+c6zwiG1Jzss=
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr18081260wrr.361.1625041934904; 
 Wed, 30 Jun 2021 01:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato> <05cc9484-f97b-0533-64fe-ff917c6b87ee@intel.com>
 <YNwd/t3DMKSOrTAT@ninjato> <3016ab8b-cbff-1309-6a1f-080703a4130f@intel.com>
 <CAK8P3a0Ew+RS_1buR+1OneH8XEqVjPOr0FGCF5d6CvFQuJqg6g@mail.gmail.com>
 <YNwmO0LhcS//hvc5@smile.fi.intel.com>
In-Reply-To: <YNwmO0LhcS//hvc5@smile.fi.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jun 2021 10:29:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a09CR4xnm+JW70quHz=6=AedrtNAc_2o=ZUNZ_Y30KnJw@mail.gmail.com>
Message-ID: <CAK8P3a09CR4xnm+JW70quHz=6=AedrtNAc_2o=ZUNZ_Y30KnJw@mail.gmail.com>
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Provags-ID: V03:K1:JwQ3ZcywDnUifWDgjNRbz2Qvf82YeUzrrIY2zF1L4eT4FVXijPY
 zk9cDlMVPB1fwUQLxIeNTPN9fYyymZP6qhp11FH82z8d0vFRigKeKmXoCoqkPKTHwkNOp7/
 pXQsg7wTUkX8gVlagSusFlcMS0DXsDyHO42pqvy4EMKN7pUyISG2I6ejIKcZhX3hiNFdqTq
 h0G7p/nICHAkBFOjOFYUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0gsdDKw2CoI=:ChyhAuSOyMT6HuMlZLxirZ
 +ZXytU1Mr4D1xSqjrfxIHAkHoJH8RER1/+xAv4fAaQ8mbvz30uzcEaPRodCrb19NqSnhNmcW0
 tlyQVLuxSaR4pV7BEy61/NMZ4fg/s0IdZv3OWTuG/6NkIgnvPJlenTVAa3W+RK3SQYpkOqjtE
 ctBkvEy78B6WBjrKUP+jrutTkVPFEp0FnVDzERTIZfDvZSVbSVVTOYXRQQUSapWv9yeuBqqne
 H1clMR/FxuXIpv7AqxgSq2tjiQ+GytQqt8ZztVTynr/c8yIbY66MS8P7JYfuhJ8ickw6LPFUd
 aEHYmOadmWOFtZA5AGwk8mnWLTd5tAsFrzz9+xhbe23o9eZCXkmmaW+2zM5ohvgiKhsDVIkN5
 35AWTLwY+1yPH9ebyXjrDHYuPZVKy6WudseBCUC37qirsgWnFj12GhTQF8wqoQ8udZWidyjrd
 zP8v6RiRZRAyQix3zbbFUilWUXLc4zl97C89xKrWcexWC+F4vTDr+5vqsNfFbfwBbclGfnn7s
 Lqkx7SynSRudduYfK8BquJRO1QY3oF0S16wa3O52Dx5qLGVx/hiyha85+348ndegyhkpitiNl
 KN3kYKPwQOrL7zp/mCn8gxQDesTjWVNoxUdEChSDGq6etOoaULkcJTEzM/Jxg9fgRwMmPaFdw
 4uqw=
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>, yu1.wang@intel.com
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

On Wed, Jun 30, 2021 at 10:09 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 30, 2021 at 09:55:49AM +0200, Arnd Bergmann wrote:
> > On Wed, Jun 30, 2021 at 9:51 AM Jie Deng <jie.deng@intel.com> wrote:
>
> ...
>
> > On a related note, we are apparently still missing the bit in the virtio bus
> > layer that fills in the dev->of_node pointer of the virtio device. Without
> > this, it is not actually possible to automatically probe i2c devices connected
> > to a virtio-i2c bus. The same problem came up again with the virtio-gpio
> > driver that suffers from the same issue.
>
> Don't we need to take care about fwnode handle as well?

I'm fairly sure this gets set up automatically on DT based systems, based
on the dev->of_node of the virtio device, with no changes to the i2c
core core.

If you want to automatically probe i2c devices on a virtio-i2c controller
with ACPI, I have no idea if that would require changes to both
i2c-core-acpi.c as well as the virtio core, or just one of them.
So far, my assumption was that this would not be needed with ACPI.

        Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
