Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC128298CC7
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154323; cv=none; b=EuM76Xl4N+n8l+5bGMbLsLDnOcsWwKjIiN9FviM631uVcSNOxCDBnKsblr92Qdb81WB94WSM8+v3f8bGW2B0b9fws2csoHX7jMul2DVkE+oNI279dzU2uFNYyf/KhK6YJy0sdrjZjZ+qYL+UCeMAaLBR5iuGXcENXZGdm0Dui3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154323; c=relaxed/simple;
	bh=Vm2BtOrr7/4guLkxjFZFHOZoayeqUbBXepUyeDwPM+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnopVCX2NwcfBlCWTM1NmfFc+J2SrCr9Yy1smDehwDQhqEKk8UOpOZSjlkEJ9KRGTaJDBz01pPBySpNUS1dNTCEwPFk4bgfrjAoXQSoD8dT6Gosdc03DSb14cH1J6bkI2ZvPTR6E7qJtIAL5whLXbrM2IjSxFp0ZQ9QaY13XlwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oSM+VBUN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSM+VBUN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-294f3105435so339225ad.1
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 23:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762154321; x=1762759121; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y22k5ngiq32o4MbKE/s0CLErP3q9IoFtmfwfCLBHatI=;
        b=oSM+VBUNSop6YNaxcEI6m+472U8sxfYz8xkpLsWw8hGh/nUpBw7GRs0VUHQi8FtZjA
         xQGFHzyVj0t+Zp1dkp7rSK4NMbvH7fPDiBuqb8XXoZ+BbmRZvmsn02zsSV/TBWQ+Kn1W
         KoOsV5Yopl1PPtx/DcIv2jgvHlUHMtghgRYfjnkegXv+tj0ehrVWVo8wNbXl6Lcp19db
         6TawpRDZ7plNIbQg/wfw7H/dju/U0PAs87644ziuekiQVnVgYAz9X2ddzjdJbaPih0za
         bB6FbWOm4jDSrcUZ+VvEpCMzNIAad0Fr03j4DXsgnLFYTC9tm5k37V8mxWAabLQ3+pEl
         Meww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154321; x=1762759121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y22k5ngiq32o4MbKE/s0CLErP3q9IoFtmfwfCLBHatI=;
        b=vzW8BsYMk6A6i2BsttPkn91B5cp+Bp7Hm2v58m1Xv7CqVtifXIV7j8p5jabWLmvZC6
         plpsp3M+Wa8aDbDmKW91/Ym7E8lOu/EynrFDidyDl+yJam+Rrxwxszb2WlhzQwCJHKBS
         GATDoFhWLzRYz+31PpRbvcrFJk7UOcwvclAMi9iMw1ksiu4hGjuL2oIj8cfSFa2NHyNB
         fTzO+3RxaXux2LTN4MVGaFwpvmw7Wtd7B+UDc2anzhfdiMboNRdlAAT7r1fPffA58+V7
         mHesnaAhoawPffySkXbO3UQZrQLKpC4d7kkPknknwJ1lfr8umIX1DuRdxXOGP4/WxwPn
         GFSA==
X-Forwarded-Encrypted: i=1; AJvYcCX8cPbssOgXUgsj2y850ykWcitxqFFh+ApYf0iQjnlXAC2t1fVPqlb3MoTrPf7ireIDHdoeVHjG/AzTrP5tjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSM7nlgD1KIwYFToihxMuENHP2O6bcegI67dZrE4jFUWEXIrRW
	fe6GxBeghgc532z2YpF5/HoziXq3L1IJYA2J0mLL2BArdmNrF5W/qs/kOHbBoOXpzA==
X-Gm-Gg: ASbGnctAoHcvUwzQGBR3AOOhz+QPROf3GVobKsI07tCPnTkEM/mG8qWjYDCgGdA9y5B
	wljjw4+OaYaidW6tbMvstAVSTr4jK5fHmtrHKYHigecE3WgYvaxBF4aGiwvbg1g62fkhYbK+8GI
	4oMo7giN6Ve40RpbEsY466Atfc7TMVxlAhMqRs6RmRpzDgrQvU2SVBd52OFsm4rCwxvRaoXxSkC
	O/FR4waXYPcn8K3bW7kU13QhagoIuqxquDT/bEEVInCQmCKYH9s7HK2r8MnxTWcF9wEuMY48coO
	3Sr7R4BOblYuI/pbRYtx4yz2azGoaSbqVobCkJ7Ua2qc7KKtCjcHPp/i3C9TDTm4uD08LibR1CK
	U3fCgnUxa9Lw2qme210XLsnQ52zn9WPy/MyOGXC+D/mxM8NNUvI1sJGTo+LqtpOmAxMnx6boeaw
	miq4w5m513BxwGXd4hxBgRD6wqy8qndYgtEyI8Ew==
X-Google-Smtp-Source: AGHT+IHz7vQ0cm4SGWCD8qu7hNB41Aed4i8aC1NkscOeFOjchnLwW8gMwvqn5xaYYumt7DzVtDnmgQ==
X-Received: by 2002:a17:902:d2d0:b0:295:30bc:458e with SMTP id d9443c01a7336-29556477728mr5855785ad.3.1762154320729;
        Sun, 02 Nov 2025 23:18:40 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db197340sm10108242b3a.44.2025.11.02.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:18:40 -0800 (PST)
Date: Mon, 3 Nov 2025 07:18:31 +0000
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
Subject: Re: [PATCH 07/22] vfio/mdpy: Provide a get_region_info op
Message-ID: <aQhXR2M6riHmufl7@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <7-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:21PM -0300, Jason Gunthorpe wrote:
> Move it out of mdpy_ioctl() and re-indent it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  samples/vfio-mdev/mdpy.c | 53 ++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 

Acked-by: Pranjal Shrivastava <praan@google.com>

- Praan

