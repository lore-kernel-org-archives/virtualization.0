Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B492EC558
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842217; cv=none; b=KIwDuooOHoEC5IDyjJZh3W8V/BhDBxry4rXKU931VLLfUQe87b7ZRKLCk1P5DKBir+CJVulIEiPO5+XGPtt/yzs/q29dWu3girXn/fen4IiU76DolAa+530R+VhWNusbBWL9ngIjrPXKZKBztoIM5I1zlm6c2cXtN9ihFKC4xew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842217; c=relaxed/simple;
	bh=rf6zLo4HMSx3jjTOpNOmyUHF2Og5rRAkebiZTxcDcUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3R4WvIoYnLuT3vs4zi/DCQWFS9DebOw9zCrBH7R+/LbGZAYyKF0HmLwayNq74YDjQElJCvTbCd1nFwdhw+C1QvoK+2G11ibhKpOjXf/zzVT+AZN0N5ItngB7eIniCKFTGE0SU1tU1SAcGf5NzRd0T2mq6XtB93ysDQHUONbw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=etGEmKRh; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="etGEmKRh"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ed0a9cbb3fso2907245137.3
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768842214; x=1769447014; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPF37M4OZRPT3BtJHYXM5EEOm0b3fHdtNnzMGWb7xcQ=;
        b=etGEmKRhp/a4Av/U5IqTruxF2Vwqnvo3PDrIXzeewfsAVuWavSfSeamH/NjCyqrvVW
         8Wr+cnY5nplEg1J06noMDABA4+kKJ4mwoV0IfUQQJ11Gh5Lvwrlcw0rGh0w/NZYCH1bQ
         6cRzsdAJy2Z/RLdIYVOQ0tWeohlR4Bhu1IppDtyEqI7QEz+C1q7KEVmbIBQEc1qckGfM
         wQ1PKiF3RpJV4zwdbzEpISMf0o5iu6vBMo8bljL7Q8DI9v2eiTGoqFLoRbS+6Ikb8zyY
         R+CuweR3Hw22swS8YuLsWhXYIpwIYO9yB5+G1glLZ/XSyPGSP6TfuGCFBmtGz/2pAosJ
         74CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842214; x=1769447014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPF37M4OZRPT3BtJHYXM5EEOm0b3fHdtNnzMGWb7xcQ=;
        b=KMVfRI3RQKF4UllzXgLjLl1R0A1/ocCe4V1lapYXZTnGkgSYEXeC+OSHZU3FE9DqUv
         O4v9daU3znHUKAVDGjDRIq5mgwGPRfpsLKrqDuDs6M36sfUm3c3Ftlqta2KT7KlN3bCj
         r/01ljjfFZ6oyw30BpKahajCCl6Ict1BEGSM94fScaiHPsBKLiTCwUuLKH1LM/BiGFeR
         c2TNOzodA+yXV3kYdNan7gNhG+iSsk/ET2Q7QoG2eMBb4WJwdys5Rzk1kxwb5Ailnjvs
         bd28ih42wtWd8w1SQb4h2OuXr86fF0+bGBwDwsCQTil2NYJBXMjKXuuUgCPDujDe7mYJ
         SFDg==
X-Forwarded-Encrypted: i=1; AJvYcCW0DU/yjbeDFn3yND72+kd//SbDflWnns/v9kEqltxK9rnvTCAO9eenI0idjwx45T7th15od+B0TkP3ahi/yw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9bhjqqmRNFpvYm7agoqQ347YvoIfI91FFk4jIqKTCFhB6LBfU
	lTC2YHWjgSTtZqksTQSpV3L4DHJGWe5Zsua8Cm7RJnphAGXOc8hvdgnwnMiNJ9wacXA=
X-Gm-Gg: AY/fxX77r4g7kqnb6j0eum9xt5+y5B82S9QWUs3lCYb4R12dTmwZpQJTncBWmDhjh/p
	NN9qsKl5BwYZRzf8pxVFDLi/qCTf+mnods8J4m730Jom1dNVf/kOOuPAhTEgTs2CfZiYgUvE93o
	HCB+yfZEUh7WXe82r0rcl7e2d7PGxPnmqGLBQ0WO93bfzwLjZJWLy4LQ7r1v6n8JftEhnCZkktP
	xyOyLyMKWUv7v+pQrqaHXkIN3Vqd6xtabl1HyOdiAzXSna9TVldVDbjd6v9goB4919OCQyJeDHw
	SnmsJ7dvwmpS0jvd1aFvzt8BCnFLjWapF0PdlGdJQuWdA/62ewL8IEOIpN/VEPZGjhk/995PyLB
	3f4bG6/canuFZel+O/YDBcX1OLUMfS7k7BZ3K2oV8m3D00iRt+UnK8Z5019Zeog2oChf2eVwOD6
	pVnyr98feEY6CnVE2Lj3Hms21RIwPQeK9p+RNeO82j79lFqAFtVXZtgdgAZIE1Qqr1Y60=
X-Received: by 2002:a05:6102:2ac9:b0:5db:d07c:218f with SMTP id ada2fe7eead31-5f1a55dacc2mr3505780137.40.1768842212920;
        Mon, 19 Jan 2026 09:03:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6027c9sm90833946d6.13.2026.01.19.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:03:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsf5-00000005ITl-3vB3;
	Mon, 19 Jan 2026 13:03:31 -0400
Date: Mon, 19 Jan 2026 13:03:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] vfio: Add pinned interface to perform revoke
 semantics
Message-ID: <20260119170331.GJ961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-4-a03bb27c0875@nvidia.com>
 <bd37adf0-afd0-49c4-b608-7f9aa5994f7b@amd.com>
 <20260119130244.GN13201@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119130244.GN13201@unreal>

On Mon, Jan 19, 2026 at 03:02:44PM +0200, Leon Romanovsky wrote:

> We (VFIO and IOMMUFD) followed the same pattern used in  
> amdgpu_bo_move_notify(), which also does not wait.

You have to be really careful copying anything from the GPU drivers as
they have these waits hidden and batched in other parts of their
operations..

Jason
