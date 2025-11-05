Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F77262B
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377566; cv=none; b=B7iqgdtVjyhsusq2YakwGWPIOcQikgIyaEp2Bh2xbqi5tIT/bGldiUFyvpqvzvkUnlBJrxqsoCxNy/kiZMAGd0J5z2d/x+tVN3zekTCiz9rBAsvvcMlp09B97J+8wbJ0X4Rr9c2ecAIuho9Z8pxYxL9mluee2cbb1RGq3si2E00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377566; c=relaxed/simple;
	bh=qCj0HkjcLlvzURF6w77QHtU0WP9/ZsapXnXVQY35VDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij9Hu5tSp4KnwwceuAMXrox1vid/cl/J05KYJmzv9umWgJAKTQ/CYg1Ms6C9xq4PiyBsxWZivf98VDpYW5Dg0L2oPVNCbudiRO84kQ+f9FlU1diRuk/HKa1G/fB+bXZi7cBdFzokbEhccIf2RbqYVwxhpSl2c/FRkyZ3iIsU1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wfO7mSo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wfO7mSo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d67abd215so39425ad.0
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762377565; x=1762982365; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsPKARLgoDbiEbqdjmx1yQIPjPrrWc4YFZC2utX6iXU=;
        b=2wfO7mSoaVuOvGu3v8M2X73oY0Pan62oi//+FK3/9E3zsASyTMqNIWAhxfFj8lcYOO
         PQ9BWK/1+5MWmzQY4KUulz3t6C15qFbO5ZO66hZhVrcK4VsYWKMX3YCFpeqzagi07b9f
         rud0sk0IiHg0V1fNdwDCd9qvkITNuijSSmovOrSzN2LSvtm90h6cediNz783TPmaxQu2
         X0GG4vz61wDJ/m4ZYG22u6WTNPL0hzTpYrfgntJRiN8pv+ERQm4gsAmA+HWXEeb1tbR1
         0NPB243U9I/Ss7IUI8X0j5/+tyZIN9Hb3XtgmyX1KNjQ9DTk6wyo1zgmcag+elY0hxNH
         9U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377565; x=1762982365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsPKARLgoDbiEbqdjmx1yQIPjPrrWc4YFZC2utX6iXU=;
        b=ncYP08LkT6DqH6yFOCyDDpASrk/uhTZrZCjW72PhXgJv3l+NV0zMv86Es1T2JgHoCS
         RJf8jF6Ld1mtUKgAjfxIhBWTl9Xhew9MKpk3LVdxC/ZxB7WtseiH0ysOiVB3NQ2T6Wno
         1ZBE9sOb6LjfIMJ8+2gHz6gOBQ6nUMlyqyQ0v8eD48xEaYMBB/Dy+/YnBVLlxbnn6J6I
         Bqq6p7E6TNkhL0IHysQXa3CH0chLKBF2k1xZrlpRjtGN+yrgeyPDaVs4kv2nFmkHuGLO
         DDxlEjZ/fM30S/ZWCRCA+Tb658q7klbaq40RzQZSgcuprYNsFN6nvZm2Ro1RhmCUAs7S
         JCTw==
X-Forwarded-Encrypted: i=1; AJvYcCVL9sGDQn8iFffd07jhLLCTEQpJTmxYTTXRW+Ad9zsBNKzCjutva4JuY3uoVpPdRh791AIDU8CfZ/0vyN25WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7jtqvZfgVO0tBDZ/mfrtOvh+WFgjcROvCipX/LpPFL1sfjlg6
	lmB4kDt2sPMF65tP6cejtqe6InroeRGOLJLyKFLfBXjTCMFmHfzQ3W6j9HZtscxD6w==
X-Gm-Gg: ASbGncs9DUwRKIFWA4O911hPnZ9RpFRalNlpcAS3hHK+wIG6uhTQzmvYs/0N00vAQBA
	no7fIxPsoU0uO2WUCVJkO9Q9hnSFSwmys940yIbd0TOLXygEKclPOmfKuBAXSP5/FKXzlwBYM/c
	6jc5Y017IQ3+cHXd8J+jC5RLG41F7mfMptCYQ5S4kIFHF/izEFTJhyAN/crLtCwvbvmSCsR2xen
	IdgO61VIn7G16BTzra5KnPIwUhkPQw1o+nKEKtzjGQzjKSFnP2nVnf0YnpNndYCCFlXmJQ0QuC2
	xqT2AqaylRf2HdlUa4MP9OOjbaAVLgXik3tq/5mIggjr7qegOhSC2PtD+J0edor+LjfGUMXY8Rm
	RumW+q5WoNVnOXB2X+U5gVvQRav7RLVYX0ON6UwxKFduPIhg7zz+/PxA8G27sOqHNzPb3N2AW7S
	u98rKrcC7NV0AF/hmJ3w4yPbl6XQYZdSzEI+ZbrA==
X-Google-Smtp-Source: AGHT+IEIIO35cH2PrBkhqYMd/E+xZSf3lgI2yKX1DyfVtbO2pYBYeKyrnA3lBD1BQHg2AJrJT8JqeQ==
X-Received: by 2002:a17:902:d505:b0:266:b8a2:f5d8 with SMTP id d9443c01a7336-29655c7a119mr1205695ad.14.1762377564053;
        Wed, 05 Nov 2025 13:19:24 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af82bf14d6sm365224b3a.66.2025.11.05.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:19:23 -0800 (PST)
Date: Wed, 5 Nov 2025 21:19:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
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
Message-ID: <aQu_Uc_ZmBJUgw0_@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <14-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <aQhcOYVbY-LqOjW5@google.com>
 <20251105134829.333243dd.alex@shazbot.org>
 <20251105205600.GX1537560@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105205600.GX1537560@nvidia.com>

On Wed, Nov 05, 2025 at 04:56:00PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 01:48:29PM -0700, Alex Williamson wrote:
> > On Mon, 3 Nov 2025 07:39:37 +0000
> > Pranjal Shrivastava <praan@google.com> wrote:
> > 
> > > On Thu, Oct 23, 2025 at 08:09:28PM -0300, Jason Gunthorpe wrote:
> > > > Remove the fallback through the ioctl callback, no drivers use this now.
> > > > 
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > ---
> > > >  drivers/vfio/vfio_main.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > > > index a390163ce706c4..f056e82ba35075 100644
> > > > --- a/drivers/vfio/vfio_main.c
> > > > +++ b/drivers/vfio/vfio_main.c
> > > > @@ -1297,13 +1297,13 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
> > > >  		break;
> > > >  
> > > >  	case VFIO_DEVICE_GET_REGION_INFO:
> > > > -		if (!device->ops->get_region_info)
> > > > -			goto ioctl_fallback;
> > > > -		ret = device->ops->get_region_info(device, uptr);
> > > > +		if (unlikely(!device->ops->get_region_info))
> > > > +			ret = -EINVAL;  
> > 
> > Nit, typically I would have expected a success oriented flow, ie.
> > 
> > 		if (likely(device->ops->get_region_info))
> > 			ret = device->ops->get_region_info(device, uptr);
> > 		else
> > 			ret = -EINVAL;
> > 
> > But it goes away in the next patch, so *shrug*.
> 
> Yeah, still I can edit it..
> 
> > > Nit: Let's also add a warn/err log here highliting that the device
> > > doesn't populate the get_region_info op?
> > 
> > Are devices required to implement regions?  If so, it'd be more
> > appropriate to fail the device registration in __vfio_register_dev()
> > for the missing op than wait for an ioctl.  However, here in the device
> > agnostic layer of vfio, I think the answer leans more towards no, we
> > could theoretically have a device with no regions.  We also want to be
> > careful not to introduce a WARN_ON that's user trigger'able.  Thanks,
> 
> Yeah, I had the same thought, so lets leave this. If we do want a warn
> it should be in registration.
> 
> A device without regions does not seem useful, but also it doesn't
> malfunction if someone does want to do that.
> 

I agree with the both of you.. I just thought if we should remind the
user with a log that the dev doesn't expose a region. But I guess we
don't need to worry about that.

> Thanks,
> Jason

Thanks,
Praan
