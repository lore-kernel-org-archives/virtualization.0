Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB3316904
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698735; cv=none; b=QuTaLAQzR335PlKd5sPym+0NsppdfdkBiiquY8Z7QJcHknZGcAy+gcQLR+F8d4WthV3NeMPgO+GYsf9krWc6aRbIhApO5H/3lvXzpYSfpVrtWNxt4zQKX/WSj/7hUpYaJkboLea7+fsWiPInO+KIzXRJyEBWaEceZtYyBnj5XbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698735; c=relaxed/simple;
	bh=K929Qe1UqCZl76ieO2aMPpP3RDbZ+XEIE24yDLHrmkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzECF/WfiqpixoAsEKSxwW2MnK4miNrrSWzVV5vvd31dLX2u5D1VsRejrL7TBFuboxk4rvXOuxrnn+gTRbAX5CWXnLN0FCkkmpG8eX3wcc/qIxF/wtWqgI4LfgfRXZ5Kgxys6MQGN6gqMGUTvbblsqWH5giqc2cKz5IP982skKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YL+YG5w2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YL+YG5w2"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c6aaf3cd62so113616385a.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769698733; x=1770303533; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4w2e3JsR9J6c+UOY9xxx12hv3SNlcI3MEz/ixg8Unk=;
        b=YL+YG5w2igfhop24kw4kFg/6idyn6qxXRewmnLNJF5KaVbDaP7irQsImCI0vQyAu8D
         Q4AecQNFLNyB/QEL5XU3Qm/5QMBKjAbo1xrZMT9VfTQMMui/pzgQjl2VmszOPybfS+YE
         Ljh0qnc/U1VjK4xu6UVTNTytmE3CDCVTckpDicAQRHekAX+ZhLWCuikXbJTxzitQKzvJ
         HRfDxMETUmt1Hq0t1tV1ay1gxCMDsj/BpTGbL2+oyV/xyiybgCcjIoLUIaHY7JzptCab
         qP2L/bfDgZlEDekRs5YWW4SAEO0KbHBxofgQF8uiDfhj5UKMMQHWdY8FPVfEcWKDKydQ
         SX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769698733; x=1770303533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4w2e3JsR9J6c+UOY9xxx12hv3SNlcI3MEz/ixg8Unk=;
        b=A7p6Qq6ns5nmJZMLJryfp+sVXYNeU4IjKKF0k0cWygK71uGtZswd14Kzu98+CvFE7Q
         jyH9FGzLt1+oeJXXDvZ9rGuCJRBlMwGkDWRrt6AIsYYtECzg8vradZv8Ql/vGx/yTFck
         0EwEaFW+1nzszG9baruC9Ap5Mh/Q1E+UTcBf0QlgxToE7TYkQ7MvFLJ7PTQ6EQQ6sH7b
         7WGFeSIuy8HxcbsyKv465MS5Tn1EGpwknmbEkW2myD55RmKkvn/KTLOfBHSu9T6gj4ek
         KxgWX8p3uMcCs1M4nBIW+/4PEMG4bW7HOPbUxX8B15CZQhkqsXRG3By19m+1jwXyciWl
         ZywA==
X-Forwarded-Encrypted: i=1; AJvYcCUcIcXRYO7laLV33DkXRYte0OcYU4Y7ZIYfZVIocQabyvcOI0BKQlcgsRcIDxasW8otBXyrpTw7qtR8RQm+Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6x6NoxUnMD6zVkzD5q6++xVSMXF9esyfNAKBwwvjAs+9s0ljX
	lsKkA20i/rq3YMSkqPjkSe5Pm2v8Eb1WTm/3HCTl4jB0AelGgm1WuthaxiTyUbgEukk=
X-Gm-Gg: AZuq6aISYpigXP7qK51X8DF6VNo2qkuznAUpbfg2mY19KeMTjieds4aUV5TW+IfJ4hS
	2GbiIayPxJa1xMPURrGVzptCH0Q5QXvTZDAWkUxeuvHsjB8OVVnPqk7aXjTaATrI+TnKp9eefFN
	Zcy0NccwsNddCtx+FlyVr6p5TcPzHgDY2glQUswVVGmFTxZItGhPSYxKUSu0q5Tdvr7Vabmsarr
	GWAnJ0joBzP8n1cxmC/61Knf4Z6PVV8OUdlkxnsIt3rp6fjw+dhufJiLNreG6nSDR4BqjXfQgzi
	XmsM/zpTuVvM1JJnap8N3Y6CLFfAOpJtQfbswVooI1tk1R8jYcaVdGmOrc6TrMC5Cm6nSEodly8
	tf9Y8hMcmYcTu1a5JIzTVYCPrh/l+dKZiOMWpPvO3VWKOesxah7ESUWttJ2MVKUM1BXFSZ+LXZB
	B1laHRXDuhT0owDT5mLdtS3jfiCoR2AICrzn7coEXoKaWSxR1BxTZVa9RyO7GvEXkyeUI=
X-Received: by 2002:a05:620a:2550:b0:8c6:d398:4a76 with SMTP id af79cd13be357-8c70b833da6mr1225384185a.2.1769698732651;
        Thu, 29 Jan 2026 06:58:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375c0d8sm38242676d6.43.2026.01.29.06.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:58:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlTTv-00000009kfJ-363L;
	Thu, 29 Jan 2026 10:58:51 -0400
Date: Thu, 29 Jan 2026 10:58:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260129145851.GE2307128@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <aXfUZcSEr9N18o6w@google.com>
 <20260127085835.GQ13967@unreal>
 <20260127162754.GH1641016@ziepe.ca>
 <BN9PR11MB5276B99D4E8C6496B0C447888C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B99D4E8C6496B0C447888C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Jan 29, 2026 at 07:06:37AM +0000, Tian, Kevin wrote:
> Bear me if it's an ignorant question.
> 
> The commit msg of patch6 says that VFIO doesn't tolerate unbounded
> wait, which is the reason behind the 2nd timeout wait here.

As far as I understand dmabuf design a fence wait should complete
eventually under kernel control, because these sleeps are
sprinkled all around the kernel today.

I suspect that is not actually true for every HW, probably something
like "shader programs can run forever technically".

We can argue if those cases should not report revocable either, but at
least this will work "correctly" even if it takes a huge amount of
time.

I wouldn't mind seeing a shorter timeout and print on the fence too
just in case.

Jason
