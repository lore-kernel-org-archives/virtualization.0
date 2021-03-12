Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC54C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 08:38:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696A764FC3
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 08:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696A764FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 31FF643039;
	Fri, 12 Mar 2021 08:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xa7xt2aHqo5B; Fri, 12 Mar 2021 08:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC85E40025;
	Fri, 12 Mar 2021 08:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0778C000B;
	Fri, 12 Mar 2021 08:38:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B3AEC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 237E46F972
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FlkufFLJkCnz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:38:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BB236F593
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:38:04 +0000 (UTC)
IronPort-SDR: zMHl7Zbb1E7YjLZFqN6wul5JUat/gFdE2AOp4obXHuDrD6S+AH0RYGfbSIatOJJ6PxfwttX6FZ
 FsauHzJcI9+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="176395569"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; d="scan'208";a="176395569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 00:38:02 -0800
IronPort-SDR: 8c9+J2Da86cjcBUqFbvTy/6CkYSZWSBvXbUTgVkMsNsB6EFOhL5iXaiJuVOjmndPwWr3p+TQc7
 3GQB1cWtWIcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; d="scan'208";a="377644496"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga007.fm.intel.com with ESMTP; 12 Mar 2021 00:37:57 -0800
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
 <20210312061012.slmfnhxe6y5kgrnv@vireshk-i7>
 <a97c64ea-773a-133b-c37c-cd02493e0230@intel.com>
 <20210312081108.fvqrvb75byurt3lo@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <d35e385e-3f5f-49b7-1593-3ed203853dbf@intel.com>
Date: Fri, 12 Mar 2021 16:37:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210312081108.fvqrvb75byurt3lo@vireshk-i7>
Content-Language: en-US
Cc: mst@redhat.com, bjorn.andersson@linaro.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, wsa@kernel.org,
 andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 virtualization@lists.linux-foundation.org, arnd@arndb.de, stefanha@redhat.com,
 tali.perry1@gmail.com, conghui.chen@intel.com, loic.poulain@linaro.org,
 linux-kernel@vger.kernel.org, Sergey.Semin@baikalelectronics.ru,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com, pbonzini@redhat.com,
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


On 2021/3/12 16:11, Viresh Kumar wrote:
> On 12-03-21, 15:51, Jie Deng wrote:
>> On 2021/3/12 14:10, Viresh Kumar wrote:
>>> I saw your email about wrong version being sent, I already wrote some
>>> reviews. Sending them anyway for FWIW :)
>>>
>>> On 12-03-21, 21:33, Jie Deng wrote:
>>>> +struct virtio_i2c {
>>>> +	struct virtio_device *vdev;
>>>> +	struct completion completion;
>>>> +	struct i2c_adapter adap;
>>>> +	struct mutex lock;
>>> As I said in the previous version (Yes, we were both waiting for
>>> Wolfram to answer that), this lock shouldn't be required at all.
>>>
>>> And since none of us have a use-case at hand where we will have a
>>> problem without this lock, we should really skip it. We can always
>>> come back and add it if we find an issue somewhere. Until then, better
>>> to keep it simple.
>> The problem is you can't guarantee that adap->algo->master_xfer
>> is only called from i2c_transfer. Any function who holds the adapter can
>> call
>> adap->algo->master_xfer directly.
> See my last reply here, (almost) no one in the mainline kernel call it
> directly. And perhaps you can consider the caller broken in that case
> and so there is no need of an extra lock, unless you have a case that
> is broken.
>
> https://lore.kernel.org/lkml/20210305072903.wtw645rukmqr5hx5@vireshk-i7/
>
>> I prefer to avoid potential issues rather
>> than
>> find a issue then fix.
> This is a very hypothetical issue IMHO as the kernel code doesn't have
> such a user. There is no need of locks here, else the i2c core won't
> have handled it by itself.

I'd like to see Wolfram's opinion.
Is it safe to remove lock in adap->algo->master_xfer ?


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
