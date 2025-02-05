Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2412144A8
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793603; cv=none; b=O8S8CpAMg4YYtBSC2bLMogfUiMSo3hAUfYuMj+r1TcB3g91Z2f7Hs5yV+7BbWQhlM4qGRqCVXr7o//LXwDgUY9X4+4GSd/nOpznsChPkB6CLiYcRPIUtKrdAgvKFLVgI4HvoQJwtkB9xuQve6N06JLxKtIqZn9HW6ficY6vJ8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793603; c=relaxed/simple;
	bh=q7L8AfCkoiRYk6XD0LRMspwgS/hS3OT1u+Pk97yLlzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgEb+1IkUgZqqKIh8Xu+ViNSfrkxQ6w0i5j7V/t4wVwlAdHQrFmvlzfMN7acEu3LW/3vuj209L+Rqf7A2leztewH/3KQWrGSsAUpBChaiOlfo/NIzCReECkR6QG7MxUDK+6VFEcJrK1onDvzvBwtSYrHsG4/4B92d4Q2DUKRUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdFLoNMD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdFLoNMD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f9cf77911eso453203a91.1
        for <virtualization@lists.linux.dev>; Wed, 05 Feb 2025 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738793601; x=1739398401; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVdg6lU59UKb0/TD/si7cIrxJXLN5wRx2BqZWD8EZQ0=;
        b=hdFLoNMDTSJYVQV4cDmGtSGqDiWQbcxeoUgksLrhhHqlRlugOjiNsVDYfM6IlxKghJ
         aMDjQ2vuhnrfn7fkKzHDmmMwCq2yPuqpTZe9wcb3NWeRkYbL4+6bYQdp0M9beT5+ZSik
         pCeAkH+3ZuWr3+9SFpBKGChU1L2I116C44fCdEkwLccwIAmcyhWM8dyhWwXh3/TpVLB6
         4Guan4sJbo6kCtE1ffUjEpLVGUUU8PE/ycK2WEmXjWKkScRDA4AQ0F4SjKuXt5jyPLxA
         CQuTMKBGP99o0i7EolB6kelfLJMnIs3mXzfVajlLgxYHpdrBX7kg9d1BY5oZgyqBTwIa
         xXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738793601; x=1739398401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVdg6lU59UKb0/TD/si7cIrxJXLN5wRx2BqZWD8EZQ0=;
        b=Z96nRl9h/bk3KP9FzjJVQs+FjVu6hG3qF+BIIcK29R7UyELvOcqmsCndTyq8FRzg2b
         X7am4/yexLwuFbMT5xy7IbfXQOgZRohOfO4wsI+JL+PN1dEJkHiHbh1tNd285jcs+Oh2
         Fszd0TRMZoMDza+eCHthYPyFRLqPDha1VlWlCtYdvEATzT6z5J3Ge41/VQXznsGDat/2
         TGxxoVm2CWQ1A63jyemaUrLMIMPQB8fvRrjf8vC9vRMIg8Ix7QdGVoH0f6Ueie/OT8Jm
         V9OpbtM5bcf7AkpfvapXfKv3NdS1zJ9ECyYnITZa3KEwmSw6weugdCjPMWf4QWtkYCCD
         d7cA==
X-Forwarded-Encrypted: i=1; AJvYcCVdUZk1v/wKtWw25Cy7SO+zNJGua4KBSCVdW41Z54J7q9+QxeHyqE+PGTih1cwdAT2QxwyJcaXfaoikaV/w0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNOYq5CnMtghz/mVpAB2bQmsu58B0/4EouaCmSabyt0bb+zvHt
	vR5t5uqJxxq7y5Hqn2H5K4qB+N5Sj6w0YNXIceh8f2T2p3bLRv3HoxboWeiO6T28sZfiJezOJ4x
	3sw==
X-Google-Smtp-Source: AGHT+IEzBJXIxqY+Exe441l1aJjABmGJq/OUJpRwmw6f4+fEJCNQJEg3bbzDZBjxuP/ajdzYJPIfpzBr2jA=
X-Received: from pjbsi5.prod.google.com ([2002:a17:90b:5285:b0:2ea:4a74:ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e707:b0:2f9:9c3a:ed3
 with SMTP id 98e67ed59e1d1-2f9ffb7ba78mr1633015a91.16.1738793601045; Wed, 05
 Feb 2025 14:13:21 -0800 (PST)
Date: Wed, 5 Feb 2025 14:13:19 -0800
In-Reply-To: <20250201021718.699411-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-2-seanjc@google.com>
Message-ID: <Z6Pif2CFE0o1eOnj@google.com>
Subject: Re: [PATCH 01/16] x86/tsc: Add a standalone helpers for getting TSC
 info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, jailhouse-dev@googlegroups.com, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 31, 2025, Sean Christopherson wrote:
> +static inline int cpuid_get_tsc_freq(unsigned int *tsc_khz,
> +				     unsigned int *crystal_khz)
> +{
> +	unsigned int denominator, numerator;
> +
> +	if (cpuid_get_tsc_info(tsc_khz, &denominator, &numerator))

As pointed out by Dan, this is broken.  It should be crystal_khz, not tsc_khz.
I fixed the bug in my test build but clobbered it before posting.

> +		return -ENOENT;
> +
> +	if (!*crystal_khz)
> +		return -ENOENT;
> +
> +	*tsc_khz = *crystal_khz * numerator / denominator;
> +	return 0;
> +}
