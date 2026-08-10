Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743383D9DB0
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370193; cv=none; b=Qb3KpQ26z0QJ3h1mGad8MNdCUcilBkoZoXzaHsfz+kN+iiJVPqemhlJENzGWZTNaA+LFVQZjpEDyxxV9VB70xmKZbarhtp7JOQ3fO52hDPW3n/F2Ar9nXJW3r++0mv+agqNVJoiM8Z06WroXAWz+/abCQ8aKEedsRNXTbXEz5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370193; c=relaxed/simple;
	bh=T4h+0OngmiFLBNepEjU3d20+8UJV2w5wRPCm1XE6zT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAttsJRHIbE/MgQ34y5fxWfD3dfZ/oIuB5t8Eidt9wa9KFeldjVhdCoe1lmvMA8RXcb8tYCK0j5RwQn2T6V5mg9BiM4qL+4Iq7Nri4oKyOyfHcG1oTVkblCzxhHNgIzjC8dquj3DiiUvJgL9x+MS4LirD1OqSTaHk9pMhBJuezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVoxqVSx; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVoxqVSx"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so46409515ad.2
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786370192; x=1786974992; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scUOSvWK83pq1cJ9Y23cB7+1ZF4+W+kSdr2X3LP0fns=;
        b=fVoxqVSxYkduSOFbjvc8ClJk0S42eYldS4hGWuI7oIsMZyOiK9uoZAg/1gX6U0yasa
         teK6JrCwKfZJHgXF9FOm23O/IRh7YYRp82LWo30F3+9g8MNsZULmYjaqLq93SOSlCjo3
         DnIDLGI2hypGhsATQJq23gMvi9VgYSLMWHTPowHoUqazmF6rdUI+RzwIbDNZPY2IfOgC
         IwyCtYl7StLU+v2EDcpTmnnlf+FNEIIlpD/eIp4vv4vFiB0KfTVT1iytfASuIJhGj0d8
         Mg6t7FgFh5NDLEBZSXK8poiW/PE3ZaKodlyg7DkXznp7oaZj1mL/27cf0TYCAv1xABAv
         fAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370192; x=1786974992;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=scUOSvWK83pq1cJ9Y23cB7+1ZF4+W+kSdr2X3LP0fns=;
        b=B2XhXWlcifEz7vfaD/7YpQgWsYHZcq0n6qCoEB5v6TM5VMl0gG7Hp3lPPepfYjIPs1
         ADXum0foUqEuH+Cu21znkvVuLyhLJFJeBWmQu+m+ocWBT27L7jK2A3R/C4KZoJevlROn
         9MdJy+IpJAUDCbmB+917epAbWsejKzhkbkSkrjUVs/A/TB45Fn84qYddj7iw5+MwbosT
         VtS5UZWKhCISfGdJbvdaOA8Ld8IFKeZ/fnX91xXLE7ImdvEQH97G3QOw5cZYy/vjqbaR
         u68MQ1D+rHHIe5jPuXn5KYm9IDfuRLopcOxqlszcpCzjvapkALmF3OkspXKg85R26eXh
         vj8A==
X-Forwarded-Encrypted: i=1; AHgh+Ros8UJgitB7I4ZZ5VRojV4bkvqey24aXGR5N72HUeqjAJ3pIWsKEypVRNJvpqxM1Q2pgK0dZ2qeZSaNaMW/AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuzaCVAurNdOAhxQ4sJPMSYKAlKJk21LnMYlD57FxSqu3Tr/fr
	v12bAhtqEwr+kVN8XDoHpZ+XoBM7PNxXCExSM6WK2dKVjnkXU4HoOA3xt/Sse2nd353/vblCiYS
	W+VbB7A==
X-Received: from plml3.prod.google.com ([2002:a17:903:1843:b0:2cc:7ef7:ea41])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:13c7:b0:2ce:9c48:22d3
 with SMTP id d9443c01a7336-2d30033718fmr21913835ad.11.1786370191619; Mon, 10
 Aug 2026 06:56:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 06:56:31 -0700
In-Reply-To: <d0ee3cf97854b904323db3799e05117d065a6ba0.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-14-seanjc@google.com> <d0ee3cf97854b904323db3799e05117d065a6ba0.camel@infradead.org>
Message-ID: <annYj0zj68hH8zIu@google.com>
Subject: Re: [PATCH v6 13/51] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, pbonzini@redhat.com, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, jan.kiszka@siemens.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	jgross@suse.com, daniel.lezcano@kernel.org, tglx@kernel.org, 
	jstultz@google.com, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 08, 2026, David Woodhouse wrote:
> On Thu, 2026-08-06 at 16:35 -0700, Sean Christopherson wrote:
> > Mark the TSC frequency as known when using ACRN's PV CPUID information.
> > Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
> > the TSC freq is explicitly provided by the hypervisor.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Huh... does this literally get reverted completely in the very *next*
> patch in the series? Kind of weird, but I guess in some ways it makes
> sense...

The literal code gets reverted, but the functional change does not.  Before this
change, ACRN is the only guest-side PV code that doesn't set X86_FEATURE_TSC_KNOWN_FREQ
when the hypervisor provides the exact frequency.  I.e. this patch allows for
making the "No functional change intended" claim in the next patch.
