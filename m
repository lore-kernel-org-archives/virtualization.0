Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:55:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB8361183
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFB8361183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B50AB405EC;
	Wed, 20 Oct 2021 08:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DTWU8H6CCeBG; Wed, 20 Oct 2021 08:55:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB9EF40605;
	Wed, 20 Oct 2021 08:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3772C0011;
	Wed, 20 Oct 2021 08:55:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72A6EC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51EDD405EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NOd_X9F0MITQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 385B0405E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:55:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="208832768"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; d="scan'208";a="208832768"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 01:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; d="scan'208";a="483636775"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.68])
 ([10.239.154.68])
 by orsmga007.jf.intel.com with ESMTP; 20 Oct 2021 01:54:57 -0700
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
 <20211019082211.ngkkkxlfcrsvfaxg@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <81ea2661-20f8-8836-5311-7f2ed4a1781f@intel.com>
Date: Wed, 20 Oct 2021 16:54:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019082211.ngkkkxlfcrsvfaxg@vireshk-i7>
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


On 2021/10/19 16:22, Viresh Kumar wrote:
> On 19-10-21, 09:46, Vincent Whitchurch wrote:
>>   static void virtio_i2c_msg_done(struct virtqueue *vq)
>>   {
>> -	struct virtio_i2c *vi = vq->vdev->priv;
>> +	struct virtio_i2c_req *req;
>> +	unsigned int len;
>>   
>> -	complete(&vi->completion);
>> +	while ((req = virtqueue_get_buf(vq, &len)))
>> +		complete(&req->completion);
> Instead of adding a completion for each request and using only the
> last one, maybe we can do this instead here:
>
> 	while ((req = virtqueue_get_buf(vq, &len))) {
>                  if (req->out_hdr.flags == cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT))


Is this for the last one check ? For the last one, this bit should be 
cleared, right ?


>                          complete(&vi->completion);
>          }
>
> Since we already know which is the last one, we can also check at this
> point if buffers for all other requests are received or not.
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
