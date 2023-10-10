Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CA7CD80D2
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 13:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 767C2821A9;
	Tue, 10 Oct 2023 13:37:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 767C2821A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j5LsjKIP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u9iatOClgYXV; Tue, 10 Oct 2023 13:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8FF88215D;
	Tue, 10 Oct 2023 13:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8FF88215D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76AE0C0071;
	Tue, 10 Oct 2023 13:37:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2093FC007F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A93A0417D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A93A0417D1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=j5LsjKIP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_EVdUYv5ZKr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:36:46 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEC1B417B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:36:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEC1B417B8
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40537481094so52699955e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696945004; x=1697549804;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BmUolm1QSdNeTrqOVAQPrq9kGFBVTiJa2lpVnk3jmBI=;
 b=j5LsjKIPnqAyeGa5r5yqN6yiFd/06tyKnR3NvhY6i+ZBvXB6mvA+eXpLEhdTFH4w89
 g4XSPNdXUe+ZBGwQPZePRsjKYLHInf/2+oXEYdFSHJGYxhyBeZNyS4Mdk0aT/dMF7F/J
 uZL33dufA8AlVTnrtdJR7RJl9XGwEkNCinU6bwK2XvuD+4Wj//+FV6PEkdb009swLvVq
 wOzJ77XW+hRAXIPXLW7OxxWJwEHLpiOjZ2H37oBRvAnYfyRvBkdPK0Uy1PyVPSMklJ6Y
 8eb5LfutclvvGi5whiaVi9y8Iig9BEWVecz0aou4ISWwZIDdwaNmEmTPei4C5Do5tTwN
 GuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696945004; x=1697549804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmUolm1QSdNeTrqOVAQPrq9kGFBVTiJa2lpVnk3jmBI=;
 b=OLvCWmbwwUXfOp/N3zwwskWaai/UWLPIHPkOiomNLJb85WgSZlNuksWFU/CaphvaCE
 lGOznoX0QcdpWFVWVZgwDtLc/O3yQie591o4wOebURFqEpTv+tbvMHh0cLm2FHg9GN5Z
 e/V69Ie1vcJFObGEr9HqDanBJolESyP1NJBGGYYo5/IbYVA6FuCHUt8+izC+zvNs7Hfc
 g46L+FTmsWa2yrLYDE/YFyKvte2o4o78nkEp12A62mXaS9SxpGBk6k/0jL00lBYG0Fjr
 fhcZzu7naEdPhXtO44Ajqly+ePD1NqQUkMaUQaO/AkwuN/RLDFexiPS0oZNo74L+4+g1
 FGmg==
X-Gm-Message-State: AOJu0YyF8wCNNTj8Z0C+WzXAZKlcNIVboeHdseiRbmwg0Xxxwqm+XxFh
 +aCSAn17BHfRLKBEIR3IdKmAJg==
X-Google-Smtp-Source: AGHT+IHXwKtrRxLqgdq4AfzMyWp6S9vbUS+FM9ayQpgPUAK4Eah+7xzWBZhlrzBTdjuZoJ3DKx6Icw==
X-Received: by 2002:a05:600c:224a:b0:3fe:dcd0:2e32 with SMTP id
 a10-20020a05600c224a00b003fedcd02e32mr15632141wmm.19.1696945003617; 
 Tue, 10 Oct 2023 06:36:43 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b003fee567235bsm16493195wmk.1.2023.10.10.06.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 06:36:43 -0700 (PDT)
Date: Tue, 10 Oct 2023 14:36:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <20231010133649.GA2902909@myrica>
References: <ZSRFW0yDlDo8+at3@work>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-hardening@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Oct 09, 2023 at 12:24:27PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..379ebe03efb6 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -85,7 +85,7 @@ struct viommu_request {
>  	void				*writeback;
>  	unsigned int			write_offset;
>  	unsigned int			len;
> -	char				buf[];
> +	char				buf[] __counted_by(len);
>  };
>  
>  #define VIOMMU_FAULT_RESV_MASK		0xffffff00
> @@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
>  	if (write_offset <= 0)
>  		return -EINVAL;
>  
> -	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
> +	req = kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
>  	if (!req)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
