Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB99C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 07:53:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1567261972
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 07:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1567261972
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE0AE402A7;
	Mon, 22 Mar 2021 07:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5O8259Mj8gNJ; Mon, 22 Mar 2021 07:53:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FEA8400A9;
	Mon, 22 Mar 2021 07:53:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30E98C000B;
	Mon, 22 Mar 2021 07:53:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C38F7C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 07:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA15A82E19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 07:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPRLwI51nWgF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 07:53:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C9C882E0E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 07:53:43 +0000 (UTC)
IronPort-SDR: sM4obq64O5ueqvoibRiFkcaqix5IAR217j/6rPSD8WqPeXU1AB6Ab91PJtleNWJmyB293lMTp9
 z42fVE0UldLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="189620966"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; d="scan'208";a="189620966"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 00:53:42 -0700
IronPort-SDR: zgU0rmsxDry5X4QjX4pUlRJvBNvqDip4gkVX7iBQef89oRvoq8EmDs7cC4K5N8zrCNJ1v6z/jT
 UnakFcneIGkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; d="scan'208";a="414378048"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga008.jf.intel.com with ESMTP; 22 Mar 2021 00:53:37 -0700
Subject: Re: [PATCH v9] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <e09c07532f5456816eb91ef4176bf910284df4ff.1616418890.git.jie.deng@intel.com>
 <20210322064144.y6kpajolwh2kd3lj@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <dbb5dfe9-8ee6-e3f8-3681-d0ec83282930@intel.com>
Date: Mon, 22 Mar 2021 15:53:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210322064144.y6kpajolwh2kd3lj@vireshk-i7>
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


On 2021/3/22 14:41, Viresh Kumar wrote:
>
>> +/**
>> + * struct virtio_i2c - virtio I2C data
>> + * @vdev: virtio device for this controller
>> + * @completion: completion of virtio I2C message
>> + * @adap: I2C adapter for this controller
>> + * @i2c_lock: lock for virtqueue processing
> Name mismatch here.


Will fix this typo. Thank you.


>> + * @vq: the virtio virtqueue for communication
>> + */
>> +struct virtio_i2c {
>> +	struct virtio_device *vdev;
>> +	struct completion completion;
>> +	struct i2c_adapter adap;
>> +	struct mutex lock;
>> +	struct virtqueue *vq;
>> +};
>
>> +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>> +					struct virtio_i2c_req *reqs,
>> +					struct i2c_msg *msgs, int nr,
>> +					bool timeout)
>> +{
>> +	struct virtio_i2c_req *req;
>> +	bool err_found = false;
>> +	unsigned int len;
>> +	int i, j = 0;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		/* Detach the ith request from the vq */
>> +		req = virtqueue_get_buf(vq, &len);
>> +
>> +		if (timeout || err_found)  {
>> +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * Condition (req && req == &reqs[i]) should always meet since
>> +		 * we have total nr requests in the vq.
>> +		 */
>> +		if (WARN_ON(!(req && req == &reqs[i])) ||
>> +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)) {
>> +			err_found = true;
>> +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
>> +			continue;
>> +		}
>> +
>> +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], true);
>> +		++j;
>> +	}
> I think you can simplify the code like this here:


I think your optimization has problems...


> 	bool err_found = timeout;
>
> 	for (i = 0; i < nr; i++) {
> 		/* Detach the ith request from the vq */
> 		req = virtqueue_get_buf(vq, &len);
>
> 		/*
> 		 * Condition (req && req == &reqs[i]) should always meet since
> 		 * we have total nr requests in the vq.
> 		 */
> 		if (!err_found &&
>                      (WARN_ON(!(req && req == &reqs[i])) ||
> 		     (req->in_hdr.status != VIRTIO_I2C_MSG_OK))) {
> 			err_found = true;
> 			continue;


Just continue here, the ith buf leaks ?


> 		}
>
> 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], err_found);


i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !err_found); ?


>                  if (!err_found)
>                          ++j;
>
>> +
>> +	return (timeout ? -ETIMEDOUT : j);
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
>> +		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
>> +		ret = virtio_i2c_complete_reqs(vq, reqs, msgs, nr, true);
>> +		goto err_unlock_free;
>> +	}
>> +
>> +	ret = virtio_i2c_complete_reqs(vq, reqs, msgs, nr, false);
> And this can be optimized as well:
>
> 	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
> 	if (!time_left)
> 		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
>
>          ret = virtio_i2c_complete_reqs(vq, reqs, msgs, nr, !time_left);


Good optimization here.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
