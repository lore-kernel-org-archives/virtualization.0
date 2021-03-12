Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B4CC433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 08:58:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3361564FF9
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 08:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3361564FF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D77478451D;
	Fri, 12 Mar 2021 08:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JPdg4oFQt310; Fri, 12 Mar 2021 08:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 833EE83576;
	Fri, 12 Mar 2021 08:58:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C1C1C000B;
	Fri, 12 Mar 2021 08:58:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 938F8C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7432F4150B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5rpykUPh97gA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:58:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B9AB40025
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:58:28 +0000 (UTC)
Received: from mail-ot1-f41.google.com ([209.85.210.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N4R0a-1llkz13bh0-011Nzv for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 09:58:26 +0100
Received: by mail-ot1-f41.google.com with SMTP id x28so3179624otr.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 00:58:25 -0800 (PST)
X-Gm-Message-State: AOAM5308Kj0uujvQvL+BgUwg8I/YnPHZtxix4L3MEhnCU+KcVOO0p6s1
 jU1cATXPF4o8UxPkN/+bPB/xHgxEwH+FczDOwYg=
X-Google-Smtp-Source: ABdhPJwYs59n0VylMOhIElZBVkf0QrYdjO1x9NuhV8bORxTjcrcJXdCea/1IKmHztL8VndEu2T79aN56RsYQecgZr2I=
X-Received: by 2002:a9d:6341:: with SMTP id y1mr2560459otk.210.1615539504308; 
 Fri, 12 Mar 2021 00:58:24 -0800 (PST)
MIME-Version: 1.0
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
In-Reply-To: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Mar 2021 09:58:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
Message-ID: <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>
X-Provags-ID: V03:K1:F5a8jhpwZ+kdE0K8UeXWwmLyIrJ26DAkcQKsesjhbJCUii5Q+Qz
 URcNtzXOWiP9sNNBFPJJxDsmYeLGI+WJ9Eyn2cxi2SBzpctL0ivZsiVgS+EBrslkMmvIUAm
 MJCisJ0QXggC+56+vKBtIw16Ypj7ybfbBF6xyn6rZtWIEsuWQc0Km68/REEb/UkHlWkSClQ
 V/rp31OToq9/hykjzssVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G7U+gqgn0ek=:u7V8yP2z66HqcS61gILgbC
 I8LJNluRc5SCVRYnDkB5FaYDxn1aPwesWeV+AtHLOhhwA0pLCXsu+TjIdNI05qzaTyW/XYEFy
 tJ9xN69kzbmJjnSyeqhx80ILF8B8JcGZvI0Uf/utgCmABuAn6x4FEs/wk0t+e6cuqyjYQTFAU
 P6sFi3+sHDxleXgTPDWSV6EdTdCAvhE2eO7lQrBCZShYxCORsD6oO7ROFft63CgcQ6bP3/ZBc
 xMbZmBtI49hQzFPga2+CH91NbGh4u0B6pSijyFuWRhHl5fJBhg05Qm5Y44kJ4Oqzov7EXMfKx
 lZG6IEaYiu1mPg78FjQOVA5t7O8r1wUKPtJvbsRikokB1FbYiMbF19rnKrzSMZCtXr3w1gtEV
 +w67tEiin9Obm2xSQJIqeA+jyNdWHXWoVExKKpYVXELw26adajO/gbmdcCbYpjCmVzIQwxGFR
 s6Ds+VWNU1tCc8QAF1LhFOwiQGqYwjhUqhfOVk3TwC/btU3umFX30wrl3pf/OqFLjres+8VUg
 99eVA2pEKJDiH7pFMtFBqvKCf0du5BS/m+vsdqqSq/qf0R0WlgeDVsmQ0bUTqXQzw==
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Fri, Mar 12, 2021 at 2:33 PM Jie Deng <jie.deng@intel.com> wrote:

> +
> +/**
> + * struct virtio_i2c_req - the virtio I2C request structure
> + * @out_hdr: the OUT header of the virtio I2C message
> + * @buf: the buffer into which data is read, or from which it's written
> + * @in_hdr: the IN header of the virtio I2C message
> + */
> +struct virtio_i2c_req {
> +       struct virtio_i2c_out_hdr out_hdr;
> +       uint8_t *buf;
> +       struct virtio_i2c_in_hdr in_hdr;
> +};

The simpler request structure clearly looks better than the previous version,
but I think I found another problem here, at least a theoretical one:

When you map the headers into the DMA address space, they should
be in separate cache lines, to allow the DMA mapping interfaces to
perform cache management on each one without accidentally clobbering
another member.

So far I think there is an assumption that virtio buffers are always
on cache-coherent devices, but if you ever have a virtio-i2c device
backend on a physical interconnect that is not cache coherent (e.g. a
microcontroller that shares the memory bus), this breaks down.

You could avoid this by either allocating arrays of each type separately,
or by marking each member that you pass to the device as
____cacheline_aligned.

      Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
