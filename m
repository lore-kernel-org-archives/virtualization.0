Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB152F9DBC
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163744; cv=none; b=Y8hnSnZr1ONGnbsw2cn4ssp2JEc+2Xbns/WEjYSaQ3ALq5KEUtF8rRNeJLi9gQwMaQZmIqqJY83Hgpt9bfGgPLomQ/v9Mdu8EdzZtb8ZuLyRVsYsmy1xNosnzIF8Ilw1aeu9nCFNURaEMIKCo1NQtz4BjBoIp8S7YPKyIll3XTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163744; c=relaxed/simple;
	bh=i8L9n6bZwkPz17FpheWU6M/n9dfpcR4hkCB+s7fwei4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGdvxFD4+c5VIfp+d1ITCiUpGAghZaXd38p3sJQRajEcoPabLqYWg07iYHleXmbHVeXD36KrH3QmZYp9F8vSbMooOMgMOPKn7H3OuKTvqpMOq5+jhim22obUF9M88WNfEt2gn/WY/jVa1+MxLgpno4v47TWnxlGK1e8/lfAY9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJwzt7un; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJwzt7un"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so81185e9.0
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762163740; x=1762768540; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/iKwbtWviZdAY+4F++DJl0rWWY/RQA9LSGiuI2/hl/A=;
        b=TJwzt7unbMkp13Jw9k7vyRgWJIk+B2pigamOHsjV7onXWSM/m7WDqnHlVkuCxKq+iv
         dOX9KQf8qjUw62V6FIpcndKkzHR3Bii2lgcTERldtX5ZD2eM5IYXI+kqwXS1UCJpByX6
         TxDsj5oU6oKlpeD+sE5pJqQfPdRO2T3DfJjBs7pxPUYX72s3pWC8asEm1+VwQzjvRrZC
         18wefMNtORtrmqfFYjVS72374bob4uzpteJCCmM7kh2uCDTnTk7jLsoWRRfGPatvH7qX
         pEnt3LjhGNMkcV98qebimJP5b2EmQvDtyMHyQ//JIpvbX5EabeTOX4CtHpqGOF/n9lDD
         fDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163740; x=1762768540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iKwbtWviZdAY+4F++DJl0rWWY/RQA9LSGiuI2/hl/A=;
        b=FUIVHe2oRiCEdowpoSbXGsLVWl7br1rH30RltHG75HbMqljpSDC7dbUUGaWe3qMRIp
         TlXofUmq8RluAZ+c3f2G6n1XwRwVivWIHomh34aZXoqpPRJH7xvcQZCIxsy5hXIZO/aW
         K2mc4dm0tlwe+iSWyv4HSDQdkXQYWOkd9kyEUBJ/g+E1/mi4mYCf4RVrWZSTxQQq0odH
         CgJp2f81HkosAZ50pP6VYClfRSXL9GRyRmvsV8erA9CgS3zPi2bpX+lfJIHpjvG8AzV3
         HE3j9cKR53CJiJ8jJM1/9fTDdrafPWi6QSRNLiYQC3qqamOjIQGkOW0bREN/YYw+ab6Z
         TOvw==
X-Forwarded-Encrypted: i=1; AJvYcCUIgDRnU+wI1SJApa2M277bkDt5SRMcr1UwYB67B1JHut8FiML4jhC6YPx4G3GQZZgXFeFB6mRrlwyD86MJUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfxnzyiLybYQJEy1JWSecrQEiYJpbGQZtE9b6A/tqW1Q4K55Lf
	E5ecixNqO7WHelnXduqNmEf9n3p3DkM0lAJfPTKd7ym9oAK9dfmAE9Re49q0yo2ZMQ==
X-Gm-Gg: ASbGnct7oB3881iNq02cpm/6JcGORzGL1DBOM/c6QAgF9pz8oJ2AruuZfmUhhTLhpTU
	hNW3DNu914cUVE3ttgZCImxdAeTrFAOWFp7lsIKSDCdqFfmQXJJL5nngGDi9Tv0AABqwZK3giEt
	BqyfZ18Q1+nPoso7FkCjB5GnPLLJBrc4Y6veH1psKfW/8i6rg9xz+HXbt4rAX2qHaNlavyFTpHY
	uZrqr+8kmOgvPDSrOKTc49L4c++zIaZyX8SNitnZZniZBCuMx9kUDFMzMUxFMnY7hOE6r+Hl6K5
	OMoCehLMXgFsuZ24SjLGimbT916age4/nLaxzw7Pd83p00IiA6IJPilGxz33xhTux2j4mEOdwAI
	2+XmCqfRcjVxwpYwkdkwDZVDwqFhmSO/XIqTTs7PF/tQbuFfjNuRZ4vm4uScEPQbj41Mr51ZigI
	WnmXbkhYSM96uTwGlUnLiEs9eKLctk4Z+iHd7mRZl7rVZ8HZsFbw==
X-Google-Smtp-Source: AGHT+IHAx+AWORE9paLXTzRW7mKzqe0hb2wtQ9DF+W6v23M9Vo/fGIuffOpRO4zhYPoMBhdyXFmsSw==
X-Received: by 2002:a05:600c:8a0d:20b0:477:255c:bea8 with SMTP id 5b1f17b1804b1-4773da9baeemr5918155e9.7.1762163740369;
        Mon, 03 Nov 2025 01:55:40 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13ebfe8sm19975798f8f.35.2025.11.03.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:55:39 -0800 (PST)
Date: Mon, 3 Nov 2025 09:55:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	David Airlie <airlied@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Brett Creeley <brett.creeley@amd.com>,
	dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>, linux-s390@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Pranjal Shrivastava <praan@google.com>, qat-linux@intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 14/22] vfio: Require drivers to implement get_region_info
Message-ID: <aQh8GG15d_-Ge2Xx@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <14-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:28PM -0300, Jason Gunthorpe wrote:
> Remove the fallback through the ioctl callback, no drivers use this now.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/vfio/vfio_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index a390163ce706c4..f056e82ba35075 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1297,13 +1297,13 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>  		break;
>  
>  	case VFIO_DEVICE_GET_REGION_INFO:
> -		if (!device->ops->get_region_info)
> -			goto ioctl_fallback;
> -		ret = device->ops->get_region_info(device, uptr);
> +		if (unlikely(!device->ops->get_region_info))
> +			ret = -EINVAL;
> +		else
> +			ret = device->ops->get_region_info(device, uptr);
>  		break;
>  
>  	default:
> -ioctl_fallback:
>  		if (unlikely(!device->ops->ioctl))
>  			ret = -EINVAL;
>  		else
> -- 
> 2.43.0
> 
