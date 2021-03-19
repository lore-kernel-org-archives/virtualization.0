Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB603C433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 06:56:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A11764F62
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 06:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A11764F62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3177E606E2;
	Fri, 19 Mar 2021 06:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOdjIaIV3ev2; Fri, 19 Mar 2021 06:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8EFF605CA;
	Fri, 19 Mar 2021 06:56:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C40A3C000A;
	Fri, 19 Mar 2021 06:56:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DD32C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DDAC4EBA6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9nsypOH7TmlH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:56:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FE2A4E804
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:56:45 +0000 (UTC)
IronPort-SDR: PmL07HAiKSxDhrRgLft/d4X67rFuRasG+FUPDbbCMQyG0bOdhTtzEZY8qmZibMVv8Ih8dXF6A5
 flUrtC2bGcXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169767602"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="169767602"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 23:56:44 -0700
IronPort-SDR: 4XLjY1071ohxFYhhnhny34Lao8zBShsKovY4BIxPfFqwJ15K+l+6lMrmq2UM+QC0m+/gSkf93q
 60GYy2IGhDiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="591765584"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga005.jf.intel.com with ESMTP; 18 Mar 2021 23:56:37 -0700
Subject: Re: [PATCH v8] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
 <20210316074409.2afwsaeqxuwvj7bd@vireshk-i7>
 <0dfff1ac-50bb-b5bc-72ea-880fd52ed60d@metux.net>
 <CAK8P3a3f9bKdOOMgrA9TfeObyEd+eeg8JcTVT8AyS1+s=X2AjQ@mail.gmail.com>
 <20210319035435.a4reve77hnvjdzwk@vireshk-i7>
 <b135b474-b167-67ad-588c-b0cfe8dc2998@intel.com>
 <20210319054035.47tn747lkagpip6v@vireshk-i7>
 <834186be-71b1-a67c-8dee-b90527b459c8@intel.com>
 <20210319063553.eq5aorcyiame6u2e@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <6df192ef-abc1-35a6-298d-e3e67655ac1f@intel.com>
Date: Fri, 19 Mar 2021 14:56:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210319063553.eq5aorcyiame6u2e@vireshk-i7>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 Arnd Bergmann <arnd@arndb.de>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Tali Perry <tali.perry1@gmail.com>, conghui.chen@intel.com,
 loic.poulain@linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 2021/3/19 14:35, Viresh Kumar wrote:
> On 19-03-21, 14:29, Jie Deng wrote:
>> I also see example drivers/i2c/busses/i2c-xiic.c. Some people might think
>> this way is more clearer than
>>
>> updating each member in probe. Basically, I think it's just a matter of
>> personal preference which doesn't
> Memory used by one instance of struct i2c_adapter (on arm64):
>
> struct i2c_adapter {
>          struct module *            owner;                /*     0     8 */
>          unsigned int               class;                /*     8     4 */
>
>          /* XXX 4 bytes hole, try to pack */
>
>          const struct i2c_algorithm  * algo;              /*    16     8 */
>          void *                     algo_data;            /*    24     8 */
>          const struct i2c_lock_operations  * lock_ops;    /*    32     8 */
>          struct rt_mutex            bus_lock;             /*    40    32 */
>          /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>          struct rt_mutex            mux_lock;             /*    72    32 */
>          int                        timeout;              /*   104     4 */
>          int                        retries;              /*   108     4 */
>          struct device              dev;                  /*   112   744 */
>
>          /* XXX last struct has 7 bytes of padding */
>
>          /* --- cacheline 13 boundary (832 bytes) was 24 bytes ago --- */
>          long unsigned int          locked_flags;         /*   856     8 */
>          int                        nr;                   /*   864     4 */
>          char                       name[48];             /*   868    48 */
>
>          /* XXX 4 bytes hole, try to pack */
>
>          /* --- cacheline 14 boundary (896 bytes) was 24 bytes ago --- */
>          struct completion          dev_released;         /*   920    32 */
>          struct mutex               userspace_clients_lock; /*   952    32 */
>          /* --- cacheline 15 boundary (960 bytes) was 24 bytes ago --- */
>          struct list_head           userspace_clients;    /*   984    16 */
>          struct i2c_bus_recovery_info * bus_recovery_info; /*  1000     8 */
>          const struct i2c_adapter_quirks  * quirks;       /*  1008     8 */
>          struct irq_domain *        host_notify_domain;   /*  1016     8 */
>          /* --- cacheline 16 boundary (1024 bytes) --- */
>
>          /* size: 1024, cachelines: 16, members: 19 */
>          /* sum members: 1016, holes: 2, sum holes: 8 */
>          /* paddings: 1, sum paddings: 7 */
> };
>
> So, this extra instance that i2c-xiic.c is creating (and that you want to
> create) is going to waste 1KB of memory and it will never be used.
>
> This is bad coding practice IMHO and it is not really about personal preference.


I will remove that structure and update the members in probe.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
