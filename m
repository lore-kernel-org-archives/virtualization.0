Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C932E62D9
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410461; cv=none; b=sSsv/KQ6UnNWcOB7cBIdARrrigHfYlN9RZ/IAUEpKiOXHoNWUONEtH5FFe+yFvU7YgZKEWNIv4YnWQ8vkrKiN3z/MLKgHWrR2ODTgO6SHmilRAXz/RtNu2EZpYgPm9SjrWgn+JbE7UpRjpFnWigdk97oTyj8vosbwi4BG2u0MEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410461; c=relaxed/simple;
	bh=uQspQgAYPv3Cb8Bx+9DY3tUvsrynhhsH1nDv4+whjaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOCepLFImlAaAk8XiPg17NmryjrmfkL0pUTZ4JCVjVKSvzsaKndSS4u47HTsQ28H8Vh7ctic8Ie8N4H1bf/MeBdpGmYq1mzxTfPPxq2FI9gcVrWnM/Qbuxot3qAj9faX+at8Kb/+GMknFz59oKo/zYZX6/2V0UJZpO0HhdmzsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BtyO1x3g; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BtyO1x3g"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50150bc7731so22261cf.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768410458; x=1769015258; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RFOwDQBVEpg9rej94TvEUAdCP3OvqZFUczDhVsj6Jg=;
        b=BtyO1x3g2lktzGu3iRJbVPOet7Gm7p6NReDB2dbdhrFOQ5AB8iJcElYN5pQa3/FwX6
         Z0YmyIwdUtHwHT752mBEChD0fXKQDlFymbxBTcoHwFFY5WE05Bxbe+GAxIkVq4vzBMrT
         BuWOXepmJj/4elVgrEocMYVE7Rl5FlZXFAuGgZkgc9njZ33Z4BDEjZjrmuoDwrRIvA4U
         Hr2Rz2O9aY03YLeIJngquyr/moAGlg2XDYZmXDg216APyai7v7GeXWwnnwcZA66Us0pH
         N1zvVqYkqB1zDv1nxa0rHSYRhzokODmGpBFIsNCdsaDrH60cRaLztY2hcN0I8S7nsC/r
         VP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410458; x=1769015258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RFOwDQBVEpg9rej94TvEUAdCP3OvqZFUczDhVsj6Jg=;
        b=KWiQ6w6oIfeNN1kNZVIsGJHSfG+fC4BHZG95PuNfqgdLQWjaZgGqbB8aipHLtZgmm2
         O8DCq3VZrx6vN9qNwcsPZ+dtKusPp0XZuX4sbK2Q9tPAHgQCTn3/+18mPFfWG4II2ulA
         ZkDIuXaHytX+c5X/zp3mWRI2Rsevb9j7Rbgs5M+ViNL9NRCOuKxB4lYCdK/ytH3sdOtC
         uReAmLMIefN+WjFRs22PIYos8vAnwyDfVbfF2wOXo7yDpRGT7ynGib5SF5TMHiI5EXBQ
         lgyN92rge+ALAPYN0mN8WPPooxtZzxwhe1wuUeISYUfZBCF9vw+RBqmyJPhd0eh10//J
         4QjA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Agi4qaP0F0n4JbQ4iDw1gWelSdGZ/rK/qf3fxzW4skM8n+8fZUHqJsn0eJowFDpWEVIK1NKCLqOiA1QEnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yytj0iHpXJCdk769FxjzoeoRp3qZs7+bmxZ8vAIT1gpa8HDkkzN
	7cOpUvBeiggfc+4liTuDEFBBZZK82fvLvJKQJKhy06HOABhkr/mhWsxWTpEe4JT59a4=
X-Gm-Gg: AY/fxX41+92qajb0bj9UyEWw2UgydaynbzJkc0U1cB/yhhS9rhwYN9VORa36s+g2tkF
	dLUBZ/IscakWQnK7m4GOsr7w2utZMAPSlBKG2rUcZN8JU9U3XcSP26WsA7vlZvW4mm7ZADBCgin
	MIG/7KEE4YrAZW1he7jx18pcBm81ERCHoo3NgADuGWkogqDWxQGMJNYGUf34CSh/dprPIuP806k
	NWnud48/CxRDxGiTWSQGhYiWgairxhUTtIMtxM8c4Mgz4VkRSL2HGDkmfCqkZTQfGXWZOVAlib2
	vvnQcf2afD29zT9pf/Yvutm0bk5l4tnxAe6pZW3WPCY4UAhMuY6tk1YgdpdRp0/Qai2jsUQECqb
	wSaMOW3M7Un4VoQEoRF3ZD2OISSkeACqNAgeImakv70F/BW+AlFfkTdLLlnqkkWb+aQfFqSl/Ej
	HPqJKbaXc33a2WDGHpSMtMazqmSNFNeaAuyWZNgh1sdxK23M40ySIhWCzflO7sTR6rC5g+IQ==
X-Received: by 2002:a05:622a:4203:b0:501:3c88:131 with SMTP id d75a77b69052e-501481f8ff5mr39550561cf.22.1768410456999;
        Wed, 14 Jan 2026 09:07:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148eccd7fsm17076341cf.25.2026.01.14.09.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:07:36 -0800 (PST)
Date: Wed, 14 Jan 2026 12:07:03 -0500
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
Message-ID: <aWfNN-hy64bGw6p2@gourry-fedora-PF4VCD3F>
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

I suppose this commit more than the others is actually an RFC.

DAX might not want it.  Other drivers might.  Now at least I have the
code to do that.

> >    - Users manually change memory state via /sys/devices/system/memory/
> 
> I don't see why we would want to care about that :)
> 

Absolutely critical if we have something like a CXL DCD region that
wants to try to protect hot-unplug.  But that is probably an argument
for implementing this in a cxl region driver than DAX.

> >    - Other kernel subsystems interfere with driver-managed memory state
> What do you have in mind?
> 
> Not sure if this functionality here is really needed when the driver does
> add+online and offline+remove in a single operation. So please elaborate :)

See above - so yeah I'll probably drop this and come back to it in the
sysram_region driver in CXL.

~Gregory
