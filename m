Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F5C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 02:22:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EDA61477
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 02:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EDA61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 439B043117;
	Tue,  2 Mar 2021 02:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqwYpCg2Yb7y; Tue,  2 Mar 2021 02:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D22FD43125;
	Tue,  2 Mar 2021 02:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5EF6C000B;
	Tue,  2 Mar 2021 02:22:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0DD1C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7DEB83C8F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uK_NyMDjCIjs
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:22:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C512883C68
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 02:22:06 +0000 (UTC)
IronPort-SDR: +bRjnk86DDucPMvHVaVoqfOyc7BAGhlvkBGYAgH4Xywy0sDHToIa9ijzZVCiIXkUhKdQL6ey44
 Pw4pBJmw4cuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="185986683"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="185986683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 18:22:05 -0800
IronPort-SDR: Sb5TjNiGTCmzYSMQV8Pa9AbbhcFfBgIoiLBKSTDcrCgSl9LbnlDIweQAFEbW6+oLBnibn6J8BW
 6t1wuJwl3n0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444539717"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 18:22:00 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <16efea9f-d606-4cf9-9213-3c1cf9b1a906@intel.com>
Date: Tue, 2 Mar 2021 10:21:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 arnd@arndb.de, mst@redhat.com, shuo.a.liu@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 kblaiech@mellanox.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, rppt@kernel.org
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


On 2021/3/1 19:54, Viresh Kumar wrote:
> On 01-03-21, 14:41, Jie Deng wrote:
>> +/**
>> + * struct virtio_i2c_req - the virtio I2C request structure
>> + * @out_hdr: the OUT header of the virtio I2C message
>> + * @write_buf: contains one I2C segment being written to the device
>> + * @read_buf: contains one I2C segment being read from the device
>> + * @in_hdr: the IN header of the virtio I2C message
>> + */
>> +struct virtio_i2c_req {
>> +	struct virtio_i2c_out_hdr out_hdr;
>> +	u8 *write_buf;
>> +	u8 *read_buf;
>> +	struct virtio_i2c_in_hdr in_hdr;
>> +};
> I am not able to appreciate the use of write/read bufs here as we
> aren't trying to read/write data in the same transaction. Why do we
> have two bufs here as well as in specs ?
>
> What about this on top of your patch ?
>
> ---
>   drivers/i2c/busses/i2c-virtio.c | 31 +++++++++++--------------------
>   include/uapi/linux/virtio_i2c.h |  3 +--
>   2 files changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 8c8bc9545418..e71ab1d2c83f 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -67,14 +67,13 @@ static int virtio_i2c_send_reqs(struct virtqueue *vq,
>   		if (!buf)
>   			break;
>   
> +		reqs[i].buf = buf;
> +		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> +
>   		if (msgs[i].flags & I2C_M_RD) {
> -			reqs[i].read_buf = buf;
> -			sg_init_one(&msg_buf, reqs[i].read_buf, msgs[i].len);
>   			sgs[outcnt + incnt++] = &msg_buf;
>   		} else {
> -			reqs[i].write_buf = buf;
> -			memcpy(reqs[i].write_buf, msgs[i].buf, msgs[i].len);
> -			sg_init_one(&msg_buf, reqs[i].write_buf, msgs[i].len);
> +			memcpy(reqs[i].buf, msgs[i].buf, msgs[i].len);
>   			sgs[outcnt++] = &msg_buf;
>   		}
>   
> @@ -84,13 +83,8 @@ static int virtio_i2c_send_reqs(struct virtqueue *vq,
>   		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
>   		if (err < 0) {
>   			pr_err("failed to add msg[%d] to virtqueue.\n", i);
> -			if (msgs[i].flags & I2C_M_RD) {
> -				kfree(reqs[i].read_buf);
> -				reqs[i].read_buf = NULL;
> -			} else {
> -				kfree(reqs[i].write_buf);
> -				reqs[i].write_buf = NULL;
> -			}
> +			kfree(reqs[i].buf);
> +			reqs[i].buf = NULL;
>   			break;
>   		}
>   	}
> @@ -118,14 +112,11 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>   			break;
>   		}
>   
> -		if (msgs[i].flags & I2C_M_RD) {
> -			memcpy(msgs[i].buf, req->read_buf, msgs[i].len);
> -			kfree(req->read_buf);
> -			req->read_buf = NULL;
> -		} else {
> -			kfree(req->write_buf);
> -			req->write_buf = NULL;
> -		}
> +		if (msgs[i].flags & I2C_M_RD)
> +			memcpy(msgs[i].buf, req->buf, msgs[i].len);
> +
> +		kfree(req->buf);
> +		req->buf = NULL;
>   	}
>   
>   	return i;
> diff --git a/include/uapi/linux/virtio_i2c.h b/include/uapi/linux/virtio_i2c.h
> index 92febf0c527e..61f0086ac75b 100644
> --- a/include/uapi/linux/virtio_i2c.h
> +++ b/include/uapi/linux/virtio_i2c.h
> @@ -48,8 +48,7 @@ struct virtio_i2c_in_hdr {
>    */
>   struct virtio_i2c_req {
>   	struct virtio_i2c_out_hdr out_hdr;
> -	u8 *write_buf;
> -	u8 *read_buf;
> +	u8 *buf;
>   	struct virtio_i2c_in_hdr in_hdr;
>   };
>   

That's my original proposal. I used to mirror this interface with 
"struct i2c_msg".

But the design philosophy of virtio TC is that VIRTIO devices are not 
specific to Linux
so the specs design should avoid the limitations of the current Linux 
driver behavior.

We had some discussion about this. You may check these links to learn 
the story.
https://lists.oasis-open.org/archives/virtio-comment/202010/msg00016.html
https://lists.oasis-open.org/archives/virtio-comment/202010/msg00033.html
https://lists.oasis-open.org/archives/virtio-comment/202011/msg00025.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
