Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B4AC433FE
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:03:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB96610D2
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCB96610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FB25401AE;
	Fri, 22 Oct 2021 09:03:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cyqcqgZUHrzG; Fri, 22 Oct 2021 09:03:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFC3140189;
	Fri, 22 Oct 2021 09:03:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC31AC0020;
	Fri, 22 Oct 2021 09:03:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41B12C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2915383163
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gschcgwPxrjL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:03:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D49D830C2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634893425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vlS6aml8LL1qZe5zkUk/1HXVoXarBD/8NvPesYzireA=;
 b=QHM/68RNwGIaBMjJfNw5FNOGHRmHsEg2wDphtkNYggsxecghxq1Glkh/5gMIN/psCaM6nH
 nOd3KmaqWnxPUU/OQ4ytjiycbwbUehCPG+g7uwqAgpMmnB4mcwIFoh0B+MWawxk346sxAB
 eT1Mcf8xGWnsW8bt5cgFMyeCIHDm8KA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-H-YxaEdkP3C7MUAdCc3LGA-1; Fri, 22 Oct 2021 05:03:42 -0400
X-MC-Unique: H-YxaEdkP3C7MUAdCc3LGA-1
Received: by mail-wm1-f69.google.com with SMTP id
 k5-20020a7bc3050000b02901e081f69d80so733818wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 02:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vlS6aml8LL1qZe5zkUk/1HXVoXarBD/8NvPesYzireA=;
 b=V745sgB+gEeYIxLyS32z4pJ5cti34ewdjTD2ol2paA9gEqS2fzdnLVK7uEt0Vz/hiX
 +K+533A2nSxkWFn+ZNAIPtbVFP1gmTTHnjRbIKR1HIKQw8Uvchwy5zlLrXLwR/1/11a0
 FQP6TTxvB1YrwcXumbow4BICC6g1OK4oPGoiFpO6tgS9C+aWVNTUbw3dFwU2ic7DWRZ5
 P4Kt6XGjT6In2+rdx760yfsno9W0YyPPuHDpexfJKmsZNEeRlEPPQ5f5qp+y2aRvEp+I
 wFDNTrDhEICi09XpA5+N5H0aUYQUvFdB/uH2yWLZrISbNvdukdtx4Uz0Qx13evqHj5Xn
 RZig==
X-Gm-Message-State: AOAM531htJ0pwqxg41s2JRlVeRYYkDjK/dL0f4BdRfjoa60/IU/wfO3N
 Db/nRMuedY8ZQ28KOKjejkuILu5LBrlg3CqSXI1eHmL7hPzZTaSQS46ORJri1quAaCjhpfOf8Wb
 tE8p918S2YhVEqULhMtziqHRtfMDLQzRw7wJmnkRfQQ==
X-Received: by 2002:a1c:191:: with SMTP id 139mr12823385wmb.186.1634893421629; 
 Fri, 22 Oct 2021 02:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgz69ZOr6NDfBcGs5kRzntTTBb/m5Ee6/7befhnYjWUjj9wGNPtMHwP34fX3HbNswLKjwtYg==
X-Received: by 2002:a1c:191:: with SMTP id 139mr12823362wmb.186.1634893421493; 
 Fri, 22 Oct 2021 02:03:41 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id p188sm3376289wmp.30.2021.10.22.02.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 02:03:40 -0700 (PDT)
Date: Fri, 22 Oct 2021 05:03:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH] i2c: virtio: Add support for zero-length requests
Message-ID: <20211022050222-mutt-send-email-mst@kernel.org>
References: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
 <0adf1c36-a00b-f16f-e631-439148c4f956@intel.com>
MIME-Version: 1.0
In-Reply-To: <0adf1c36-a00b-f16f-e631-439148c4f956@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, conghui.chen@intel.com,
 linux-i2c@vger.kernel.org, stratos-dev@op-lists.linaro.org
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

On Fri, Oct 22, 2021 at 02:51:10PM +0800, Jie Deng wrote:
> 
> On 2021/10/21 17:47, Viresh Kumar wrote:
> > The virtio specification received a new mandatory feature
> > (VIRTIO_I2C_F_ZERO_LENGTH_REQUEST) for zero length requests. Fail if the
> > feature isn't offered by the device.
> > 
> > For each read-request, set the VIRTIO_I2C_FLAGS_M_RD flag, as required
> > by the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> > 
> > This allows us to support zero length requests, like SMBUS Quick, where
> > the buffer need not be sent anymore.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Hi Wolfram,
> > 
> > Please do not apply this until the spec changes [1] are merged, sending it early
> > to get review done. I will ping you later once the spec is merged.
> > 
> > [1] https://lists.oasis-open.org/archives/virtio-dev/202110/msg00109.html
> > 
> >   drivers/i2c/busses/i2c-virtio.c | 56 ++++++++++++++++++---------------
> >   include/uapi/linux/virtio_i2c.h |  6 ++++
> >   2 files changed, 36 insertions(+), 26 deletions(-)
> > 
> 
> Acked-by: Jie Deng<jie.deng@intel.com>  once the spec is merged.


There's supposed to be space before < btw. and one puts # before any
comments this way tools can process the ack automatically:

Acked-by: Jie Deng<jie.deng@intel.com> # once the spec is merged.

> 
> 
> > +	if (!virtio_has_feature(vdev, VIRTIO_I2C_F_ZERO_LENGTH_REQUEST)) {
> > +		dev_err(&vdev->dev, "Zero-length request feature is mandatory\n");
> > +		return -EINVAL;
> 
> 
> It might be better to return -EOPNOTSUPP ?
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
