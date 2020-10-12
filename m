Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5699CC433DF
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 03:18:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DD920757
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 03:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DD920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D43886936;
	Mon, 12 Oct 2020 03:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d+vTSPUli65q; Mon, 12 Oct 2020 03:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0264486930;
	Mon, 12 Oct 2020 03:18:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDBAEC07FF;
	Mon, 12 Oct 2020 03:18:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70FF0C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 55AC284C93
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EHQVUNSBrUpw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF9ED84C44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 03:18:43 +0000 (UTC)
IronPort-SDR: qmYpc5JlDKuzkNq9ZCYvQKZR1d27PWrL/rMwyztwZzWHgKmhun6kaiErr/RQ/FIfC2JJHeMY+A
 SaGFbvjOVaYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="227330329"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; d="scan'208";a="227330329"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2020 20:18:42 -0700
IronPort-SDR: wn48UUCHyPIxAShK90rpdGM5jdgvNx/lyisOggpdFq0ZFLb41WfVBNv3nnz9YTrKAyFr9USUj6
 MmAUQUFbr+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; d="scan'208";a="299153675"
Received: from unknown (HELO [10.239.154.47]) ([10.239.154.47])
 by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2020 20:18:39 -0700
Subject: Re: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <1350309657ab0c7b9f97e7a5c71d084f88caa549.1600743079.git.jie.deng@intel.com>
 <20201008140151.GE897@ninjato>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <4b4cd16b-5930-008f-1139-0dae2825f717@intel.com>
Date: Mon, 12 Oct 2020 11:18:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20201008140151.GE897@ninjato>
Content-Language: en-US
Cc: bjorn.andersson@linaro.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
 yu1.wang@intel.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 krzk@kernel.org, virtualization@lists.linux-foundation.org,
 Sergey.Semin@baikalelectronics.ru, jarkko.nikula@linux.intel.com,
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


On 2020/10/8 22:01, Wolfram Sang wrote:
> Hi,
>
> some super high level questions:
>
>> different controllers according to their needs. A backend
>> example can be found in the device model of the open source
>> project ACRN. For more information, please refer to
>> https://projectacrn.org.
> Could you provide a link directly to the backend, please?
Sure. Here is the link.
https://raw.githubusercontent.com/projectacrn/acrn-hypervisor/master/devicemodel/hw/pci/virtio/virtio_i2c.c
>> The device ID request:
>>          https://github.com/oasis-tcs/virtio-spec/issues/85
> Shall we wait for this to be approved? Or will it get only approved once
> the driver here is upstream?
That's what I want to know also.
So hi Michael, what's the upstream flow for this patch ?

Thanks.


>> +	  If you say yes to this option, support will be included for the virtio
>> +	  I2C adapter driver. The hardware can be emulated by any device model
>> +	  software according to the virtio protocol.
> That means stuff like "limiting which devices on a given bus can be
> accessed" will be handled by the backends, or?
>
> What kind of testing has been done with this on which setup?
>
> Thanks and happy hacking,
>
>     Wolfram
Yes, you can configure what devices can be seen by the guest.
This provides a way to flexibly organize and manage I2C slave devices 
from the guest.

We tested it on Intel APL MRB. There are some docs for you reference.
https://projectacrn.github.io/latest/developer-guides/hld/virtio-i2c.html?highlight=i2c

Regards.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
