Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FC2E719B
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067431; cv=none; b=T0GIl5a7cDD6Eex5if8mbWelwAyGWo3INzrGD+CYXehzgN39GpO2RNNCLRK6IG/KLFppDtlOMUv59MzqF10aREKKCGv2dLtOWvV9umeYa1r31Dxge3s/u/9PBUsLp+RupKLcyoux7OGu9eT/hY7WG2R8Qfw4/PyOukxWAEzPMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067431; c=relaxed/simple;
	bh=V/hxOsVp4piMpArHe7ioxetvdl4y0PTvTNEBx/lxH1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=l/SAlr0vVc3kcRn7TGFNBpJdGzOs1y+PLDC61H2JnkBu4hqJ5aAuXEcqW5vBKLUfSpG6tCozdp+vn/pwq1P4v+vGr/0l75amnnYpePoKyIlEsqr4z0q/1bHr1Bzyfpu66BmV53074JU8Tg+Xj9wcs2NsNLe9X/Z3uvcveqkGCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oyjbw5LV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oyjbw5LV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba5f794825so112268235ad.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067430; x=1780672230; darn=lists.linux.dev;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3KwUKexhBMnhxMu/5zzl7QcY3Y917Dhb3kMyW4ALaw=;
        b=Oyjbw5LV1U3ZZ2K3l9nEZWOPEfLCD4+6qvRnHymMiOdwOCiGKduU2KvtXT82LF7qWs
         gLyQrb1qPotXqFtr5isF1JPWbHl0383LDHCKylGtnv35oox7Ws+VU/GaVB2rxwdbP7Xj
         pDwLmczCFigRZ4/nVlEfampqkWKnJTYtRjdjNKpyZXzJ6MSHIIpKyWAKWZoAhR7oasPA
         plTMJWOvJ+KVTBSh236+xF7GLD+f9NW6Sft7Nx4cZ/7VfBXpu3uYV9VVRHcMP9irMVmQ
         ut16yjAD76iKNRCvvtnn2xlbcHyZLOk5vMY1j3V194DaMJEkz7OkAQG0N7CqD9oEZzwA
         hgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067430; x=1780672230;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3KwUKexhBMnhxMu/5zzl7QcY3Y917Dhb3kMyW4ALaw=;
        b=ER9uQWgnk+2/1+/KvNdY9gLbO4/Pg69bTFL1P5E1aWnwsKm2v0BWYzvzGAJ+9s1754
         Km1ORZvFtuGBgPzLdIivoXo25UsbqnEslD2gtDuUOpS/gvYh6uprUUWuBh8krYoS13YW
         JXqE4YFUYPEb5o1URgtLzGvHt4IB5kjySOFSegaleendMCT8roNqCLGZRHxhiRAZNV7N
         c2P3b7ohc8Gfi+diqYnyaXQcTgZdDEAN7T+DjtO8wZiwNZzYe8MxY4CWrmzP7jbv20qY
         5eNqg6fStn+C72Y0xwzISYwebqtHLYgozOG2THAadwMgbuFnTk0VirZUnRxio+auNK6k
         9ZsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t56fUfnFrt1Uk7UxB3OtR3HIf6xJX9aCjIawQk6Lt5En5BH39pxktDp8dyn56V1RB3MsJIf7YeHKt2PWteQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeBz0fuy75qKTytgzCJG50XDdne+fKQxB9aAyDIW8+w9Y5NlYS
	x3YvltyKbEEpAoGnw6NkeqBgQ5jXeD3yoXVnhWaATnvg15XgOoNyGLxjsRBZre0naDY4jU3BCUZ
	CdoJ2ZQ==
X-Received: from plpo14.prod.google.com ([2002:a17:903:3e0e:b0:2bf:19e3:ff16])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b64:b0:2b7:aa20:3c61
 with SMTP id d9443c01a7336-2bf36858f5bmr2472455ad.33.1780067429457; Fri, 29
 May 2026 08:10:29 -0700 (PDT)
Date: Fri, 29 May 2026 08:10:28 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
Message-ID: <ahmsZA8mHj9CPnd2@google.com>
Subject: Re: [PATCH v4 00/47] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, Sean Christopherson wrote:
> Well, the number of patches in the series is going in the wrong direction,
> but I'm much happier with this version, which eschews the x86_platform
> overrides entirely in favor of a fixed sequence for selecting the TSC/CPU
> frequency "routine".

FYI, our internal mail server flamed out after sending patch 26 in the initial
go.  I'm pretty sure I managed to get the rest sent without screwing up the
threading.  Holler if something is wonky and I'll RESEND the whole pile if necessary.
