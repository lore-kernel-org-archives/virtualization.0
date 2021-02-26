Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB5C433E0
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 06:36:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6E1601FA
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 06:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6E1601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01AD24335E;
	Fri, 26 Feb 2021 06:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FDo0SEJvVIYx; Fri, 26 Feb 2021 06:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BA3743226;
	Fri, 26 Feb 2021 06:36:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7D8C000A;
	Fri, 26 Feb 2021 06:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD34C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 06:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D37C4EF09
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 06:36:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZsSK-FgV6Jiy
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 06:36:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 083CE4EF5F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 06:36:12 +0000 (UTC)
IronPort-SDR: ABJe70SHdusj76sd5i0hSSwrnP74N1dwlYZ6N2AylO2ffTecRluoI7oY3YN1C7f2S1MxIzFsRq
 8wqGWe8zeqWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="182370213"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; d="scan'208";a="182370213"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2021 22:36:11 -0800
IronPort-SDR: is0K+Bt0lWf4cURRIiLxV4oQ1h0TAMqjZtGGjmWNxreUFwznHD84BCaiHBptzO8JxynKfFixrf
 X1Wa934K+VBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; d="scan'208";a="381896236"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga002.jf.intel.com with ESMTP; 25 Feb 2021 22:36:05 -0800
Subject: Re: [PATCH v4] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <7c5e44c534b3fd07b855af22d8d4b78bc44cd7a4.1602465440.git.jie.deng@intel.com>
 <20210225072114.iwmtaexl3dkihlba@vireshk-i7>
 <a580de35-787e-4024-3c80-0a101b1a6d3b@intel.com>
 <20210226042126.rix5gjxqrazb6sao@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <96f88e54-ebc7-bfda-310c-ca75b3e09398@intel.com>
Date: Fri, 26 Feb 2021 14:36:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226042126.rix5gjxqrazb6sao@vireshk-i7>
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


On 2021/2/26 12:21, Viresh Kumar wrote:
> On 26-02-21, 10:46, Jie Deng wrote:
>> This v4 was the old version before the specification was acked by the virtio
>> tc.
>>
>> Following is the latest specification.
>>
>> https://raw.githubusercontent.com/oasis-tcs/virtio-spec/master/virtio-i2c.tex
>>
>> I will send the v5 since the host/guest ABI changes.
> Okay, now it makes some sense :)
>
> I am interested in this stuff, if possible please keep me Cc'd for following
> versions, thanks.
Sure. I will add you to the Cc list.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
