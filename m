Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841328CF5E
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149489; cv=none; b=GLQnx0JyYmIGtmN/1g2K5Kfy+EyA8dNONSHG4utiy5uppwLyfukef96evSJtmiZzE9Onn2bq/Wz2JHUKd5Qeynl48l3u+sv6/ro9N5ZXq/iCEtn3xw2lKvl5aGpKug4es5G6mu5qOLtwoPOc+lJKwLW5olttxTlTxM5mHk95jsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149489; c=relaxed/simple;
	bh=COnfabRE25CHEyik36bmtXTyjtL97X8u2YW/C0gU2+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWgV2d10gI45UXOiK8xDZcGikR7oaNqCy5SC4uGUGGn1uO+q0cHXMEiIDMR03dRy6AfcnL84FFKeM6Sss8UBL3r2vPubjY6ZRTz2Z8EqCEHEfBYh5ToTq8m2KFjUZN1OfzhPxpP3kXMZzaB/5y3GH+8GibK2zuLVACuGMSeFmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6GPGEJB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6GPGEJB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295c64cb951so73685ad.0
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 21:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762149486; x=1762754286; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNN38kSQW+Z67K4qsM9EOBHtmYi+rj4bbcXqoaYoYec=;
        b=T6GPGEJBLVshs1WOyYAd/m0Cg9WEgR0Zi1WSAnkDInY5x7eTV1/b8b+fS+nFfyxZ3Z
         pvQzo37j+OY8dH7kRG1HQEQEJon9rKIobPc0TIePK41WCCbq2VbZYf3MqhuyJfzIEVBp
         o0A8Es2JcqFv71ydjILcaP+ncbb1scqH7JbZcipvLW7yjAgcn9NiK64dxoN2nxFkK8rW
         0Hl+MwuRiIsq2qKzj5IygVZeS1T7JzG2Dy/RFdcF0zi5htCdOYId5o2kzcmlNr+ME+sl
         DO0GKjbZjySIBsJER0RwSwiWQVjtdCE4IQcndRc7QrQfFw/6M+V5XDwF5LqzWaFyntb8
         +mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762149486; x=1762754286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNN38kSQW+Z67K4qsM9EOBHtmYi+rj4bbcXqoaYoYec=;
        b=hWq9bbNvhyOmXxaIYDdYoyQnHdNS2CK/n604ugY2/5g3DS88hzLJaYhx+GnEz4noru
         NKI2va5tMcDhjEqXBYgJV/H09o9jhHT1RWhBNlZT8tWvUbCiM8BC+ia7QierSkiEvYE8
         MBPfyJ1OERq8dY1bdW0+SpViV/xT8WueNMBpc/AayWdnMK82D/rt/AZNqY2zX26wPnQ5
         +QLXQSTKUpFVkAih1cnsiQhaRTx8QrHofN+AiWFxTsT3LR+tk/KXByMc6ytn5jyW87gb
         D+5stSBpxL4YSN54xte3rsNtJYRCumbpZbb2E1gOkRf00EvHhRIUUQE4VYHluEdJ50d0
         HRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR8VOxcbG9+EDJbbVIGoDxmCxyTEJAdcKkhxoAeNWvxgJXl1sgjzwt6VAd7FiFVHFrdhaV60yatVzVM+552A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbcSa5MzGpPTLQGukbyRA/9EGOLBP+CDw5TSTPXa9o2CGlJdAQ
	F07U/aoD6X/S8eE8C6HjjBxKkn9/zQhn7HRfoESLajz+a1bz+CPqbzQs83MrxHMnnw==
X-Gm-Gg: ASbGnctGXl+/ErDHArxnYuORtV/TvQigQhhBaO/+g/weTX1a3UiIRvHFCN1al4gm6pa
	iG/hGfo5N7Zwfpf9TGewgAvYBGzQGsU3EObxEyfDVuU1YXmIPeFUGToKARFD5yrjh6ow0tIaeBA
	RoP6bRrK4vaeLEAE0BIeTaakzOCiVZNKYbDP1wHl4J1pfBUx2cneqAhQ/Wr/0hRhkdpzD3EO6b2
	GlzdJecrQzpc6VU78COkSZ6aaWzwPxm7w1p+vtaMlxPCMS+QSMwWx4p+j/StvHrnblahdBRQ5uG
	JCBp8g0J5QgjlhJGNQ23zlfREXCOABmsG9o/yOJAGWSNd1Y3WZGyuQDgPDCTGonk56OPnz7Jmat
	c9/FIS3AIozeqGnn5R4QPALXU3JKoQMytdUBJnNg896LxX86eVDxwXVwSfh0jvm4enhRX7Vrvws
	x8NLqOeP73nck9blXciLNCYsIMjUb84Qm3XV2lrnwdZ5Y7axP+
X-Google-Smtp-Source: AGHT+IHe2S0n2gwZ091UPBX6ERfL1n+n8BtlVw9vlL1yBRvzccFZt3lfIo5NNtd6hxmzG7hv2JOREg==
X-Received: by 2002:a17:902:f68e:b0:295:5138:10f2 with SMTP id d9443c01a7336-29556599a23mr4787225ad.11.1762149485582;
        Sun, 02 Nov 2025 21:58:05 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f26e0a6sm5783366a91.5.2025.11.02.21.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 21:58:04 -0800 (PST)
Date: Mon, 3 Nov 2025 05:57:54 +0000
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
Subject: Re: [PATCH 01/22] vfio: Provide a get_region_info op
Message-ID: <aQhEYq9YVzbBlWnC@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <1-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:15PM -0300, Jason Gunthorpe wrote:
> Instead of hooking the general ioctl op, have the core code directly
> decode VFIO_DEVICE_GET_REGION_INFO and call an op just for it.
> 
> This is intended to allow mechanical changes to the drivers to pull their
> VFIO_DEVICE_GET_REGION_INFO int oa function. Later patches will improve
> the function signature to consolidate more code.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 9 ++++++---
>  drivers/vfio/vfio_main.c         | 7 +++++++
>  include/linux/vfio.h             | 2 ++
>  include/linux/vfio_pci_core.h    | 2 ++
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
