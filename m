Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2776C07E9A
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 08:02:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48255613B7
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 08:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48255613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 015FA60840;
	Mon,  5 Jul 2021 08:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYCaqlzK9ND4; Mon,  5 Jul 2021 08:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 83A686083F;
	Mon,  5 Jul 2021 08:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3648BC0010;
	Mon,  5 Jul 2021 08:02:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB0FDC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A931040109
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i_gwJ01zKXmi
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:02:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F27FF400B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:02:47 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id c15so9803887pls.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7HFtrvl8Hp3RAM/FFfn+6kiIZNa9TUM0Rjxm9S07BYU=;
 b=wT20aR19P0l8+aXdUbQcBT2ncbwV7FLfcH5+V03YDNNqKv6/W87Yd4qmTk6DrcK30g
 DvdQhRcrJe9G3BFaoFV5p4WrmgUYKk3+u3X4UvHFL0rNEX3TkXe2iLY38CprPo955Xzk
 jXw1t1JN2FhA8XTxNXav8VU91f4SYPjClLB2etFbnaARMLCB1puhJz8RBotc77tIGNYG
 YqVZkWZTcmUltC94eZPNzm9ddh9ayqP2+UMdqYc/uXD+lDCeqntSEOoRDnRI80vOfihc
 4Rwft7IiiyvdBJHDpT7OmrenOGha/+t3Zh7rTwhzsLC3HMMBQmC6moV+GZbSHYxhWGsY
 5KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7HFtrvl8Hp3RAM/FFfn+6kiIZNa9TUM0Rjxm9S07BYU=;
 b=APuBodtqV3feRH9z5f7zMyePwZ4GGQjfewVN9H4JnQEKj7Yr9jWR6Vc7MRc0Gpl7pr
 qXEs1WoFGEgAkwRdJLbNkjH4cwT0/I7dUsYusD26RbSPMDxFx5IQuYgKQCwFdkWpUs+w
 pH7INXtCqMaGq4fgvH0F4IH9CbMzU0TTCOnM0mgW4ZqbxqUZH/yzcjZi/l4N9+0CeS1w
 zN2nJuIzki/l0GgE3cBbfRyDqBw6pX6wYicVtW5Y698mt2k8rau7FaD28IFO1HZB4drz
 yYftH3ZbZARkcedNiQd6WskKZsS3Mezfg3+291f2H0SJzrp8C30R30EwfhF0Giynm/qL
 SE7A==
X-Gm-Message-State: AOAM531cjRS3ujJePygcylOZhDgDPtj1sSQaDfNs8Q2Ru1MsMvPmwMZj
 DwsSDtq/ItRQj1vbwpSzdNCFig==
X-Google-Smtp-Source: ABdhPJzpiH5Tj6rIdJ6BpWrt9yRBYxI8qI2sTP9njbWlR/EiBwQY+vKPW1G7o0sV6W/XsAOUrtBk/A==
X-Received: by 2002:a17:902:e848:b029:129:2e87:9944 with SMTP id
 t8-20020a170902e848b02901292e879944mr11397658plg.27.1625472167343; 
 Mon, 05 Jul 2021 01:02:47 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id v14sm13323329pgo.89.2021.07.05.01.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 01:02:46 -0700 (PDT)
Date: Mon, 5 Jul 2021 13:32:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v13] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705080245.yabjlrgje5l7vndt@vireshk-i7>
References: <8908f35a741e25a630d521e1012494e67d31ea64.1625466616.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8908f35a741e25a630d521e1012494e67d31ea64.1625466616.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
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

Hi Jie.

On 05-07-21, 14:53, Jie Deng wrote:
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
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

Calling this for cases where virtio_i2c_prepare_reqs() itself has failed will
always return NULL, should we even try to call this then ?

virtqueue_get_buf() returns the next used buffer only, i.e. returned by the host
?

> +
> +		/*
> +		 * Condition (req && req == &reqs[i]) should always meet since
> +		 * we have total nr requests in the vq.
> +		 */
> +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||

Mentioning again for completeness of the review, reqs[i] can never be NULL here
though req can be. And even in that case you never need to check req here.

Feel free to ignore it if you want, we can always send a fixup patch later and
discuss it further :)

> +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
> +			failed = true;
> +
> +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +		if (!failed)
> +			j++;
> +	}
> +
> +	return fail ? 0 : j;

Since you don't return ETIMEDOUT anymore, you can simply return j now. And so we
can work with a single failed argument and don't need both fail and failed.

> +}
> +
> +static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct virtio_i2c *vi = i2c_get_adapdata(adap);
> +	struct virtqueue *vq = vi->vq;
> +	struct virtio_i2c_req *reqs;
> +	unsigned long time_left;
> +	int ret;
> +
> +	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
> +	if (!reqs)
> +		return -ENOMEM;
> +
> +	ret = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> +	if (ret != num) {
> +		ret = virtio_i2c_complete_reqs(vq, reqs, msgs, ret, true);
> +		goto err_free;
> +	}
> +
> +	reinit_completion(&vi->completion);
> +	virtqueue_kick(vq);
> +	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
> +	ret = virtio_i2c_complete_reqs(vq, reqs, msgs, num, !time_left);
> +
> +	if (!time_left) {
> +		ret = -ETIMEDOUT;
> +		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
> +	}
> +
> +err_free:
> +	kfree(reqs);
> +	return ret;
> +}

> diff --git a/include/uapi/linux/virtio_i2c.h b/include/uapi/linux/virtio_i2c.h
> new file mode 100644
> index 0000000..df936a2
> --- /dev/null
> +++ b/include/uapi/linux/virtio_i2c.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
> +/*
> + * Definitions for virtio I2C Adpter
> + *
> + * Copyright (c) 2021 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
> +#define _UAPI_LINUX_VIRTIO_I2C_H
> +
> +#include <linux/types.h>
> +#include <linux/const.h>

Both of these need to be the uapi headers as Andy said earlier and they better
be in alphabetical order.

#include <uapi/linux/const.h>
#include <uapi/linux/types.h>

Though in your support, I do see a lot of files in uapi/linux using the standard
types.h, which looks wrong as that types.h is not a userspace ABI.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
