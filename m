Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28415C11F67
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 08:52:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC04C61DC1
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 08:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC04C61DC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71D4F402A0;
	Tue, 29 Jun 2021 08:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FISSKYp4OAlj; Tue, 29 Jun 2021 08:52:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D117400A4;
	Tue, 29 Jun 2021 08:52:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DECBAC0010;
	Tue, 29 Jun 2021 08:52:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A65EAC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 08:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 944744012D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 08:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_USUcLoT-ao
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 08:52:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84B20400A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 08:52:16 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id c8so16637192pfp.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VRDj6e+Lqnmeo3ZhydynJ+H5q+l8CnwAokRbOJM0nwc=;
 b=yVj+8Vh6JwKM1tH895sPcIlFKTgBt2qxInbHnxNMFWHV4he+OcXXLT/d2niuW/CEmt
 g9LYtuNyCBURRSH+gir2EOQsBc8Ms36tLjuJT6K3xh6IRdMyFSb/vFjLOmVfb+R1YLAR
 QlMG1UZ5m5WdsAhU4IQSZqywzzDbpO5q2umuw49EBwIfpxKkE7DFiYuzw1Y2Er+mWb8m
 uBtbkndiJ5HLBNFuecdEr6zQjvDbpCIzp9zK1jA91S0u2/HB63MQ9nqK9+RzGrxrXtem
 r+8542jeuxhdX+4v6UJSi0UBXrv6FsGVqiWxulZBWrrF/rPR6NkSMZGIlzG4PaEhALZR
 V28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VRDj6e+Lqnmeo3ZhydynJ+H5q+l8CnwAokRbOJM0nwc=;
 b=NoPuReOs3WzqP+xO3pU2GX76nnRkE5QlSCOKrp4rEPN4SAjVLvsgQe6g4JlF1ky2x9
 MKMDUF5ZRItCovhwkkQWx7o16/WbGLu1bhmY6RufhrCshFzFZOKpA+BPl6fTF31647aJ
 MdM0bXipgxs5uhoRvltjaQw+XQ2Tnmd9PA9eApCXc+gLL3Eq9XW4mM1l+yANo+YDKXw9
 VekzlfUQjzyHxwIu8ZRDa+PDXmwEFelR1qiAJV3TtTahJQZkXiOa1HgJVtcQJz7e/Agd
 DRNDWhTa6bDlbkp5/Rvb9a+xCHAfNpvwzFJz/nFmQS7Put8NYhtbk/B3xsP0FUaQhbd6
 dLRQ==
X-Gm-Message-State: AOAM531/vyLq5r3XetTTs3/aAbyEepB6L6AFl97DVsm0NmO1nAvc1UMg
 QNvq1QHw6tE3wPzomyLEIYY2JA==
X-Google-Smtp-Source: ABdhPJxw2YQgANmJKSXb0azrt7CyxbCAGSM9vVRfeCOACPl0w7wdr4dlRe4f8Q2/+LafbzEvYR8owQ==
X-Received: by 2002:a05:6a00:d0:b029:30a:4c82:181 with SMTP id
 e16-20020a056a0000d0b029030a4c820181mr16562171pfj.27.1624956735846; 
 Tue, 29 Jun 2021 01:52:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id t8sm17547212pjs.12.2021.06.29.01.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jun 2021 01:52:15 -0700 (PDT)
Date: Tue, 29 Jun 2021 14:22:13 +0530
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
Message-ID: <20210629085213.7a7eqcgkmtk5y7nh@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
 <YNmVg3ZhshshlbSx@ninjato>
 <CAK8P3a3Z-9MbsH6ZkXENZ-vt8+W5aP3t+EBcEGRmh2Cgr89R8Q@mail.gmail.com>
 <YNmg2IEpUlArZXPK@ninjato>
 <CAK8P3a3vD0CpuJW=3w3nq0h9HECCiOigNWK-SvXq=m1zZpqvjA@mail.gmail.com>
 <YNnjh3xxyaZZSo9N@ninjato>
 <20210629041017.dsvzldikvsaade37@vireshk-i7>
 <YNrZVho/98qgJS9N@kunai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNrZVho/98qgJS9N@kunai>
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

On 29-06-21, 10:27, Wolfram Sang wrote:
> > While we are at it, this has been replaced by a Rust counterpart [1]
> > (as that makes it hypervisor agnostic, which is the goal of my work
> > here) and I need someone with I2C knowledge to help review it. It
> > should be okay even if you don't understand Rust a lot, just review
> > this file[2] which is where most of i2c specific stuff lies.
> 
> Can't promise I can do this before my holidays, but I will try.

Thanks.

> > I am not sure why you say I2C_RDWR isn't supported. The spec and Linux
> 
> This is how I interpreted Arnd's response. I said mulitple times that I
> might be missing something so I double check.
> 
> > SMBUS. To clarify on an earlier point, every virtio transfer may
> > contain one or more struct i2c_msg instances, all processed together
> > (as expected).
> 
> That was the information missing for me so far becasue...
> 
> > If you see virtio_i2c_send_reqs() in this patch, you will see that it
> > converts a stream of i2c_req messages to their virtio counterparts and
> > send them together, consider it a single transaction.
> 
> ... when I checked virtio_i2c_send_reqs(), I also saw
> virtqueue_add_sgs() but I had no idea if this will end up as REP_START
> on the physical bus or not. But it definately should.

Just think of virtqueue_add_sgs() as something that setups the
structures for transfer. The actual stuff at the other end (host)
happens only after virtqueue_kick() is called at the guest (this
notifies the host that data is present now), in response the backend
running at host will re-create the struct i2c_msg and issue:

    struct i2c_rdwr_ioctl_data data;
    data.nmsgs = count;
    data.msgs = msgs;

    return ioctl(adapter->fd, I2C_RDWR, &data);

So we will end up recreating the exact situation as when
virtio_i2c_xfer() is called.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
