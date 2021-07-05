Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1DEC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:22:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74B461375
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74B461375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7847440176;
	Mon,  5 Jul 2021 06:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKC-eaZemLlT; Mon,  5 Jul 2021 06:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B37940168;
	Mon,  5 Jul 2021 06:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B31ECC0010;
	Mon,  5 Jul 2021 06:22:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED237C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BEFAB83A4B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yE6ze2PNDbLi
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:21:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 844B1839DB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:21:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="208885406"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="208885406"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2021 23:21:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="562409078"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2021 23:21:53 -0700
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
 <20210705024340.mb5sv5epxbdatgsg@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <adb5a18f-cf48-3059-5541-fb6d7bafb8d2@intel.com>
Date: Mon, 5 Jul 2021 14:21:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210705024340.mb5sv5epxbdatgsg@vireshk-i7>
Content-Language: en-US
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, conghui.chen@intel.com
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


On 2021/7/5 10:43, Viresh Kumar wrote:
> On 02-07-21, 12:58, Andy Shevchenko wrote:
>> On Fri, Jul 02, 2021 at 04:46:47PM +0800, Jie Deng wrote:
>>> +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>>> +				    struct virtio_i2c_req *reqs,
>>> +				    struct i2c_msg *msgs, int nr,
>>> +				    bool fail)
>>> +{
>>> +	struct virtio_i2c_req *req;
>>> +	bool failed = fail;
> Jie, you can actually get rid of this variable too. Jut rename fail to failed
> and everything shall work as you want.


Oh, You are not right. I just found we can't remove this variable. The 
"fail" and "failed" have different

meanings for this function. We need fail to return the result.


>>> +	unsigned int len;
>>> +	int i, j = 0;
>>> +
>>> +	for (i = 0; i < nr; i++) {
>>> +		/* Detach the ith request from the vq */
>>> +		req = virtqueue_get_buf(vq, &len);
>>> +
>>> +		/*
>>> +		 * Condition (req && req == &reqs[i]) should always meet since
>>> +		 * we have total nr requests in the vq.
>>> +		 */
>>> +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
>>> +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
>>> +			failed = true;
>> ...and after failed is true, we are continuing the loop, why?
> Actually this function can be called with fail set to true. We proceed as we
> need to call i2c_put_dma_safe_msg_buf() for all buffers we allocated earlier.
>
>>> +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
>>> +		if (!failed)
>>> +			++j;
>> Besides better to read j++ the j itself can be renamed to something more
>> verbose.
>>
>>> +	}
>>> +	return (fail ? -ETIMEDOUT : j);
>> Redundant parentheses.
>>
>>> +}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
