Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F157C11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 15:09:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40BC61477
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 15:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40BC61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6353E40465;
	Wed, 30 Jun 2021 15:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JnAtbexzkIe3; Wed, 30 Jun 2021 15:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 964B0400C8;
	Wed, 30 Jun 2021 15:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74ED6C0010;
	Wed, 30 Jun 2021 15:09:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1144C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 15:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E54040596
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 15:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N8ZgKLQKkQ4D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 15:09:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8592405CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 15:09:09 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id g24so1943222pji.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Qwm5a7S4d67APmjTQTuY/hq2xmS0TKPAGGqg/CRnPBo=;
 b=hQH2rW5/+D+sJ/vCi4D9X8JFCi1w+1YhK43zeTPcZwmHjtigMz7Hxi58hLvpUD+8hL
 SVROijWxos23t5Bb/r1YMi/mc8Qlw+LBTwkIUiGnwDG98PM+UoaKA+VhNbnNXA8clSry
 3ldvy7ODk38s0v9vbtVMyVEej8y/uv7Aw61OwDGVw//0fds4QMMRcHpqOZY8wLcHVsR2
 HE0T2XuJbZ9NOqgWdU6Qigdb4P/k4fjulqOovDJrE67zg57LT9uKxhlcwispghfWLBia
 hEQgsgBUr6LNJfYAlwn0AIuac1fIrsccm82oCVHZqn4WRMRnsiJDSZ2tL/2WGTWXXZQR
 DPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Qwm5a7S4d67APmjTQTuY/hq2xmS0TKPAGGqg/CRnPBo=;
 b=fzhS6kxtOd//bVAdm4cJC08YceIuwBW9RoFWDA2KkijCsLJzqf3iQnPor1YVT9lL8d
 f41mB/KymbvrD3JzeLDvtv9C39saWH1nY1ryb+XBmSUHBuiUh9AXK1MYCkJLrm7/bl3i
 eNM5l+OJoU/UXbimn6ST3kWSpnA8IzoFKOo1GRCXN+ttl0qboxDpyLM7Kg4bGuVPSVpC
 mDJaY992CbCVlwrPORHtZtlTsqS9QI4MOOp66W/uLIq3hxH3kpCJP0hx4qN/WkUAlcZY
 E/x4M1Bu2fqd1S95Y48TeyYaqFFFeSZFc6jtInQeUqnPimZDKY+7D6HjfQ9N9ZZkTovu
 XpqQ==
X-Gm-Message-State: AOAM533bI1ip79T/cfgbtmBo3KyCieyo+gZCH2LhngPkz2V7VRXy/LZE
 AL/4zuZ6Tqx0bM1QAMCoO+L47g==
X-Google-Smtp-Source: ABdhPJym5Xp6zNUdD2feUDXohHd8CRMVwRm3dGknfSKatUpwmL5kTwmKxG7StUS5g65JI3R/thswEg==
X-Received: by 2002:a17:90b:4f83:: with SMTP id
 qe3mr5005813pjb.49.1625065749166; 
 Wed, 30 Jun 2021 08:09:09 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id f69sm3163333pfa.24.2021.06.30.08.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 08:09:08 -0700 (PDT)
Date: Wed, 30 Jun 2021 20:39:01 +0530
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
Message-ID: <20210630150901.5uzjelg4k7xgbumb@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
 <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
 <YNmg2IEpUlArZXPK@ninjato>
 <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
 <YNnjh3xxyaZZSo9N@ninjato>
 <20210629041017.dsvzldikvsaade37@vireshk-i7>
 <YNyB/+fNK0u2bI6j@kunai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNyB/+fNK0u2bI6j@kunai>
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

On 30-06-21, 16:38, Wolfram Sang wrote:
> > While we are at it, this has been replaced by a Rust counterpart [1]
> > (as that makes it hypervisor agnostic, which is the goal of my work
> > here) and I need someone with I2C knowledge to help review it. It
> > should be okay even if you don't understand Rust a lot, just review
> > this file[2] which is where most of i2c specific stuff lies.
> 
> From the high level review I can provide, it looks good to me. Block
> transfers are missing, but I think you said that already. Mising Rust
> experience, I might miss details, of course. But the general approach
> seems fine to me. smbus_prepare() will get a bit more messy when you add
> block transfers, but it still looks bearable, I think.

Thanks for having a look.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
