Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179219F48D
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415435; cv=none; b=KwaWDa1Xz5oXhW+CsxI+eMA2FGUAeyocCeqv7LdGe1YR7ARYTLEaUfRYXH4kw83yS44mrQplckm6oBuoFP2/g0OwodT9gk/a5Jl4Dspz5VJA3tEo1m3ygE/NqUkKR0IwJbu3k9psgCnX9nWxORJZPxVtECn+qM0kmNqEjmPoBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415435; c=relaxed/simple;
	bh=dXr0vdvJSE4CQmBa2fTuILJV/L6G5HpSxSHQ49PKVqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PXpLq4EDHWqhEvcevBKFVRuTvClHoAcav68EWGHLWbcMb4f0t/qc6qXBl748FD4Lhuu08ZyHwmNPengRBJQPyq9I6yMjSOnZxl5JOBSZI7SHCRszKVIwY/ofAfLphETfZgxcg2FwdxkAzSESYE+KZhQjCOaKQJeauy4cwALIIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViCKNHeR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViCKNHeR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3055f2e1486so9192647a91.0
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745415433; x=1746020233; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTV99TNe8c9V+BGz9HYw0E5RTZLdGwFx/9m2XgmuzHE=;
        b=ViCKNHeR4hKtz1fF2/sg1frL4tUwq5vfKLfB3VHAoyCMhgWe6W7S/Rt7Ac8iy3hUAf
         W7nVHQGW+/h4AzfpdaesTM0RHso5eJ14hiOHULxbkNerqSmU7Lyt1EGwDqmAW951YRVE
         PmbCKrgTq+Chca2b0SIcrodBRjpCK1D5M6DwQMYZ5M7SutoEeAZqAmsO6D3ybeIeA+I5
         bcS2d/+kS79kjDJbf9SP61sLPxQiPwhlMRevayO1ZYzY79VdXuk5Yc50PiCwVw61MmlV
         06wutRRevqq6CU28pJFV8gV7YoGTs97VPb3txa+WoJV/d7zLAy8g1mMom8N8LskVT6Z7
         rmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745415433; x=1746020233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTV99TNe8c9V+BGz9HYw0E5RTZLdGwFx/9m2XgmuzHE=;
        b=OxC1HBwXbe50hjtxZNnKCWVw6xIyqO2cHUwvTe+Y7xWs1Ojdudt0Ccc5N5SsJqo2lf
         NduT0xOQTA+4hcfjyDPLKAoX4m2ClGHMkySm8rfu+T1C2GlfuAix8gmyTGp5nRj2ItcK
         UeC+NEgPFqjjSG21P0Gb2NoiaWj9MzINBlgm9v9yCNcR9t2NSTk7TOv4RN9mBG79DKLA
         OM+Rx4ea2f4kwnFDqxPUptqU66uNHFjhUG6pJPRjinQo61RyTCzUoRPi7x/jyLs8M354
         0OS4JWH8n695qsHjSio4nKGzpRANC+Nr1zpU2qO5A9JELTfQm2cZAi9kqXS7Aayl9ryF
         Uobw==
X-Forwarded-Encrypted: i=1; AJvYcCVpX1xEh2pBECz+wVXj+/g+bes+k4AhE5BIr8BoCKdZTE6bdKurNw5k9TCc6o8tAwv0+oTBRNefH6T/hvxekw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxA6hfYKkbIZcav8eribJEQQtMnN7At4TiOpCKRU1rHkckEz26Q
	P3nDPs+PGjwKWnS/C7fr3zAlZRUJsyMFXQ0aE7W/x8yu7o5axtK1h9UJ/wq7eiSnvgjVpJ1uAf3
	EwQ==
X-Google-Smtp-Source: AGHT+IEWS42km52dkYFlmcKZWmN1wttg5SPG3JN+o4kIB9LzXEDLrbHh1gdrPp7a64YZSw75FwPTF5N3xvo=
X-Received: from pjur12.prod.google.com ([2002:a17:90a:d40c:b0:308:867e:1ced])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2650:b0:2ee:9b2c:3253
 with SMTP id 98e67ed59e1d1-3087bbc9333mr25668631a91.30.1745415432973; Wed, 23
 Apr 2025 06:37:12 -0700 (PDT)
Date: Wed, 23 Apr 2025 06:37:11 -0700
In-Reply-To: <7527f09c-7163-4276-b9a4-edac6c8217ae@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com> <20250422082216.1954310-11-xin@zytor.com>
 <aAexLqjhKncFyw2V@google.com> <7527f09c-7163-4276-b9a4-edac6c8217ae@zytor.com>
Message-ID: <aAjtBxzvRgNt4Uzr@google.com>
Subject: Re: [RFC PATCH v2 10/34] x86/msr: Convert __rdmsr() uses to
 native_rdmsrq() uses
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org, 
	jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com, 
	pbonzini@redhat.com, vkuznets@redhat.com, luto@kernel.org, 
	boris.ostrovsky@oracle.com, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 23, 2025, Xin Li wrote:
> On 4/22/2025 8:09 AM, Sean Christopherson wrote:
> > I strongly prefer that we find a way to not require such verbose APIs, especially
> > if KVM ends up using native variants throughout.  Xen PV is supposed to be the
> > odd one out, yet native code is what suffers.  Blech.
> 
> Will try to figure out how to name the APIs.
> 
> One reason I chose verbose names is that short names are in use and
> renaming needs to touch a lot of files (and not fun at all).

Yeah, I've looked at modifying rdmsrl() to "return" a value more than once, and
ran away screaming every time.

But since you're already doing a pile of renames, IMO this is the perfect time to
do an aggressive cleanup.
