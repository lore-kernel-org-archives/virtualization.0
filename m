Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E8CC433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:56:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B8E61153
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B8E61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F9FA60093;
	Thu, 15 Apr 2021 06:56:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A42zp3A-DKO5; Thu, 15 Apr 2021 06:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4386260D75;
	Thu, 15 Apr 2021 06:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05395C000C;
	Thu, 15 Apr 2021 06:56:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61787C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39527401FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id twdTPLA6oPtq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8162C401F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:56:26 +0000 (UTC)
IronPort-SDR: OfcRDvLilc5eo/osnWjh/6MtqdhDh2GR4CSGFX4i987sHZAQn45yhxB8Pow1caDGg0K1ochCIo
 6EAahwHm45Jg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194909774"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="194909774"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 23:56:25 -0700
IronPort-SDR: IwNtvxqKG63G2Vyzj1z8gOzo293FGZE5KxdLe37XiCPZJxNVvEdCvfuLv0RPGJtDm3JpTVBr92
 Rdj06eOGq6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="421596188"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.55])
 ([10.239.154.55])
 by orsmga007.jf.intel.com with ESMTP; 14 Apr 2021 23:56:19 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323072704.rgoelmq62fl2wjjf@vireshk-i7>
 <a2994a8f-bbf9-b26f-a9d2-eb02df6623b8@intel.com>
 <CAK8P3a3OBUZC2nxaQ2wyL9EeT3gzXUX9sfJ+ZJfJUiJK_3ZkrA@mail.gmail.com>
 <20210415064538.a4vf7egk6l3u6zfz@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b25d1f4e-f17f-8a14-e7e6-7577d25be877@intel.com>
Date: Thu, 15 Apr 2021 14:56:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210415064538.a4vf7egk6l3u6zfz@vireshk-i7>
Content-Language: en-US
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, shuo.a.liu@intel.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 2021/4/15 14:45, Viresh Kumar wrote:
> On 23-03-21, 10:27, Arnd Bergmann wrote:
>> I usually recommend the use of __maybe_unused for the suspend/resume
>> callbacks for drivers that use SIMPLE_DEV_PM_OPS() or similar helpers
>> that hide the exact conditions under which the functions get called.
>>
>> In this driver, there is an explicit #ifdef in the reference to the
>> functions, so
>> it would make sense to use the same #ifdef around the definition.
> Jie,
>
> I was talking about this comment when I said I was expecting a new
> version. I think you still need to make this change.


I didn't forget this. It is a very small change. I'm not sure if the 
maintainer Wolfram

has any comments so that I can address them together in one version.

Thanks.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
