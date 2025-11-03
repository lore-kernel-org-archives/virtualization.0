Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FF298CA2
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154091; cv=none; b=dD6mkPxPXMm98r24BKQ/aLEGudmQHml8L8fbI+SDUQeLThZYriUXFjRZN0uC6GiWIf6Vz8Ze28BxMxQtXdFNHXLGNXDTlubnciIwYK2crTYPr2GJ6nb1WzmKQ72AZgMfdcHfBd/svK48HzdbwlN2u9S/4z0cK29HhUx0czyWaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154091; c=relaxed/simple;
	bh=M46toCVjS5FqeK8M2CG3xD/T7DNTY+jrsL9mMEekFOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PInF9S1BoOd2CVooxEl+csCcOkprDsWVb6FC5ACIUCuziyuV4chHuerIpCyuzF1M3fCJYpyDW4q/cEun9wvMKNKmryZCaMYmQkCtH5OzUJZzKA4dkTT6UWnBuoN5o4W+HKLHUj/u4eiJbdTquMc4LFK2qWkAUPUYdlNsHB67kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXxIMuOZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXxIMuOZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2959197b68eso193295ad.1
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 23:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762154090; x=1762758890; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krxDO85tsubF5J6uxcbfpS+xA/eKw7o0+Vmbt9d1Ois=;
        b=fXxIMuOZp1iH7KvDYHN0tmyf0+kCvQ/tzIQU1LjCi7fkKxoEkF61YzhJp+Wte6zn7D
         9uPTAx8AF/e5xwUkmKlYIDcruLR4a1hF+rTkHBxY10hc60jDoO3Vx64rizVqv1edIPeK
         KX02WRpoPzxwG84D55PpXi12YQQjIedF6jS3lT0dH4kU4QF9tA9eZbxgx+JAUubeTU/F
         y94r3ARvNoPge9F7eUrmvUkvVB8f9nOKeHFDZJIo3XTNXGj7Eihvifhd/geFMoO7Dt3P
         KEVJq74q6XJS8mNUjUVAcTGY+AV3WLWZa05Zqjf0OWaIvaVonSgXJNOKUffh3vVT8Qku
         I58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154090; x=1762758890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krxDO85tsubF5J6uxcbfpS+xA/eKw7o0+Vmbt9d1Ois=;
        b=KZnk0u5S95GPoFh27F4DKetbs/lsBdBpNYzkVbNtAcdeQelrayN42l9e1Ak8YWjUXt
         WRP2XwhFv1k0WOSNJpvIsUvcVv55GPK+UPkNLZMU9pL9U2kTKtBUxOIwnIFQx8uA35Qa
         I2olWVXAz28pCAG2Dr6Un1ww1DAAIL1zYLa/Bez9L5tTEED9KAjXJ5FhVeiirI1TzmOi
         iraRIE7z84GAGbs+xx4fsCvgAkxZWurMqIKKkwPSy+94AFw9cpc57YAdef+u2AvFaKWE
         8ZddNE6KeTFwdVJ6ag9Nq/8sDG8GI0QJGPNJbcSxWyWsKpSw04/4QC/urgAUHbHkQDIz
         J/6w==
X-Forwarded-Encrypted: i=1; AJvYcCVvW98oapFeIdydtx97sCloo+o4YfW5ny0/Htd2vBFjhsVaqWafe2xgK61gbXLdL0MscTJYX1wSYSHs0xTmPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIq8G2SpGLiBsrNrrDxventRsLb+c9ZBTCG4OyPwAMYO/Mb242
	7CUi0HH1XKhLN6jyN/X++e+l0oy7R8l18pn8+kmYBOQV5sR6frgoa4QcXcupQ+gJpg==
X-Gm-Gg: ASbGncsClJ2H3pv+d/wDBkAGWiYcWxnZPS9SpBMYAXl8VrWvzNA9JY3SCYq51lf07Zs
	SMTXHKTiNcb6QSiYml4/xJ1sTpUVf2Qv0T87Zb6i0Mst52/UKr3ycekV+ddkqrd0T6yVQcwdnqj
	ojOWh5/9/OU4inN22fDLWvZzdKY3CLnw76waM8TFEU2RJcingQjfiHz/KqFrRpGBMsMAXDRJdWR
	bfeI/87lLdlSRW01dVU4YdqNVzV1dl5DLq4rlPqd/i8F8ogGsVnoq+S+WeMs5H9cPdUq0+gKG94
	+9N18FKz0wGWCWavg3vW+habmiGUrEOSPI339qHk/ueWKwdheCTwmg0kgg71A1OHWx0wasPq8Zx
	Ggdt6ieN7k5JDRJNzawDG9S4VfBjTPBaWWx0sThMaa84fXIEb4AhAz26pgVPPP0yK31H2bvC8Yy
	YTx3ZS+JacJskqXa5PBuLKg/80cDd/RxAkflZvgw==
X-Google-Smtp-Source: AGHT+IE97CemVwDodrlEsACTbu3ii+CcSlX4Mt/UH1nASQkOOWezhknbfsTfFcSLebBhaZ2a41/idw==
X-Received: by 2002:a17:903:184:b0:25b:fba3:afb5 with SMTP id d9443c01a7336-295565ad1aemr5343685ad.11.1762154089465;
        Sun, 02 Nov 2025 23:14:49 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696eae8sm107020535ad.61.2025.11.02.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:14:48 -0800 (PST)
Date: Mon, 3 Nov 2025 07:14:38 +0000
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
Subject: Re: [PATCH 09/22] vfio/platform: Provide a get_region_info op
Message-ID: <aQhWXmluuFaU3XPL@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <9-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:23PM -0300, Jason Gunthorpe wrote:
> Move it out of vfio_platform_ioctl() and re-indent it. Add it to all
> platform drivers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  1 +
>  drivers/vfio/platform/vfio_platform.c         |  1 +
>  drivers/vfio/platform/vfio_platform_common.c  | 50 +++++++++++--------
>  drivers/vfio/platform/vfio_platform_private.h |  2 +
>  4 files changed, 32 insertions(+), 22 deletions(-)
> 

Moving the GET_REGION_INFO logic to vfio_platform_common.c and exporting
it for both the vfio-amba and vfio-platform drivers to use in the new op
looks correct. LGTM

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
