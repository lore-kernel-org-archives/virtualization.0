Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC4DC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 06:42:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933546191A
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 06:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933546191A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10FF54065D;
	Wed, 24 Mar 2021 06:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VlY-MXhjxzDs; Wed, 24 Mar 2021 06:42:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B6B94064F;
	Wed, 24 Mar 2021 06:42:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FD45C000D;
	Wed, 24 Mar 2021 06:42:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58FBEC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3270A60AA4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YKRg3aCyGgB7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:42:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EDE860A5F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:42:01 +0000 (UTC)
IronPort-SDR: vH7RbvsxSKoOu1UNDQr/tdpCei50TPeT9j4OcRP1C5uJT6jhTkud7H/5AIEvds2PGkZJfeyHRw
 P2cd7wJprHeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="190738530"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; d="scan'208";a="190738530"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2021 23:42:00 -0700
IronPort-SDR: NT4+/DdOkxENlHgafw08wJsSqZLkPMNVtiS/Ygvbz2H1aAze1hTodXHcbVXPrXYZhmCDBgl4d3
 WIBkKVMSHv7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; d="scan'208";a="442079888"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2021 23:41:55 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210324042046.idkctj2t7cxi53jf@vireshk-i7>
 <70908366-c270-848e-0be3-c85fec7958ec@intel.com>
 <20210324060907.nwilmghg2xcdz7nv@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <84f0bf1b-9b69-6fc0-011c-2aafde208435@intel.com>
Date: Wed, 24 Mar 2021 14:41:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324060907.nwilmghg2xcdz7nv@vireshk-i7>
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


On 2021/3/24 14:09, Viresh Kumar wrote:
> On 24-03-21, 14:05, Jie Deng wrote:
> Or, now that I think about it a bit more, another thing we can do here is see if
> virtqueue_get_buf() returns NULL, if it does then we should keep expecting more
> messages as it may be early interrupt. What do you say ?

I don't think we really need this because for this device, early 
interrupt is a bad operation
which should be avoided. I can't think of why this device need to send 
early interrupt, what
we can do is to clarify that this means loss of the remaining requests. 
A device should never
do this, if it does then loss is the expected result.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
