Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFB2BDC14
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155030; cv=none; b=JL2F2k9HtPu67ulTfd1G2prfRIvCRdxTi0NiRZAmw7gES0rx2GOsjVxmZTBzck6P5tqiGJ6083vQd7kPIZNeBMgDCbey8EL6v95lFa9+K/HFcugrd1GbtXhAoO0E44RtfU6y8iV5b8tEFdLsYFToPWm8g9cuojRxbsBV/hxrG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155030; c=relaxed/simple;
	bh=tcJ9j0rjVgX0LlfeiyBdhL1zp92EWqORHcfEAw97Bb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmreq00h6uka+oMchz3vMVR2CEM8kLBw/RKhm2v39mzCAEaU8X91L2sPRHRjGtmHXPnxCj0UhDTrYtp7OGPxBKCvj69h9FPZ/3k1e9PIV7GVMkJTGnWJyT9F3p1bR+v47Ij0UuLWWDJpTlik8OeTSxceYFAzdbTYwcYjQogv/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwfOJ+X4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwfOJ+X4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d67abd215so384745ad.0
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 23:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762155028; x=1762759828; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W00R51s/bFZ7FSKiqSW+6LDxOwjjTftHVYebWZvSUlk=;
        b=nwfOJ+X4u627NjUHasSTjSImso/7eKaviE2U/+lcgM4KRW2mrg3WLhk/361Ll9Nfst
         VoVJO9F/wtwZzjL6zo62aoo8xAWhrGlYDiLgrCTrDMQ0U7ocdvMdFbkgVBf22CoRdimp
         dMwp8SjtdISph9l58PepQyg8RIUeQCXlowxFx4+FW2qYymJWyGLQOr4xiIIQUGWRGXbH
         53XSPJHi7TIzyORDtjf5WV89b2+M/bOyMCRTeTp9TyMC7oWUr5FJqsyoKfZ3qbAV5RkJ
         pB5MikwFYkjfj8bH1btICMHJkbNBjci62cTlSpnOAsbiVDb2sVWOYKo0d+gFZrJVuXpi
         8vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155028; x=1762759828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W00R51s/bFZ7FSKiqSW+6LDxOwjjTftHVYebWZvSUlk=;
        b=YU1NX40qXoGNWxE6xWfL5MaokZ1fKxBJB1/OEQmAEcZGyL6O3+8CE4UPeDe0Bpi4GY
         6vEmq2vhj6E8RBYRd87CIHP7GZ29/A0FRtXVHqzEQuUctVWKY3orIIth38HF+YYwSErX
         kxHzDfHAfdg3xnIQl2r/qloyQpkFgwz2yqgne6UY8t+KPtZzOuvR9AHL/P43We//71nW
         srxUSXNmXwTibmNPZJp33YpnM6QOgng7FCGyRa+T8Aq3cYU/huX2M03OUvQUnYIDMoVX
         11/wqVDfJlfScEYi2fvtGJw/unX5ubiCWx78MwVPnVWJtCm5bwBB5AwQa3jnM6Xi63ls
         rHYg==
X-Forwarded-Encrypted: i=1; AJvYcCVkw2WtbWiXae9XL6+ggQ4zDSbPp5VPtTBOdiKB9B4vUWfi+qIyljMgz+gBdFUJ60si0GS9Zfi5w1HvDDB2+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2y37fh3odcowslGPKhpl1V9hP6tS9f6/cRtkaAznnZF7of6eq
	SzG6tBiVIsmSVJu5sZb4uAv5v4agnX6cKkfp29dS57Jv1KbpE4p3WmNwPC39ReiKIQ==
X-Gm-Gg: ASbGnctdgZQbvZ5eNzFIAIAK6EpdqPi9+huduCtsjsBHfZ8If9rSM9gFutdDKMAu/Ht
	LEa6GuYevQkhlhYCO07fjlRAU8CfnPxugWPu+rkEa0ez5+9lwkvhPog5U6MRgltxtMRgedtdlIu
	IpSgE+e0Cy84wtECeXNzwwyrpMk2johw73JP3EDJKNrJvIQu2I9akBiM/0mnFAIz1qTAeWHVhU/
	5Su37hkTtwOVgEzlHzRdnWS8uhYYNKcqmEPcAoE333RaCu6A37dm6bbUFKKWE6qFTuRYyMAHW88
	v/MN6u2n9cheiHv0j3qJJ8dBfOUojLSsXLPnobnkW5MV63tb2c6OVyrk3//Z2MOxImEAMyvnMnt
	JNnfWP6Xe15GAy7u6bpVUDw7qc4f4jOyj212DJlNNKKXwYXOSJEarRCNCDb9rUxPJFtW3O40hDo
	I8/A3DJcuJU1EtRlreWTij5imhGborM2MOUCJCrA==
X-Google-Smtp-Source: AGHT+IFjaXH+x0wDYP1YTleZ6beMQ7i4yOeGqaMcf/YJxMNIbFnQkDy7S1c8+nxpPDJ2MzqKvGx2GQ==
X-Received: by 2002:a17:903:1a70:b0:295:28a4:f0b3 with SMTP id d9443c01a7336-295549cab2dmr7007095ad.0.1762155027242;
        Sun, 02 Nov 2025 23:30:27 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340acfa77b8sm8320159a91.18.2025.11.02.23.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:30:26 -0800 (PST)
Date: Mon, 3 Nov 2025 07:30:16 +0000
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
Subject: Re: [PATCH 10/22] vfio/fsl: Provide a get_region_info op
Message-ID: <aQhaCAAliYQVNjgK@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <10-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:24PM -0300, Jason Gunthorpe wrote:
> Move it out of vfio_fsl_mc_ioctl() and re-indent it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c | 55 +++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
> 

Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
