Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA397C11F66
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 09:13:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D31A61DE4
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 09:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D31A61DE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A07982BC4;
	Tue, 29 Jun 2021 09:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R5pOl9pE2_Y4; Tue, 29 Jun 2021 09:13:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E160A82B81;
	Tue, 29 Jun 2021 09:13:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92694C001A;
	Tue, 29 Jun 2021 09:13:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB9AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E9FD400FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3qgIOzowUXJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:13:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26E88400A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:13:40 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id n11so6836819pjo.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=/mbR5W4jZNhMRD0mHPnAUx4Qn6VhbPpqpMkPdEN+qCw=;
 b=h3kBBqZh8DPMfpKRMWrkgKG29VmYBFChBsDU6VX3DQIGT21s30+n7loOWNEwLULJYI
 Jt8PlO/AdtorV+BXuwyRi5kVsr/8ziGzZMkIs3sJlT5fkFZCzN4jQe6G5vENi2ghiEy8
 iSNsGWR26aZam456igvzC+A99sXH2vJu5VKvcUa2iqjv8WhojD8w1sNmx2vVtIh6nG9f
 kGvt0hXL+39Ps8C7+wFO1T4JDY4eqpFtYTpVjsIOpfDJ/37P8Mv1qQdYb+kdtERLN5x3
 feYqRfWr4ac7x/b6I81iyeAC/Ivqgui8c/Oha+9yYCJN4UyNY+e21Tm5FyYlLQlnrI+2
 s81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=/mbR5W4jZNhMRD0mHPnAUx4Qn6VhbPpqpMkPdEN+qCw=;
 b=k5BxB/vAm+ld15BkhctTfcklb2t+RDpbjEGX5u5GkmDMbLo2N8/YMaJ8QWhoj+BCcW
 uCz0IiAMOQ+Tk83yp9QtV8r7H3cr0TWBtZHS3sWu5nQhoQ5WUOGuIpE7JnmFzyHlMiPU
 bh7Qfff5zWM5spV9oa8F3RYxRt0W0M+xnHsyZqhHdYojXyFFGOtt+89atM03slWYKlww
 AsiMevzgH0HMFztNrUgGApvu3TH6yYjUrwnYeYYs1c9IivdKbNoF1uiZ2gT6hTUkbpQI
 8IHl730XP7cOnwD00uZ4z6MWp9L/uQ4g4pI/3DLLnci+xiM7JalpOmldYHJd3d/VHEdM
 C2wA==
X-Gm-Message-State: AOAM530dWszWwIZ1g0Mvlm09rFTkV+nfMcr/cLGtgp68KuaLOG49xg43
 yM+uTXnOfKzl5r+kVnqbXbQHyw==
X-Google-Smtp-Source: ABdhPJwX62WyP4ZnIeHKOlZFjp5zh7GhKe84JXR5nkRF7xvHcouHhy1+axXBjzQ/kCNnfCWFOYX/iQ==
X-Received: by 2002:a17:90a:4dc5:: with SMTP id
 r5mr42292126pjl.203.1624958019649; 
 Tue, 29 Jun 2021 02:13:39 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id y4sm17167803pfc.15.2021.06.29.02.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jun 2021 02:13:38 -0700 (PDT)
Date: Tue, 29 Jun 2021 14:43:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Linux I2C <linux-i2c@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, kblaiech@mellanox.com,
 jarkko.nikula@linux.intel.com,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Mike Rapoport <rppt@kernel.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, yu1.wang@intel.com,
 shuo.a.liu@intel.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210629091337.bcerprdyupvgr6gf@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
 <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
 <YNmg2IEpUlArZXPK@ninjato>
 <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
 <YNnjh3xxyaZZSo9N@ninjato>
 <4c7f0989-305b-fe4c-63d1-966043c5d2f2@intel.com>
 <YNraQMl3yJyZ6d5+@kunai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNraQMl3yJyZ6d5+@kunai>
User-Agent: NeoMutt/20180716-391-311a52
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 29-06-21, 10:30, Wolfram Sang wrote:
> =

> > =A0=A0=A0 3. It seems the I2C core takes care of locking already, so is=
 it safy to
> > remove "struct mutex lock in struct virtio_i2c"?
> =

> Looks to me like the mutex is only to serialize calls to
> virtio_i2c_xfer(). Then, it can go. The core does locking. See, we have
> i2c_transfer and __i2c_transfer, the unlocked version.

Right, this is what I have been suggesting as well.

So do you want Jie to send V11 now after fixing these three issues, or
you have more concerns ?

-- =

viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
