Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50D2E7BB5
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165302; cv=none; b=GFjOHAnhyhvIIkVbwpXjZ7yjuG/CiC5gNAOcByq1FMMMUZSyFgy8KNUBKFmankeu6ADI1HCRaUIw9f7rfET9BRYynz6e/FOFB2abxLbqzhDmdcrGi76iTCVMtXwl9OZjzLZGcm0vdILezyDBINdyWwQ1zID3wmb+AsUrX4ftmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165302; c=relaxed/simple;
	bh=/HKMzy5aaV8LtDdSBvQnNIuHvkwtMkRBm1mFEXs55wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpk6x2lPiBF3JEj7yj8utmnvbjOl9hhsbuDbJbzDm9QhL/76KZ81+U99vcRcIvZk2O0dqr+kteqQDeswOrJqKiY4mgB2aUiR3IJqk/muQHM3N+8acF4hzk47JI8y6W62dpmK5xVgPrRVtklOsOef85S5ivhco44Y/SjpGCCMxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoKKXh7C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoKKXh7C"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-294f3105435so372515ad.1
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165300; x=1762770100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zM2bsN+XnlGuvDGqw1tQvaweGHKrw1JAZACa3YqST0c=;
        b=WoKKXh7CEDI+t0bgHtW7+/W3OtqgXoeMWdPxO5NSKW+MwKCJ/pD5K1/xnRylYF/1WM
         WZ8ZCwShkeTNgL6REi6Q1KQ8PlL2tBS9Duwcbt5vNnrwbRgh0ctnu5yzfkKT9JzYKb9A
         yuz/FpKMBhpks/IbhakJgLrfcTbQ9v/LGwWzpMjdPabn53ug2sTo2Wsz/vxXdFkUYZKB
         U9bqRwYIwC0meO8jT+OooJbmIzX4Q3ys0jMEXxlrkbjX+h/LhHwL6nnEzuPVp6ZMlllS
         Ujdjp+ChagNubA+iq+2/wbnkOH/xpca3t1UsK2XiUDlRZ3K/jNDhTA2psx1Y/OmGft+5
         2QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165300; x=1762770100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM2bsN+XnlGuvDGqw1tQvaweGHKrw1JAZACa3YqST0c=;
        b=W2QEFS9CZDXwsUCzHgluHtMEol5QBaxt0WNIJhmQrEd08DBZqf2UuvqLUb//8MSIJB
         MUYJmP6geJqYl8OiObw/gZ78Lq4UoCiB086vFrDcKOJXBzK6rLebOcW5zJPDAV+fSqFP
         38k2/Nq0JOBngaMk0BGrTidn/IJeg12hnTI8JMQrPY1sy6GHvNoN20V2PS6pdfZy89TO
         mmmi0aXV/0lkZumXgnYPrSsPQsFxhfFWKStOEUvbGiQgjwsOYWW60igR8Yu949iWxmqC
         nUKEOX+lKUyrv1KkmEx9LDADDv/jhNPK9XgC6lUQE3dpZNJzbTDv2n1LQYaad+vjaFiF
         z4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQQQIWZrN7lKzt4YvUUNpm81/BeKlpeH7vufSpYG8qlTGgRjyVC6P6pZr3s0BzOFOgzgb7ESTjYJ2IyX4x+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxATia0eekLomuAJvzc+cnAJmgvYg0gUeuCDEfMdjyq4kO/bXd/
	KT5BQ/9M43yCTOtS7dtvfbzjfULlV5/HTwfZBya0oNF6IoBS8WhDh/ItJmpk0QgyAA==
X-Gm-Gg: ASbGncvLYa2hQjHA3XbwMyJf6msQW/Nu9ZtYO96gcVemighc5lVj533ZAHVOazIPctH
	/trUMW6uoj8AvE5GPe/6ss1sMezP6fshl+eHyva9yh80o4qAe2Y3dEAnI5II6G0c7WrEZxy/seM
	3ErF9EvX4iUWyxFJC1AXrDXXxiOfoaag2fa4L97Uxb+k/BT1LejR1GLRbuBFbodDPjAgacwuEHi
	3OPcKBe2YlReER/5P17JOy9X74vSFIP0U57kaQ7l8GONdyFjKajcsE3C24cSjDgRIYoLyXLo9+n
	e+VQeTz9AR3T85lOxP1SuqBdRgHOkGggO8qIKpoY4PsYH0rDxgd0G6+ymnaslFA+PSY08wspZBI
	duELfs74+lXvQrs07ByUUB/nmddNcKSzuLgeUdxq65cIBX37zTc60AI0mxDyWzKQeo29bT8yPbj
	aGab+1xbL/P4rb9EZHxQznwdCK1dVm42JeTnob9UhreaxHVZOX
X-Google-Smtp-Source: AGHT+IHDQYQU+xgcIcym40SdSIPVCJL4E/vz3sWG3WXd+xmfQ1K9iSuwfFgvjeHeyY3RCG42umC9MA==
X-Received: by 2002:a17:903:1a70:b0:295:28a4:f0f5 with SMTP id d9443c01a7336-29556476c7amr6429175ad.5.1762165299489;
        Mon, 03 Nov 2025 02:21:39 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f26e0a6sm6205722a91.5.2025.11.03.02.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:21:38 -0800 (PST)
Date: Mon, 3 Nov 2025 10:21:28 +0000
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
Subject: Re: [PATCH 20/22] vfio/platform: Convert to get_region_info_caps
Message-ID: <aQiCKBl0ScO78Le9@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:34PM -0300, Jason Gunthorpe wrote:
> Remove the duplicate code and change info to a pointer. caps are not used.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  2 +-
>  drivers/vfio/platform/vfio_platform.c         |  2 +-
>  drivers/vfio/platform/vfio_platform_common.c  | 24 ++++++-------------
>  drivers/vfio/platform/vfio_platform_private.h |  3 ++-
>  4 files changed, 11 insertions(+), 20 deletions(-)
>

Removes all the boilerplate (copy_from_user, copy_to_user, argsz
validation) and lets the VFIO core handle it.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!
Praan
