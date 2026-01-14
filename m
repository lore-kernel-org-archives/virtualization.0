Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385EA2FF65F
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412197; cv=none; b=HjRDUAsAthwPuevAg7Shk/pftrxCHP91RTQ9plfs05hhmdXY/rZ933Zdgn4yKX/vWZOkK3QE6SNmaxmaffBbZxjJIzx7vDOUzZ+3UKxJ/qgkIlzyosSl/w3COICxRWuwPn089M3KNPD4KDFYVUPlemtTO5L+zBy/yOoNslQeEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412197; c=relaxed/simple;
	bh=kiL1vI/3XAUWl4aE2fDFyGqz7AzrKtHTl9V5sXFpytI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8TA/5ICnuV1v7Nx37xaMihG/5hdFWGWZP626dSz6AfTMkOKoXI9vVrPLRDs/45WlFPzf5hiIPMpmfL8TY0/ZgtbelJjQpuwyxrExfIFID6spyR+3XhegjcPwbBDVMFPazeDJ08NxLz2VVGhPYUxIZGpwNmuX8i29A5nfq63zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CoS0c92R; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CoS0c92R"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c2c36c10dbso6015785a.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768412195; x=1769016995; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=figB8dzHwd2D0XvRaWeBpTz4+U95P61NoReY1arrqU0=;
        b=CoS0c92RhVEy5LcyyHwGY3z01b3R+Vb8a+FqD2xL4cUm6RecBIvGi0avq05EX2c618
         YPoyrmNfw7A9Ws0CoF6U9p/mV93Ne07Hm4IiXPLMziZrHN3AvmMliLGWlAibXV8eD5xp
         a+LM97cxsnh/bzjdecGCW67KwyCa8QKSSc3npRdLhCLFfxcSkRiIT77XYbdjVc/SHdrj
         GqMAisK5N4Es39iMZ3w8MCNK8n5hBUul0twoV11gwqCtIBFMRypB6d7rAnISOSPtzUj/
         /KIvWiZJunO/Rh0D5FVYaV587G+Vi36n4mJfsW9SAc+nrCDtsgrae5BGKrbWxR5fNnQy
         rHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412195; x=1769016995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=figB8dzHwd2D0XvRaWeBpTz4+U95P61NoReY1arrqU0=;
        b=T7g6Y4khtT4VtGv7TBk4IVcEYSuuSrhJRypm3yg7+1k8/A/s0hUoOwt/c+wQzJdpkb
         ZG4lpPdmMMav58MBV85+aHZumsoRUoCs0whv1Dq+WstfqhM/ik1MhaowY1hFfqD3BVTF
         ZsTcHY/kyLIoMJdh29ta92VXjS1AtOJVKwnWoQkA6/oEN0HFlq2JDv66rA0nTUFMFQTC
         BErquvUMmYqdzYpWgRsq4KSD7MShn6xpZrz+Yq23g+0rs5SWba7N/nUt0ppxCuO8qGjd
         S8kBOpjiNzoplOl7WomscsRfPS7edz2D3OMpVKHye55vKWAhJn/ula0O6sqokSEm1+be
         OEhw==
X-Forwarded-Encrypted: i=1; AJvYcCUediBRX1Xdr6GPwaT4ghOA/epFf/vSvjqrHCIamvusalAZBg52/8fmElITeevJ/0+HZmeYzZ3BPQsSuNGjtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOoFGzVp4qdRUf0MLXUlbJrCt2ow4BhB/5gYQMLCIP/xfPMEiE
	MGn4PMWvi89l/jOCnSgWoUwepndWQZ639uRRbdIcCs68VmpRAWFIFEpQt4UhJb40nl8=
X-Gm-Gg: AY/fxX4DL9z1MjFhGwiSovL8H9/31RuX0mmg6GpmfZkGhfBwKjmv8nYla6tvjuY7LcN
	eZl/ZKq+McqWayv/mfhIf7r3hJQJa3H0KW7lSfBq+DH1rBokt86LnWOskMAN0Z7D0fmDg1mYY0k
	hpP/Z8VSKth4C8RBoepyjxv3gOQgKqrntnIH8xf5jx9l0+ZNyPTvghPoO5HspF0DNsnSc5PqJ9O
	wFo5sVz5s28bEAj2aDvo+QAwnn8Gg2ybkyGnRCbf4N9WGjQhyxqoMX+RfuJ5sxFIurTzVhW0q8Z
	ACo4FhFR3iMm25v4hboI5est77zYTWI2/vE2bTP0X0ELqX2xSPGE3Wq3qkhDBIVicChUO1/AJaJ
	JkGD6fI004eoHAtQ0Voy7dCYKk25oM9Tmu8Y4ZvYFXZ//TnWg1EUAIEzPyJookiZz1b1mjPd/mW
	mCmL9pBRxVM3mBFIBOZ6STwZHy6TT5dhXSrbd1ay+GKQVA0VbHuW00VE4ORTtYakZmoDi+uA==
X-Received: by 2002:a05:620a:4502:b0:8b9:7a1a:8c73 with SMTP id af79cd13be357-8c52fb90a04mr537400485a.46.1768412195222;
        Wed, 14 Jan 2026 09:36:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530a6bdbdsm200764785a.10.2026.01.14.09.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:36:34 -0800 (PST)
Date: Wed, 14 Jan 2026 12:36:02 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 8/8] dax/kmem: add memory notifier to block external
 state changes
Message-ID: <aWfUAiag6khaLJpq@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-9-gourry@gourry.net>
 <d1938a63-839b-44a5-a68f-34ad290fef21@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1938a63-839b-44a5-a68f-34ad290fef21@kernel.org>

On Wed, Jan 14, 2026 at 10:44:08AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:52, Gregory Price wrote:
> > Add a memory notifier to prevent external operations from changing the
> > online/offline state of memory blocks managed by dax_kmem. This ensures
> > state changes only occur through the driver's hotplug sysfs interface,
> > providing consistent state tracking and preventing races with auto-online
> > policies or direct memory block sysfs manipulation.
> > 
> > The notifier uses a transition protocol with memory barriers:
> >    - Before initiating a state change, set target_state then in_transition
> >    - Use a barrier to ensure target_state is visible before in_transition
> >    - The notifier checks in_transition, then uses barrier before reading
> >      target_state to ensure proper ordering on weakly-ordered architectures
> > 
> > The notifier callback:
> >    - Returns NOTIFY_DONE for non-overlapping memory (not our concern)
> >    - Returns NOTIFY_BAD if in_transition is false (block external ops)
> >    - Validates the memory event matches target_state (MEM_GOING_ONLINE
> >      for online operations, MEM_GOING_OFFLINE for offline/unplug)
> >    - Returns NOTIFY_OK only for driver-initiated operations with matching
> >      target_state
> > 
> > This prevents scenarios where:
> >    - Auto-online policies re-online memory the driver is trying to offline
> 
> Is this still a problem when using offline_and_remove_memory() ?
> 

I just remembered another reason I did this:  

echo offline > memoryN/state

This leaves the dax/hotplug state in an inconsistent state.

if you do the above for every block in a dax region, `daxN.M/hotplug`
still shows up as online.

This just hard-locks the state to consistent (unless an online/offline
fails along with its rollback).

The additional complexity seemed warranted for that, but if you're happy
to leave users to their footguns I'm not going to argue it.

---

I just realized this breaks the current ndctl pattern and would force
ndctl to convert to `hotplug` since memory block onlining will fail.

~Gregory
