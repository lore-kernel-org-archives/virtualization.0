Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4A7C11F69
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 06:52:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5AF61413
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 06:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5AF61413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E0F4065B;
	Fri,  2 Jul 2021 06:52:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHMO3TCvlpg2; Fri,  2 Jul 2021 06:52:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 488E8405D0;
	Fri,  2 Jul 2021 06:52:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25251C0010;
	Fri,  2 Jul 2021 06:52:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF9B6C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97993405EF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KyfzefaQhVxq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:52:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB508405D0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:52:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="269811345"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; d="scan'208";a="269811345"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2021 23:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; d="scan'208";a="482188013"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Jul 2021 23:52:12 -0700
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, arnd@arndb.de,
 jasowang@redhat.com, andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
 shuo.a.liu@intel.com, conghui.chen@intel.com, stefanha@redhat.com
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7> <YN4WeJCepCrpylOD@kunai>
 <20210702045512.u4dvbapoc5a2a4jb@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <409b6cc3-3339-61b2-7f42-0c69b6486bb3@intel.com>
Date: Fri, 2 Jul 2021 14:52:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210702045512.u4dvbapoc5a2a4jb@vireshk-i7>
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


On 2021/7/2 12:55, Viresh Kumar wrote:
> On 01-07-21, 21:24, Wolfram Sang wrote:
>>> I just noticed this now, but this function even tries to send data
>>> partially, which isn't right. If the caller (i2c device's driver)
>>> calls this for 5 struct i2c_msg instances, then all 5 need to get
>>> through or none.. where as we try to send as many as possible here.
>>>
>>> This looks broken to me. Rather return an error value here on success,
>>> or make it complete failure.
>>>
>>> Though to be fair I see i2c-core also returns number of messages
>>> processed from i2c_transfer().
>>>
>>> Wolfram, what's expected here ? Shouldn't all message transfer or
>>> none?
>> Well, on a physical bus, it can simply happen that after message 3 of 5,
>> the bus is stalled, so we need to bail out.
> Right, and in that case the transfer will have any meaning left? I believe it
> needs to be fully retried as the requests may have been dependent on each other.
>
>> Again, I am missing details of a virtqueue, but I'd think it is
>> different. If adding to the queue fails, then it probably make sense to
>> drop the whole transfer.
> Exactly my point.
>

This is not efficient. If adding the ith request to the queue fails, we 
can still send

the requests before it. We don't need to know if it fails here (adding 
to the queue)

or there (later in the host). The "master_xfer" just need to return 
final number of

messages successfully processed.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
