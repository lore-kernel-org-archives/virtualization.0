Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39EC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 04:38:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB49D613CB
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 04:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB49D613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68E74835DF;
	Mon,  5 Jul 2021 04:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4pfETydWeVRe; Mon,  5 Jul 2021 04:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 272D3837B6;
	Mon,  5 Jul 2021 04:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8E82C0010;
	Mon,  5 Jul 2021 04:38:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C61FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0EA240270
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NStbfzzTy_2y
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:38:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D12AD400B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 04:38:44 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 h1-20020a17090a3d01b0290172d33bb8bcso1561317pjc.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 21:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9P2iB/sAd1xmJMgbCZUej24RLFJsagtt1uS0tyR4q8M=;
 b=w2USAZ+ILD7DA3N5p2ftBJv8i0VXUjV8GESTg1sd/GdNGz+szkvOBjCkqy4uieeacq
 yuHsKRxPBIfIuNdpT9RHjEcwAlVMrrBeDSXZOcXLwoYnQ2q00DBngXc8dKIP/tE7R+Cl
 ql5k6+AyoWcCAEa/PdZWeI4ReVBr8J0bXlZBpZaChM3YI3jQ00sU3WRyU5xwSWAUPdv8
 FA0cuLoHurAmzUXeKsIqWjlcR3Z3mSYDgM1+TaHxgmc7ZQK3su9Y2A9/SNzG1b7283hi
 8+WcSc0ow4mNoffPvJFFgyvCVhdMqpBdp8np/3HfPnVBWqCgU8GxOuvBf/53g2p9QeOD
 LWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9P2iB/sAd1xmJMgbCZUej24RLFJsagtt1uS0tyR4q8M=;
 b=d9iPK6LFREz4LzRBfzDEHUapt6YXaDcHqdPpdZa0DDgAvc+cG6i9LFSnafakKDvLtu
 KaowkHFiK/ZmNJG9ZR2JnnZbHueQtkdxzirdr7OI4rnpRHPyMgXUO4yfcPg+UdyFJwpr
 EtLLHn/y1PqopUmzsTsdBrt9kTaX5nNKFlBxUpOsRuY6pFce40DchurdFj1rtlqkPMhn
 oIch/nLdTXCGr0+9fCIHlpqDy2QaJ8MRhouv2TAMNZP/RAvzdKvWVxU27tAjX6LN+uZm
 qJSkUhYMadEHtnGrxpLohfpuUfZIrMMmxGnd35qZrprqqCBOkGSBYCr/eb7FA0aC36nP
 eUDg==
X-Gm-Message-State: AOAM532FmGyUK2fMTcW5vhKRU+dMfOPwjV5+STYbkodAh7vLz1GZz/Xa
 GLuqsGNV2IkZVY6kNL1gmaotKw==
X-Google-Smtp-Source: ABdhPJwEBRMtpmK0GGKvqO/i6O1rTEesHaW5t2Hr81oWZpzVJ53bBl9mHEGFdTTK+WdlprJcqIzZcQ==
X-Received: by 2002:a17:90a:8e82:: with SMTP id
 f2mr13568598pjo.177.1625459924145; 
 Sun, 04 Jul 2021 21:38:44 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id l12sm10902491pff.105.2021.07.04.21.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 21:38:43 -0700 (PDT)
Date: Mon, 5 Jul 2021 10:08:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705043841.zujwo672nfdndpg2@vireshk-i7>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <20210705024056.ndth2bwn2itii5g3@vireshk-i7>
 <332af2be-0fb0-a846-8092-49d496fe8b6b@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <332af2be-0fb0-a846-8092-49d496fe8b6b@intel.com>
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

On 05-07-21, 11:45, Jie Deng wrote:
> On 2021/7/5 10:40, Viresh Kumar wrote:
> > On 02-07-21, 16:46, Jie Deng wrote:
> > The right way of doing this is is making this function return - Error on failure
> > and 0 on success. There is no point returning number of successful additions
> > here.
> 
> 
> We need the number for virtio_i2c_complete_reqs to do cleanup. We don't have
> to
> 
> do cleanup "num" times every time. Just do it as needed.

If you do full cleanup here, then you won't required that at the caller site.

> > Moreover, on failures this needs to clean up (free the dmabufs) itself, just
> > like you did i2c_put_dma_safe_msg_buf() at the end. The caller shouldn't be
> > required to handle the error cases by freeing up resources.
> 
> 
> This function will return the number of requests being successfully prepared
> and make sure
> 
> resources of the failed request being freed. And virtio_i2c_complete_reqs
> will free the
> 
> resources of those successful request.

It just looks cleaner to give such responsibility to each and every function,
i.e. if they fail, they should clean stuff up instead of the caller. That's the
normal philosophy you will find across kernel in most of the cases.
 
> > > +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > > +				    struct virtio_i2c_req *reqs,
> > > +				    struct i2c_msg *msgs, int nr,
> > > +				    bool fail)
> > > +{
> > > +	struct virtio_i2c_req *req;
> > > +	bool failed = fail;
> > > +	unsigned int len;
> > > +	int i, j = 0;
> > > +
> > > +	for (i = 0; i < nr; i++) {
> > > +		/* Detach the ith request from the vq */
> > > +		req = virtqueue_get_buf(vq, &len);
> > > +
> > > +		/*
> > > +		 * Condition (req && req == &reqs[i]) should always meet since
> > > +		 * we have total nr requests in the vq.
> > > +		 */
> > > +		if (!failed && (WARN_ON(!(req && req == &reqs[i])) ||
> > > +		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
> > What about writing this as:
> > 
> > 		if (!failed && (WARN_ON(req != &reqs[i]) ||
> > 		    (req->in_hdr.status != VIRTIO_I2C_MSG_OK)))
> > 
> > We don't need to check req here since if req is NULL, we will not do req->in_hdr
> > at all.
> 
> 
> It's right here just because the &reqs[i] will never be NULL in our case.
> But if you see
> 
> "virtio_i2c_complete_reqs" as an independent function, you need to check the
> 
> req. From the perspective of the callee, you can't ask the caller always
> give you
> 
> the non-NULL parameters.

We need to keep this driver optimized in its current form. If you see your own
argument here, then why don't you test vq or msgs for a valid pointer ? And even
reqs.

If we know for certain that this will never happen, then it should be optimized.
But if you see a case where reqs[i] can be NULL here, then it would be fine.

> And some tools may give warnings.

I don't see why a tool will raise an error here and if it does, then the tool is
buggy and not the driver. And we don't need to take care of that.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
