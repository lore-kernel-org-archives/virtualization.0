Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39432B985
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414342; cv=none; b=C4Z9KvYq/d2zGHLEiy3w33SjCBxUa7QDALsz8HW8Qmq7Hid0aAhU7Do8vu6OiMrnR7AWw8z0ZQ4CxsCgjtVEbz8Q0plU1zOTcIGEN3vjyjj1TntV/Y/DcIuOOpBPWTYvTt7ndyWEwjkiDfrL6/JzggLHFmTIukccnS6F+AHJy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414342; c=relaxed/simple;
	bh=Ludne4UyCmokfcKLruO0U5b344CQHhAN/3PEM1PYEik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0nOz1mNUNbIOEzRflz3vlEg9K+dnWQt3UakaMrRtAlpIVo3Fb9OKGSNDLMgfhCLK/YkeDA/VgCE1g/nRo4TelSSm4kpkrdKecGeBdb8X/vB0aH3CDAcMLkpc5hWP/J0EbPVoZO2OeEo305CLSxbafG5AHt/qk0DaTKMd85c3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qjTSAqbE; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qjTSAqbE"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so204916d6.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768414340; x=1769019140; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfgGnc8yYPLi9t7dHOsu001XcSCAHL7N89lmWN6W/2k=;
        b=qjTSAqbEmlU3OGHqjvZEqAZPUipd+VEjYtq8UoP+tbKupfm0U4aDzHM50iuwqZBgaH
         Cx8+8H0+CztoILYyozuIQiL0yme/ZsytvfDMJnetjydCYUt8fdY7z8FgoERvVlUKKEGp
         KnYaPZ7rI3lEoB8tj8hKez7Nw445/QkHkD5NX+D3U6A0tvMOG3tbzFyIyyoTsbLnEI2l
         6i5rBWGqzITASFbCcKNQ8et23cLd2csUQY4B1+Pp+ScIKFPUkfxwfZgeR2XdW8bdE8Pi
         IPZpTqLUBcVd3eG0dAa7rDGVlJum+0usCyM4+Xvp7S2RiAFvYRCFpAhzmPlMEsN+Tk7r
         4tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414340; x=1769019140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfgGnc8yYPLi9t7dHOsu001XcSCAHL7N89lmWN6W/2k=;
        b=mtYPSvXnmisftOfE8nptR6VkniBJj3o4ABDhF7BQ+RfKvN6PICl+7jaTa9sIeVWEpA
         YT0bh6UAKDeHw8k3fu5RovKlWfZ7I/2YOJl2VNVatm6i7FWgIhkyA+IIS8yuSNdgC91I
         RUXOzE31E5OxTp4ukUWZ7UQgAdX8Bucfi9TnoFoRbDPowJYX98+NaW3ULh4YW+LS/Mwj
         hsbKHg/6ljdMHIDrhYUHAE1aLWkKp8kehKCNNz2b6alH1p//iYgaYLS7TNtClHO8X1wr
         VNA8jxcgH3RMN2mfxpM62EQ1vVGAJXliqaj/qT3nghhX/2XnXYcenz/+dNoeHsxxmWhb
         C03w==
X-Forwarded-Encrypted: i=1; AJvYcCWmgtv9ZJeCZcNFllcDFxwrMfM6lQvdy7aQ7db4pDTaAQryhGbvbVZLmQXEO7VTSTe3RgLseeiZqhsBg8J3dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoY2CYs9/sBkYzEmzeYOQZtyfqMyy7xFp7T+HY6bQiI/KOko7y
	5E23GZxH826tmqJ+bDOHdjEIwADmf0r1bF1dfTPhOLYNCPqhfXxtWBR0v5cN5fsTgwo=
X-Gm-Gg: AY/fxX62qMxSfzFhLMxQLDH8GwpFofMpMXG1pcVKKadMvuaSZCcxmx2KcLUSBdA3SB4
	WtnUEzfFrs60MKm5O1wUJvN6UCP6YGY7G6hhoZ3wmbh7lCdEROfL/uE09nQbOiHOJT0iQPcEPLX
	mgwfdLGfgdf2u+U5wvKxJ2lsr3NrtUcoLFOQkO4Wz16ruu3/cXWr065Hix2lFtMz937WpNWCTbu
	tdb4M6DwXPH1rD1fxa5I5qKRQYnprIYOCAiqG4Zxta6F3eXYu6aZcMt5gPlUZOY0rcew0PBzOHw
	6Ofg8Wm2DlfzD1B02ThUExJ2VdHyBIJy3NPpOLeFIRjZRMCwjPHbA2Oh4EW2ga5kCOMxqsNI/uG
	XALCfnciKwVDLIYF9V8k2V9AkawX5+cuLxJ4mZYFr6k9UMY9975Mh22+7hbCWi4ebJAVKg+51QZ
	xa2NMZIlmdnwfXVbwnY/iYhvWqkt9TvHoeS/XFcRiLOkQ51rq+JAnkG4pZhZHXQcMpHi3gTg==
X-Received: by 2002:a05:6214:10c2:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-892743cfe92mr35226416d6.43.1768414339907;
        Wed, 14 Jan 2026 10:12:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770d17a3sm181634186d6.9.2026.01.14.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:12:19 -0800 (PST)
Date: Wed, 14 Jan 2026 13:11:46 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 7/8] dax/kmem: add sysfs interface for runtime hotplug
 state control
Message-ID: <aWfcYjZVrROHfGyh@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-8-gourry@gourry.net>
 <3555385d-23de-492c-8192-a991f91d4343@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3555385d-23de-492c-8192-a991f91d4343@kernel.org>

On Wed, Jan 14, 2026 at 11:55:21AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > The dax kmem driver currently onlines memory automatically during
> > probe using the system's default online policy but provides no way
> > to control or query the memory state at runtime. Users cannot change
> > the online type after probe, and there's no atomic way to offline and
> > remove memory blocks together.
> > 
> > Add a new 'hotplug' sysfs attribute that allows userspace to control
> > and query the memory state. The interface supports the following states:
> > 
> >    - "offline": memory is added but not online
> >    - "online": memory is online as normal system RAM
> >    - "online_movable": memory is online in ZONE_MOVABLE
> >    - "unplug": memory is offlined and removed
> > 
> > The initial state after probe uses MMOP_SYSTEM_DEFAULT to preserve
> > backwards compatibility - existing systems with auto-online policies
> > will continue to work as before.
> > 
> > The state machine enforces valid transitions:
> >    - From offline: can transition to online, online_movable, or unplug
> >    - From online/online_movable: can transition to offline or unplug
> >    - Cannot switch directly between online and online_movable
> 
> Do we have to support these transitions right from the start?
> 
> What are the use cases for adding memory as offline and then onlining it,
> and why do we have to support that through this interface?
> 

After a re-read of the feedback - are you suggested to basically kill the
entire offline state of blocks entirely? (e.g. if a driver calls to
offline a block, instead fully unplug it)

I took a look at the acpi and ppc code you suggested, and I think they
also have "expect offline then online" as a default expectation.  I
can't speak to those users requirements.

This would definitely break things like daxctl/ndctl, but maybe that's
preferable?  I pointed out that patch 8 does this anyway - and I'd like
input from ndctl folks as to whether that should end in a NACK.

~Gregory
