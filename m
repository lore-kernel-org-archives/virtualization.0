Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E7AC07E95
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:45:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2C06135E
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2C06135E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 296AE403D2;
	Mon,  5 Jul 2021 03:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMsBNDt4BJ_O; Mon,  5 Jul 2021 03:45:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 54A0A4034C;
	Mon,  5 Jul 2021 03:45:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26094C001A;
	Mon,  5 Jul 2021 03:45:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3AF9C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85ACE837EC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:45:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3-3F5je8UDD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:45:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38E3883518
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:45:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="188600266"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="188600266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2021 20:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="562383925"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2021 20:45:40 -0700
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <20210705024056.ndth2bwn2itii5g3@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <332af2be-0fb0-a846-8092-49d496fe8b6b@intel.com>
Date: Mon, 5 Jul 2021 11:45:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210705024056.ndth2bwn2itii5g3@vireshk-i7>
Content-Language: en-US
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com
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


On 2021/7/5 10:40, Viresh Kumar wrote:
> I think we missed the first deadline for 5.14-rc1 as Wolfram should be out of
> office now. Anyway lets make sure we fix all the pending bits before he is back
> and see if we can still pull it off by rc2.
>
> On 02-07-21, 16:46, Jie Deng wrote:
>> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
>> +static int virtio_i2c_send_reqs(struct virtqueue *vq,
> It would be better to rename this to virtio_i2c_prepare_reqs instead, as this
> doesn't send anything.


That's a better name. I'm OK with that.


>
>> +				struct virtio_i2c_req *reqs,
>> +				struct i2c_msg *msgs, int nr)
>> +{
>> +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
>> +	int i, outcnt, incnt, err = 0;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		/*
>> +		 * Only 7-bit mode supported for this moment. For the address format,
>> +		 * Please check the Virtio I2C Specification.
>> +		 */
>> +		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
>> +
>> +		if (i != nr - 1)
>> +			reqs[i].out_hdr.flags = cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT);
>> +
>> +		outcnt = incnt = 0;
>> +		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
>> +		sgs[outcnt++] = &out_hdr;
>> +
>> +		if (msgs[i].len) {
>> +			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
>> +			if (!reqs[i].buf)
>> +				break;
>> +
>> +			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
>> +
>> +			if (msgs[i].flags & I2C_M_RD)
>> +				sgs[outcnt + incnt++] = &msg_buf;
>> +			else
>> +				sgs[outcnt++] = &msg_buf;
>> +		}
>> +
>> +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
>> +		sgs[outcnt + incnt++] = &in_hdr;
>> +
>> +		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
>> +		if (err < 0) {
>> +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return i;
>> +}
> The right way of doing this is is making this function return - Error on failure
> and 0 on success. There is no point returning number of successful additions
> here.


We need the number for virtio_i2c_complete_reqs to do cleanup. We don't 
have to

do cleanup "num" times every time. Just do it as needed.


>
> Moreover, on failures this needs to clean up (free the dmabufs) itself, just
> like you did i2c_put_dma_safe_msg_buf() at the end. The caller shouldn't be
> required to handle the error cases by freeing up resources.


This function will return the number of requests being successfully 
prepared and make sure

resources of the failed request being freed. And 
virtio_i2c_complete_reqs will free the

resources of those successful request.


>> +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>> +				    struct virtio_i2c_req *reqs,
>> +				    struct i2c_msg *msgs, int nr,
>> +				    bool fail)
>> +{
>> +	struct virtio_i2c_req *req;
>> +	bool failed = fail;
>> +	unsigned int len;
>> +	int i, j = 0;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		/* Detach the ith request from the vq */
>> +		req = virtqueue_get_buf(vq, &len);
>> +
>> +		/*
>> +		 * Condition (req && req == &reqs[i]) should always meet since
>> +		 * we have total nr requests in the vq.
>> +		 */
>> +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
>> +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
> What about writing this as:
>
> 		if (!failed && (WARN_ON(req != &reqs[i]) ||
> 		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
>
> We don't need to check req here since if req is NULL, we will not do req->in_hdr
> at all.


It's right here just because the &reqs[i] will never be NULL in our 
case. But if you see

"virtio_i2c_complete_reqs" as an independent function, you need to check the

req. From the perspective of the callee, you can't ask the caller always 
give you

the non-NULL parameters. And some tools may give warnings.


>> +			failed = true;
>> +
>> +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
>> +		if (!failed)
>> +			++j;
>> +	}
>> +
>> +	return (fail ? -ETIMEDOUT : j);
>> +}
>> +
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
