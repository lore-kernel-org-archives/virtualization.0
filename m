Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BCBC433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 15:24:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F8F64E01
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 15:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F8F64E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2194360592;
	Mon,  1 Mar 2021 15:24:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AlBTrOw4EYGv; Mon,  1 Mar 2021 15:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFF3D6069E;
	Mon,  1 Mar 2021 15:24:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2ED9C000B;
	Mon,  1 Mar 2021 15:24:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEC05C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C04B06069E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDUdR_OJcY8R
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:24:27 +0000 (UTC)
X-Greylist: delayed 00:05:05 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A264860592
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 15:24:26 +0000 (UTC)
Received: from mail-ot1-f41.google.com ([209.85.210.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MLz3X-1lY8aU005B-00HsIL for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 16:19:19 +0100
Received: by mail-ot1-f41.google.com with SMTP id k13so16752858otn.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 07:19:18 -0800 (PST)
X-Gm-Message-State: AOAM531wQIRIxdZIaY82pcrJr4xBC4Ah+iTGMAHmLD0lp/buTc3O8kQw
 PpsFihUeH8y2OXQ7wRNqabgbAdJCQmB68cmk7nU=
X-Google-Smtp-Source: ABdhPJzyiLnOL1kROt9+jRnTIwJeOV/uCEnyhesvyVqUv7WZRVsJ+KCvh3/BmgI42/Bl2bUQmuVo20Np1fETHnPswk4=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr14016983otq.210.1614611957367; 
 Mon, 01 Mar 2021 07:19:17 -0800 (PST)
MIME-Version: 1.0
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
In-Reply-To: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 1 Mar 2021 16:19:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
Message-ID: <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>
X-Provags-ID: V03:K1:iFo1N4Bd2AirwQycNH7SYCfItSKr0vw9dobN5VB9BKJej7Cj7c4
 rMuZ3PdvWLVjfXA+GqtLSFbZZVo6bbMtVxqOx+nBiazhuDvtnsKccGRfT5LC8uiFscDtofo
 6oHv+SGl9qJYTFVwHQ74xU2+MEms4eiZiVVe603W8AQf68I74cQJmdoTHv664RMPmgn89JZ
 eVMz1I2TBmh+c18m8DeTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TgEqFzUOmdM=:vYvQ7zur6b2mhtInzaOhls
 W5pGKvEaCkgtihNXAg6SatyPcY7ub8PbXtvs4XhnDFkeeHK/7SS4qMtarSfCze8MX+U18NqT0
 QmoHAzqgL9Fh6zi2NR3iAv1bJfoT3te+QBwkCjr8MDmrW5iDztRKIggWH4rDKFkp3vRYOwhuq
 +aLCV5aWOUpMTIMgDPlXaefBabQvFoV8gZ5cmA1XPY9A0S0t0EuUowSENQEOU38s6xzrtbBP8
 pWJC/lxO/WpS6uo/D5/SILq21MlivFv0UL35twkutWLJ9162hHT4UfvoyMK1joGMYOtCt1NqP
 DmPOloPhFrvOpD79PYRUVl5U766X/eAfuPnhEGTEIGueUVM9+IDYu0Q0QBmRw9Re1bmCoSyNn
 xko48KI+wrRNK0XWjf+dNQrHtZb8hd7WAauvcX1v9TkgZXCSU3LTcXxcs0KZxwoAbKNAxzVnv
 VSt0V5Y0sqns/fjU97NL10IsUzwyLqeerhiC49uuCp5EuBLAmQ8jVoSQqHuV9fp5sM87FMX+T
 6py6c3R9I9A5AFI8JRAV+kogh4jCVVmYgkviWLF3vmT
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>
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

On Mon, Mar 1, 2021 at 7:41 AM Jie Deng <jie.deng@intel.com> wrote:

> --- /dev/null
> +++ b/include/uapi/linux/virtio_i2c.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
> +/*
> + * Definitions for virtio I2C Adpter
> + *
> + * Copyright (c) 2021 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
> +#define _UAPI_LINUX_VIRTIO_I2C_H

Why is this a uapi header? Can't this all be moved into the driver
itself?

> +/**
> + * struct virtio_i2c_req - the virtio I2C request structure
> + * @out_hdr: the OUT header of the virtio I2C message
> + * @write_buf: contains one I2C segment being written to the device
> + * @read_buf: contains one I2C segment being read from the device
> + * @in_hdr: the IN header of the virtio I2C message
> + */
> +struct virtio_i2c_req {
> +       struct virtio_i2c_out_hdr out_hdr;
> +       u8 *write_buf;
> +       u8 *read_buf;
> +       struct virtio_i2c_in_hdr in_hdr;
> +};

In particular, this structure looks like it is only ever usable between
the transfer functions in the driver itself, it is shared with neither
user space nor the virtio host side.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
