Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59752C2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 12:06:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D3E61477
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 12:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D3E61477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83A256073A;
	Mon, 28 Jun 2021 12:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-Vv31aGPBOX; Mon, 28 Jun 2021 12:06:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 35D4E60594;
	Mon, 28 Jun 2021 12:06:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14320C0010;
	Mon, 28 Jun 2021 12:06:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76D1AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 12:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63EE460599
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 12:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwfRWg_qQKwJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 12:06:06 +0000 (UTC)
X-Greylist: delayed 00:07:36 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E19260594
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 12:06:06 +0000 (UTC)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRCFu-1lczaK0vA4-00N9fk for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:53:24 +0200
Received: by mail-wr1-f50.google.com with SMTP id y3so1506966wrq.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 04:53:24 -0700 (PDT)
X-Gm-Message-State: AOAM532DujL4wB0acway2SUGxJZA8MFS7i12RKPfqad8u+KykmAKQVpV
 2xLgsbSEOX9PNz53auRm5r2591wIE8plqENyB+s=
X-Google-Smtp-Source: ABdhPJzgeeV1Oni80yiuTi9OxHyN5NYhrhIio7ch03ZD5B7a0G2ZxN8TSW57aRgI9A+sZfsbv891q4dL2gyadq0w/UQ=
X-Received: by 2002:adf:e107:: with SMTP id t7mr26147077wrz.165.1624881203891; 
 Mon, 28 Jun 2021 04:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
 <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
 <YNmg2IEpUlArZXPK@ninjato>
In-Reply-To: <YNmg2IEpUlArZXPK@ninjato>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 Jun 2021 13:50:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
Message-ID: <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
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
X-Provags-ID: V03:K1:zsPuWy5RJErfFUWzClJepRY+qZeXRjrNyyHo8+xdw4SOoi/NmPH
 hXTicAt5vVpEF67PuJpZ5CzEvL793s/1nwYpG1DzGhvtrt1zMFs6WE77M0UyFYnkf3G7JRC
 ZP54gMyk+5p2QTG8upu4IRjV1PYC/K+K5kcKEljnZdP1vtauo0Ntgs9029Hsl8tre/EMOpC
 ouTjxsmOyV87neOcv9Aeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LCpGRA/U8W4=:BzTSiibyjdFzXS8iv7DXJI
 f5RrdJXVDMwEIoqu9uvza6dMdjZAhqhNSIbVttVrc7TEEwvbUap0iKs3E6L7f/4KNqo55fojA
 B+56ycA5UwLoWan5x75v87f7/eB6HfdtKuDZxLC8sNynQYlaKOpl6sWnOh8XyYTK3fUstBNDx
 tu7zLT0BgZhtzSKBzdGSpG8kZmoeNEHiG9CU4pBuZvoGs03g/m4DSepvj4sqESbtYepCkvH1i
 lvWXpwE71KMWMrPACAWCY/0mjzIE72WRfZHJrSzshWZDSCRoaUzaJPDXf/EzEwbldFDRIN0O+
 iPdOMzgfkN1Hiagiiw1x4f6Us6TX9R9bGBLC2KmAU/WAYe7l9O1L6R4PRNo8wKsKJh2NGtwtV
 XON8dvZv/5Wb/IuO8FErgPzWWi59LcIxmLZWkGmNunriuH319h2TX2Rh8oSB/JlNbGwlDEyml
 syte/U7T3QUpIODRENaxE5TznIJwZJhjjxIqhUlT9XsiamjiQs8kRAaxX/nMrnyZL7Sml3ywW
 NeLG12gppV2+wlJjEUphMk=
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

On Mon, Jun 28, 2021 at 12:13 PM Wolfram Sang <wsa@kernel.org> wrote:
>
>
> > Ok, that's what I thought. There is one corner case that I've struggled
> > with though: Suppose the host has an SMBus-only driver, and the
> > proposed driver exposes this as an I2C device to the guest, which
> > makes it available to guest user space (or a guest kernel driver)
> > using the emulated smbus command set. Is it always possible for
> > the host user space to turn the I2C transaction back into the
> > expected SMBus transaction on the host?
>
> If an SMBus commands gets converted to I2C messages, it can be converted
> back to an SMBus command. I don't see anything preventing that right
> now. However, the mapping-back code does look a bit clumsy, now that I
> envision it. Maybe it is better, after all, to support I2C_SMBUS
> directly and pass SMBus transactions as is. It should be a tad more
> effiecient, too.

You can fine Viresh's vhost-user implementation at
https://lore.kernel.org/qemu-devel/cover.1617278395.git.viresh.kumar@linaro.org/t/#m3b5044bad9769b170f505e63bd081eb27cef8db2

As you say, it does get a bit clumsy, but I think there is also a good argument
to be made that the clumsiness is based on the host Linux user interface
more than the on the requirements of the physical interface,
and that should not have to be reflected in the virtio specification.

> Speaking of it, I recall another gory detail: SMBus has transfers named
> "read block data" and "block process call". These also need special
> support from I2C host controllers before they can be emulated because
> the length of the read needs to be adjusted in flight. These commands
> are rare and not hard to implement. However, it makes exposing what is
> supported a little more difficult.

Right, this one has come up before as well: the preliminary result
was to assume that this probably won't be needed, but would be easy
enough to add later if necessary.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
