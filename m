Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D4C433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 07:52:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B44864E77
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 07:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B44864E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B569F4010F;
	Fri, 19 Mar 2021 07:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lleWvW9FV5A; Fri, 19 Mar 2021 07:52:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A9EC40109;
	Fri, 19 Mar 2021 07:52:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFB79C000B;
	Fri, 19 Mar 2021 07:52:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F218C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 07:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55B3B83AB8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 07:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sn-bF0DMtPG0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 07:52:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A4CC83B65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 07:52:14 +0000 (UTC)
IronPort-SDR: +255H1b9IMq+RGviSI31V303dKzRG2GDS0no3e4S3NillPNE1zOO9eOBve+4uj/iOPf7tIcoxb
 HgNOms1sT+7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="177435366"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="177435366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2021 00:52:12 -0700
IronPort-SDR: zjPrexRqxtCYtRmHSXN7LMBzQIpIurWqPudlUyZdovv25pEGo65DEw15rZi79Jkq9SEiI2HO/Z
 mJQSmrk8TaHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="591782733"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga005.jf.intel.com with ESMTP; 19 Mar 2021 00:52:06 -0700
Subject: Re: [PATCH v8] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
 <20210319055322.lw4dhb2kwtrtd3qu@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <3eedeab5-04e6-885a-20f2-3ff2f05cf7d0@intel.com>
Date: Fri, 19 Mar 2021 15:52:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210319055322.lw4dhb2kwtrtd3qu@vireshk-i7>
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


On 2021/3/19 13:53, Viresh Kumar wrote:
> On 16-03-21, 18:35, Jie Deng wrote:
>> +++ b/drivers/i2c/busses/i2c-virtio.c
>> +static int virtio_i2c_send_reqs(struct virtqueue *vq,
>> +				struct virtio_i2c_req *reqs,
>> +				struct i2c_msg *msgs, int nr)
>> +{
>> +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
>> +	int i, outcnt, incnt, err = 0;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		if (!msgs[i].len)
>> +			break;
>> +
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
>> +		reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> You allocate a buffer here, lets see if they are freeing properly or not (I
> remember that I gave same feedback earlier as well, but anyway).


"MAY" allocate a buffer here.


>
>> +		if (!reqs[i].buf)
>> +			break;
>> +
>> +		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
>> +
>> +		if (msgs[i].flags & I2C_M_RD)
>> +			sgs[outcnt + incnt++] = &msg_buf;
>> +		else
>> +			sgs[outcnt++] = &msg_buf;
>> +
>> +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
>> +		sgs[outcnt + incnt++] = &in_hdr;
>> +
>> +		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
>> +		if (err < 0) {
>> +			pr_err("failed to add msg[%d] to virtqueue.\n", i);
>> +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> On failure here, you freed the buffers for request "i" but not others..


Others still need to be sent and then be freed.


>
>> +			break;
>> +		}
>> +	}
>> +
>> +	return i;
>> +}
>> +
>> +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>> +					struct virtio_i2c_req *reqs,
>> +					struct i2c_msg *msgs, int nr)
>> +{
>> +	struct virtio_i2c_req *req;
>> +	unsigned int len;
>> +	int i, j;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		req = virtqueue_get_buf(vq, &len);
>> +		if (!(req && req == &reqs[i])) {
>> +			pr_err("msg[%d]: addr=0x%x is out of order.\n", i, msgs[i].addr);
>> +			break;
> Since you break here, what will happen to the buffer ? I thought
> virtqueue_get_buf() will return a req only once and then you can't access it ?


Will refine it along with the latter loop.


>
>> +		}
>> +
>> +		if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
>> +			pr_err("msg[%d]: addr=0x%x backend error.\n", i, msgs[i].addr);
>> +			break;
>> +		}
>> +
>> +		i2c_put_dma_safe_msg_buf(req->buf, &msgs[i], true);
>> +	}
>> +
>> +	/*
>> +	 * Detach all the used buffers from the vq and
>> +	 * Release unused DMA safe buffer if any.
>> +	 */
>> +	for (j = i; j < nr; j++) {
>> +		req = virtqueue_get_buf(vq, &len);
>> +		if (req)
>> +			i2c_put_dma_safe_msg_buf(req->buf, &msgs[j], false);
> This will come in play only if something failed in the earlier loop ? Or my
> understanding incorrect ? Also this should be merged with the above for loop
> itself, it is just doing part of it.


Will refine it along with the earlier loop.


>
>> +	}
>> +
>> +	return i;
>> +}
>> +
>> +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>> +{
>> +	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>> +	struct virtqueue *vq = vi->vq;
>> +	struct virtio_i2c_req *reqs;
>> +	unsigned long time_left;
>> +	int ret, nr;
>> +
>> +	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
>> +	if (!reqs)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&vi->lock);
>> +
>> +	ret = virtio_i2c_send_reqs(vq, reqs, msgs, num);
>> +	if (ret == 0)
>> +		goto err_unlock_free;
>> +
>> +	nr = ret;
>> +	reinit_completion(&vi->completion);
>> +	virtqueue_kick(vq);
>> +
>> +	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
>> +	if (!time_left) {
> On error here, we will surely not free the buffers, isn't it ?


Right. Will fix it. Thank you.


>> +		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
>> +		ret = -ETIMEDOUT;
>> +		goto err_unlock_free;
>> +	}
>> +
>> +	ret = virtio_i2c_complete_reqs(vq, reqs, msgs, nr);
>> +
>> +err_unlock_free:
>> +	mutex_unlock(&vi->lock);
>> +	kfree(reqs);
>> +	return ret;
>> +}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
