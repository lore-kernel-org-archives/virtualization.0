Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E123AC11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 07:51:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B2861C81
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 07:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B2861C81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29661608C1;
	Wed, 30 Jun 2021 07:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ivUQxlM5xsWs; Wed, 30 Jun 2021 07:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E2666608AC;
	Wed, 30 Jun 2021 07:51:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D6A2C0010;
	Wed, 30 Jun 2021 07:51:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B035C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 07:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D671B83641
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 07:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KG0QQwDV8iXL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 07:51:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7954E8356E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 07:51:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="269441028"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; d="scan'208";a="269441028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2021 00:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; d="scan'208";a="641616026"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2021 00:51:09 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, arnd@arndb.de, kblaiech@mellanox.com,
 jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
 rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
 u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
 yu1.wang@intel.com, shuo.a.liu@intel.com, viresh.kumar@linaro.org,
 stefanha@redhat.com, pbonzini@redhat.com
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato> <05cc9484-f97b-0533-64fe-ff917c6b87ee@intel.com>
 <YNwd/t3DMKSOrTAT@ninjato>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <3016ab8b-cbff-1309-6a1f-080703a4130f@intel.com>
Date: Wed, 30 Jun 2021 15:51:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNwd/t3DMKSOrTAT@ninjato>
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


On 2021/6/30 15:32, Wolfram Sang wrote:
>>>> +	snprintf(vi->adap.name, sizeof(vi->adap.name), "Virtio I2C Adapter");
>>> Is there something to add so you can distinguish multiple instances?
>>> Most people want that.
>>
>> I find the I2C core will set a device name "i2c-%d" for this purpose, right?
>>
>> I think this name can be used to distinguish the adapter types while
>> "i2c-%d" can be used to
>>
>> distinguish instances. Does it make sense ?
> That alone does not help. See the 'i2cdetect -l' output of my Renesas
> board here:
>
> i2c-4	i2c       	e66d8000.i2c                    	I2C adapter
> i2c-2	i2c       	e6510000.i2c                    	I2C adapter
> i2c-7	i2c       	e60b0000.i2c                    	I2C adapter
>
> Notice that the third column carries the base address, so you know which
> i2c-%d is which physical bus. I don't know if it makes sense in your
> "virtual" case, but so far it would always print "Virtio I2C Adapter".
> Maybe it makes sense to add some parent device name, too?
>
> And if this is not reasonable, just skip it. As I said, it can be
> helpful at times, but it is definately not a show stopper.


OK. I will add the virtio_device index for this purpose.
which indicates the unique position on the virtio bus.

Thanks Wolfram, I will fix it and send the v11.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
