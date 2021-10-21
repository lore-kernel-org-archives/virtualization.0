Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F96FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 05:55:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888A4611CC
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 05:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 888A4611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 464C940628;
	Thu, 21 Oct 2021 05:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWK_ODV8PRle; Thu, 21 Oct 2021 05:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3DFF40538;
	Thu, 21 Oct 2021 05:55:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C33CCC000F;
	Thu, 21 Oct 2021 05:55:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 600AAC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C9884053B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hRS9xkj5Ppsu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFB1240538
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 05:55:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="315156184"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; d="scan'208";a="315156184"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 22:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; d="scan'208";a="444654055"
Received: from unknown (HELO [10.239.154.68]) ([10.239.154.68])
 by orsmga006.jf.intel.com with ESMTP; 20 Oct 2021 22:55:31 -0700
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, wsa@kernel.org,
 viresh.kumar@linaro.org
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <a6cb9ae7-eee3-74aa-87de-a2be3fdc7a76@intel.com>
Date: Thu, 21 Oct 2021 13:55:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019074647.19061-3-vincent.whitchurch@axis.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, kernel@axis.com, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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


On 2021/10/19 15:46, Vincent Whitchurch wrote:
> The driver currently assumes that the notify callback is only received
> when the device is done with all the queued buffers.
>
> However, this is not true, since the notify callback could be called
> without any of the queued buffers being completed (for example, with
> virtio-pci and shared interrupts) or with only some of the buffers being
> completed (since the driver makes them available to the device in
> multiple separate virtqueue_add_sgs() calls).


Can the backend driver control the time point of interrupt injection ? I 
can't think of

why the backend has to send an early interrupt. This operation should be 
avoided

in the backend driver if possible. However, this change make sense if 
early interrupt

can't be avoid.


>
> This can lead to incorrect data on the I2C bus or memory corruption in
> the guest if the device operates on buffers which are have been freed by
> the driver.  (The WARN_ON in the driver is also triggered.)
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
