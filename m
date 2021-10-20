Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59542C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 03:38:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5C860F9D
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 03:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF5C860F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92F87403B5;
	Wed, 20 Oct 2021 03:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y5YGsJ72twz8; Wed, 20 Oct 2021 03:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0ECCC40018;
	Wed, 20 Oct 2021 03:38:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8053C0011;
	Wed, 20 Oct 2021 03:38:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 014E2C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 03:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E444660820
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 03:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B43vTwQtgZYn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 03:38:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDC71607CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 03:38:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="226145044"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; d="scan'208";a="226145044"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2021 20:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; d="scan'208";a="483547120"
Received: from unknown (HELO [10.239.154.68]) ([10.239.154.68])
 by orsmga007.jf.intel.com with ESMTP; 19 Oct 2021 20:36:31 -0700
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, gregkh@linuxfoundation.org
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <d16fed64-6aa9-8c68-91e0-06fc84c3049c@intel.com>
Date: Wed, 20 Oct 2021 11:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
Content-Language: en-US
Cc: wsa@kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org
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


On 2021/10/19 16:09, Viresh Kumar wrote:
> Doing this may not be a good thing based on the kernel rules I have
> understood until now. Maybe Greg and Wolfram can clarify on this.
>
> We are waiting here for an external entity (Host kernel) or a firmware
> that uses virtio for transport. If the other side is hacked, it can
> make the kernel hang here for ever. I thought that is something that
> the kernel should never do.


I'm also worried about this. We may be able to solve it by setting a big

timeout value in the driver.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
