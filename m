Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E742C433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 01:37:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89ED61925
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 01:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89ED61925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A69D400F2;
	Wed, 12 May 2021 01:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gqs4CFp3J-R2; Wed, 12 May 2021 01:37:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D9AD400F6;
	Wed, 12 May 2021 01:37:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE33C000D;
	Wed, 12 May 2021 01:37:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95347C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E56E605BD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eer3rbJklVEo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:37:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2A7060592
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:37:36 +0000 (UTC)
IronPort-SDR: A+Z8lfLejwGQGXWjcZwxN1ZQ3chwFVSCeL7B4g/ENLhBkqrk1o8/jzVeoEK1DK3bqnfWZE7xHo
 TMTWcmNReMqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199273947"
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; d="scan'208";a="199273947"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 18:37:34 -0700
IronPort-SDR: 007IjHf4WiwPqoxuEtwNyMbvc+/ux94zViP2xJeFry1Btbsi5mIj4XZeHY0rTK00U0YS+61Yr8
 8B5C6Pk0Sjig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; d="scan'208";a="609708586"
Received: from unknown (HELO [10.239.154.58]) ([10.239.154.58])
 by orsmga005.jf.intel.com with ESMTP; 11 May 2021 18:37:29 -0700
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
 shuo.a.liu@intel.com, Stefan Hajnoczi <stefanha@redhat.com>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323072704.rgoelmq62fl2wjjf@vireshk-i7>
 <a2994a8f-bbf9-b26f-a9d2-eb02df6623b8@intel.com>
 <CAK8P3a3OBUZC2nxaQ2wyL9EeT3gzXUX9sfJ+ZJfJUiJK_3ZkrA@mail.gmail.com>
 <20210415064538.a4vf7egk6l3u6zfz@vireshk-i7>
 <b25d1f4e-f17f-8a14-e7e6-7577d25be877@intel.com>
 <20210415072131.GA1006@kunai>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <9a51ed24-c6cd-cafd-73d3-6ed165594b49@intel.com>
Date: Wed, 12 May 2021 09:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210415072131.GA1006@kunai>
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

On 2021/4/15 15:21, Wolfram Sang wrote:

>> I didn't forget this. It is a very small change. I'm not sure if the
>> maintainer Wolfram
>>
>> has any comments so that I can address them together in one version.
> Noted. I'll have a look in the next days.

Hi Wolfram,

Kindly reminder. Hope this patch hasn't been forgotten. :)

Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
