Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499A346E6C
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010605; cv=none; b=r9PcfvJqOMwN23nRxNK8+OMjp8+xTUx2fORBvcz4jsn5QmSH3hU9LfyChOQ0OGDeGwkaySVOXA3SQTJGWBlYaDU6lkK0sW/hKGca2lvUHKwkQ0kZB7FOWxypJvwdaEhXy2Mzj0BWKAJBmRjCxD7KTBxQ8Wow+Jwi94uYdhVO5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010605; c=relaxed/simple;
	bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYdT5YIh7zRB9iyscz/uIotO7lURVTAdOiBXPpYM8u9UaAAFZ9JezPvGb/M8BtAFb423FT5hnTywNQJk21bff4/jhPk+0Bm6B5kQvXPukdip06c2vtdE2fTfESwnNj1mkHqh1ykLiyKqGHzlh+HwEbTy5bL88HxKSU8vFp70N8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nZUVGpxt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nZUVGpxt"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c537a42b53so993359785a.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769010601; x=1769615401; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
        b=nZUVGpxt8Rl3ANaRPtFG3YTk3vP0mq49LXuiK2IKtC/z7grN2ASbxYV+gdA3+rt5v0
         OPpfBsuODEJhrifTdDkkJD4kShvODnMrUJupz2at+mBb6igxHRiMtEWivRo9bxsXZ3UN
         Sp1xwZJ4oYI1t2ptZ/yWeQ9YagqwyIsKTnZlOB99fmsMM8yO/ICUeTvVtgi+DHlmYL+k
         9NlnnEF2xOrFGnj9YOkiDb3fiW3FFi7WEsGoLZEZuoBDPF5g8VMmdV63Ysh2uxjJZba4
         AIGcTz5VL9fChN8WT7rDtj/QtAOwKszOMwPEMYtRVHkIr2Yy/aSdcJIQoZSswjMG+8lI
         Wspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010601; x=1769615401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
        b=e9pqLf2KzvxoRovRrbgGSV1dsoC/W9vumzvSd1dyU6jywI9EzJ/WU/oTKVVaqWG2jS
         jfTPHT9Ao0qyCEfMTuPz8tA4b3uEXSA2UJjJ4TJ2+GZwoNdvU/9AElkBY52wKOMbURv3
         h3za76LxAxz2MNdasbC7Xfsf2F/ZidE5l5MmGxmi4BWKk2uFoG1NplwW9HmQ2fGdIX7M
         0EmXqlbdKwUZym2kd4zdx7JF5VqJmQZt7d87WHzKkSWQ//BJmk8ZNWja3A/lNdYW+wbV
         8oY7xIxqmCX7EACvWN50dO37ncthi4fNjz6TatNo52K9cf6uKk1ixT3qW6ZNSQFEmPw1
         fyJg==
X-Forwarded-Encrypted: i=1; AJvYcCXZDAyb4k5vRUUX7yxonr9YjI5iASHKtJ/e+ryvHg3Ev7OOZnNVe++cbjoQj86hGcCcHHcLaVDKFaiC8OnAMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwYI0kM6gbzkZz/siiPmGvRdBYY9q8Il1A0LGB9ZK1vYz91WCJ
	flCgetyrcRKWW5C57BxydjrpIYNrWwN6wG/Iuha5fkgHFBWHTLsmqfYAFKL4kD74fOk=
X-Gm-Gg: AZuq6aLOw/xEa55nDu2AFkQGf97rc3MIoSzAOT8GL5WZW8ZKWRCpzUROHDO2KghMKb8
	QCysfx71IqnAhP1dHXDeaS0m9TNB29WYGC8grrm+vLOUYeows6L1u1MtZTZn0ulBwpRB//BqjCn
	kOg2QPFP6Z5qBiWjrPNwX+tW/SOUIXtb7dKWGLtiZc4gMeGck1sBB3dvCJR9qsPDzoNazemYBJF
	XeQE871FJw+zvc+dzaAjKlPeR0Y/7lKGG69+2faZYYYGS3K0vBYcu/oqCeQrFbDEkVmATjmiYlp
	j6y7kDcz87Mwmekn/bL6Hfog66oq2X0tixK6akL8EznTo+rerv0Q0fBUTwt1nRNIfff6DSZLbet
	EYArdMFePo/xen7O4ajox5yJsfWGxiiac2g+Rr3JoHyyOuGYB7BpPqzsiR2S3AKTvZewdcZs8tw
	JynOJ488zpt+qHETqxuuc+rP2GUo1R+FYL4XVD/PQAUmp0urDIzXuyFJJc6J4Lrn5pWjZ8jsfp2
	h6SwQ==
X-Received: by 2002:a05:620a:298a:b0:8b2:7290:27da with SMTP id af79cd13be357-8c6a68ec70emr2561552085a.12.1769010601362;
        Wed, 21 Jan 2026 07:50:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6a9d97sm127467116d6.34.2026.01.21.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:50:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaT2-00000006Emy-0KMB;
	Wed, 21 Jan 2026 11:50:00 -0400
Date: Wed, 21 Jan 2026 11:50:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Leon Romanovsky <leon@kernel.org>,
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121155000.GE961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <aXDhJ89Yru577jeY@google.com>
 <20260121142528.GC13201@unreal>
 <aXDnAVzTuCSZHxgF@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDnAVzTuCSZHxgF@google.com>

On Wed, Jan 21, 2026 at 02:47:29PM +0000, Pranjal Shrivastava wrote:
> But at the same time, I'd like to discuss if we should think about
> changing the dmabuf core, NULL op == success feels like relying on a bug

Agree, IMHO, it is surprising and counter intuitive in the kernel that
a NULL op means the feature is supported and default to success.

Jason
