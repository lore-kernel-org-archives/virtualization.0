Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04BFC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:31:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EB3613C8
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EB3613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F23483A50;
	Mon,  5 Jul 2021 06:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1hfVV_fM35x; Mon,  5 Jul 2021 06:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F38D283542;
	Mon,  5 Jul 2021 06:31:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6D05C0010;
	Mon,  5 Jul 2021 06:31:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8643EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72A084046E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wsmVJSBLgI-p
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:31:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E0FD4046A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:31:06 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id i184so2850531pfc.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wWMXmMCJoSZ9OCdipGCDRnC3WjS629PoEJ5rr2yZGV4=;
 b=DkNMSvM96dm/AcUPUGEq9JBeaCg2RBULAlZIqhkyanmq/ooofwovzz1sIYEjs873Hy
 hfEBAN6RtF0t5J86yneotbcmbmZzq0O3hj4ZljjxrqTM3IXpQJrnodt+Xb5GgW6QQe5p
 cIrHyv3lrAXb2qZ14efevI+sKddKGnFRJFyEpvM1+7pWINYIv2NA0Ce9O75/33njDL7i
 y99Glt8+3v+1ZCUoIR0bAnLi+lVKclqr98EkceNpSYW47BaMMJOf+0gM8qLTxP4qANrk
 0EmPbLfPMNYyqnfq7aL56vC+OAJzTbQezhjtY0qK4Plk1T8ysZclL44NmcpHZloPEw66
 ItJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wWMXmMCJoSZ9OCdipGCDRnC3WjS629PoEJ5rr2yZGV4=;
 b=IETh52WRxor4XsfPguFBqbbzrRFCsAOB1uEozlTKrjE1tnzUUx4VOG5+BvaQNcvcem
 8x1ETPhRz6Zy+9rQpdYIAv/ucN6y0Qa2uvv5q2LVLCvZ+KhkgftJAbOezk+OlAaBwtfH
 6iqwiL/ixntKdoGMIMl/2FbGv+av1FiczFDgupjJ6g7AYkakLk1r0iHn70BZWjhaTuqX
 T2E91GlbfO9gqHAXeXAF3nQTBxZwUgr+TWD2x4VJJ8Bgsfk3WVdnUHrrQx2ZWzdHDkJp
 3ZBIXGorPm9M5AUU7iQyubC63FId5GHrE8rf0yrTd8e+d+R9XcjNS/4eUNyJEiJ4AE9c
 HflA==
X-Gm-Message-State: AOAM5315TWhlQdRuxpUBzk+aGvG1yP7+nzVRokZyU1FWwe8W/3QfLrMo
 mhCagveOGpqQOvFXHB2EWtRvSw==
X-Google-Smtp-Source: ABdhPJwjbeDpEwUGHX4wapdtd68i1JUGbnqyQuUWmDrUGIl18KntYn+5LqFO42LZddC9cRK1RvizQQ==
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr1117953pgm.294.1625466665652; 
 Sun, 04 Jul 2021 23:31:05 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id z20sm13337396pgk.36.2021.07.04.23.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 23:31:05 -0700 (PDT)
Date: Mon, 5 Jul 2021 12:01:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705063103.4gnrnx6qwheq37lp@vireshk-i7>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
 <20210705024340.mb5sv5epxbdatgsg@vireshk-i7>
 <adb5a18f-cf48-3059-5541-fb6d7bafb8d2@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adb5a18f-cf48-3059-5541-fb6d7bafb8d2@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, conghui.chen@intel.com
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

On 05-07-21, 14:21, Jie Deng wrote:
> 
> On 2021/7/5 10:43, Viresh Kumar wrote:
> > On 02-07-21, 12:58, Andy Shevchenko wrote:
> > > On Fri, Jul 02, 2021 at 04:46:47PM +0800, Jie Deng wrote:
> > > > +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > > > +				    struct virtio_i2c_req *reqs,
> > > > +				    struct i2c_msg *msgs, int nr,
> > > > +				    bool fail)
> > > > +{
> > > > +	struct virtio_i2c_req *req;
> > > > +	bool failed = fail;
> > Jie, you can actually get rid of this variable too. Jut rename fail to failed
> > and everything shall work as you want.
> 
> 
> Oh, You are not right. I just found we can't remove this variable. The
> "fail" and "failed" have different
> 
> meanings for this function. We need fail to return the result.

Ahh, yes. You are right. Maybe rename fail to timedout, it would make it more
readable, else fail and failed look very similar.
 
> > > > +	unsigned int len;
> > > > +	int i, j = 0;
> > > > +
> > > > +	for (i = 0; i < nr; i++) {
> > > > +		/* Detach the ith request from the vq */
> > > > +		req = virtqueue_get_buf(vq, &len);
> > > > +
> > > > +		/*
> > > > +		 * Condition (req && req == &reqs[i]) should always meet since
> > > > +		 * we have total nr requests in the vq.
> > > > +		 */
> > > > +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
> > > > +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
> > > > +			failed = true;
> > > ...and after failed is true, we are continuing the loop, why?
> > Actually this function can be called with fail set to true. We proceed as we
> > need to call i2c_put_dma_safe_msg_buf() for all buffers we allocated earlier.
> > 
> > > > +		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> > > > +		if (!failed)
> > > > +			++j;
> > > Besides better to read j++ the j itself can be renamed to something more
> > > verbose.
> > > 
> > > > +	}
> > > > +	return (fail ? -ETIMEDOUT : j);
> > > Redundant parentheses.
> > > 
> > > > +}

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
