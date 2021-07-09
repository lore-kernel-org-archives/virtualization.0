Return-Path: <SRS0=F8NL=MB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F655C07E9B
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 03:44:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1541461442
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 03:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1541461442
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5F2D42248;
	Fri,  9 Jul 2021 03:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNDaxT5KadAS; Fri,  9 Jul 2021 03:44:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1CFAE42251;
	Fri,  9 Jul 2021 03:44:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2DE3C0010;
	Fri,  9 Jul 2021 03:44:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D7B5C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 03:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 640CD606BE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 03:44:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lb73y34Zas1a
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 03:44:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A3F96066A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 03:44:11 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id p17so3780406plf.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jul 2021 20:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xkFDtexi/vMwk8I3d6YlTg5u37i8ZW2hQo1vPp5vAsk=;
 b=CIGTDosxAQ1YjXeC3953YY48H+KIcktvFf+jUy6Mf3aKz9wBXD27lWDOaK7UCa23Hi
 PWHBvkvblid2DvD713/emp6BmhVjoXVyyC2KDZPIRy9bs1eHgiqQztLd+28te0uYIV/O
 gE66OE3UGusmNlh4Gfxj63fcFmrH7p3KLoSLwBeIpvE8SWMgRKT8LeCKgdCikjKxin4z
 q9sDIgDhoRtFk21Pe8VMVmq1MAZf27Vv29rcFc6f72E1AEP2hbE15ClxubOUGaXvHSWm
 gOn7MT3GAU2RrDIk4/5PtozgUlwa9FLExSwt7EkkI8N1iakD8beHuDX3Z8h1G3+eNNsw
 36XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xkFDtexi/vMwk8I3d6YlTg5u37i8ZW2hQo1vPp5vAsk=;
 b=A4aW92PdoxyPk1T/NZ8TiY7y/WGDRvmIteEb+87AU+4Sk7C1ePa3z5eqzbmGX1mU8P
 3TJ2rRFv1Gal/u9lJp64/bn67EEN125f10ROZfZwolU9lBPsQcSyNKxJfUjtIWLLtGqM
 ztwqDgdtIVXrUs4btU0f+N7C7PL6QuuY1akQ/TubhoctullB7vV1G214sX3WvU81MSA9
 IpxYKhKCQmhwhglfArZZ/LUh1SYTuEFKDvm6RnLk1FbGcADyIHTa9yycNLxooN4mn1FG
 6aEDDLhFQnlC0zBbTufRNfbM15E9nhWU94WbYyaqOgYS5P6CuLT6UX4mxnbz2ny2mT7t
 dTJA==
X-Gm-Message-State: AOAM533rDV+iuFmgQw/VD62BrCS+dPKdjubeAzFpm5ZucHxSPKos35J2
 DVocG+rxtfdMlLSaS0xJtAvjpA==
X-Google-Smtp-Source: ABdhPJxH+A4xey9h58qu80WqGf4nd39LxWfRQeFFewlb+PDJOngfC5cTctLhAT7z2TUi+NJIe3vRxw==
X-Received: by 2002:a17:90a:cd01:: with SMTP id
 d1mr8389091pju.106.1625802250390; 
 Thu, 08 Jul 2021 20:44:10 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id q21sm4218209pfh.26.2021.07.08.20.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jul 2021 20:44:09 -0700 (PDT)
Date: Fri, 9 Jul 2021 09:14:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210709034407.xmglkgzubrztnxsg@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: vincent.guittot@linaro.org, yu1.wang@intel.com, arnd@arndb.de,
 mst@redhat.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
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

On 09-07-21, 10:25, Jie Deng wrote:
> Add an I2C bus driver for virtio para-virtualization.
> 
> The controller can be emulated by the backend driver in
> any device model software by following the virtio protocol.
> 
> The device specification can be found on
> https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
> 
> By following the specification, people may implement different
> backend drivers to emulate different controllers according to
> their needs.
> 
> Co-developed-by: Conghui Chen <conghui.chen@intel.com>
> Signed-off-by: Conghui Chen <conghui.chen@intel.com>
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
> Changes v13 -> v14
> 	- Put the headers in virtio_i2c.h in alphabetical order.
> 	- Dropped I2C_FUNC_SMBUS_QUICK support.
> 	- Dropped few unnecessary variables and checks.
> 	- Use "num" everywhere instead of num or nr, to be consistent.
> 	- Added few comments which make the design more clear. 

Thanks a lot for following this up so far :)

> +static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> +				   struct virtio_i2c_req *reqs,
> +				   struct i2c_msg *msgs, int num)
> +{
> +	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> +	int i;
> +
> +	for (i = 0; i < num; i++) {
> +		int outcnt = 0, incnt = 0;
> +
> +		/*
> +		 * We don't support 0 length messages and so masked out
> +		 * I2C_FUNC_SMBUS_QUICK in virtio_i2c_func().
> +		 */
> +		if (!msgs[i].len)
> +			break;
> +
> +		/*
> +		 * Only 7-bit mode supported for this moment. For the address
> +		 * format, Please check the Virtio I2C Specification.
> +		 */
> +		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
> +
> +		if (i != num - 1)
> +			reqs[i].out_hdr.flags = cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT);
> +
> +		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
> +		sgs[outcnt++] = &out_hdr;
> +
> +		reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> +		if (!reqs[i].buf)
> +			break;
> +
> +		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> +
> +		if (msgs[i].flags & I2C_M_RD)
> +			sgs[outcnt + incnt++] = &msg_buf;
> +		else
> +			sgs[outcnt++] = &msg_buf;
> +
> +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
> +		sgs[outcnt + incnt++] = &in_hdr;
> +
> +		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
> +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> +			break;
> +		}
> +	}
> +
> +	return i;
> +}

Wolfram, in case you wonder why we don't error out early as discussed earlier,
then ...

> +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			   int num)
> +{

...

> +	/*
> +	 * For the case where count < num, i.e. we weren't able to queue all the
> +	 * msgs, ideally we should abort right away and return early, but some
> +	 * of the messages are already sent to the remote I2C controller and the
> +	 * virtqueue will be left in undefined state in that case. We kick the
> +	 * remote here to clear the virtqueue, so we can try another set of
> +	 * messages later on.
> +	 */

... here is the reasoning for that.

Please see if you can still get it merged into 5.14-rc1/2. Thanks.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
