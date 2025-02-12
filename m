Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBD211288
	for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387742; cv=none; b=ghuLFmiSQDyF88cgX+qNmwsbLPC23Rm9XA76DS9+VNNRsdoZrWEkhMSnlU94yHbc9KRMVTcN2kesTijMBTsMlxK9kUAZ+jGuyfYE6saR6Qadb1moHQdgB9mst8IX8Wtu1NPrBI7pRYe++tNHVKUI6D9KcB810ZPMNg25SifwFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387742; c=relaxed/simple;
	bh=j/MRe+mq2tPhTDU1WqstTBB8ACCVQAqwnxs28dXhnl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwsybKw0X0+/xtf9UICqWM0lZWE5+mG3eRE5EaJBQ+aGP+a2NUCQkC+DBycW3btu33j4PCdJjLzqWI4a1YlR0sYEc2wOmd42PjVn4wV4kInsTREIuL/05Ow4aK/Vu+zykBpOZEqq1Ewo1TdzCsXM+Ik6q2A5MeIV7O57VTQyaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kx7oIH3i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kx7oIH3i"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38de1a5f039so26909f8f.2
        for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739387739; x=1739992539; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HqNd92Cgc359wI1YLkJzjmHs2FZOPIccP/HZnTPHBgs=;
        b=Kx7oIH3ihwcKIn5LUll9lvpZpie65OeGeQL5/K2MJjZrYI1cPv2cGSoSU4ApEJGA7o
         TWgWsCkkxEUWLexkiAwlUrsEk5XS0+GGSboZWS5KmzyP2sX7rtUpKNaQKglquBQL6cmO
         v0TfWNZ8yA53UrhxYb7idFrAMgPR6/oZOJFBMMr+7YbQk5gzX1aYXzVkn6/Me+VKkyft
         /ahHgxDLwSHzw+oEqYpU5kQdmwtFyhZiOQnCtIU9y7hHADaNJQMr9kveh+zMkigihzhg
         5+9xyRiG0OUijc9R40qMAfoKdbtC4M+SQzRE0J1Un07Ot6nS+uE/7wPX4SodfQ2J1GMe
         wB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387739; x=1739992539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqNd92Cgc359wI1YLkJzjmHs2FZOPIccP/HZnTPHBgs=;
        b=tyzKCfRcW1mn9JHA+MqV6nT8rnXLRIWsglBAbGiF66G5l0Da9HNx42WWvXEO/O2ldt
         e3FBrFS8ekd5bl+t2R5+1uhM3ZO22llYEsl7PD3pvnkYJBa4vfRHXtTWj7zZxoCynV6k
         veVTnCSj1uJ7+GoYaPFYOc3oacvGWYspAQQ+2ZPb4twVBuGPhi2HojEzXkpBrXJEGnGo
         1Jc6wbU0KdQA79xpoCaP+Gf1Wbu6Oxbz68PFGSiP/qv71msKxJQ60dB+szlKT1kzpoEe
         AuyLozyJyIpwe23LqMwidupjT6OxPwMvz9Z+dhvvflxxkkbPstSPpbGnTUlPtcOR3qj5
         RWwA==
X-Forwarded-Encrypted: i=1; AJvYcCXhtTBJ/mZVAjsyW72hCz13GrRp36QKXhIEv7+23pwikagO/xZkPxLk6WoIp36iGBD+AohhRaUlUAvLNnvyww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzvggx7n+9/j9xJL0fD+INvPZYb1TMglP6cfLlIpjBNQQqdisx9
	b2WQvNP8LZ1h2vJ/YtzfFsuB8Io9vEhtJco9Rg8hH6EFIAh4BYZPSHpQh47b8IE=
X-Gm-Gg: ASbGnct7fYtaZHscCvj6MLJuVO7cy5qTPgcUEHL961irtdHDiB5nmBT6HHOiE99BjOq
	Dc5uLwMdTOrTaWKK7VMQ/J8QyHd4N2ixEI7o7fJsSSpAVmBNDaFz1yiMbce6VO94uJMdsIXkIcv
	n620ouC5wJKm1AJrblpxACfl4hs2Nyh9HtQ3eEm78tNpHIoDAt5BS2qVCpqPCueAErlACCcVFyZ
	FrhPNZ7mbTXKBKyt4qZeRx73FNRBpLXzDgbqrQKGHZjn00LvZrMqlMwxfwcS9XfwzvIDmVswjb/
	Zgo06GiEfx4WUA==
X-Google-Smtp-Source: AGHT+IGkzecCOJkuqQbBI6huzDaIBc5zvDDm9U/5OMf0bnMDKXZpSgMYgPel+hUwbay3rx6H0lyECA==
X-Received: by 2002:a5d:5f48:0:b0:38d:c9da:d0d7 with SMTP id ffacd0b85a97d-38f244da097mr707581f8f.2.1739387739336;
        Wed, 12 Feb 2025 11:15:39 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a053f46sm28934625e9.14.2025.02.12.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:15:38 -0800 (PST)
Date: Wed, 12 Feb 2025 19:16:03 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, patches@lists.linux.dev
Subject: Re: [PATCH 0/5] Convert virtio-iommu to domain_alloc_paging()
Message-ID: <20250212191603.GA4085684@myrica>
References: <0-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <67abee53.170a0220.154671.ae28SMTPIN_ADDED_BROKEN@mx.google.com>
 <20250212115845.GA1627174@myrica>
 <67acd4e2.630a0220.365aab.e098SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67acd4e2.630a0220.365aab.e098SMTPIN_ADDED_BROKEN@mx.google.com>

On Wed, Feb 12, 2025 at 09:05:35AM -0800, Jacob Pan wrote:
> >  Does reproducing this require
> > modifying QEMU or Linux to disable support for F_BYPASS_CONFIG, or
> > just passing QEMU/kernel parameters?
> I only modified guest code to pretend F_BYPASS_CONFIG is not supported,
>  a couple of places like:
> 
> -       if (virtio_has_feature(viommu->vdev,
>   VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +       if (!virtio_has_feature(viommu->vdev,
>   VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> 
> Is there a QEMU command line option to disable
> VIRTIO_IOMMU_F_BYPASS_CONFIG?

No, but I have a patch for testing that didn't seem worth upstreaming:
https://jpbrucker.net/git/qemu/commit/?h=virtio-iommu/bypass&id=ab2f435576a95914d2939ef4f0b190548721fe7b
With it I'm able to reproduce the issue, looks like I only tested this
case with virtual devices and not VFIO. I'll look for a fix

Thanks,
Jean
