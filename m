Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC02D7DE2
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550166; cv=none; b=cncB2O/oDKF1s6qIdtYsfKyQ1oHIMdGrihDU8SNTN7XN34XhbFvkgq35WLDsaPomYlLGzkWjNJesf9DV/7QGJKFCHqYueXHIiCjVg6VxZWnYmY2BFuFK+/qWJNiwD2huLcYMXt5HRWLif0hZGNY8n2qk1LxaAo/AZ0nTEm8/VwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550166; c=relaxed/simple;
	bh=wOC4ZkOYUETFCbDrcLvD0xJHaN+L2/CRl5PQ14lPOFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/XyDNNRXSJGpcq2oTHRgW2PXXDGBTZi9KsWuhKeR/oBdILARTbrt1c5P2ZmSWSxOmC2vqQ0lyg3LohsQKjfY1cxhqckw7Y6ozxpov/tHHEuCBYnXNRd6gKMIKZbRjXUsUmRKVNsxc//GOAvzrIC1nGFd9d7F9K3m2GcHavfmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XkdiEbdZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XkdiEbdZ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6a822068eso853817285a.3
        for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 13:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769550163; x=1770154963; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5CEx45x1VqBdZR0C8+OcuXcE46R+qBWE0zGdFKjM/s=;
        b=XkdiEbdZVxVNlTRgCnnnxn8U9o4/f7aNvJwAbMw/xvaGsp1sM6urXiHKL0bNHVDKgX
         J4vc9j3qoy9eBsBttp46HRwl8GRNw3H4txFt2BsZL4KtMyapZVFU0lUnatU6IqTqquZA
         NZvr37dNx2MumMwqc62nKeyWAcuUsGYY0Sv1YOynQpW0sN1zD/V9zwdANKNRSqGyfSYc
         ysMa/12oKyD9TQY5/Tn9XXDxHSlJ1g+kWwvVzaHGN2erLKNw4kIBh43C9Kjo31AkOERX
         WfFv1jBEi9qo9Znajl9EMrJljHyJbN/8Zq9HC5bKbK/XRH9HbyPY98r55m7UHjJqu9Nr
         e0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550163; x=1770154963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5CEx45x1VqBdZR0C8+OcuXcE46R+qBWE0zGdFKjM/s=;
        b=LmQP3N4TjVcR+hG1PPzIZzVIrT+Kbn6VvulquD8Bh6KOsZ6+Bnmr7H5IBxyPZP54UD
         PcIBgH4tSKm/DX4jEsNMaXkb+ZrL01fdSzbK7XVFo4Ds50styKRc7RKLxyeQFoZOREc7
         X8teio9Dc38d3CWxOWefiVoj3PH2rxR1ILofseQFkG2UqNux/cdgpqcuxvHPh1awTHNe
         vJ4CSVBHbgeIQQrk00dOfJLXXjv88WmdPQ5eM5KBRyoQhxaQ+vPSeUgaBDxTWm/A3Yoa
         rCWmz3pD3bp1Q7ej+TkPHHwtjyGZGGqt9Oac7StWI/CRDPrCvtuiokhAA3ief3wbSxeg
         fwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYSOCTau/qMYTZeqPKqnWlwV4RS6ovxu1/jUtlD35FrbJav7mnqxAgy/WNgyH2lW9a6qjyrFLJOJsUC7j98g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUQjCMDIhgmWKoCULFSpwTjkxJygYLxozw2qxVCJ1jbWJkQm6Y
	C8G85v9O0PlOBxDYougiSRlTnpn04Ee0xCOocFr7GZdZBMAAdTx/ZQwTdUHjPOHDsEQ=
X-Gm-Gg: AZuq6aKiv0+p20l+nApPpdAaIUY3pLLvsHiDWMqv659tc7t6vg4wRCjUHczFD2T+iWG
	hQ7pYb9HiDKZY/bHq7DLsT6qWEbYOzCBgSPQwe2aPmJnD0Zh2nOR7rJVtPY+MQulXXeBXPel8Ox
	nkdYJGF+sKvKF/Oodhogy2WTZ+7GmdIsjJbaaJlQM+6Xpu1zGq6Ni3BIN4j/Sqyz0eODpB4ltw/
	YkcvDigWStEBjqyiHDETqgoiWlVkS40t+BhFfmNxrSqSivcSUUcapFd/kG6nwJroScWZTrl94Mx
	7q/G/Wq8jjbH8snPLG0oDqute6wcJE3wiFCNiqXiLIBbhYEs3YTVZdtrd2h8W7DD2dD3Y41XEmD
	cUSt6URoM9j+tioPSkrDwELGpU4CgWjWE3ICNz7qyQUbrcG6p4HPqnMb6oGkcFXEoK7EgSb9NF6
	92WnNGzQNB1GJNGqAvUCOcY51xUlvSU/X62c6keewXHkhuPmXmzFopewYhpW3dz0JtaXbjPQ==
X-Received: by 2002:a05:620a:46a8:b0:8c7:1317:142e with SMTP id af79cd13be357-8c713171495mr79844685a.85.1769550163585;
        Tue, 27 Jan 2026 13:42:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm56868585a.18.2026.01.27.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:42:43 -0800 (PST)
Date: Tue, 27 Jan 2026 16:42:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, david@kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de
Subject: Re: [PATCH] dax/kmem: add build config for protected dax memory
 blocks
Message-ID: <aXkxUR2By_GQ9Qqn@gourry-fedora-PF4VCD3F>
References: <20260114235022.3437787-6-gourry@gourry.net>
 <20260115024222.3486455-1-gourry@gourry.net>
 <20260127133431.671e4605eee807abe84f92f4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127133431.671e4605eee807abe84f92f4@linux-foundation.org>

On Tue, Jan 27, 2026 at 01:34:31PM -0800, Andrew Morton wrote:
> On Wed, 14 Jan 2026 21:42:22 -0500 Gregory Price <gourry@gourry.net> wrote:
> 
> > Since this protection may break userspace tools, it should
> > be an opt-in until those tools have time to update to the
> > new daxN.M/hotplug interface instead of memory blocks.
> > 
> > --- a/drivers/dax/Kconfig
> > +++ b/drivers/dax/Kconfig
> > @@ -78,4 +78,22 @@ config DEV_DAX_KMEM
> >  
> >  	  Say N if unsure.
> >  
> > +config DEV_DAX_KMEM_PROTECTED
> 
> Users must rebuild and redeploy kernels after having updated a
> userspace tool.  They won't thank us for this ;)
> 
> Isn't there something we can do to make this feature
> backward-compatible?
>

This feature is likely getting dropped in favor of pushing such policy
to a driver if it cares that much to prevent users toggling memory
blocks.  

I will likely re-spin this series in a week or so when other non-mm
changes flesh out a little clearer.  This will be removed and some
of the mm/memory-hotplug.c changes will be changed to prevent the
modification of an already extern'd function.

~Gregory
