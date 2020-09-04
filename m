Return-Path: <SRS0=He06=CN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF6C43461
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 05:29:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866BD206C9
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 05:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866BD206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6737C86DAE;
	Fri,  4 Sep 2020 05:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yexRulQwRn3K; Fri,  4 Sep 2020 05:29:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5CAD1866DE;
	Fri,  4 Sep 2020 05:29:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8EFC07FF;
	Fri,  4 Sep 2020 05:29:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44A73C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 05:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2CAB8874EE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 05:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9+5YmZxAAfT
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 05:29:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 847D7874E9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 05:29:05 +0000 (UTC)
IronPort-SDR: y4wjNHqUKJtlCqpS3dmpgkMphnzzf41bM8H3VhRoUtrDN7cq4p2gn4HV/NnHF+wCDR4W9LZMBT
 y/Rlai/meAjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="219250519"
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; d="scan'208";a="219250519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 22:29:04 -0700
IronPort-SDR: Q86+RsKjWPVnlFWVlO8qPU3DAeUdjybbx+mzk7VzMm6HiRSQhhrw17/F9xhnDahn9QE2WWDCah
 8bksgMuCCPxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; d="scan'208";a="502779266"
Received: from unknown (HELO [10.239.154.46]) ([10.239.154.46])
 by fmsmga006.fm.intel.com with ESMTP; 03 Sep 2020 22:29:00 -0700
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <20200903055633-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <158c9601-d38c-47b4-9493-43fd89a85398@intel.com>
Date: Fri, 4 Sep 2020 13:28:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200903055633-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 linux-kernel@vger.kernel.org, krzk@kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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


On 2020/9/3 17:58, Michael S. Tsirkin wrote:
> On Thu, Sep 03, 2020 at 01:34:45PM +0800, Jie Deng wrote:
>> Add an I2C bus driver for virtio para-virtualization.
>>
>> The controller can be emulated by the backend driver in
>> any device model software by following the virtio protocol.
>>
>> This driver communicates with the backend driver through a
>> virtio I2C message structure which includes following parts:
>>
>> - Header: i2c_msg addr, flags, len.
>> - Data buffer: the pointer to the i2c msg data.
>> - Status: the processing result from the backend.
>>
>> People may implement different backend drivers to emulate
>> different controllers according to their needs. A backend
>> example can be found in the device model of the open source
>> project ACRN. For more information, please refer to
>> https://projectacrn.org.
>>
>> The virtio device ID 34 is used for this I2C adpter since IDs
>> before 34 have been reserved by other virtio devices.
> Please reserve the ID with the virtio tc so no one conflicts.
>
Sure. I will send a patch to request the ID.


>
> +
> +/**
> + * struct virtio_i2c_hdr - the virtio I2C message header structure
> + * @addr: i2c_msg addr, the slave address
> + * @flags: i2c_msg flags
> + * @len: i2c_msg len
> + */
> +struct virtio_i2c_hdr {
> +	__virtio16 addr;
> +	__virtio16 flags;
> +	__virtio16 len;
> +} __packed;
> virtio16 is for legacy devices, modern ones should be __le.
> and  we don't really need to pack it I think.

Right. I will fix these. Thanks.




_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
