Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556282FD66E
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165031; cv=none; b=TH2w97HYiip8Ps2mN7aCAGMBJjvyITQk8+lTufDty1KxhxCj9GLrO4SIcV28ma3c0QZcjNL645xqiC6HCw6blmEGz0Qq5AfJVwrmMUcdcrKAup+mZwITG97hA3bYOe3zrUimncdjgSC6KN+bB8uRnrQQyB5Du1lnqHNa+i3am/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165031; c=relaxed/simple;
	bh=FFZiNUWIFKtxHxItZumM7duOWwpaz/Ziw593xKPC374=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djRvGGaay3/D4+19ipte/aOtOmU4NClmEqVyyrlnCYIt7VK6vCvZaa1VvwkMchhg1xaDQEGVWO2coI3IASq4MV/sxY9cvz+uafyjIfnqk+3Z+7guJf3Vp36Ib1EkdT0mp7gbADzrOjLzDNJy91gyKWoJCJyrDgO1bV3Hg4S4chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFnRG729; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFnRG729"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d67abd215so417955ad.0
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 02:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165027; x=1762769827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+B58KtJn/bs233pgZmMdorp656WS5EnyOqIx/RHoAag=;
        b=uFnRG729emlMwN0PW3bibkJAPn+XqXoTVqbZRj/qqvM3kA19neNEkbOdPEesu/aR/o
         UxpXlzKWCOvD0NqzD+jfja5O4zIlrvvOvmAg5H2vKv7Yy1Mg5b0hi4OGmJtJuE/Ewfgc
         p87dPpVTkhGqFW7aLFNRUeAJQWuTCjMoujdkJZuhh8JDyiv84Qch9Mov06I/Xte93iGC
         YWkBpA595+0Rs7MyfxAmhjjUzwC4hQ4Trh8ASaiRiLj//al7rtQM1eFBwYIPgYNJ2/Qw
         hjvtDKI6vCU+OecLlE8RVQi1qav0USiNOsgZm/QLYUvn+JxxIaeNKPbDdSTGJ7u3OJK6
         XmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165027; x=1762769827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B58KtJn/bs233pgZmMdorp656WS5EnyOqIx/RHoAag=;
        b=H8i0cOBTIFrKRCHUXvAWBzrKUmJidEB9LhxV87Q3wZLGbpmbjMs+q2KEaCiIMRBGrx
         inQEPgrmG7vWQ0TjdIU0NZHkGcACY2HFHffF/tMCVPm6xzj8ukD5W1hbBjhNSNdNqWSi
         pQukkwNncYgK9cQ5uTY5rl//O8U0n9pPm5Le9ZNvPjGUQBJWQ1ds8NsIEZoNJ5XFzCnC
         1AEihbNqad4A67koRlbXbdHCNwH8NqYivVl7Ql21a0/+l02DLDbe5IG5Odg+m0Z8bhVm
         jhYuxrXQus8YLSz9hOJ8FL0wvtHaXu733ZQoEIUEuJwplQM5K3tqSQygYXfLZoQx75dA
         AHDg==
X-Forwarded-Encrypted: i=1; AJvYcCUzIGGyD5+hCexze/vhj4ZDP8sRIjGdN7L+WCpugYMFnPgi9MTWOxvPuCS4Uw1bkohxZqR7j0oZyNWzUe/yZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk4ZqOUC2RYlK+hx2gxwDOzOiOnCo1hevf0HHlALaEvfFKVC4f
	yVFevXKPy0IOeAI1jI33dBfsNeuevVoUnpSrpn6PuZxDM0b6HyDCBjft2Qjfsqoq/w==
X-Gm-Gg: ASbGncuQMiwWk2JRZFC4SSEx6gdeA+1XYo7bLkfLrMYBLX+MCuoJFuBO7ADzlyyMqIe
	25hmj95+9rvl2vDbszS2YEWxWCVxnIglKiGZZB2NS+MIZ6L2Ju2+0BqMAHrXUDSSu1xmUrDmMgh
	iaWm5VZUUuL9dKxtf/3aanettJmPPtb+106RFmt4dG0bx6W/sU9l7r4u5ZYVVUafhTAOpnzUL0+
	h6/jffEQKqwa+x/GnknUiq56xsjj24RpEBPDmry/YakRbpjMadsF1fadOlRbok9B0xHyTKEwZ1q
	rqc2q+sFPdPcPAy9ylN2zf5tdKV4tm6UlLnXRouxpenaYt8ZbUPcHxCamrRjVww56z0WPmacDiH
	GG+UosIw4sg9BbH7i96jNdEgoUrMbV+7KxIoNySIa+dRpuvLT+uxN50qSRigiFbAzFeZxHPC9oR
	lcp0R9yzeTEhyZVbflkaXa4wNzhlw5NW2sBIVWng==
X-Google-Smtp-Source: AGHT+IHxzXLAyCFx7IPmcOnpFb2vp8Rgf1l3Kna0V2OUhXGSl0YxnYi8nj1MD1lWW9qX+m9LVNsxvQ==
X-Received: by 2002:a17:902:e88c:b0:290:d4dd:b042 with SMTP id d9443c01a7336-29554bc5206mr7508255ad.16.1762165026873;
        Mon, 03 Nov 2025 02:17:06 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aa4f4c28easm4658013b3a.31.2025.11.03.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:17:06 -0800 (PST)
Date: Mon, 3 Nov 2025 10:16:56 +0000
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
Subject: Re: [PATCH 15/22] vfio: Add get_region_info_caps op
Message-ID: <aQiBGEgQ3vCpCvXM@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <15-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:29PM -0300, Jason Gunthorpe wrote:
> This op does the copy to/from user for the info and can return back
> a cap chain through a vfio_info_cap * result.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 54 +++++++++++++++++++++++++++++++++++++---
>  include/linux/vfio.h     |  4 +++
>  2 files changed, 54 insertions(+), 4 deletions(-)

The newly added vfio_get_region_info seems to pull-in common boilerplate
code (like copy_from_user, arg size validation) into the core code,
removing redundancy across all other vfio drivers. LGTM.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
