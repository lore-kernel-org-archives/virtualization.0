Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E61A2C15
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126332; cv=none; b=bxRWcEnkQg49zXYKLyuThjrMVPE03PwPbpIVDZ1Bgy6nH7zKTbi0FXgdm3vilV2IKDXAXkeS3SCUYl8tDJ4y2b4MX8f8bMg45zmNMIhJWiUxBInrpN+reDGLYNKVyW3N/vTkpcdNoivIvRF7OkAtHRgdWybKlI4oU7CVAl1uhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126332; c=relaxed/simple;
	bh=ylSqnLZbO+zia8UKjkEK25WV8CJGTqFaiaWW/u+DMEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiUExn5THXdemZaBJJmwyR+sVMsAmzw2VKZHY/kPtER7OWO0b8/lZRgYxFWPRG34Kak4CRWU1HmDhf/BlThX6hchyrWO1fz17HFAdvaRCopBgpK9IAvLkCwnGHDyrOFjBAqgfC3Gy8jtpQi1xM0rRTOYbfPPthSJmo9kAMer4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fLZ4tj7/; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fLZ4tj7/"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B76E060B63
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 23:58:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 14rH5dvw2DCD for <virtualization@lists.linux-foundation.org>;
 Tue,  7 May 2024 23:58:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BD1B060A84
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD1B060A84
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fLZ4tj7/
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD1B060A84
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 23:58:49 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3c98820fc2cso15060b6e.2
        for <virtualization@lists.linux-foundation.org>; Tue, 07 May 2024 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715126328; x=1715731128; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvtASyflOHvhyFKgb33ra88jVW8QAEN6i7T1g7ME2mI=;
        b=fLZ4tj7/cqfyrW3lnNYhJRaDqMGfmHf1whwz5tPEuOHr9IejMXCkjGVnAwHgeECKcA
         DIIKbzSWRGQLlUr93x1vuINl9tVAsZljQzcrqDAr/sii+rVGxoJXhwzWmF/1PyHDDdt1
         zwf8/4UXK4yoCAkQKNN5+RvcOY7q3Fkdd5HPOCcOB5BASxF5e4H6j58EEsDY6ldBz2hk
         kK0miL4wVSQQbO7MYbqCMhIhb8jqyCIQVcvzn+0cAegijPFrqlwwGN+bi3Bc841/CtHg
         oziTsT4LZlLakuxDk+1G+qA51/Q99QxzS0Xn7uIgZcLhwHSGBWYY9c6mc1LNmMVxyWiG
         /eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126328; x=1715731128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvtASyflOHvhyFKgb33ra88jVW8QAEN6i7T1g7ME2mI=;
        b=e53NiDGwLycBiECpBD0jqBx4Kc0eOnxI44jJBsc7XgoFBLWe82Af1gPfTLOUJJUtM3
         H/4ggTVvDC1Y4GaMT/6qZkONv+CtKE9QFiQrAGS4iEsB1avTq4uMZpk/cWX89bVBvIcS
         FPUSvuC1KcOu+o8djKtmzGxzC3BGb0g2VSZg3GekxIV8XIwoFsOsUnDwNHMqoGdd7Y7q
         HFhBrDs55IrhQSiluki/AZz5Y7KceRIMQUPF9hfNywcOSZvfRtAJb2uo8FxZIPvn3akk
         /iCyQrMXtKR8PfzGLM9QcuEFeNRh/H5kbVRyddFZ3RCImfKMQvVT0ohqMm5d9dLvBDt0
         CWjg==
X-Forwarded-Encrypted: i=1; AJvYcCVtEbji9YLrYBxisgFa9PEDBJxIglrjqcNppJV61xEEidQIVbnKe6Bf6z0EEtbzmKP87Nlazrm5OocVBITBa7xJZMPnQ2GtblHPL/YR6D39FnrR5uYkydwyzg==
X-Gm-Message-State: AOJu0Yx8AS6nIBx77uyRls1v1Pj0RYpxa9lL6QDe8iW8JVS9hpBLeSi7
	3jvoKkVB44uFntnNwujuA+HQnDbld1PeC3sC6VGn1Z3CXtO7e0br8fBZco5UNxE=
X-Google-Smtp-Source: AGHT+IHu9M7KtAnyALdrftZ/mWuRI60K3nPgZ0sthjqi//C4bjE+htSbFz1y13Y/VO1rSC947qc2mg==
X-Received: by 2002:a05:6808:1393:b0:3c9:66f2:f31a with SMTP id 5614622812f47-3c9852d5e11mr1317313b6e.34.1715126328537;
        Tue, 07 May 2024 16:58:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b00790f74b3814sm5340332qkb.82.2024.05.07.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 16:58:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Uhr-0003Vm-7q;
	Tue, 07 May 2024 20:58:47 -0300
Date: Tue, 7 May 2024 20:58:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240507235847.GL4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-3-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:03PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index da1addaa1a31..ae65e0b85d69 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -30,6 +30,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>  
>  struct iommu_attach_handle {
>  	struct iommu_domain		*domain;
> +	union {
> +		/* attach data for SVA domain */
> +		struct {
> +			struct device	*dev;
> +			refcount_t	users;
> +		};
> +	};
>  };

FWIW I was thinking of having the caller allocate the handle and pass it
down, but this seems workable too and is a bit simpler.

> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index bdc2e6fda782..b325097421c1 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -106,7 +106,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
>  static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
>  {
>  	u32 pasid;
> -	struct iommu_sva *handle;
> +	struct iommu_attach_handle *handle;

Though I'm much less keen on this..

Maybe

  struct iommu_attach_handle {
  	struct iommu_domain		*domain;
 	union {
	      struct iommu_sva sva;
 	};
  };

?

Then container_of(sva) to get back to handle and keep the meaningful
type?

Jason
