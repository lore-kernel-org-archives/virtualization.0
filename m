Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD5DC28CFA
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 05:07:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2244B6186A
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 05:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2244B6186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9F0E4EC23;
	Tue,  2 Mar 2021 05:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QV2UAJlSxHBA; Tue,  2 Mar 2021 05:07:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 369C649BF4;
	Tue,  2 Mar 2021 05:07:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 178C0C000B;
	Tue,  2 Mar 2021 05:07:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60267C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AABC83CD7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmJbjYwlisUS
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3C4B83C6C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:06:58 +0000 (UTC)
IronPort-SDR: Y/foEs0PytdjKQNQ5ND4a9MgHiPAzHHE6zyUEnTy2JaVT81ivmWUWE4mUepxZ8MHugqkkYxr+R
 x6mog1Qe8OFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="206317485"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="206317485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 21:06:58 -0800
IronPort-SDR: wC2bDyBmi0EgPUh2mckEVJcTi1BVjhN/kpCXBscfpu7q505k7SZLIfh0tJa+QWXTl/V4r+wymJ
 DqZBizKNO+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444591095"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 21:06:50 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
 <20210302040114.rg6bb32g2bsivsgf@vireshk-i7>
 <20210302042233.7ppagwjk3rah3uh3@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <5e66fc1b-81d3-341e-4864-adb021e9ce1e@intel.com>
Date: Tue, 2 Mar 2021 13:06:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210302042233.7ppagwjk3rah3uh3@vireshk-i7>
Content-Language: en-US
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com,
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


On 2021/3/2 12:22, Viresh Kumar wrote:
> On 02-03-21, 09:31, Viresh Kumar wrote:
>> On 01-03-21, 16:19, Arnd Bergmann wrote:
>>> On Mon, Mar 1, 2021 at 7:41 AM Jie Deng <jie.deng@intel.com> wrote:
>>>
>>>> --- /dev/null
>>>> +++ b/include/uapi/linux/virtio_i2c.h
>>>> @@ -0,0 +1,56 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
>>>> +/*
>>>> + * Definitions for virtio I2C Adpter
>>>> + *
>>>> + * Copyright (c) 2021 Intel Corporation. All rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
>>>> +#define _UAPI_LINUX_VIRTIO_I2C_H
>>> Why is this a uapi header? Can't this all be moved into the driver
>>> itself?
>>>
>>>> +/**
>>>> + * struct virtio_i2c_req - the virtio I2C request structure
>>>> + * @out_hdr: the OUT header of the virtio I2C message
>>>> + * @write_buf: contains one I2C segment being written to the device
>>>> + * @read_buf: contains one I2C segment being read from the device
>>>> + * @in_hdr: the IN header of the virtio I2C message
>>>> + */
>>>> +struct virtio_i2c_req {
>>>> +       struct virtio_i2c_out_hdr out_hdr;
>>>> +       u8 *write_buf;
>>>> +       u8 *read_buf;
>>>> +       struct virtio_i2c_in_hdr in_hdr;
>>>> +};
>>> In particular, this structure looks like it is only ever usable between
>>> the transfer functions in the driver itself, it is shared with neither
>>> user space nor the virtio host side.
>> Why is it so ? Won't you expect hypervisors or userspace apps to use
>> these ?
> This comment applies only for the first two structures as the third
> one is never exchanged over virtio.
Yeah. Actually, the backend only needs "struct virtio_i2c_out_hdr out_hdr"
and "struct virtio_i2c_in_hdr in_hdr" for communication. So we only need 
to keep
the first two in uapi and move "struct virtio_i2c_req" into the driver.

But Jason wanted to include "struct virtio_i2c_req" in uapi. He 
explained in this link
https://lists.linuxfoundation.org/pipermail/virtualization/2020-October/050222.html.
Do you agree with that explanation ?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
