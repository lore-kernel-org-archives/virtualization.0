Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491E537FF
	for <virtualization@lists.linux.dev>; Fri, 20 Sep 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823186; cv=none; b=eRKacEd+BbMPOVCyuKBuQaYUGUaYxkLVQUj0IrBE6utAPJdrd5fVCcHau0lEEoq36OOYkoWp+GbzsgtDr4HfJE0QgMVv2s7PyQgaNPOao5v4d9B7fI+zV62zXCCgZb5yUe3DlFfIPxeznH7mOxp5c24/5gL06oqRqZVY8PJcd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823186; c=relaxed/simple;
	bh=KCEzMowm1+eVx5+kajieuV283XCegDBPGRjbQMjuUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0MdWROD3XNcOM2XasHdPxkmuVpeXJ2f3xcE41YBDVgvEqCEVMigAXjNnNHoF/5spqwsEy2qECsZLv0CPqViZpgUoES7tv4U5bYkgZzuloOxLQwB5r8YiYq3+b1T7kDgBzc93cWg07Qpq8nIr0Yog+hmlHSwuFv7iirLNa+lM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ed2OvdIB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ed2OvdIB"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d43657255so259131066b.0
        for <virtualization@lists.linux.dev>; Fri, 20 Sep 2024 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726823182; x=1727427982; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ea6kApel9704WtmafZwie6CE4udCD/ZWEKovHegrZg=;
        b=Ed2OvdIBf3vOligexbHpw9sO1fEfl0DaCRlkd4FoWKgKrj62A3ARfUk4n7mxNsK8zu
         IiLOOHYIlazl0mvPNXe+sVTD9/hNWC0vteqjMnl8of069VYYR53RwfaE+AqnTCLoLtfh
         0DDJOcts3+WN05wfT+5F9RbxbaFYFQdmjaU/qbcmH/yFOnqmzv0Cf5riefAOGx5ck26/
         lNyoUijkV/GeBG7Ge+q9sL3C94kVD3Z54j5dgho7ThB+00eVrjkzI8eUIoI3nI7m2I1w
         zqrss3xsryiSKqBBd7qEJ6wyrn/yj/G/WIvgQdUcrhXnzai5+0v6zh6lJPs1kEHmuIXC
         mUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726823182; x=1727427982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ea6kApel9704WtmafZwie6CE4udCD/ZWEKovHegrZg=;
        b=ko5lFqGuihoIYmKg/QQsMxkPv1qTpfFncGa8z910wg2ny+Cdcn23lJARmW9flhXUBR
         sEdXlyUI+T9CCEdrOgpJVoSo5Nn/nWMP5SMWNYfRNpj3iYt/MalpozhrYya7/z9LtB5e
         SXC8kf9Shq+q82TH0G3p180XD39Eoddy6OxfzxwOPADu6YrhSPgv5itbqiF2VXTmAwT8
         4YA5Mudu1IwlmPSctndUBb+noapWC4Vod8G7xarhRclm0y5Oys8HT8dBDlk6Eyo55Nut
         OHRntAR+zlJmc/l4KSb1kIHj3CsWm6lHyEFZQzhhzgrrBNNm9SsGaWTWikMsx2GReGGX
         +GYA==
X-Forwarded-Encrypted: i=1; AJvYcCW+ELZB/PrTGqSZouuzqNUGViaD/tzEzbZ0tKVMWU9T4Cm0O/QW30Vm8UzqCdfCv6ZzP8Ha1Klvag2Xq1taNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcrQVcCNB7blbNh4bnOEv/xTHWmi2vuypbSgNfpvbgKvWD406Y
	4XNbzI3BlFLC+L9T0ERpRj25j+0A6BA1E0NlgILHT42Po0DUqAizgmXVOIUvb6c=
X-Google-Smtp-Source: AGHT+IHS5Ou0XIJ4uflfTtxR3ETCTI4FJBbvqfkbaPfxDAC5XJ69GFR67U4wnEW673qhczAiNcFAYw==
X-Received: by 2002:a17:906:cad6:b0:a8d:25d3:65e4 with SMTP id a640c23a62f3a-a90d4ffcb11mr164635366b.36.1726823182340;
        Fri, 20 Sep 2024 02:06:22 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4971sm821742366b.90.2024.09.20.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:06:21 -0700 (PDT)
Date: Fri, 20 Sep 2024 11:06:09 +0200
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
	virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
	qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
	wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
	Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	=?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>

> > 2. Coarse grained memory increases for 'normal' memory.
> >     Can use memory hot-plug. Recovery of capacity likely to only be possible on
> >     VM shutdown.
> 
> Is there are reason "movable" (ZONE_MOVABLE) is not an option, at least in
> some setups? If not, why?
>


This seems like a bit of a muddied conversation.

"'normal' memory" has no defined meaning - so lets clear this up a bit

There is:
* System-RAM (memory managed by kernel allocators)
* Special Purpose Memory (generally presented as DAX)

System-RAM is managed as zones - the relevant ones are
* ZONE_NORMAL allows both movable and non-movable allocations
* ZONE_MOVABLE only allows non-movable allocations
  (Caveat: this generally only applies to allocation, you can
   violate this with stuff like pinning)

Hotplug can be thought of as two discrete mechanisms
* Exposing capacity to the kernel (CXL DCD Transactions)
* Exposing capacity to allocators (mm/memory-hotplug.c)

1) if the intent is to primarily utilize dynamic capacity for VMs, then
   the host does not need (read: should not need) to map the memory as
   System-RAM in the host. The VMM should be made to consume it directly
   via DAX or otherwise.

   That capacity is almost by definition "Capital G Guaranteed" to be
   reclaimable regardless of what the guest does. A VMM can force a guest
   to let go of resources - that's its job.

2) if the intent is to provide dynamic capacity to a host as System-RAM, then
   recoverability is dictated by system usage of that capacity. If onlined
   into ZONE_MOVABLE, then if the system has avoided doing things like pinning
   those pages it should *generally* be recoverable (but not guaranteed).


For the virtualization discussion:

Hotplug and recoverability is a non-issue.  The capacity should never be
exposed to system allocators and the VMM should be made to consume special
purpose memory directly. That's on the VMM/orchestration software to get right.


For the host System-RAM discussion:

Auto-onlined hotplug capacity presently defaults to ZONE_NORMAL, but we
discussed (yesterday, at Plumbers) changing this default to ZONE_MOVABLE.

The only concern is when insufficient ZONE_NORMAL exists to support
ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
can be mitigated w/ existing mechanisms.

Manually onlined capacity defaults to ZONE_MOVABLE.

It would be nice to make this behavior consistent, since the general opinion
appears to be that this capacity should default to ZONE_MOVABLE.

~Gregory
