Return-Path: <SRS0=He06=CN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A1C43461
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 06:09:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E0E206E7
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 06:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E0E206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 96FA286D12;
	Fri,  4 Sep 2020 06:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P+sxAZfsLYUC; Fri,  4 Sep 2020 06:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C54BF86665;
	Fri,  4 Sep 2020 06:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD396C07FF;
	Fri,  4 Sep 2020 06:09:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79970C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 06:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6E15186687
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 06:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AKr+hyHPa+p9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 06:09:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9DC9586B04
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 06:09:01 +0000 (UTC)
IronPort-SDR: lBqG/3kL468cXYkUEvQA9uLM8o6Ck3B5fOlfnPOz4pO58M4+FBXpMz8LwLtJ/Y6VJBLKkWFFVb
 apY9IVAUUt4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="157706112"
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; d="scan'208";a="157706112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 23:09:00 -0700
IronPort-SDR: WnIAQssWbM5cgI7sn0A2JEgKJnpLS33upoRBQzZKYQiiqXDGsSvnzo7Qerwh0SK61m69h8sMIn
 WqboLBUn+9tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; d="scan'208";a="502788500"
Received: from unknown (HELO [10.239.154.46]) ([10.239.154.46])
 by fmsmga006.fm.intel.com with ESMTP; 03 Sep 2020 23:08:53 -0700
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <20200903102008.GY1891694@smile.fi.intel.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <71587fa1-ded8-2f96-378f-fc1ecc18a1a1@intel.com>
Date: Fri, 4 Sep 2020 14:08:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200903102008.GY1891694@smile.fi.intel.com>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, krzk@kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, rppt@kernel.org, shuo.a.liu@intel.com,
 tali.perry1@gmail.com, conghui.chen@intel.com, jdelvare@suse.de
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


On 2020/9/3 18:20, Andy Shevchenko wrote:
> On Thu, Sep 03, 2020 at 01:34:45PM +0800, Jie Deng wrote:
>> Add an I2C bus driver for virtio para-virtualization.
>>
>> The controller can be emulated by the backend driver in
>> any device model software by following the virtio protocol.
>>
>> This driver communicates with the backend driver through a
>> virtio I2C message structure which includes following parts:
>>
>> - Header: i2c_msg addr, flags, len.
>> - Data buffer: the pointer to the i2c msg data.
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
> Seems it's slightly different version to what I have reviewed internally.
> My comments below. (I admit that some of them maybe new)
>
> ...

Yeah... Some new devices have been added into the virtio spec during 
these days.


>> +/**
>> + * struct virtio_i2c_hdr - the virtio I2C message header structure
>> + * @addr: i2c_msg addr, the slave address
>> + * @flags: i2c_msg flags
>> + * @len: i2c_msg len
>> + */
>> +struct virtio_i2c_hdr {
>> +	__virtio16 addr;
>> +	__virtio16 flags;
>> +	__virtio16 len;
>> +} __packed;
> As Misha noticed and somewhere I saw 0-day reports these should be carefully
> taken care of.
>
> ...

Sure. Will fix these.


>> +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>> +{
>> +	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>> +	struct virtio_i2c_msg *vmsg_o, *vmsg_i;
>> +	struct virtqueue *vq = vi->vq;
>> +	unsigned long time_left;
>> +	int len, i, ret = 0;
>> +
>> +	vmsg_o = kzalloc(sizeof(*vmsg_o), GFP_KERNEL);
>> +	if (!vmsg_o)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&vi->i2c_lock);
>> +	vmsg_o->buf = NULL;
>> +	for (i = 0; i < num; i++) {
>> +		ret = virtio_i2c_add_msg(vq, vmsg_o, &msgs[i]);
>> +		if (ret) {
>> +			dev_err(&adap->dev, "failed to add msg[%d] to virtqueue.\n", i);
>> +			goto err_unlock_free;
> break;

OK.


>> +		}
>> +
>> +		virtqueue_kick(vq);
>> +
>> +		time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
>> +		if (!time_left) {
>> +			dev_err(&adap->dev, "msg[%d]: addr=0x%x timeout.\n", i, msgs[i].addr);
>> +			ret = i;
>> +			goto err_unlock_free;
> break;
>
> And so on.
OK.
>> +		}
>> +
>> +		vmsg_i = (struct virtio_i2c_msg *)virtqueue_get_buf(vq, &len);
>> +		if (vmsg_i) {
>> +			/* vmsg_i should point to the same address with vmsg_o */
>> +			if (vmsg_i != vmsg_o) {
>> +				dev_err(&adap->dev, "msg[%d]: addr=0x%x virtqueue error.\n",
>> +					i, vmsg_i->hdr.addr);
>> +				ret = i;
>> +				goto err_unlock_free;
>> +			}
>> +			if (vmsg_i->status != VIRTIO_I2C_MSG_OK) {
>> +				dev_err(&adap->dev, "msg[%d]: addr=0x%x error=%d.\n",
>> +					i, vmsg_i->hdr.addr, vmsg_i->status);
>> +				ret = i;
>> +				goto err_unlock_free;
>> +			}
>> +			if ((vmsg_i->hdr.flags & I2C_M_RD) && vmsg_i->hdr.len)
>> +				memcpy(msgs[i].buf, vmsg_i->buf, vmsg_i->hdr.len);
>> +
>> +			kfree(vmsg_i->buf);
>> +			vmsg_i->buf = NULL;
>> +		}
>> +		reinit_completion(&vi->completion);
>> +	}
>> +	if (i == num)
>> +		ret = num;
> And this conditional seems a dup of the for-loop successfully iterating over
> entire queue.
You are right.
We may save several lines of code by using "Return (ret<0) ? ret : i" at 
the end.


>> +err_unlock_free:
> Redundant.
OK.
>> +	mutex_unlock(&vi->i2c_lock);
>> +	kfree(vmsg_o->buf);
>> +	kfree(vmsg_o);
>> +	return ret;
>> +}
> ...
>
>> +	vi->adap.timeout = HZ / 10;
> + Blank line.
OK.
>> +	ret = i2c_add_adapter(&vi->adap);
>> +	if (ret) {
>> +		dev_err(&vdev->dev, "failed to add virtio-i2c adapter.\n");
>> +		virtio_i2c_del_vqs(vdev);
> Usually we do clean up followed by message.
I will change the order. Thank you.
>> +	}
>> +
>> +	return ret;
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
