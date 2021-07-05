Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC15FC07E95
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 02:41:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFF4613D2
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 02:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFF4613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C69C4041E;
	Mon,  5 Jul 2021 02:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqHnsnw20SXQ; Mon,  5 Jul 2021 02:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C734400B5;
	Mon,  5 Jul 2021 02:41:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C4F4C0010;
	Mon,  5 Jul 2021 02:41:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD363C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EAFF6066B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F3_ttRdVtTAh
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:41:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 443BA605BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:41:00 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id 17so15244185pfz.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5/pN4Ke3pX5vwwN2WlNO8yjdHUq5AXPfMRLrRETfPdM=;
 b=aKHomYdcEPhBlAt9kkJ9qhJHj4PKhbT8TgIKZmAadkH7oOmMWT7cO8Nc2Dh6r+KABy
 0RcgKCkPwd9PD3TXkF4zAa6KFS+yFhm5nSMnR89DRg9ljePoxjE+xGbwDXJOtD1+RDjs
 68unMHyVBNWNz0Bu/GPPH479FKPHzgOvubvi3NE/0q6wpbhwbt8YDwJyn50nP+W68MVW
 FdyYPUiMSa96ouDxzhvHnCLNgjRlVmpskQhqkZMmNj/I2IAIK/h2sspGxK2anoPE3lii
 bCW8i0qRetCnlEHomG0zBkx3BJbYyo3nhULU8cGXU0fArL/+TyqX0mtApAuIFlWnXq/M
 53Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5/pN4Ke3pX5vwwN2WlNO8yjdHUq5AXPfMRLrRETfPdM=;
 b=R8HuovWgE1G943EUNJhTUonyT5W5httPWpkfOZmxGtUQHM4ELIxpNm4kRqGgJooKIl
 +12vwlsVhd3S6wmgiQJwXgIzsVrV/AjvneGz+xMAi7ho0ljOtigEjLLav9uWAJjzE41X
 WD4DWMUBHcE49LOQf/OOyrCijqWVc0V1eEWtyyxIclPVI8fwSe4mWwD2+4DdHvFBlXq6
 BNKC7VYUrbtwJZr0tdJNYPqWQM3lc+MFzeEP37ocWF/V/VUdKFvDQJyOHNwsA1RzWq3k
 gTBgftEzhLEvmDr40Ziq+eGA/+ubarTi+uugs/hmM8QT1QeLBjh7WTa8lrIuMSNzxuwu
 b+5Q==
X-Gm-Message-State: AOAM531YzzuhWP/IouQioFIDsNnw+Yi+muYmyPmE4KEZT3dzN72VXewW
 T2n7I7Z5TynSIH8woI9Ahj82Rw==
X-Google-Smtp-Source: ABdhPJzv9zFkEM6yETuk4Cev7zKRIgjashmgNIf2AdxBqzXPrH5890A/gDkkpaAuKAPq34OVoQ/T0Q==
X-Received: by 2002:a65:68c1:: with SMTP id k1mr13154806pgt.335.1625452859542; 
 Sun, 04 Jul 2021 19:40:59 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id d1sm10001808pfu.6.2021.07.04.19.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 19:40:58 -0700 (PDT)
Date: Mon, 5 Jul 2021 08:10:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705024056.ndth2bwn2itii5g3@vireshk-i7>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
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

I think we missed the first deadline for 5.14-rc1 as Wolfram should be out of
office now. Anyway lets make sure we fix all the pending bits before he is back
and see if we can still pull it off by rc2.

On 02-07-21, 16:46, Jie Deng wrote:
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> +static int virtio_i2c_send_reqs(struct virtqueue *vq,

It would be better to rename this to virtio_i2c_prepare_reqs instead, as this
doesn't send anything.

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
> +		if (msgs[i].len) {
> +			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> +			if (!reqs[i].buf)
> +				break;
> +
> +			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> +
> +			if (msgs[i].flags & I2C_M_RD)
> +				sgs[outcnt + incnt++] = &msg_buf;
> +			else
> +				sgs[outcnt++] = &msg_buf;
> +		}
> +
> +		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
> +		sgs[outcnt + incnt++] = &in_hdr;
> +
> +		err = virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL);
> +		if (err < 0) {
> +			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> +			break;
> +		}
> +	}
> +
> +	return i;
> +}

The right way of doing this is is making this function return - Error on failure
and 0 on success. There is no point returning number of successful additions
here.

Moreover, on failures this needs to clean up (free the dmabufs) itself, just
like you did i2c_put_dma_safe_msg_buf() at the end. The caller shouldn't be
required to handle the error cases by freeing up resources.

> +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> +				    struct virtio_i2c_req *reqs,
> +				    struct i2c_msg *msgs, int nr,
> +				    bool fail)
> +{
> +	struct virtio_i2c_req *req;
> +	bool failed = fail;
> +	unsigned int len;
> +	int i, j = 0;
> +
> +	for (i = 0; i < nr; i++) {
> +		/* Detach the ith request from the vq */
> +		req = virtqueue_get_buf(vq, &len);
> +
> +		/*
> +		 * Condition (req && req == &reqs[i]) should always meet since
> +		 * we have total nr requests in the vq.
> +		 */
> +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
> +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))

What about writing this as:

		if (!failed && (WARN_ON(req != &reqs[i]) ||
		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))

We don't need to check req here since if req is NULL, we will not do req->in_hdr
at all.

> +			failed = true;
> +
> +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +		if (!failed)
> +			++j;
> +	}
> +
> +	return (fail ? -ETIMEDOUT : j);
> +}
> +

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
