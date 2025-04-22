Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119F283C8D
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334579; cv=none; b=HiUmUxN6SzpnUMxwX/TsTKGdMykw0Si8ekUjOGKOgwK27rQvjWZ8JzQV+QlCBBlQVd/gsdo/OMwTftiC76Roz+vVAQ/OQmzpwPVKx8IN5ZGoz+8l+8bvFAfD+EAiEmLVbN7coz7xCWjci76E3bWCfP1fudDZbj+trl6IMprauNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334579; c=relaxed/simple;
	bh=u2pTJx0Ij+runOvsJmA0q5y9Kslc+OcE1AiOs4Q52gA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULKWlViL6AdEWaerR/Zzsz3O9Q3jOIhQmIAgE3xws8VOJdnNjB8KgZQ7lPdgFV+vhG5bRnjLeOrq/WqpMjECs4a4cyYRSKIkO0Hjz/tfZFlweVed94LmjWuBed9RmV2wclNp5f1c5XTZc5fsfhPSP4uy0FAc+mhu1fbwyE+lI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iT6X0q/5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iT6X0q/5"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3086107d023so5116236a91.2
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745334576; x=1745939376; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRXArVhux4Bsw70YvwQ+lh5zlccYMqH0xPXNTi9FZ8g=;
        b=iT6X0q/5tA3762UAd0EWvZHrh+nVmGOP1DtcM/dftgKWxh5QUtZ5E/SG4YiLJE7tvc
         uyJ+bP+RShG72q0/WbPHw6W9cnJPvtVirnOttdDQwYJ+aXfyPQcH10q0oYZsh+MxWroN
         p08nweoWPOR4HmwlSjIGr1/rDZoL6GWQW/l0XosxFU7b8eDunkMwCMm/JrmbAQ8Zx2Ya
         rW7jgy7juqdtcgiCXvuOwQZz6Vki9Fe4JSEs0nbKnSk2VBgOd4m293HDpRVECOO7OcQt
         og+n2YreZ1rnzebNqvQq3J9p5Jjkg7hH4gEQZKvsStul65NBKwy1SgOq/9l/g3xWVBiv
         ugsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745334576; x=1745939376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRXArVhux4Bsw70YvwQ+lh5zlccYMqH0xPXNTi9FZ8g=;
        b=qHwbFtaP2ZamTGeEy5riPosA5PQ/KmgYYtBU928sH+bdpHeeda4hkAX+SHH5gFUL3d
         pm/CL05c7OKi2wtsmsNTFVtAJc9fhre0XuluJywwQ235POWbC+eI5ZrF3wRx39fLEcjj
         ot9iY1gwmcXNtXLscOwucdu2QZLXzEtL4i4cLQleo1AKG/U3TZbUEJLfsWp9xX8B5mdI
         xqmm1qlSpruzmei4Yf+jI5zL7A83ux2MiRbiCoTBpmdlTu3TRQNf0lz3+tbMXd+IUbQw
         mOeGlMawahpe1+pU8C5ocUWScyaSUoP6HnR7tZREF1Upd7vRX+w+HBWIyX6gQp1bkrnn
         GQDw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Reb7/t6x7TSJ6nsD1WfpuZZMthPSHssgVamhjsS+j9SuFqh78uiJf5LNMKUyWANvnt2kL5sr7XRaMM59ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqvlHaOvnOe6pbRYxAKEvwANZAc4Cq7yS6Iy/aRzPTT3S+mmH+
	UReb80qBSbHPeD+81lbN9e7A4JzQFGcZrC6YBaDFS1o8tODWerEJ852t3Gp29jCav2fCa0e+oFt
	viQ==
X-Google-Smtp-Source: AGHT+IHGR6YFubcBkAQrqhkjsdDwq21aLEhFyH8uteoXFGo84CYqI3Y4PMerNLsX7Qx/XFlRMipUTrfnrN0=
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:2fc:2c9c:880])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ecf:b0:2ff:692b:b15
 with SMTP id 98e67ed59e1d1-3087bbca3b0mr26039866a91.33.1745334576501; Tue, 22
 Apr 2025 08:09:36 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:09:34 -0700
In-Reply-To: <20250422082216.1954310-11-xin@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com> <20250422082216.1954310-11-xin@zytor.com>
Message-ID: <aAexLqjhKncFyw2V@google.com>
Subject: Re: [RFC PATCH v2 10/34] x86/msr: Convert __rdmsr() uses to
 native_rdmsrq() uses
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
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

On Tue, Apr 22, 2025, Xin Li (Intel) wrote:
> __rdmsr() is the lowest level primitive MSR read API, and its direct
> use is NOT preferred.

Doesn't mean it's wrong.

> Use its wrapper function native_rdmsrq() instead.

...

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1547bfacd40f..e73c1d5ba6c4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -380,7 +380,7 @@ static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
>  	if (!vmx->disable_fb_clear)
>  		return;
>  
> -	msr = __rdmsr(MSR_IA32_MCU_OPT_CTRL);
> +	msr = native_rdmsrq(MSR_IA32_MCU_OPT_CTRL);
>  	msr |= FB_CLEAR_DIS;
>  	native_wrmsrq(MSR_IA32_MCU_OPT_CTRL, msr);
>  	/* Cache the MSR value to avoid reading it later */
> @@ -7307,7 +7307,7 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
>  		return;
>  
>  	if (flags & VMX_RUN_SAVE_SPEC_CTRL)
> -		vmx->spec_ctrl = __rdmsr(MSR_IA32_SPEC_CTRL);
> +		vmx->spec_ctrl = native_rdmsrq(MSR_IA32_SPEC_CTRL);

And what guarantees that native_rdmsrq() won't have tracing?  Ugh, a later patch
renames native_rdmsrq() => native_rdmsrq_no_trace().

I really don't like this.  It makes simple and obvious code:

	vmx->spec_ctrl = __rdmsr(MSR_IA32_SPEC_CTRL);

so much harder to read:

	vmx->spec_ctrl = native_rdmsrq_no_trace(MSR_IA32_SPEC_CTRL);

and does so in a way that is difficult to review, e.g. I have to peek ahead to
understand that this is even ok.

I strongly prefer that we find a way to not require such verbose APIs, especially
if KVM ends up using native variants throughout.  Xen PV is supposed to be the
odd one out, yet native code is what suffers.  Blech.
