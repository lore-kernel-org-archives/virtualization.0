Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64042D94A7
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498968; cv=none; b=mWMbUPqU+EU8CwFXkcT/nXReJJdTcI6/bZEiHTJ0a+rVLTwNHVyhLtfe/6EneZno6QKYYyqpjhKS+I6svx6R4xvN1ssIdF6eTj+Gl5Wul6dtYd9Sg4TA3nt/VtN9LQYcUv1qFZ+ty/OZt/7ZkN2RdbfSMsUKqCLefxvtQYrqZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498968; c=relaxed/simple;
	bh=7rVJtF+bvJULYMq8lpChlQoAbB/f9XjCtTYOiHbBkFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3JAHEKizVSl1NP2wnAWGwyNOoow4jdGmWjosxxoDYNbyY+Ve2Ew+Yh7pUFl2ORJltZBiJE5qoqCbcAWjP3CCJ0ga/98UhZRPkIQPmaRkn1PMcEqn48Yl9JOUK9eqKf+TAVnAW3vPGCy1PZ9kVrgp6EZKtNNqIS4fnI2HRk1iC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IWiKImR/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IWiKImR/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c530866cf0so113617485a.1
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 09:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768498966; x=1769103766; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzIg+4sDQXFup5j8N72u0s9znKRCdSZxBT6As8A61p4=;
        b=IWiKImR/bWZjCs1tk+8dhbWQEgApkOjHViLWNNqX3nxB7jDfEoBKid/PBMmpf9z0Gq
         vM8wHzl/fYuqkAJ7bMres1aLOhMrlzvZtqNkabOnKnmGsePnp0rkbpemgwY/FvniR3Iy
         iOFZstHSqYcup4uBUw5k0blPb6Oyd95QAe2XUxPvmAAM3sOcWTOPda/iHQvwYExDA0P8
         phQixmDFtppce4H4Ygvk87j76Nv3KY5DQBDz36bKrjIRJDKQXhkyZtUIViMK6NlNdabc
         QkhtmcQEpowyC/jN7SW2xUF8qXyomuY+bqH7io5GwXTOP7hD8fKX47FbHiuk60JAQM/b
         wNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498966; x=1769103766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzIg+4sDQXFup5j8N72u0s9znKRCdSZxBT6As8A61p4=;
        b=mwJGE8ZN1TCzCe29mvaAy1t2Hbc/hIB2tFB6kiL9y9m+jqb/Z2v/8ge9I1cPVeLHlX
         uXw7wLGKSPZg8/y6KXjFdAnaE9qi3NpHA0BSmMUnpGCkRxDMongpcnlfl1X9G3Y4c1Rn
         soXqGrRPZTf7wgk+od0NJaaOr4keAr0ncBRjN6evGbp9dOZoMLJ+YMRCoyZRv6Dx3uWY
         gOaXJgZFsbZXdhqtpqj0B6gSPgdvwr2JAZWApz/uG7YSg53PoPczBHPvN4nZOR0WWggT
         3Ev4dAUNPZPHqB8G/Hcun5XcIlkTHngadVWeAJjwqDQXVxGI8fXpIU2WR/FhmoLXYU2o
         5RvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMjkZBZWGOSvGCG6F9VZsMcaJTwHpuVfOqZ01scGnbBTXxEb15n4mhYWmKiLPo25SdJg8IlzjtxUKDgvznXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgZbxLE/jGUaLEG2y1jL5Rt8cQXDWEvJXauaOn7RodsgGCDQy8
	pkc1p7ERJo2cCmtWnyBrTy8EpNnfNngT4NZi1Mquf0NqmERsp+xKPraoqt+YINJigI4=
X-Gm-Gg: AY/fxX7AfSkUZESX2FcTf1Kby4IUKfAQ/IUhEkEte65J8p9orwTOY5Xudua/dRqDeHQ
	p2Nj+WPTMdOzkRM8Z/b7BwEndSyIEaU8YQ7VPgcVr83rFdXku0ubOPuggpRaFYxAbo453jmwA07
	D1bCEZtcAmhztzDOD2n0I8K4Uzm8TqCLxuJQY8bcVXVqXCqCHherwDrK9xFwJ9y78w0rZXyTsJy
	a0YAQ1JfnlkJDP9zaQVyddHgurq5KuwJ5GBfUehy+Vy8vHUBAtHxGyuiPujrfTAFjYKvrlgQ1/E
	aDEAJG9xnKiZOEjsTXDGZm8GH/igzCTSjVCpf+yQIZZNIEE8b5GaSeZPRnogyXO+ysZzwaLw3lY
	hu2HKWsyaueRdSnBuc/enRShf8MxBdoJ59djhe3mfbwaqZlbuxulCdu5YcMkuBWel3ssLytMqRR
	XIGNamTIEVD1xqSkKdU+WAdlBin6iKnErvy//KvOsXnVCbEpznX/dJozi1gb7/BnXwuVl3/A==
X-Received: by 2002:a05:620a:6c0d:b0:8b2:e533:66f7 with SMTP id af79cd13be357-8c6a66da89bmr35061185a.10.1768498965430;
        Thu, 15 Jan 2026 09:42:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bacb43sm463952585a.41.2026.01.15.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:42:44 -0800 (PST)
Date: Thu, 15 Jan 2026 12:42:11 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH v2 0/5] add runtime hotplug state control
Message-ID: <aWkm8zVc9zy1w3eM@gourry-fedora-PF4VCD3F>
References: <20260114235022.3437787-1-gourry@gourry.net>
 <eb3e6ae9-d296-465f-a5a9-963da4d8ce6a@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3e6ae9-d296-465f-a5a9-963da4d8ce6a@kernel.org>

On Thu, Jan 15, 2026 at 06:26:21PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/15/26 00:50, Gregory Price wrote:
> > The dax kmem driver currently onlines memory automatically during
> > probe using the system's default online policy but provides no way
> > to control or query the entire region state at runtime.
> > 
> > This series adds a sysfs interface to control DAX kmem memory
> > hotplug state, and refactors the memory_hotplug paths to make it
> > possible for drivers to request an online type at hotplug time.
> 
> Gregory, slow down a bit please. I haven't even had the chance to go through
> your replies on v1.
>

Sorry, i realized your feedback on v1 showed there was just too much
complexity.  I would ignore v1 entirely at this point, this version is
significantly simpler.

> I'm currently on PTO and don't have the full day to review stuff :) And boy
> oh boy, do I have a lot of stuff in my inbox.
>
> Maybe given this is the second time the patch subject is suboptimal is
> another sign to slow down a bit? :P
> 

Apologies, and I will let this one sit.

~Gregory
