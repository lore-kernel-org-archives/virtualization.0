Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926B0C11F64
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 04:04:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD9A61554
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 04:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD9A61554
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB24E41612;
	Thu,  1 Jul 2021 04:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LVtzN724OE3o; Thu,  1 Jul 2021 04:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16E5A4160E;
	Thu,  1 Jul 2021 04:04:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B56C0010;
	Thu,  1 Jul 2021 04:04:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1162C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 04:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96C994160E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 04:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EZDE4fDBacBV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 04:04:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E67E41612
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 04:04:38 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d1so2898560plg.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 21:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tlLiC0/suIzFL9Kc0HiGXCJ9guNpwuTifmDbO7ccBmk=;
 b=GjsPDXLqMMYdUtQ04S9QypWLzNfxSIdZN+wtJfxqs98oJc5FP3ISRbX2vsRPb4PlIW
 vEvCOlQb4NcDvwQh5ovIc6R2cKiIg/jsRX7gUTseHHRA8lYhQejsePqoDy5Z3Rh8pXKc
 z4Yt71s9d61EOaJklZX8BRcv2MrKq67YrL/S19LYhy4+A9066tuu43r7Efu/+SjFbuBy
 3TYYVI/ZhG/3Sguxn9jXBA6u9DqiuKUwNnHi7164E4LbbRuHY8X8qHTZMPCIBcLjAdDs
 FIXOytssI5Ir/j4ocrqCrh8rXPlWkphvsLk6m2qOpsh/vq3gA0a1sW2PmFdFyjEF63Am
 VofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tlLiC0/suIzFL9Kc0HiGXCJ9guNpwuTifmDbO7ccBmk=;
 b=WZlf/eFAv+HaS3YDGmWIwcwsA/tdHH8Ge54ROY7ShLekIpZZynjyfBF8npTATiQT17
 UPPOCWy6vY/Vi3NW88cnwyYZLvhxRzU4d+cPdAEiZjxJ8VzidZkZIJVRTdWgzCUX67mz
 PZOOCGrIbnp0mBHogPXAJfJr+JkE7vIdOeDo/7LnxzLBVF0Yr+hcVaROhDWOsb3u4s4w
 1llMtxg+K3Fn/6sbSHB3EQvfqf1rLVNcWDXJIykh5+txtv1uqb8CZBriOI6S8QwhLzXC
 DOFHR9so04uUEkThQ5QwYahAFiUqrY0YyDcyFG6cbZfD/e4nD0lFV4ZLwlpgauVfiQQH
 KcJA==
X-Gm-Message-State: AOAM531zByxA8lzh1+HMGd2gWYR3im0+sEmXoywaEqpcT3aXE9yvKZGS
 iBTaGvutz9XriGS6lcuxPdsfIA==
X-Google-Smtp-Source: ABdhPJxC8zqchwOE8jWRaqXwN4H0BnWwhHXMQTOWPNq3iG1fMlPMEl10tro8es2vXM0pEV3FpN+w/A==
X-Received: by 2002:a17:90b:2504:: with SMTP id
 ns4mr8022103pjb.140.1625112278476; 
 Wed, 30 Jun 2021 21:04:38 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id q7sm17404549pfk.192.2021.06.30.21.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 21:04:38 -0700 (PDT)
Date: Thu, 1 Jul 2021 09:34:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 01-07-21, 11:24, Jie Deng wrote:
> Changes v10 -> v11
> 	- Remove vi->adap.class = I2C_CLASS_DEPRECATED.
> 	- Use #ifdef CONFIG_PM_SLEEP to replace the "__maybe_unused".
> 	- Remove "struct mutex lock" in "struct virtio_i2c".
> 	- Support zero-length request.
> 	- Remove unnecessary logs.
> 	- Remove vi->adap.timeout = HZ / 10, just use the default value.
> 	- Use BIT(0) to define VIRTIO_I2C_FLAGS_FAIL_NEXT.
> 	- Add the virtio_device index to adapter's naming mechanism.

Thanks Jie.

I hope you are going to send a fix for specification as well (for the
zero-length request) ?

> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> +static int virtio_i2c_send_reqs(struct virtqueue *vq,
> +				struct virtio_i2c_req *reqs,
> +				struct i2c_msg *msgs, int nr)
> +{
> +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> +	int i, outcnt, incnt, err = 0;
> +
> +	for (i = 0; i < nr; i++) {
> +		/*
> +		 * Only 7-bit mode supported for this moment. For the address format,
> +		 * Please check the Virtio I2C Specification.
> +		 */
> +		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
> +
> +		if (i != nr - 1)
> +			reqs[i].out_hdr.flags = cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT);
> +
> +		outcnt = incnt = 0;
> +		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
> +		sgs[outcnt++] = &out_hdr;
> +
> +		reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> +		if (!reqs[i].buf)
> +			break;
> +
> +		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);

The len can be zero here for zero-length transfers.

> +
> +		if (msgs[i].flags & I2C_M_RD)
> +			sgs[outcnt + incnt++] = &msg_buf;
> +		else
> +			sgs[outcnt++] = &msg_buf;
> +
> +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
> +		sgs[outcnt + incnt++] = &in_hdr;

Why are we still sending the msg_buf if the length is 0? Sending the
buffer makes sense if you have some data to send, but otherwise it is
just an extra sg element, which isn't required to be sent.

> +
> +		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
> +		if (err < 0) {
> +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> +			break;
> +		}
> +	}
> +
> +	return i;

I just noticed this now, but this function even tries to send data
partially, which isn't right. If the caller (i2c device's driver)
calls this for 5 struct i2c_msg instances, then all 5 need to get
through or none.. where as we try to send as many as possible here.

This looks broken to me. Rather return an error value here on success,
or make it complete failure.

Though to be fair I see i2c-core also returns number of messages
processed from i2c_transfer().

Wolfram, what's expected here ? Shouldn't all message transfer or
none?

> +#ifdef CONFIG_PM_SLEEP
> +static int virtio_i2c_freeze(struct virtio_device *vdev)
> +{
> +	virtio_i2c_del_vqs(vdev);
> +	return 0;
> +}
> +
> +static int virtio_i2c_restore(struct virtio_device *vdev)
> +{
> +	return virtio_i2c_setup_vqs(vdev->priv);
> +}
> +#endif
> +
> +static struct virtio_driver virtio_i2c_driver = {
> +	.id_table	= id_table,
> +	.probe		= virtio_i2c_probe,
> +	.remove		= virtio_i2c_remove,
> +	.driver	= {
> +		.name	= "i2c_virtio",
> +	},
> +#ifdef CONFIG_PM_SLEEP

You could avoid this pair of ifdef by creating dummy versions of below
routines for !CONFIG_PM_SLEEP case. Up to you.

> +	.freeze = virtio_i2c_freeze,
> +	.restore = virtio_i2c_restore,
> +#endif
> +};

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
