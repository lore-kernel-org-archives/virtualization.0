Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B273EC4332F
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 04:20:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A5A611C6
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 04:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55A5A611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1237F403B5;
	Wed, 20 Oct 2021 04:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bb4Y_uv1djNh; Wed, 20 Oct 2021 04:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7574C4013A;
	Wed, 20 Oct 2021 04:20:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D5E0C000F;
	Wed, 20 Oct 2021 04:20:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6633C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 04:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8147240658
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 04:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8o4CbkY-s9Fr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 04:20:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5CD140656
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 04:20:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="226149950"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; d="scan'208";a="226149950"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2021 21:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; d="scan'208";a="483560724"
Received: from unknown (HELO [10.239.154.68]) ([10.239.154.68])
 by orsmga007.jf.intel.com with ESMTP; 19 Oct 2021 21:20:13 -0700
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
To: Wolfram Sang <wsa@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 virtualization@lists.linux-foundation.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7> <YW6Rj/T6dWfMf7lU@kroah.com>
 <20211019094203.3kjzch7ipbdv7peg@vireshk-i7> <YW6pHkXOPvtidtwS@kroah.com>
 <20211019143748.wrpqopj2hmpvblh4@vireshk-i7> <YW8LFTcBuN1bB3PD@ninjato>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <94aa39ab-4ed6-daee-0402-f58bfed0cadd@intel.com>
Date: Wed, 20 Oct 2021 12:20:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YW8LFTcBuN1bB3PD@ninjato>
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


On 2021/10/20 2:14, Wolfram Sang wrote:
>> I think it is set to HZ currently, though I haven't tried big
>> transfers but I still get into some issues with Qemu based stuff.
>> Maybe we can bump it up to few seconds :)
> If you use adapter->timeout, this can even be set at runtime using a
> ioctl. So, it can adapt to use cases. Of course, the driver should
> initialize it to a sane default if the automatic default (HZ) is not
> suitable.


I think a big value may solve most cases. but the driver never know how 
big is enough by static configuration.

Can we make this value to be configurable, just let the other side 
provide this value ?





_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
