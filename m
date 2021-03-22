Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C138C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 08:28:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0BA60232
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 08:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0BA60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3125040384;
	Mon, 22 Mar 2021 08:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O_BYmjV2_T0j; Mon, 22 Mar 2021 08:28:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B9D440375;
	Mon, 22 Mar 2021 08:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70360C000A;
	Mon, 22 Mar 2021 08:28:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D68AEC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B049E82FCE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FwXZuahAXOsd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:28:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79A3882FC9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:28:38 +0000 (UTC)
IronPort-SDR: Z8WDYpGqvE7ngIfFZTgoq3bozsVbYrOtwj9nge7whxecpMSr0LmIdkP5tZLNjoZDWwtilzLOya
 RlywGAC0KpKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="177357520"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; d="scan'208";a="177357520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 01:28:37 -0700
IronPort-SDR: B4r06u5gEarLdb3pVnUy1PVeMTpmrYqd8XYUNiKF5/HB8KAV+XHWfMu96lCnaN4TZykDLrFMaW
 rGBQ89h+itBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; d="scan'208";a="414390082"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga008.jf.intel.com with ESMTP; 22 Mar 2021 01:28:32 -0700
Subject: Re: [PATCH v9] i2c: virtio: add a virtio i2c frontend driver
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <e09c07532f5456816eb91ef4176bf910284df4ff.1616418890.git.jie.deng@intel.com>
 <20210322041857-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <5f4aec88-3131-ca20-e28e-383642c9a2ad@intel.com>
Date: Mon, 22 Mar 2021 16:28:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210322041857-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: viresh.kumar@linaro.org, bjorn.andersson@linaro.org,
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


On 2021/3/22 16:19, Michael S. Tsirkin wrote:
> On Mon, Mar 22, 2021 at 09:35:59PM +0800, Jie Deng wrote:
>> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
>> index bc1c062..6ae32db 100644
>> --- a/include/uapi/linux/virtio_ids.h
>> +++ b/include/uapi/linux/virtio_ids.h
>> @@ -54,5 +54,6 @@
>>   #define VIRTIO_ID_FS			26 /* virtio filesystem */
>>   #define VIRTIO_ID_PMEM			27 /* virtio pmem */
>>   #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
>> +#define VIRTIO_ID_I2C_ADPTER		34 /* virtio i2c adpter */
> ADPTER -> ADAPTER?
> adpter -> adapter?


Good catch. Thanks Michael.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
