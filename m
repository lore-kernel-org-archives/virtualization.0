Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87D1DDC1D
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296730; cv=none; b=qN38Z2dR4K5DyNgttAfo/VtxW/I9TWyWkHYpLmbh3WqPp2W8xwnuxtSK00pudmNtpNa4KbasRH0mFmsgrmiaxHXYAUkHRTaFg50yRHkC5jkKpe1vTngkQ3IRZpes6t5VaUlWdPA59HFl1Tvyo3XEqik07ZLKpAQtfajNB1J4r78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296730; c=relaxed/simple;
	bh=ZIicm+KVsGD+UXLKJQ6xU43zvhsJHugkh0vLpA6ilxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nPa32BZaodGJvyL7yylLITGGWbNe87uteB/g9zMEU2R9x5HQASt7IBMqPwDiVn9u3MBWGFklieqUHqpzWVjUeSy5bOTOtN8Z91uU/NClWvlm0MIIAbCMnD41ixbzxrK+Y0u7s3BpnfCPhP4Z9vw7MmVcHoCqX0MjLa5LZXM4D6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUeUlh5k; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUeUlh5k"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so1039354a91.0
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744296728; x=1744901528; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z2Z/UC7GMxO7YogACXn6KcfTpVXYjk8lDSafrd3aGw=;
        b=UUeUlh5keuvdJTcJ5m+LZXuygkbQLcrFLP2Y4XjoFcHuQgGSrcApc7P+37hJB2iYKk
         +B2n0J3EDLLUiP7ZUYX/g6jr2S2mirY2pfpmUSyNH10yze8Ddfp5tCoR5naiMOe9GfpT
         9Cyt81SQ2agJZlw97CJGnPMj2/dL5LlaB+PPQ31hsi16erpt0updjxs11gPn7WSQ/Q3y
         17r2TAFREmQCMNb3GX1QiQBkLdVBJ72Vz5j14/Bn/FOC3pIhxT8BpMzf0Uz1TfA6CbUR
         n5ThEbqN9e0nVoyQhnStgOn4XLZ3Bo2etv0OCPfRB/hOLaz1vcBNlvetK8frC9AzDsuC
         4Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744296728; x=1744901528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z2Z/UC7GMxO7YogACXn6KcfTpVXYjk8lDSafrd3aGw=;
        b=KeOv+7tN+o/p4XAtysMf4mrKyYmB9fi3TmrFiqyIjbpNWMUwrBij88BwEEoBtMAUSu
         cfxT0ptnqL1foC46HOxPn6za82MwrWImKxzlMiN6PyPpOUAcGmBTKFDYvoHvxHPoDpKR
         2+04kCgqLv2TZ9x5tnJH5r7bgULagpVGR+VFaR26Foa059FFbgZZ7TFlnuC2UOAYbLae
         6wr+Sc7h0iz0IEdY77k/zGR6UCEOIVgS7UADAvA4otsSOjYnUi/5bdzN9uC7UbpwKz9k
         6MpjF7yGc9G2ozWQoCv4BvnHHq6uzxU40/tB8OK1x15IqXKnqugQH6A5KVLMpm1e/T5Y
         M0pA==
X-Forwarded-Encrypted: i=1; AJvYcCXuGMkeKaLpdDFIXnaSOsdv4cnKEtfC/gRiyD+P6yiCIa6SvhgOqF6vmHtEdN63YmwMeBxGqafXuRC0kJon9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8NoJ0TsA8Ie+AsUKNSNHZoVhzo2qC8Pb/RkA7cIDlhiUpRyIK
	IaBwFSMD/nQ9+e6umJjIYEqNd5lkqfeUZb6afIzY3GqrD5YexPEIT0/5Xj91aZoCgrHajQvyB5p
	GcA==
X-Google-Smtp-Source: AGHT+IGZay7VOQfADYHvwp0kpNoQEUaWaWhAXxEPULjNq/g/UaMADWvkJQ5d2IT2MEsdoUp5QTqBbaB3uao=
X-Received: from pjvf15.prod.google.com ([2002:a17:90a:da8f:b0:2fc:2c9c:880])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5844:b0:2ee:db8a:2a01
 with SMTP id 98e67ed59e1d1-307e9b43a9dmr3689922a91.30.1744296727781; Thu, 10
 Apr 2025 07:52:07 -0700 (PDT)
Date: Thu, 10 Apr 2025 07:52:05 -0700
In-Reply-To: <BN9PR11MB52769DDEE406798D028BC17D8CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com> <20250404211449.1443336-8-seanjc@google.com>
 <BN9PR11MB52769DDEE406798D028BC17D8CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
Message-ID: <Z_fbFcT3gxNK_dWr@google.com>
Subject: Re: [PATCH 7/7] irqbypass: Use xarray to track producers and consumers
From: Sean Christopherson <seanjc@google.com>
To: Kevin Tian <kevin.tian@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 10, 2025, Kevin Tian wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > Sent: Saturday, April 5, 2025 5:15 AM
> > 
> > Track IRQ bypass produsers and consumers using an xarray to avoid the
> > O(2n)
> > insertion time associated with walking a list to check for duplicate
> > entries, and to search for an partner.
> > 
> > At low (tens or few hundreds) total producer/consumer counts, using a list
> > is faster due to the need to allocate backing storage for xarray.  But as
> > count creeps into the thousands, xarray wins easily, and can provide
> > several orders of magnitude better latency at high counts.  E.g. hundreds
> > of nanoseconds vs. hundreds of milliseconds.
> 
> add a link to the original data collected by Like.
> 
> > 
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: David Matlack <dmatlack@google.com>
> > Cc: Like Xu <like.xu.linux@gmail.com>
> > Reported-by: Yong He <alexyonghe@tencent.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217379
> > Link: https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com

I linked Like's submission here, which has his numbers.  Would it be helpful to
explictly call this out in the meat of the changelog?
