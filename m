Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCB8C07E96
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 02:43:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC859613D0
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 02:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC859613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75F2E83521;
	Mon,  5 Jul 2021 02:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wMf_yXfISGh; Mon,  5 Jul 2021 02:43:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 133E283640;
	Mon,  5 Jul 2021 02:43:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCC1AC0010;
	Mon,  5 Jul 2021 02:43:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 163A9C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD010606B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TZd2msPvXCJ9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:43:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 562006066B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 02:43:43 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id e20so17001023pgg.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xuSwe/RfSoZsmqWmRxSCKHgdBKSJxFIJ1HP2k67JkNE=;
 b=TLV4gOuFn+VPLM41B7YR5L1wKfxLzcF6bpswN35lacqXklwXMThcUo1B9UxFGWGPbc
 6PBWQHbzjUGYKZ4JQhq1j45l5gCQTgzTlmgp5zMxaCGufDbwT4VFfkCk5bl+oqhW97Ta
 HRAnqvXotEJYQ7QiirWsTDMvf6wLaXM0XnMGWZcVZcUj6S8YkdKEuKBzvpucQF5ZHLJ4
 ZnDjDJKLK8jD2lgAz9H92+hFKOWObUF09q/ReTqmmbwTHHaaKBkkBPlY40wMnTHYpETJ
 m24o5HYwIKUPJz0kfdBUvF1aeIizRv8nbCZMwoJmD4y8bZAbDrmSb/tvRuiNfpb0wX3I
 V0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xuSwe/RfSoZsmqWmRxSCKHgdBKSJxFIJ1HP2k67JkNE=;
 b=D8qkH3tppcS7ZISI5HnRD0V/JLTyCYEpW8CRfcfeUoMJdh9WKt/qeoXoJtH4KRlzUE
 tx6iGqOfJijJtdxaQ/55+vO8Bwq8We1MGyqBARV0gi9uuMhqWXZyKjSkmN8kh7oVyYx4
 e37ohWiKSOadeXYJGu8hZ+8zXv8rZYhLV77y5Ci0gAMtv/hmiuhhXQ49oBIg6ltd/IUI
 a0DYPGDPCW3VG46E1WXzp1icouRnFKfu9tnOJAhXaslovcFtOIpXN5SweuA8WV5tfrS9
 UOFm01UgGqXZWg4lQYS9C6UBIvWA/VTf6H9xGPIIB9d4zdpozwTpQkpyIJ/Wvl2EZ1o+
 3xFg==
X-Gm-Message-State: AOAM532JkWCNREd/0t8LsGnRq997i6mdugakOLg8qv572/unD6OeqT7f
 LaIkFhjJqmpWfIlrQbWhLjA6jQ==
X-Google-Smtp-Source: ABdhPJwmAJLOYAES7tvc7lRmiTWlLmQtQ+z3LyBxTrAkUo6791EZO4D8kVO6bvovxidDnExrClJHKA==
X-Received: by 2002:a63:284:: with SMTP id 126mr13154170pgc.347.1625453022687; 
 Sun, 04 Jul 2021 19:43:42 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id y127sm5987540pfg.96.2021.07.04.19.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 19:43:42 -0700 (PDT)
Date: Mon, 5 Jul 2021 08:13:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705024340.mb5sv5epxbdatgsg@vireshk-i7>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: arnd@arndb.de, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
 yu1.wang@intel.com
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

On 02-07-21, 12:58, Andy Shevchenko wrote:
> On Fri, Jul 02, 2021 at 04:46:47PM +0800, Jie Deng wrote:
> > +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > +				    struct virtio_i2c_req *reqs,
> > +				    struct i2c_msg *msgs, int nr,
> > +				    bool fail)
> > +{
> > +	struct virtio_i2c_req *req;
> > +	bool failed = fail;

Jie, you can actually get rid of this variable too. Jut rename fail to failed
and everything shall work as you want.

> > +	unsigned int len;
> > +	int i, j = 0;
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		/* Detach the ith request from the vq */
> > +		req = virtqueue_get_buf(vq, &len);
> > +
> > +		/*
> > +		 * Condition (req && req == &reqs[i]) should always meet since
> > +		 * we have total nr requests in the vq.
> > +		 */
> > +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
> > +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
> > +			failed = true;
> 
> ...and after failed is true, we are continuing the loop, why?

Actually this function can be called with fail set to true. We proceed as we
need to call i2c_put_dma_safe_msg_buf() for all buffers we allocated earlier.

> > +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> > +		if (!failed)
> 
> > +			++j;
> 
> Besides better to read j++ the j itself can be renamed to something more
> verbose.
> 
> > +	}
> 
> > +	return (fail ? -ETIMEDOUT : j);
> 
> Redundant parentheses.
> 
> > +}

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
