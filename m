Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A2C56201
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 02:00:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4915520674
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 02:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4915520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 676A22E137;
	Thu, 26 Nov 2020 02:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsa8M0X-0T5j; Thu, 26 Nov 2020 02:00:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 76AF62284F;
	Thu, 26 Nov 2020 02:00:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F986C163C;
	Thu, 26 Nov 2020 02:00:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08DD8C0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 02:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DEBA587115
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 02:00:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVZYkl-V3KZA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 02:00:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 08BC586FB6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 02:00:24 +0000 (UTC)
IronPort-SDR: scgsU7OdgK3qSh+g2C/mwyDuAAwHdykeZ1fhkiPJU7UhBFhrpny+kMdpurpxGIs5diFurzYwdW
 Mu55M1ae5gHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="233831086"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; d="scan'208";a="233831086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:00:23 -0800
IronPort-SDR: 913kfw8Ec+NcvFxFD6m4Gu+rguSGuI/s3mXDR8Y+FHviKD1VfSUOTp2Swp1GI+aSrMDp9DlIXS
 tviKmatTO/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; d="scan'208";a="359379959"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.51])
 ([10.239.154.51])
 by orsmga008.jf.intel.com with ESMTP; 25 Nov 2020 18:00:18 -0800
Subject: Re: [PATCH v4] i2c: virtio: add a virtio i2c frontend driver
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <7c5e44c534b3fd07b855af22d8d4b78bc44cd7a4.1602465440.git.jie.deng@intel.com>
 <20201125043422-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <6cbea83e-04fa-8d5a-bba7-d80afabe8a5d@intel.com>
Date: Thu, 26 Nov 2020 10:00:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201125043422-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 linux-kernel@vger.kernel.org, krzk@kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, rppt@kernel.org, shuo.a.liu@intel.com,
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

On 2020/11/25 17:35, Michael S. Tsirkin wrote:

> On Mon, Oct 12, 2020 at 09:55:55AM +0800, Jie Deng wrote:
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
>>
>> The virtio device ID 34 is used for this I2C adpter since IDs
>> before 34 have been reserved by other virtio devices.
>>
>> Co-developed-by: Conghui Chen <conghui.chen@intel.com>
>> Signed-off-by: Conghui Chen <conghui.chen@intel.com>
>> Signed-off-by: Jie Deng <jie.deng@intel.com>
>> Reviewed-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> I assume this will be updated once the specification is acked
> by the virtio tc. Holding off on this one for now since
> we know there will be host/guest ABI changes.

Yeah. I will update this driver once the specification is acked by the 
virtio tc.

Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
