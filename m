Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0E5C4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 01:29:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2F761029
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 01:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D2F761029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BEDE80C8F;
	Wed, 18 Aug 2021 01:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibYLbCOfNAVZ; Wed, 18 Aug 2021 01:29:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A38B780B78;
	Wed, 18 Aug 2021 01:29:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75909C0010;
	Wed, 18 Aug 2021 01:29:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B729C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 01:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 580E9606FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 01:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzRHaH3ByheH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 01:29:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C066760674
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 01:29:42 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="213110878"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="213110878"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 18:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="531300286"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2021 18:29:38 -0700
Subject: Re: [PATCH v15] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com, arnd@arndb.de, jasowang@redhat.com,
 andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
 conghui.chen@intel.com, viresh.kumar@linaro.org, stefanha@redhat.com,
 gregkh@linuxfoundation.org, vincent.guittot@linaro.org,
 alex.bennee@linaro.org, jiedeng@alumni.sjtu.edu.cn
References: <bcf2fb9bbe965862213f27e05f87ffc91283c0c5.1627018061.git.jie.deng@intel.com>
 <YRwagcZ8SUCsncEA@kunai>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b15f5586-4ffa-e794-aca3-5125dc7378bf@intel.com>
Date: Wed, 18 Aug 2021 09:29:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRwagcZ8SUCsncEA@kunai>
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


On 2021/8/18 4:22, Wolfram Sang wrote:
>
>   Michael S. Tsirkin <mst@redhat.com>
> Okay, with rc6 being released, I won't wait for an immutable branch
> anymore. I applied this now and we will see if there will be a merge
> conflict. If so, it will be trivial to handle, I'd think. So:
>
> Applied to for-next, thanks!


Thanks Wolfram!


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
