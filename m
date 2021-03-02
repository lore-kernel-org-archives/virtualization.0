Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB93CC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:28:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259E16148E
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 06:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259E16148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB03583D90;
	Tue,  2 Mar 2021 06:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2VsDWvm8h1iz; Tue,  2 Mar 2021 06:28:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B2AC83D7E;
	Tue,  2 Mar 2021 06:28:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2410EC000B;
	Tue,  2 Mar 2021 06:28:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49810C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 378F343038
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8jni2uY6NuW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:28:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA60543030
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 06:28:17 +0000 (UTC)
IronPort-SDR: gPNHx7pybdd/lolwCFiPa+6BJL47eCr/vR+1QsDqD+5rnRGwe8yfWHoV+q83JDec1CImvUYUnl
 7vNlMTEWtCNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="248111659"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="248111659"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 22:28:16 -0800
IronPort-SDR: 4HEhIRxtLlBjbR5Mq0Pp6v5Wx40ez790z7ZwrTBe9T3G/JC2/2KZSjqbv1hsWgiGI5g7TMbXCP
 Y87wtZlJrYGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444614627"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 22:28:09 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
 <16efea9f-d606-4cf9-9213-3c1cf9b1a906@intel.com>
 <20210302034323.gkqymzngyqofrdsr@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <664d590d-b43f-1829-3ea0-44a4054dfca6@intel.com>
Date: Tue, 2 Mar 2021 14:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210302034323.gkqymzngyqofrdsr@vireshk-i7>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 arnd@arndb.de, mst@redhat.com, shuo.a.liu@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 kblaiech@mellanox.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, rppt@kernel.org
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


On 2021/3/2 11:43, Viresh Kumar wrote:
> On 02-03-21, 10:21, Jie Deng wrote:
>> On 2021/3/1 19:54, Viresh Kumar wrote:
>> That's my original proposal. I used to mirror this interface with "struct
>> i2c_msg".
>>
>> But the design philosophy of virtio TC is that VIRTIO devices are not
>> specific to Linux
>> so the specs design should avoid the limitations of the current Linux driver
>> behavior.
> Right, I understand that.
>
>> We had some discussion about this. You may check these links to learn the
>> story.
>> https://lists.oasis-open.org/archives/virtio-comment/202010/msg00016.html
>> https://lists.oasis-open.org/archives/virtio-comment/202010/msg00033.html
>> https://lists.oasis-open.org/archives/virtio-comment/202011/msg00025.html
> So the thing is that we want to support full duplex mode, right ?
>
> How will that work protocol wise ? I mean how would we know if we are
> expecting both tx and rx buffers in a transfer ?

Not for the full duplex. As Paolo explained in those links.
We defined a combined request called "write-read request"

"
This is when a write is followed by a read: the master
starts off the transmission with a write, then sends a second START,
then continues with a read from the same address.

In theory there's no difference between one multi-segment transaction
and many single-segment transactions _in a single-master scenario_.

However, it is a plausible configuration to have multiple guests sharing
an I2C host device as if they were multiple master.

So the spec should provide a way at least to support for transactions with
1 write and 1 read segment in one request to the same address.

"

 From the perspective of specification design, it hopes to provide more 
choices
while from the perspective of specific implementation, we can choose 
what we need
as long as it does not violate the specification.

Since the current Linux driver doesn't use this mechanism. I'm 
considering to move
the "struct virtio_i2c_req" into the driver and use one "buf" instead.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
