Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F3C11F68
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 04:10:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC3E61D51
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 04:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC3E61D51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D30CF403CF;
	Tue, 29 Jun 2021 04:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id po003xKzwS9j; Tue, 29 Jun 2021 04:10:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 36B2240341;
	Tue, 29 Jun 2021 04:10:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 078AFC001A;
	Tue, 29 Jun 2021 04:10:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3978C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A6B182884
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mslilMkQuH_e
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:10:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71049826C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:10:20 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id c8so16110519pfp.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 21:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HbCIMJbXR00eV4jPyvQKtQotReipOTL/gg7Z8DJ8llQ=;
 b=KevEF2v/WbbhBrvu98MkRX2tgsJuIqO1/X0aBDBYmv8nqgbtIXE/gSpKRIi16iOJuf
 SOIak/iEwfohjS2dbJc932HfBoabsNbUOByEpKmvS4q3pznuX1/v43kcZ/dCWeccQH5l
 cXC+GHjt0NZflDe1/EU02kA/laewf6bVJF6ty7mwv6rTa5YRUKDDnv3qLCVUIg9Ysu3Y
 RD/xmgFsTwE+04voR7i+0aiZGct5b7daYDZC/x5qSVrsCOtplbOGBhLcNJcwdn04JHe6
 xkjPCY04gld9AMc7SGJpO0iwZUpUl1pm+0ptTRGPldkg5cirW2lP+Gyhkrp0ZpUo+59q
 hPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HbCIMJbXR00eV4jPyvQKtQotReipOTL/gg7Z8DJ8llQ=;
 b=qrIoiMfV1jS3U1IGfpA8CeKIMAoqGUH2E+iUv+p46Kvc43zR7Yp9l4H7oNFvxVZc5F
 8EwJM6F0yeXQfqmoxkKH0BAsgWrEszu5yAitZ4akyUQstL4xCjnDQCtigw7hXBni48VG
 upTcbcikFphZlOFckErA/y//LyRGLrSv0L58oMwiA/2xMfqoVuQ+Dp/G2vOXKeJFM86f
 UmA52fA+9e0OFvVNGPeiFeo3dEUoaBcupWsIKTTwkmKjZNYrr5JVLYDvDtdWe02SigAr
 5qoP2axT/y+hyofhpYBS5qxGypoaJ8B3RQ4+Pvb/apr0jcCmC+iD4jSBuKChqxQXVzj5
 Bh0g==
X-Gm-Message-State: AOAM531c6q0UTTNl/5logV4fDN23fl+1/HCuWDPbAzDt4s7oqn7Fg2dT
 QcgU17cBCrXhR2HcmL6KbJuOIg==
X-Google-Smtp-Source: ABdhPJx3CFYgS7XBI0CTsMRECG2jABxyuESu9uV4cFATrGVq+dZFzWsPOGAEWkZup9hNd5IWwipNPA==
X-Received: by 2002:a63:d811:: with SMTP id b17mr4522914pgh.286.1624939819758; 
 Mon, 28 Jun 2021 21:10:19 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id y3sm16469487pga.72.2021.06.28.21.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jun 2021 21:10:19 -0700 (PDT)
Date: Tue, 29 Jun 2021 09:40:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jie Deng <jie.deng@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>,
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
Message-ID: <20210629041017.dsvzldikvsaade37@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
 <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
 <YNmg2IEpUlArZXPK@ninjato>
 <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
 <YNnjh3xxyaZZSo9N@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNnjh3xxyaZZSo9N@ninjato>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

I will be replying here instead of replying to each and every msg :)

On 28-06-21, 16:58, Wolfram Sang wrote:
> 
> > You can fine Viresh's vhost-user implementation at
> > https://lore.kernel.org/qemu-devel/cover.1617278395.git.viresh.kumar@linaro.org/t/#m3b5044bad9769b170f505e63bd081eb27cef8db2
> 
> It looks OK so far; yet, it is not complete. But it might be bearable
> in the end.

While we are at it, this has been replaced by a Rust counterpart [1]
(as that makes it hypervisor agnostic, which is the goal of my work
here) and I need someone with I2C knowledge to help review it. It
should be okay even if you don't understand Rust a lot, just review
this file[2] which is where most of i2c specific stuff lies.

> > As you say, it does get a bit clumsy, but I think there is also a good argument
> > to be made that the clumsiness is based on the host Linux user interface
> > more than the on the requirements of the physical interface,
> > and that should not have to be reflected in the virtio specification.
> 
> Makes sense to me.
> 
> > Right, this one has come up before as well: the preliminary result
> > was to assume that this probably won't be needed, but would be easy
> > enough to add later if necessary.
> 
> If adding support incrementally works for such an interface, this makes
> sense as well.

Yes, we don't support few of SMBUS transaction (the block ones) as you
specified.

> So, where are we?

The virtio specification is already merged and here is the latest
version [3].

> As I understand, this v10 does not support I2C transactions (or
> I2C_RDWR as you said).

I am not sure why you say I2C_RDWR isn't supported. The spec and Linux
driver (+ my Rust/qemu backend), they all support I2C_RDWR as well as
SMBUS. To clarify on an earlier point, every virtio transfer may
contain one or more struct i2c_msg instances, all processed together
(as expected).

If you see virtio_i2c_send_reqs() in this patch, you will see that it
converts a stream of i2c_req messages to their virtio counterparts and
send them together, consider it a single transaction.

> But you want to support all clients. So, this doesn't match, or?

-- 
viresh

[1] https://github.com/rust-vmm/vhost-device/pull/1
[2] https://github.com/rust-vmm/vhost-device/blob/5aa22c92faac84ab07b6b15a214513556e8b1d01/src/i2c/src/i2c.rs
[3] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-i2c.tex
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
