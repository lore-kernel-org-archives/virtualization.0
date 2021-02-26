Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FDDC433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 02:46:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BAD64E60
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 02:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BAD64E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3302D4EF93;
	Fri, 26 Feb 2021 02:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JeRqTlcmryUR; Fri, 26 Feb 2021 02:46:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 708934EF7D;
	Fri, 26 Feb 2021 02:46:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32D1AC000A;
	Fri, 26 Feb 2021 02:46:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 770A1C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 02:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C2514EF8C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 02:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvgHcvGzW_-x
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 02:46:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 225A94EF7D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 02:46:10 +0000 (UTC)
IronPort-SDR: aTa3njHizKSEMyuGpQK4yz5PCqk+W8GNijs/liKCdlur0E3SnqpCtcysI//L131kS6ctmE16T4
 tqAENc6PnnCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="270727211"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; d="scan'208";a="270727211"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2021 18:46:09 -0800
IronPort-SDR: w314YCxjSH0H8ZlyfaKP5R8op3fGNv6mqVTzXc/AYy9Uw5jSvYiWZXzg+of4kSdh9M3WdQXHFS
 U+iy9egrEs1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; d="scan'208";a="381839855"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga002.jf.intel.com with ESMTP; 25 Feb 2021 18:46:04 -0800
Subject: Re: [PATCH v4] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <7c5e44c534b3fd07b855af22d8d4b78bc44cd7a4.1602465440.git.jie.deng@intel.com>
 <20210225072114.iwmtaexl3dkihlba@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <a580de35-787e-4024-3c80-0a101b1a6d3b@intel.com>
Date: Fri, 26 Feb 2021 10:46:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225072114.iwmtaexl3dkihlba@vireshk-i7>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 mst@redhat.com, linux-kernel@vger.kernel.org, krzk@kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, rppt@kernel.org, shuo.a.liu@intel.com,
 Vincent Guittot <vincent.guittot@linaro.org>,
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


On 2021/2/25 15:21, Viresh Kumar wrote:
> On 12-10-20, 09:55, Jie Deng wrote:
>> Add an I2C bus driver for virtio para-virtualization.
>>
>> The controller can be emulated by the backend driver in
>> any device model software by following the virtio protocol.
>>
>> This driver communicates with the backend driver through a
>> virtio I2C message structure which includes following parts:
>>
>> - Header: i2c_msg addr, flags, len.
>> - Data buffer: the pointer to the I2C msg data.
>> - Status: the processing result from the backend.
>>
>> People may implement different backend drivers to emulate
>> different controllers according to their needs. A backend
>> example can be found in the device model of the open source
>> project ACRN. For more information, please refer to
>> https://projectacrn.org.
>> diff --git a/include/uapi/linux/virtio_i2c.h b/include/uapi/linux/virtio_i2c.h
>> new file mode 100644
>> index 0000000..7413e45
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_i2c.h
>> @@ -0,0 +1,31 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
>> +/*
>> + * Definitions for virtio I2C Adpter
>> + *
>> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
>> + */
>> +
>> +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
>> +#define _UAPI_LINUX_VIRTIO_I2C_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/virtio_ids.h>
>> +#include <linux/virtio_config.h>
>> +
>> +/**
>> + * struct virtio_i2c_hdr - the virtio I2C message header structure
>> + * @addr: i2c_msg addr, the slave address
>> + * @flags: i2c_msg flags
>> + * @len: i2c_msg len
>> + */
>> +struct virtio_i2c_hdr {
>> +	__le16 addr;
>> +	__le16 flags;
>> +	__le16 len;
>> +};
> Hi Jie,
>
> I am a bit confused about the header and the format in which data is being
> processed here. When I look at the specification present here:
>
> https://lists.oasis-open.org/archives/virtio-comment/202009/msg00021.html
>
> it talks about
>
> struct virtio_i2c_out_hdr {
>          le16 addr;
>          le16 padding;
>          le32 flags;
> };
> struct virtio_i2c_in_hdr {
>          u8 status;
> };
>
> struct virtio_i2c_req {
>          struct virtio_i2c_out_hdr out_hdr;
>          u8 write_buf [];
>          u8 read_buf [];
>          struct virtio_i2c_in_hdr in_hdr;
> };
>
> while what we have above is completely different. What am I missing ?

This v4 was the old version before the specification was acked by the 
virtio tc.

Following is the latest specification.

https://raw.githubusercontent.com/oasis-tcs/virtio-spec/master/virtio-i2c.tex

I will send the v5 since the host/guest ABI changes.

Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
