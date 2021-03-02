Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B68C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 07:16:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337D661494
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 07:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337D661494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5EFA43098;
	Tue,  2 Mar 2021 07:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0w-gNRuQsHD; Tue,  2 Mar 2021 07:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49BEE4303D;
	Tue,  2 Mar 2021 07:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2026AC000A;
	Tue,  2 Mar 2021 07:16:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6418C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 07:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F33B83D7E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 07:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rIoHGc2Pji7Y
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 07:16:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A14283C46
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 07:16:12 +0000 (UTC)
IronPort-SDR: JK+UyQs/3oDzxLYrW2iD0QlUoBPK+XqGsKVnrqZ3C/7Sv1T5oXwoguD+ub97lS+hOUss6ECVHb
 LjYYEdFCzcbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186042567"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="186042567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 23:16:11 -0800
IronPort-SDR: cONYIPV0OpIAhapGBuMV8l0Va3BTh17wycnHERsBtyZn7o1wKu8N/PRruo2a5RXzARs2ntB5/C
 +jd9tVBIgNbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444631585"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 23:16:05 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <YDzZHKdrpROgSdg3@smile.fi.intel.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <5888846c-cc7b-44b1-98df-9fa10d89a3ff@intel.com>
Date: Tue, 2 Mar 2021 15:16:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDzZHKdrpROgSdg3@smile.fi.intel.com>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 viresh.kumar@linaro.org, shuo.a.liu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 kblaiech@mellanox.com, tali.perry1@gmail.com, conghui.chen@intel.com,
 rppt@kernel.org
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


On 2021/3/1 20:07, Andy Shevchenko wrote:
> On Mon, Mar 01, 2021 at 02:41:35PM +0800, Jie Deng wrote:
>> Add an I2C bus driver for virtio para-virtualization.
>>
>> The controller can be emulated by the backend driver in
>> any device model software by following the virtio protocol.
>>
>> The device specification can be found on
>> https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
>>
>> By following the specification, people may implement different
>> backend drivers to emulate different controllers according to
>> their needs.
> ...
>
>> +		buf = kzalloc(msgs[i].len, GFP_KERNEL);
>> +		if (!buf)
>> +			break;
>> +
>> +		if (msgs[i].flags & I2C_M_RD) {
> kzalloc()
>
>> +			reqs[i].read_buf = buf;
>> +			sg_init_one(&msg_buf, reqs[i].read_buf, msgs[i].len);
>> +			sgs[outcnt + incnt++] = &msg_buf;
>> +		} else {
>> +			reqs[i].write_buf = buf;
>> +			memcpy(reqs[i].write_buf, msgs[i].buf, msgs[i].len);
> kmemdup() ?
Do you mean using "kzalloc" in the if condition and "kmemdup" in the 
else condition ?
Then we have to check the NULL twice which is also not good.
>> +			sg_init_one(&msg_buf, reqs[i].write_buf, msgs[i].len);
>> +			sgs[outcnt++] = &msg_buf;
>> +		}
> ...
>
>> +
>> +
> One blank line is enough.
Will fix it. Thank you.
> ...
>
>
>> +	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
>> +	if (ret == 0)
>> +		goto err_unlock_free;
>> +	else
> Redundant.
Good catch !
>> +		nr = ret;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
