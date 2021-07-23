Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A89C4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:22:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1693760EB5
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1693760EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1C024013C;
	Fri, 23 Jul 2021 02:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qr5Lf52AWLpW; Fri, 23 Jul 2021 02:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6291B400C5;
	Fri, 23 Jul 2021 02:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE8AC0010;
	Fri, 23 Jul 2021 02:22:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF16EC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B44C78299E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RgZ34NgOwWpj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:22:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F937828BA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:22:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="272900659"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; d="scan'208";a="272900659"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2021 19:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; d="scan'208";a="502337077"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Jul 2021 19:21:54 -0700
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com, arnd@arndb.de, jasowang@redhat.com,
 andriy.shevchenko@linux.intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com,
 conghui.chen@intel.com, viresh.kumar@linaro.org, stefanha@redhat.com,
 gregkh@linuxfoundation.org
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <YPmQQelKfa4J7zdA@ninjato>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <4c257470-9b07-d5dc-a5ba-770b0229663e@intel.com>
Date: Fri, 23 Jul 2021 10:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPmQQelKfa4J7zdA@ninjato>
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

On 2021/7/22 23:35, Wolfram Sang wrote:

> Hi,
>
> so only minor stuff left from my side.
>
>> @@ -21,6 +21,17 @@ config I2C_ALI1535
>>   	  This driver can also be built as a module.  If so, the module
>>   	  will be called i2c-ali1535.
>>   
>> +config I2C_VIRTIO
>> +	tristate "Virtio I2C Adapter"
>> +	select VIRTIO
>> +	help
>> +	  If you say yes to this option, support will be included for the virtio
>> +	  I2C adapter driver. The hardware can be emulated by any device model
>> +	  software according to the virtio protocol.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called i2c-virtio.
>> +
>>   config I2C_ALI1563
>>   	tristate "ALI 1563"
>>   	depends on PCI
> The sorting is not good. I think your entry should go to the bottom of
> the Kconfig file.


OK. I will move it to the bottom.


>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 69e9963..9843756 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -147,4 +147,7 @@ obj-$(CONFIG_I2C_XGENE_SLIMPRO) += i2c-xgene-slimpro.o
>>   obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>>   obj-$(CONFIG_I2C_FSI)		+= i2c-fsi.o
>>   
>> +# VIRTIO I2C host controller driver
> This comment can go, I'd say.


I will remove this line. Thank you.


>
>> +obj-$(CONFIG_I2C_VIRTIO)	+= i2c-virtio.o
>> +
>>   ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
>
>> +		/*
>> +		 * We don't support 0 length messages and so masked out
>> +		 * I2C_FUNC_SMBUS_QUICK in virtio_i2c_func().
>> +		 */
>> +		if (!msgs[i].len)
>> +			break;
> I recommend using struct i2c_adapter_quirks with I2C_AQ_NO_ZERO_LEN. But
> let's wait first if zero length are possible or not.


I think we can add an i2c_adapter_quirks for this moment. Support for 
I2C_FUNC_SMBUS_QUICK
can be added incrementally if needed.


>
> Also, checkpatch:
>
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>
> So, is one of you interested in maintaining this driver?
>
> All the best,
>
>     Wolfram


I will play this role. I see Viresh also spend a lot of time on this driver.

So I'd like to ask Viresh, are you willing to be a co-maintainer ?

Regards,
Jie


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
