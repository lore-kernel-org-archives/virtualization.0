Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4661FC433F5
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 06:51:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E8D60FF2
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 06:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9E8D60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A758483981;
	Fri, 22 Oct 2021 06:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xut2xVGmZd6h; Fri, 22 Oct 2021 06:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A46583935;
	Fri, 22 Oct 2021 06:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8DAC001F;
	Fri, 22 Oct 2021 06:51:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 858F3C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F48F606D9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lrRRCxrDNZWV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29B31606C5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 06:51:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="226694192"
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; d="scan'208";a="226694192"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2021 23:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; d="scan'208";a="495543192"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.68])
 ([10.239.154.68])
 by orsmga008.jf.intel.com with ESMTP; 21 Oct 2021 23:51:10 -0700
Subject: Re: [PATCH] i2c: virtio: Add support for zero-length requests
To: Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <0adf1c36-a00b-f16f-e631-439148c4f956@intel.com>
Date: Fri, 22 Oct 2021 14:51:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
Content-Language: en-US
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, conghui.chen@intel.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-i2c@vger.kernel.org,
 stratos-dev@op-lists.linaro.org
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


On 2021/10/21 17:47, Viresh Kumar wrote:
> The virtio specification received a new mandatory feature
> (VIRTIO_I2C_F_ZERO_LENGTH_REQUEST) for zero length requests. Fail if the
> feature isn't offered by the device.
>
> For each read-request, set the VIRTIO_I2C_FLAGS_M_RD flag, as required
> by the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
>
> This allows us to support zero length requests, like SMBUS Quick, where
> the buffer need not be sent anymore.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Wolfram,
>
> Please do not apply this until the spec changes [1] are merged, sending it early
> to get review done. I will ping you later once the spec is merged.
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202110/msg00109.html
>
>   drivers/i2c/busses/i2c-virtio.c | 56 ++++++++++++++++++---------------
>   include/uapi/linux/virtio_i2c.h |  6 ++++
>   2 files changed, 36 insertions(+), 26 deletions(-)
>

Acked-by: Jie Deng<jie.deng@intel.com>  once the spec is merged.


>   
> +	if (!virtio_has_feature(vdev, VIRTIO_I2C_F_ZERO_LENGTH_REQUEST)) {
> +		dev_err(&vdev->dev, "Zero-length request feature is mandatory\n");
> +		return -EINVAL;


It might be better to return -EOPNOTSUPP ?


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
