Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC12FF144
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167141; cv=none; b=PhWFrfHXFidXYC0OGv+6k0bsgnEgwo2fcBovjJkTUavTUznjwe/MC0Y338oQerG2lc31d4ScqRQAokHHINm9lIENpJuy69TAn7+uShZWYP8Mtsx81EvJfZt1zldP39wZNKSSzf2XG4YBVTjA/OBsajXlp7uNew9SQrZdzP8hmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167141; c=relaxed/simple;
	bh=mvE+DUWqyOq8EZSNgDW4VO8ZUoDnjwG4bmh01CUVPv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZkNWtXB6gtxnUDoQi6utVc0MjAhDO16Cn6W0xa4wCkQlRWObma/ic8QiCeASMYMeQocvfpDsWXLWyk0dhH7I+S8JF92uKDCBCKGQEyf06wfrgYw5nbK2PwbVnAKRMM4mlE9IxOavLhv1bQIwQKOjMZ8ADeh2FJUFmwrH0XsnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ+l+MZz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ+l+MZz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d67abd215so423875ad.0
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 02:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762167139; x=1762771939; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwKprwTirCt4i5Js91Sl+ZyTThwVs5kTlEuvLY+kPJk=;
        b=XQ+l+MZzCuJ2wydGz63KO5Z67ON3Uw1XXsrqWfNQUG2dRGh5NoI0sngQf8qWFUnABV
         l8Kjf7GABv+gCJJmQf4db7i+wimo6F6p3DXI4pquxCbhDgCGPQqaLo3AyCFGcoWhvRUg
         Gi+ERnfQ8gB37gZNlhjq9D6LvbmbKPgtKtMZ2w9q2WM5QY+AZzWlEb5LrgivQ9DiWzap
         +vOSZxMr4/xkZKvtgyvmzqe8rAsjjFjPTujDph7WIJeHPCVTqqmQVea1YgawI4kSSw4Q
         CpxQQ1Y0qdzpKCj8xW8b7fB4vMGcHX8YJdnv7vji9p4ZVSr/8orBNoCTCoL7/+LCYD57
         kmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167139; x=1762771939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwKprwTirCt4i5Js91Sl+ZyTThwVs5kTlEuvLY+kPJk=;
        b=LmG1cujIYXOZIug4938aaVZUdUtREnPCZwCCHxo7HdXn9qsMid0dH6O97tI+tDq+4V
         aZXFGlnf9YQ2PK/OwjrXIyDp8l9xtxxkni/NSv/5MWLPYRiyaGS/W/fjalkHwqYm9d/U
         Vcf4DI91qEOAcANECE7Sq4jeMspEz9sq7iyn2++GYjtSTeY+CpmQjVaP6eYCOvVgutfs
         gvgCyjf8XIgWbWXx9X9lY6s2GklF+Wy+Ni3864UYq9Sa1910lz71DU9TY/katKD3645H
         1gyvyZnsBKzCvp16NHPQsc1JEO4JxWBdMzbPsgJo/3F5t7z45PluXjg7f1Lq1GurYODM
         xUtA==
X-Forwarded-Encrypted: i=1; AJvYcCWXG4KX3oNQ2X1XqVlqVPjKow+2yWREx+6gdic4wi0Dd0KrJ0UsTvJ/ODrZyvZn1+bHNoMQ+o4EA2uqaIDQVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLAtY1eX42K9tPOEQFEcn48ZtrMTBvryhlXtdVx2hUCu7/rm8k
	h3kZ8jWQOoJFzCXTXTl24/y4Zk6n2etQokq2M95EAxD+EdQockv6w/TGzAL73Hu/Eg==
X-Gm-Gg: ASbGncsKTFA13HHxmz6oY+hpmPRVwczjd0N37mbSAUaa/ScFRazVdQZLgCu5AN+DYQc
	bD2j7zMv/xmRqj/hLmH5fmQFdN2/EWUlOQpf5IV7MCQQ/VHxIGfS7K9tWuiibfx1Rvl+7mYtuSb
	kzbo2iV5aoghzXjOfSa8NjsOJVLuWuEX1hdQl2Ybtm3xlcr4fCC/ADrCWhHBcuQ5DyDnJO3YcVk
	kp1X7BPzIXFwth7dMrDEXUXLETi2/s27hjY0vU+qKHhVq8ji39tzL/UdsB7nrbXSaDaz/yd5obj
	4c685lioE68vS8BWxcdAGCvNJj+ADyun4QLSgjrcnn0HgOZPK5Pq6/6fBgcKevurO73HQCa7s3P
	MqYt4fQdynXEs7GFcsZIqQVmqhEUQJe+zHBZwnbfeA6MQ94jtPZ9MgohqnjWhLwKgC4krNpBnF/
	kupvZcJDFaogmC64p6ebL1puH/jyUjrz8loruFAg==
X-Google-Smtp-Source: AGHT+IHPuCzOHK+gl1PDmhIoWt8nQcQHNMFtOu890fqfdIsVUQlawn89pKWjl6bN9nnq4lv2uM5QPg==
X-Received: by 2002:a17:902:c411:b0:295:3f35:a315 with SMTP id d9443c01a7336-2955658e37fmr6124875ad.5.1762167138172;
        Mon, 03 Nov 2025 02:52:18 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415994181esm651172a91.5.2025.11.03.02.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:52:17 -0800 (PST)
Date: Mon, 3 Nov 2025 10:52:07 +0000
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
Subject: Re: [PATCH 22/22] vfio: Remove the get_region_info op
Message-ID: <aQiJV4p3AKZSDH08@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <22-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:36PM -0300, Jason Gunthorpe wrote:
> No driver uses it now, all are using get_region_info_caps().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 50 +++++++++++++++++-----------------------
>  include/linux/vfio.h     |  2 --
>  2 files changed, 21 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 82e7d79b1f9fe2..f911c1980c9420 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1263,48 +1263,40 @@ static long vfio_get_region_info(struct vfio_device *device,
>  				 struct vfio_region_info __user *arg)
>  {
>  	unsigned long minsz = offsetofend(struct vfio_region_info, offset);
> +	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
>  	struct vfio_region_info info = {};
>  	int ret;
>  
> +	if (unlikely(!device->ops->get_region_info_caps))
> +		return -EINVAL;
> +
>  	if (copy_from_user(&info, arg, minsz))
>  		return -EFAULT;
>  	if (info.argsz < minsz)
>  		return -EINVAL;
>  
> -	if (device->ops->get_region_info_caps) {
> -		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> +	ret = device->ops->get_region_info_caps(device, &info, &caps);
> +	if (ret)
> +		return ret;

Shall we kfree(caps.buf); before returning?

> -		ret = device->ops->get_region_info_caps(device, &info, &caps);
> -		if (ret)
> -			return ret;
> -
> -		if (caps.size) {
> -			info.flags |= VFIO_REGION_INFO_FLAG_CAPS;
> -			if (info.argsz < sizeof(info) + caps.size) {
> -				info.argsz = sizeof(info) + caps.size;
> -				info.cap_offset = 0;
> -			} else {
> -				vfio_info_cap_shift(&caps, sizeof(info));
> -				if (copy_to_user(arg + 1, caps.buf,
> -						 caps.size)) {
> -					kfree(caps.buf);
> -					return -EFAULT;
> -				}
> -				info.cap_offset = sizeof(info);
> +	if (caps.size) {
> +		info.flags |= VFIO_REGION_INFO_FLAG_CAPS;
> +		if (info.argsz < sizeof(info) + caps.size) {
> +			info.argsz = sizeof(info) + caps.size;
> +			info.cap_offset = 0;
> +		} else {
> +			vfio_info_cap_shift(&caps, sizeof(info));
> +			if (copy_to_user(arg + 1, caps.buf, caps.size)) {
> +				kfree(caps.buf);
> +				return -EFAULT;
>  			}
> -			kfree(caps.buf);
> +			info.cap_offset = sizeof(info);
>  		}
> -
> -		if (copy_to_user(arg, &info, minsz))
> -			return -EFAULT;
> -	} else if (device->ops->get_region_info) {
> -		ret = device->ops->get_region_info(device, arg);
> -		if (ret)
> -			return ret;
> -	} else {
> -		return -EINVAL;
> +		kfree(caps.buf);
>  	}
>  
> +	if (copy_to_user(arg, &info, minsz))
> +		return -EFAULT;
>  	return 0;
>  }
>  
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 6311ddc837701d..8e1ddb48b9b54e 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -133,8 +133,6 @@ struct vfio_device_ops {
>  			 size_t count, loff_t *size);
>  	long	(*ioctl)(struct vfio_device *vdev, unsigned int cmd,
>  			 unsigned long arg);
> -	int	(*get_region_info)(struct vfio_device *vdev,
> -				   struct vfio_region_info __user *arg);
>  	int	(*get_region_info_caps)(struct vfio_device *vdev,
>  					struct vfio_region_info *info,
>  					struct vfio_info_cap *caps);

Thanks,
Praan
