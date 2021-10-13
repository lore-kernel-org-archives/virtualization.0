Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D9C43219
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:00:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE3B61100
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DE3B61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 664D0404F3;
	Wed, 13 Oct 2021 11:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-Eu4u7I3Yyl; Wed, 13 Oct 2021 11:00:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22DE640463;
	Wed, 13 Oct 2021 11:00:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EADC1C000F;
	Wed, 13 Oct 2021 11:00:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 702A1C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EF2381C81
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1vSIT968GoeP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:00:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B690480B49
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:00:15 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id m26so2123866pff.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nQQWQUgxuW6Tu+PRvCtkwuIVHgAhZ7y427FiGzCqW1I=;
 b=zuDceFqPkzhsXg/5Ra0cCOC1bU0nBHOgMC+yisKtXJINh/T8f5KQ5Xk3tN1hEQWy1f
 fF/5Ti7SlnxHTZ8CRdyv6Jl7qV6+yL697U37ZNkhKajiI+l/0MJiVPCdQ2f0nPB60e3l
 deL9dfPtSkXLUF1i0K5lBK/jrlNzSLsedO4pErBw8lcHrmTQsFpVw/Kq9PVvZIU+2X3S
 BjO3inmiQSb4KC3RcJr5s4SFs01LRfMOjiO3Y4IdS3Rj0CRwh+XHIqdFiSxlkBam0yxV
 rxKuYNPGd/pLOsHpTEsqWBSUGsQm4kgH2TClaSNsf9ya4bJIDlxKTpNOca2+BLM7jp/t
 D1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nQQWQUgxuW6Tu+PRvCtkwuIVHgAhZ7y427FiGzCqW1I=;
 b=FIPkYQzofo6ZXOHLl9R/PtdJdY59DqhoXyAXiTqUC0H0gHmJlet+qiPqzcPUCPik/i
 UzWmpBcvhLmCgpEPwVnOE3AkMhoJoftVp3GpGLpGkhCNU7cfZ6SK9DD5ZOWB5VRLrEqA
 UNoo5vXuB0Q2ENIDg4TDseHK45NBDhoA2AKCFCVbsKVS4vAX5ezS8YHbCY0AhNZN6brI
 oXlBASf0t76eu+h70zTRuz20J4pToQk7P1aIuK8pAYK4PVVOFt3eP/n6P7Pn78S2lRlL
 jC3qdsmayiQiTxW0SAWGQVjrOrgeVZM9zhkjFXE8b7/Jb4zPu6zyzGP7BoloEQP1/DQA
 a5Iw==
X-Gm-Message-State: AOAM532AjsdYD05/Nj3MMCAdvNNXW2vkxAcbynTZek/4rZURpnnI0Chs
 1py3iqkNaOt5qg6N1O9afSM9Zg==
X-Google-Smtp-Source: ABdhPJxhzjNSoABq+dGG77CzsRDyX+40KYVEdGsQI8qW5B1JHU6i8UmOJoBqJRMmoCIvhAQ+em8rxg==
X-Received: by 2002:a63:2dc7:: with SMTP id
 t190mr27705777pgt.455.1634122814960; 
 Wed, 13 Oct 2021 04:00:14 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id g189sm5284657pfb.75.2021.10.13.04.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 04:00:14 -0700 (PDT)
Date: Wed, 13 Oct 2021 16:30:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <20211013110012.3exppbls2wggqfhb@vireshk-i7>
References: <20211013105226.20225-1-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: nvdimm@lists.linux.dev, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Viresh Kumar <vireshk@kernel.org>, linux-remoteproc@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, netdev@vger.kernel.org,
 linux-scsi@vger.kernel.org, Will Deacon <will@kernel.org>,
 v9fs-developer@lists.sourceforge.net,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org,
 Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Takashi Iwai <tiwai@suse.com>,
 Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Jeff Dike <jdike@addtoit.com>, Vivek Goyal <vgoyal@redhat.com>,
 Ohad Ben-Cohen <ohad@wizery.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 Eric Van Hensbergen <ericvh@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-block@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-gpio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 "David S. Miller" <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>
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

On 13-10-21, 06:55, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/gpio/gpio-virtio.c                 | 2 +-
>  drivers/i2c/busses/i2c-virtio.c            | 2 +-

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
