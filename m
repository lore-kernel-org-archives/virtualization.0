Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93219C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:15:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4468861158
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4468861158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 097ED846CC;
	Thu, 15 Apr 2021 08:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WShnE3Y3MAMe; Thu, 15 Apr 2021 08:15:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20E3D843BC;
	Thu, 15 Apr 2021 08:15:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED699C000C;
	Thu, 15 Apr 2021 08:15:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1F3C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B3A840FA5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4zKkspF0bh4X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:15:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C7A140F98
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:15:16 +0000 (UTC)
IronPort-SDR: Rwy1YfRv5VQreFWM+cItfsa7GGyak3uZ3xFRLuIECVLVgRVM7yQT4t1j6iD5MSz3hTvsLLK/k7
 maPrSeCGs25A==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258771026"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="258771026"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 01:15:15 -0700
IronPort-SDR: u7LQK+9Dd3Vu0zzlFRj1bFC9N57woWeAd5e0rKsvRAkrMxJp68n38NZRUdEA4akfAi0zamTkrT
 g3z2hPIKtBfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="421621064"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.55])
 ([10.239.154.55])
 by orsmga007.jf.intel.com with ESMTP; 15 Apr 2021 01:15:09 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Linux I2C <linux-i2c@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, conghui.chen@intel.com,
 kblaiech@mellanox.com, jarkko.nikula@linux.intel.com,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Mike Rapoport <rppt@kernel.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, yu1.wang@intel.com,
 shuo.a.liu@intel.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323072704.rgoelmq62fl2wjjf@vireshk-i7>
 <a2994a8f-bbf9-b26f-a9d2-eb02df6623b8@intel.com>
 <CAK8P3a3OBUZC2nxaQ2wyL9EeT3gzXUX9sfJ+ZJfJUiJK_3ZkrA@mail.gmail.com>
 <20210415064538.a4vf7egk6l3u6zfz@vireshk-i7>
 <b25d1f4e-f17f-8a14-e7e6-7577d25be877@intel.com>
 <20210415072131.GA1006@kunai> <20210415072431.apntpcwrk5hp6zg4@vireshk-i7>
 <20210415072823.GB1006@kunai>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <6849a8f0-204a-362a-ed97-e910065ab14f@intel.com>
Date: Thu, 15 Apr 2021 16:15:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210415072823.GB1006@kunai>
Content-Language: en-US
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

On 2021/4/15 15:28, Wolfram Sang wrote:

>> Now that we were able to catch you, I will use the opportunity to
>> clarify the doubts I had.
>>
>> - struct mutex lock in struct virtio_i2c, I don't think this is
>>    required since the core takes care of locking in absence of this.
> This is likely correct.


OK. Then I will remove the lock.


>> - Use of I2C_CLASS_DEPRECATED flag, I don't think it is required for
>>    new drivers.
> This is definately correct :)


Do you mean a new driver doesn't need to set the following ?

vi->adap.class = I2C_CLASS_DEPRECATED;

Just leave the class to be 0 ?


>
> Let's see if I will have more questions...


OK. Thank you.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
