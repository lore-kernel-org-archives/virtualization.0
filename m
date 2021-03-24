Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5137C433C1
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 01:18:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF2D619E9
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 01:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF2D619E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 017AE40407;
	Wed, 24 Mar 2021 01:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-Mkq41eYU11; Wed, 24 Mar 2021 01:18:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id A04A940401;
	Wed, 24 Mar 2021 01:18:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69FF1C000D;
	Wed, 24 Mar 2021 01:18:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E526EC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 01:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBF8240405
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 01:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W9AMQ3Xq6VIS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 01:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57C5F40401
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 01:18:04 +0000 (UTC)
IronPort-SDR: 20z4pfDvrM3E/+AMa+Cni6IHM0I6P9omydJg4EtE7MDZEMn2Bycww8a9EkQCu9b6wAv6iVqS1Z
 fbpF0XPz0q4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188282370"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="188282370"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2021 18:18:03 -0700
IronPort-SDR: zAlVZ9yHmWlD4rtt/9FoVQjk34tigwDEmDonNYtYPOpKDIpnEJojpLYTTQ3KhEgBo45gVMFNs+
 fySOsJvqCaIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="441971978"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2021 18:17:58 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Arnd Bergmann <arnd@arndb.de>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210323072704.rgoelmq62fl2wjjf@vireshk-i7>
 <a2994a8f-bbf9-b26f-a9d2-eb02df6623b8@intel.com>
 <CAK8P3a3OBUZC2nxaQ2wyL9EeT3gzXUX9sfJ+ZJfJUiJK_3ZkrA@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <3a671a0a-b0d0-be1a-5463-8124ff63684d@intel.com>
Date: Wed, 24 Mar 2021 09:17:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3OBUZC2nxaQ2wyL9EeT3gzXUX9sfJ+ZJfJUiJK_3ZkrA@mail.gmail.com>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, loic.poulain@linaro.org,
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


On 2021/3/23 17:27, Arnd Bergmann wrote:
> On Tue, Mar 23, 2021 at 9:33 AM Jie Deng <jie.deng@intel.com> wrote:
>> On 2021/3/23 15:27, Viresh Kumar wrote:
>>
>>> On 23-03-21, 22:19, Jie Deng wrote:
>>>> +static int __maybe_unused virtio_i2c_freeze(struct virtio_device *vdev)
>>>> +{
>>>> +    virtio_i2c_del_vqs(vdev);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __maybe_unused virtio_i2c_restore(struct virtio_device *vdev)
>>>> +{
>>>> +    return virtio_i2c_setup_vqs(vdev->priv);
>>>> +}
>>> Sorry for not looking at this earlier, but shouldn't we enclose the above two
>>> within #ifdef CONFIG_PM_SLEEP instead and drop the __maybe_unused ?
>>
>> I remembered I was suggested to use "__maybe_unused" instead of "#ifdef".
>>
>> You may check this https://lore.kernel.org/patchwork/patch/732981/
>>
>> The reason may be something like that.
> I usually recommend the use of __maybe_unused for the suspend/resume
> callbacks for drivers that use SIMPLE_DEV_PM_OPS() or similar helpers
> that hide the exact conditions under which the functions get called.
>
> In this driver, there is an explicit #ifdef in the reference to the
> functions, so
> it would make sense to use the same #ifdef around the definition.
>
> A better question to ask is whether you could use the helpers instead,
> and drop the other #ifdef.
>
>         Arnd


I didn't see the "struct virtio_driver" has a member "struct dev_pm_ops *pm"

It defines its own hooks (freeze and restore) though it includes "struct 
device_driver"

which has a "struct dev_pm_ops *pm".

I just follow other virtio drivers to directly use the hooks defined in 
"struct virtio_driver".

For this driver, Both __maybe_unused and #ifdef are OK to me.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
