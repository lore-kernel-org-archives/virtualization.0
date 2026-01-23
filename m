Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01B277016
	for <virtualization@lists.linux.dev>; Fri, 23 Jan 2026 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128462; cv=none; b=N1SHBQ1E64C1cuBLgu5eVBAsCIdaba8/sUSzRLK3FxKipIkB+4TH+kHOHbSR3M8KHo5LEG5ZA7CkfX6lQs4Ex19QfflZUHV4yLp81hKGYZs/quHEFUxu9Zhe+/efjZkF4aD0zM0czMbCtM8dykAeJLiijKUyFCcPKhc6dUV05oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128462; c=relaxed/simple;
	bh=ksTMqewe9wJeVkWUQ6teggTVZqK1udNl0Tl8ePWbE3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIn4HLS21OTFrtLZT0FfhMl/N4W+OzaQz86ll/QlxWMibblLniqJCiveQ3f6ICZO9ZtKoQxlHBmsRDSUMlWeGqWyKcF2LjVhuURCbwBAkJcvRgJCybRRfe/u3etV/6+Z1Cc7GJEL7SrBn85dACOz1gDpRO9D7s/qmnt/tmZjVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GzUmHT3z; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GzUmHT3z"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-894723da7dfso26977656d6.1
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769128453; x=1769733253; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asBGl1upDPy9EBtcWnpVXAcR6hW540Iv+SjDFfHMW0w=;
        b=GzUmHT3zhW+SYZYH5QBf10O+epbfrU8tYgJGSDIJ7BhCmewl6GJy7AjXI1t/3ANXzf
         Gc89/+s7KnihF76dSEN1scgb2h2Zdk1dkteqNeC5vgyo+MRsyQZ5O231An1lwVGC7b+f
         OHxbi/q+PGs4erB2QEhEOZ6akwexDiuzZ7tM5U0wseWytULAoRtf7akhUhm6nTgw/xj9
         yKSUmPRXaamW3YOwGynHZlILw/uPBhTiuqngtjI7eyaFiDUmxj8NhkFFiPOJ0nybbA8Y
         BpU8UM0Mtr5YY/Q1NS+khdyU1FIGLeSzLkFBxRNlcLbK109ge58kg5dLppzCX+w6U95i
         h9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769128453; x=1769733253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asBGl1upDPy9EBtcWnpVXAcR6hW540Iv+SjDFfHMW0w=;
        b=ingzl/2LfqZGPNFf73xcto9Rw2BMVfj7rYgIJirCKbpz5IL/xDyd+wfdo5SNljugFy
         4onhSgazQg8ioQurESSf/8gPjJg9QkADgaFxacwdHacjk+Q/dp3vxdLYO3F1Gk5fZk54
         ux76Btr5KI2SdKKZLoenpCW6fg+Xoq0nPk4Pm3bXy/axR8ZsOz2PpOWxQH7oX01ZLtgO
         6/LA1VHxoHBwjUzOdaC+n3KOvbiODzpmEOFS9tq0rRRuWTXCu0JEXOy4jyh3tvex4eUg
         kX1ZtvXPEQhJm20RBBpOFqeXeLwQyTwm6rbLXCzC8Mt+fqcQAcBkhfGhkyG0tXIZBo9h
         TLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFkVHMoy+KuaLHlO6lXlhyFf81JHxp5/0s66Xja6albQSIyGzmbNj7PC8Wb1O6xn7nRpdoRTzaGtBqZU+5aQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRS0w6M8CVizelX+VOWQA2mdi9h2LG01XPrDzlRcURuM9Ud7+o
	Pk2TXMP4mwkqp/EnakYTrZ2F97M4PomYmN2WL6OCMlMg25nmO2I4iXu3KJtyp4Mr2ZQ=
X-Gm-Gg: AZuq6aK0+qpjxtrVnO8VqwBZp1zuwxEEd3ayvcP3Cgog/uRKt6/jy9X4Nk6SsOirFpj
	wHomXCLfn9bkhbUVpA5mVEJHxZGGrChTMz43ocVDPltKsBtUMVz76PiacvCGJ81zT/dJO+/J36C
	05IYC8gqlFLJhxcq9pkwf2ok/wzZtea84hp4e4lHj/AZuOI1lZCJEW72/p9TZD5PloJ+UMnOOsJ
	huHYWGAuC6X423kSUEN6vFAzGHF7GvQsmx+dfGom0OTrFR9FMPKSGgxDJF9IcPOjVmCqqmpSbyd
	DyCz8XOKO1BJjXKmGHSht8Z3tbrKJbY/YUCoAyMFph3XPfizZBUPo1H0fPMAjH5yhlHf29pD8Uv
	W4Zhn37DaSULlExwMdK6rXC8Gs5zPY2UB2K7MnFrjCw3mLyGwt7dHd1h+AyrZlYwXCbDsfh1dvu
	RWdFxH2VAn/T4dmaTB4vRNs6ZLHr5dqnkLlHRXXOrMFoLghTk3owdQlD3sOg7CmR9CR8NuSg==
X-Received: by 2002:a05:620a:29c7:b0:8a1:b5ab:bbd6 with SMTP id af79cd13be357-8c6e2e369f0mr170716185a.71.1769128453428;
        Thu, 22 Jan 2026 16:34:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c71f8sm54022985a.5.2026.01.22.16.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:34:12 -0800 (PST)
Date: Thu, 22 Jan 2026 19:34:10 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aXLCAtwMkSMH3DNj@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
 <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
 <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>

On Thu, Jan 22, 2026 at 11:41:24PM +0100, David Hildenbrand (Red Hat) wrote:
> 
> Right, but I don't want any other OOT kernel module to be able to make use
> of add_memory_driver_managed() to do arbitrary things, because we don't know
> if it's really user space setting the policy for that memory then.
> 

Ah, this was lost on me.

> So either restrict add_memory_driver_managed() to kmem+virtio_mem
> completely, or add another variant that will be kmem-only (or however that
> dax/cxl module is called).

unclear to me how to restrict a function to specific drivers, but i can
add add_and_online_memory_driver_managed() trivially so no big issue.

You'd be ok with with this?

add_and_online_memory_driver_managed(..., online_type) {
   ... existing add_memory_driver_managed() code ...
}

add_memory_driver_managed(...) {
   add_and_online_memory_driver_managed(..., mhp_get_default_policy());
}

~Gregory
