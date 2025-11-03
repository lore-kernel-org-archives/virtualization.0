Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4642C21CA
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155591; cv=none; b=hbFQLMuTcMa/MaZCWHwZDZrJOjdfSAxem2vsC2NwlvpzyFlajMkszVfdC9WR6/dDannemc5op5/O8P7Rlh2eA0Z0QH6oV+Ae8VpgqJMxW9l6IQKmavdjJy+BWpfBhsHfrGzK/uNLEjYHaAgR3PWYBmpvTgbhhCWyHak64AwLXn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155591; c=relaxed/simple;
	bh=30R4PwwoDn0ue1N2GS0GOY1SWIFA7GBPa8q4kx5mc+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MROv1cPa0O9yoGNsYUWX7EUXli4BWCipn4hb8JUKTUxSDkugUHROr0KKB6BhxCeKy1BW2LBdnQYD1KJyKzxYZnKHB5wuT8Htwk9EiUir6PrxxEGT2qxzFbNFiAQjnuKPSnLbYu+hGe0+FeCgU9jwW9Kq7AJ3dAPZzwYb7Uvcckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjRsGULq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjRsGULq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-295c64cb951so89435ad.0
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 23:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762155588; x=1762760388; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzwh3KfEQpKPksD5Xn4ZAd8EEqdDZL8lWisUmSvX4T0=;
        b=BjRsGULq7DgerW7LBG4GUfrwkuPLwnyBpFI6ejm2GJcDVZVK6Cj4rg+t1oE+QAhJne
         clpio00o/XqQbT3h40xsHwjGh6k9f6fkvdFnhjwSmp1SebPwoBG4Mwi8Aw2uz6U/eYKH
         UToQUsLAwrKVSy/YEu43ryGVzFdbu71tJ2C2dAmLGN644hBIMbh4oPwfsc48hBfTZR0l
         7ftYbk8Ta0I100LnOMZJ4pU2smuzLHgm76CCEGf+MJF+HTsMp4xezIX8c22bO+QAKLhz
         3MzNFDIpmF/Kjn956Xzq7DFKGik6H39ouI8jCEY+oPH8WmUCKC2xzCunGvPiz/7RLyII
         CAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155588; x=1762760388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzwh3KfEQpKPksD5Xn4ZAd8EEqdDZL8lWisUmSvX4T0=;
        b=dhLj3T9oxgPCb2PR48xnarZJ288qvJ1g9eDXUZkT5LYUcAWFxYQPlLdFCycKIG1pzU
         KsqseyqGA8aUeYGGDQYgMrS2til2GVtXGiCMZ14l428dEOxbxPh6NDoacoAsRx60Vn30
         cn5a4B4nfFmKHkzlnwJdsVTRuRmS8gSOrrTzNAqJlyyzRR/BhtzUiAE3CORi1SbrOswF
         GDHZeIT6iQ0y5X6A8UA4EMx0EbbRgTdgrJPfolo2tOrLsh/D3c1LRuDdNLt4hJxF2y+9
         a4IMeY7AWizqmA9G/YRfr7fVRGS3V71qorei2pDE5XhEUqcQ5l46GvX/XFbPTyxG3OkU
         hG+g==
X-Forwarded-Encrypted: i=1; AJvYcCVnlFiGQnwMnAkjI/qPuLvNBu6eLtKKmrwPBm1OGCzBE86bXJgNQYSY5sGNwIirBkzhAs0cIeBBkd6AwOhszg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9v/Ii1gUVYFc+1AL5+L67jbQ1OuR8MkjmB5MVuM4QBooPGRti
	WumYXRmGmvI85f/JPULRHtbB63P9sdnFHkeH+gEf83mmqDx9g7euNmYDGNNbca0E2Q==
X-Gm-Gg: ASbGncvv/djXFsuY9HLQBb0bA6Ro1t83IWuK++N//Y0rZ4aVh3BbfQAyy8Oqb6SIfb3
	7sC87Y0koYuWW871XO8UAglF6LpRVpKunvR6c5LK2k8OuwEg0ObERWO+t3wSY7BkFHj7CXUlIgx
	YpDOpmS2edI9Fd6F635cLjMjIkj9cA/rL3sUMR5hSuSMHhqeYglOQAwstSrrFlo8p1kVIeTr0cj
	kTf+DL4vC7/n3ZhOx4aB59hO+0JRNRxOACv90q7yRpMWdQUOAQMoQ6fePHlvk2rvMNC7jZRyPDl
	BZwW7qcjhf9MeHqiQjRk4bSV1NfU6Myc8jH02y+c4WiFT8SCvUd/8HI7ANK2Ww17Tg4HH04WYzB
	RxZN+KNqqYmcUykpoXVfctPD25D2CtvYVIEmgDdFgYRtAJ4qekS4grUcgAMZovi5W0jstz8XZae
	C1Dd5PULecWZpV92tE6vC1MLKsRMfI3mVDsFIOmdPgZx7Z8V6t
X-Google-Smtp-Source: AGHT+IGoX/eRPHIgiRFzzACV20d0ftHJvRprPrWC1Oq8kyrn4muK0Mu+0fpj1flmH53tBH91iPLzGw==
X-Received: by 2002:a17:902:ea0d:b0:24b:1741:1a4c with SMTP id d9443c01a7336-295549f6bcbmr6601575ad.0.1762155587782;
        Sun, 02 Nov 2025 23:39:47 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952e9a399csm102714425ad.33.2025.11.02.23.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:39:47 -0800 (PST)
Date: Mon, 3 Nov 2025 07:39:37 +0000
From: Pranjal Shrivastava <praan@google.com>
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
	Halil Pasic <pasic@linux.ibm.com>, qat-linux@intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 14/22] vfio: Require drivers to implement get_region_info
Message-ID: <aQhcOYVbY-LqOjW5@google.com>
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

Nit: Let's also add a warn/err log here highliting that the device
doesn't populate the get_region_info op?

> +		else
> +			ret = device->ops->get_region_info(device, uptr);
>  		break;
>  
>  	default:
> -ioctl_fallback:
>  		if (unlikely(!device->ops->ioctl))
>  			ret = -EINVAL;
>  		else

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
