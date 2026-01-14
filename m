Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42482FFDFC
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411717; cv=none; b=H8tpiXmRlT9387T8dXS0z/CaPA0OcAN9wLbXBsEdyOZia5LCLq8isUy7WmF7Ky90GbetoVGt/hg19l5tDtk9bNIELTJm1NignEF5xSQM2gSsqItsCLVjMbuJ6jdgPccbZC3IMXePClYFltPk3+HIIWsNeYgKXus+xiWMr+tDwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411717; c=relaxed/simple;
	bh=pn2FMj69xGy0y/5Gx9Y/UeewmmSegh4/cOxhPfcbyl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqQvsN0oHO6Jci4WUFdjvRq+AZnqQ68M47UceFA9NFZsrymBAZywVzsoSLnp4sL2JtUmCLF/wcbkkHqCpu324Agf6a0ueoSM3Y3uyGbwgLq8uDRRaYCgjg8BbxqdzxifgobrYc2EmziedQ6uYsl5g1kskP7kTkFu8LXE8qLna2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eemakQNB; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eemakQNB"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a34450f19so89727606d6.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768411715; x=1769016515; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8gk61w9S/yjYbnW7IJJtdpbyzDzV71vvh8bvL1b1DI=;
        b=eemakQNBt9UrcG/hDW7JI2pfJ9CnuUdl/Ahor71Mp8/PamVJ3WdsW4jPZXfBGRB4Te
         cnbAoJj6e+z0ENTvqcqNQhInlxGanRo1y19pS5oVgQhNLZQ/jPHD15o5QtIXN4TAll8M
         gG53SycpOmESoQzIhAscxoDupB3dty6uI4ra+y6PCdcNGnX3KbpTJaHPXsptiagJqk2Q
         hK1wlUiObtFlZajffRpY8z7eexQrf8FL2aC13S3CBw/p4wMIJYQWmFgw4CboaH79M87r
         fKFZdJlSYjaHLqscS+fx156gi1UJJ0qVEmJhCqbu4iwxbn46tHkqeQEjHJLPIENY9ezX
         sDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411715; x=1769016515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8gk61w9S/yjYbnW7IJJtdpbyzDzV71vvh8bvL1b1DI=;
        b=f9jhe4CIZ/tcZLc6obY40BcV2ekI221Gm7qJJpnfwwt0Eown3x19aAXuLN6cS/Ic+A
         kWbeimky9ZbTknvcBR2zbXiklBQAQ8+jLoawMfXQZ6sNvLZtByN+SLJPhnZ8k0XE3MRW
         rEbhQ64pPkgbSZAFD0BqXrtrvMY4wC382bWycWkWDVYF+sWhvThQ7OG+BNncDdTYAAtn
         jteTGhM5zAvAbRGIYBJ5jO6gvgrnYt6S6ymoSOxkElDdf0uORehucWVKYi8ahf1xOAzq
         HB47fcr4Hrx9ncF8K41TuHlWvHeu7rFStaD3b5xm9bdeEj4e+LtKJYXYcSlqYW0w0R91
         9CmA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ssu6mkb5oNGUaPnAuVq9CSZuTn1J3LR+RIJVxXMK+nhERBu2ot0PwqNLrqbjQ8qChqpmoaHulA5T7kSOHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5PDjYViq8NKqbmguz/hnNvAm0bUsvHZZH7R0BkgljpXfgqB3u
	tsl9l7dKzMgEUhmhbmR+AVMq/X1K6FuhYdcZ/wquEIv2qnHIoW6OElntaI7EFhaznvk=
X-Gm-Gg: AY/fxX716aKliF1o2rVWg6yup75OeDh6vhZeW+tJ9ioVnwsCjlkjY57zyFC+vQ3n9m6
	/zC2tHQYM/6SA1/NnqfNWPCLiaY290Wece/u2lbbljC4eHGtW6usnjWz3CB326nbtteHAT7DnRA
	UiG4lCLzQeTwe6s0UEHmvS5hr2TWxI+U65JyRPWzupE95/yRnCgbMIR3EAsSxsMMWLbj0DelyYb
	+g+gXITZgbBh8a4hw1EcKUscb9+Cd/OeYEheIcuSaiNRbW+AQP58XqTl/IBeWeXSMdo1nBjoZ/g
	piBNhtc9GJp9UoTZf+hb1gl5hZMbm8aMZK62BMlYRkjPjNlxlhqUkQJZ2vH52/iUZAqMpcHupSl
	IzdCbpRfETtSjDuVDW6CLjHQzX/VfnpCb37W2jBO+dNQruev8Ve/csN+/ovSIOHLwOxdWM8bKtn
	BQn+CzuOxwsa4EjfXGd/mHKZpayE77UKPxDiLh1GXUQLJ0xRMyhTcEgCfs/cPugU3oOZ7Xhg==
X-Received: by 2002:a05:6214:f6c:b0:87d:e2b:cdf7 with SMTP id 6a1803df08f44-8927445388dmr42459046d6.66.1768411714702;
        Wed, 14 Jan 2026 09:28:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8927a07c731sm10671566d6.34.2026.01.14.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:28:34 -0800 (PST)
Date: Wed, 14 Jan 2026 12:28:01 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 4/8] mm/memory_hotplug: return online type from
 add_memory_driver_managed()
Message-ID: <aWfSIX5lRqb35yUf@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-5-gourry@gourry.net>
 <6a9db6ff-2fe8-4be6-baba-7db7913898f2@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9db6ff-2fe8-4be6-baba-7db7913898f2@kernel.org>

On Wed, Jan 14, 2026 at 11:49:19AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > Change add_memory_driver_managed() to return the online type (MMOP_*)
> > on success instead of 0. This allows callers to determine the actual
> > online state of the memory after addition, which is important when
> > MMOP_SYSTEM_DEFAULT is used and the actual online type depends on the
> > system default policy.
> 
> Another reason to just let the caller handle MMOP_SYSTEM_DEFAULT itself by
> calling mhp_get_default_online_type() :)
>

Yeah i don't even end up using it, this is just cruft from early
iterations.  I'll clean it up.

~Gregory
