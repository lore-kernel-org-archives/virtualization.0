Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC31C2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 09:53:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E175361C5B
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 09:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E175361C5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8929400B9;
	Mon, 28 Jun 2021 09:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H3Gn_8p0Xj-h; Mon, 28 Jun 2021 09:53:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57573400BE;
	Mon, 28 Jun 2021 09:53:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DEE6C0010;
	Mon, 28 Jun 2021 09:53:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8397C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6FAB60723
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hiA6m_W816QC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:53:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F22B460720
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 09:53:48 +0000 (UTC)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFsER-1m1O3Z4BDD-00HRhx for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 11:53:47 +0200
Received: by mail-wr1-f53.google.com with SMTP id u11so20446092wrw.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 02:53:46 -0700 (PDT)
X-Gm-Message-State: AOAM530OdS7IZgIsJq9ZNp3dDj1cZJroyrPFzOTm/mZV/la7/86Zg61E
 AxiLaijoorb0TQaCOH6bTxYr7pJGtmLGK1GtYcA=
X-Google-Smtp-Source: ABdhPJwktqDothMpLIRlMDpocHDcEWckQcB5id0jYduIugUmev01PMKggW/MtSAVvvpDnvAX/XZRRryNLFIoMAA6eyE=
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr5557535wrr.361.1624874026628; 
 Mon, 28 Jun 2021 02:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
In-Reply-To: <YNmVg3ZhshshlbSx@ninjato>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 Jun 2021 11:51:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
Message-ID: <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jie Deng <jie.deng@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 conghui.chen@intel.com, kblaiech@mellanox.com, jarkko.nikula@linux.intel.com, 
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Mike Rapoport <rppt@kernel.org>, 
 loic.poulain@linaro.org, Tali Perry <tali.perry1@gmail.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Bjorn Andersson <bjorn.andersson@linaro.org>, yu1.wang@intel.com,
 shuo.a.liu@intel.com, 
 Viresh Kumar <viresh.kumar@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Provags-ID: V03:K1:CKYeGRLUjKRCZW2au00hl1FxM0bA7VM8i5R5OupDu2d2JBp+yOB
 4R/s5fYoYHxd+KuUR+uL7JtxyOI+Wv3nvCYhWYIS3AYdmhuOvPvaTFpadP8rWlytS3IIkT/
 Y27nCi7qW1b+bQl5oUpzgkgMmqOgYVQvb8EuZHL0seA8ZCrPhTLNu7QSNBdNADpigHUN8nc
 ISaBsRmlbtZPWAmdWPDqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WoNNpVF+aTg=:MZPseY6eTDF3PFQFq3snnJ
 xmmcyUjdO/NDkYOV+6Iw1uoCGwddPg38m9zwgbqd9u2D8MLtiSKFdrrGc+KoENbbsdbPnEis9
 +jUoXa/PPdxgXOyACQsvOLH351HX4j6tisihq2hsyMkD6aeWoqPxzlKYZVrgRCU8SH29g3kPI
 hyW9EH0BODWHpylAQs+vFf3mG2Ou2Th0foNuLfXAgJV7ov2df7T+kMkIRVE5r+RnPvcDc/ETx
 HMxsYSkUUMvq4DYPzhB6JTBaObT+TqunJhL0+oTXJhFgjHlFpoQ00sO61uK81DsYK+Eg7eBd/
 13i1382DRbfRzNMOLFy5KyYCrvoP/9oambpUC8j9AgJnSimrlgl/lV+mueWzHsNdQDvaKAG/Q
 8rDoDWkVtv8/v8bfwzXPsNiMWIDgAn/82EvNwr4pFuZYpWsRm9UuB4wKr1k6GB6i0xLvog0pb
 HJC+L35kHg5yr1iKu4eAx/05DVYXCAg2n3KCtfaNT7XrtcnAoTrtrQUIpb6631uTyzjHIctNt
 UQ7dTY3cdQULGJCxT12JFXYN1dVxohnxk4iP6Z6C0OnmnbESW3FOM0KjK4pjxzIXAiROVt8kD
 r10wKwcv4RlAQH8XV6sXBN+4ipjJYozT68LRtXqOwEwRerCcdHNhqOw2DE5QGF0rTiSpjCtri
 OUX8=
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

On Mon, Jun 28, 2021 at 11:25 AM Wolfram Sang <wsa@kernel.org> wrote:
> > As far as I understand me (please clarify), implementing only the smbus
> > subset would mean that we cannot communicate with all client devices,
> > while implementing both would add more complexity than the lower-level
> > protocol.
>
> Correct. You need to pick I2C if you want to support all devices. SMBus
> will give you only a lot of devices.

Ok, that's what I thought. There is one corner case that I've struggled
with though: Suppose the host has an SMBus-only driver, and the
proposed driver exposes this as an I2C device to the guest, which
makes it available to guest user space (or a guest kernel driver)
using the emulated smbus command set. Is it always possible for
the host user space to turn the I2C transaction back into the
expected SMBus transaction on the host?

> > > Also, as I read it, a whole bus is para-virtualized to the guest, or?
> > > Wouldn't it be better to allow just specific devices on a bus? Again, I
> > > am kinda new to this, so I may have overlooked things.
> >
> > Do you mean just allowing a single device per bus (as opposed to
> > having multiple devices as on a real bus), or just allowing
> > a particular set of client devices that can be identified using
> > virtio specific configuration (as opposed to relying on device
> > tree or similar for probing). Both of these are valid questions that
> > have been discussed before, but that could be revisited.
>
> I am just thinking that a physical bus on the host may have devices that
> should be shared with the guest while other devices on the same bus
> should not be shared (PMIC!). I'd think this is a minimal requirement
> for security. I also wonder if it is possible to have a paravirtualized
> bus in the guest which has multiple devices from the host sitting on
> different physical busses there. But that may be the cherry on the top.

This is certainly possible, but is independent of the implementation of
the guest driver. It's up to the host to provision the devices that
are actually passed down to the guest, and this could in theory
be any combination of emulated devices with devices connected to
any of the host's physical buses. The host may also decide to remap
the addresses of the devices during passthrough.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
