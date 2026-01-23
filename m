Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44B257843
	for <virtualization@lists.linux.dev>; Fri, 23 Jan 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195548; cv=none; b=pkKUcfr24ErAtMKMoCINiWy9MY8+R3KlAW5TF0S7yD0zyysPCzcoyGwyB582KhKFGgBliadsmLihHUpwD53aw0PqozZ1VOLowe5YmGj1y/JDFw+2YF6e4FgIKFCraFrPPSoC78Pnl+O5eDKpRd1RrdE1ZhRTnMUvm6VSCYTmDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195548; c=relaxed/simple;
	bh=dwNTImMJO2gHVlejeQ8Ezs9GSst86dOsrCCdrs8fh6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj/fW8liVi7AEE0hjhlhVikZ2WsXDzDKk/PceSG/Qvq6OqI5NmCGg2OdOCur6rqyjruD2kGxL89nKuf6JKMsXPkcjQE9V4D2iWm8FVKzmDxkyq8GnWt1hWyUX3txccv4HOPVckfj8hSrzXWBQRPWtWPGKpegVyGLGsKPwOyE0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nNDmdg4W; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nNDmdg4W"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8948273f5d0so23048686d6.0
        for <virtualization@lists.linux.dev>; Fri, 23 Jan 2026 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769195546; x=1769800346; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAb3V8FwAoFt+i7QIjKEQtHflVF/O2of2sgUimojvUA=;
        b=nNDmdg4W7MfPeieSfkdNfZ0zgX+KDBvF7gwY5/FSn+YTYVXkOx2GUx6GwI+zF2PCWI
         HXbSyYoFqCXkOJsstVJCIAI+nzij0UzbhltVICNGZTtSyjNLH3kC+Ysv4nh3RW98jMRv
         15mRAKWvRDT3IoTHGMvirJgY7V/PgVotqJnsfEDDkmt8jH7/Lm/8IS9nLEhqokSqhJtH
         xn0aHQctOU4dVuQfPpn7Cprjj30EKAisof6LcA+7Ylu83ux0+AlTcZXqnJxRZSK4K42j
         ECyjW7ogU+dQJwAtM8DqIE4nXeOXVzznQdbuLJHIc7V5upBe/fdKsYohILbYW2w8fLjG
         Ax9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769195546; x=1769800346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAb3V8FwAoFt+i7QIjKEQtHflVF/O2of2sgUimojvUA=;
        b=WmaB0Yf4udhquUE+6qbIudAiqdo2zWk5mti20wXiAoCdDwvOSPzQUSrAj9BMN+G3XR
         YdImz471HR3MV1f/Fbl86oecRNAfL7L2Hi/UIu5Yr5khxlRau5TnBke3sGqbaafvePNw
         sMcNDmADODVlKbBCQQ7fFnDui6qpkhywEv6zNsOOF6D32ytGNSafa4wZ4R2JlMBdx8Dl
         JRegzVZP5AXz34n/HvZ/voJ1OA9EfAxRP326O1L0C15x5NRcYv9ydmvew9tXEGMpIsXk
         iRav9pNStb0qGohzGzXklcO7pUnue7AGqbVJWQ3/V+IjfjksR/utN5dhKp9zJbN9hd8c
         S3wg==
X-Forwarded-Encrypted: i=1; AJvYcCVf1Py1pr05CrVAxMaJuwTNbs4gZRQulDQQv70FleoX89hUx77Ih2RqYyFCuVuaYJHbUvp3qx0JibjYpXMFBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHrngzrQhbkq86KYtuHlxYLZ+kPcuz+YQoq2ea5UFNIMl0kuIK
	l5B3VT3VHnuUDaMjyQvEg65U0r9z91ucQzDIJW9fUAGNTnMZGVJVXukOyitjdSNv1Cc=
X-Gm-Gg: AZuq6aKHALEHscrtLa0gNvXTVTcjkU+nLVVl87rdrgofEBwsRp0O+zkSuSOvT3GFWBy
	g5qYU7wN0DJGgkx7EzEzsDaAkqWduO6VaRO6c8k2JRefdH5s1N4eEe23Zb4niDTBvKQ9oEXz26E
	KlKoU5WNJ5RQPqAcrjrWCRkLIAdz7kNjDIjdfOxVc1hYhNolLSJ6fKFRWC12PzaENX6cy46VLNc
	Iy0Pef9m7YQ/cUaRwrU6nNBOFZrh4Zocia1vJUAgjLt/Md+RuE1SFJ8lfPlV8HrEgYhlfvV33Gf
	GcYyECYZ4Q28HApbTduEFi0Io5AZdWAVhkQE8LU8qyIJZ38xflaIP9GDSrYYyYdx2E83R3gDfSX
	ejxq4cigvwzJtWhdoi+qYgOkkXYZdELcYeXJLCkxyQAaYviLp0QvsOq++Zpxn0cshjxQF5LxibG
	yW3n9cDpcXGvGOs0Xl6HCg8IFFzxpvxT7H44Yo8CC0GoiRs11krJExVXNTQFtcfqqw+uq3cNi13
	5o5mx4/
X-Received: by 2002:a05:6214:3008:b0:88a:2ac8:9b3 with SMTP id 6a1803df08f44-8947df771admr103884956d6.9.1769195546348;
        Fri, 23 Jan 2026 11:12:26 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491823cf0sm23001816d6.8.2026.01.23.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:12:25 -0800 (PST)
Date: Fri, 23 Jan 2026 14:12:24 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aXPIGMVAvVEBgFhJ@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
 <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
 <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>
 <aXLCAtwMkSMH3DNj@gourry-fedora-PF4VCD3F>
 <20260123182526.00005ee8@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123182526.00005ee8@huawei.com>

On Fri, Jan 23, 2026 at 06:25:26PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 19:34:10 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Jan 22, 2026 at 11:41:24PM +0100, David Hildenbrand (Red Hat) wrote:
> > > 
> > > Right, but I don't want any other OOT kernel module to be able to make use
> > > of add_memory_driver_managed() to do arbitrary things, because we don't know
> > > if it's really user space setting the policy for that memory then.
> > >   
> > 
> > Ah, this was lost on me.
> > 
> > > So either restrict add_memory_driver_managed() to kmem+virtio_mem
> > > completely, or add another variant that will be kmem-only (or however that
> > > dax/cxl module is called).  
> > 
> > unclear to me how to restrict a function to specific drivers, but i can
> > add add_and_online_memory_driver_managed() trivially so no big issue.
> 
> Is EXPORT_SYMBOL_GPL_FOR_MODULE() enough?
> 

Is the issue just that add_memory_driver_manage is `extern`?  If so
yeah, i can just do the EXPORT_*_GPL path.

If you prefer FOR_MODULE, then yes I can do this.

~Gregory
