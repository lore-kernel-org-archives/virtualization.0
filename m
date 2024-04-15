Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4D77F22
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187420; cv=none; b=JCB8ZKdCvepjvcNsFsndR2yW9JHsbWO+2jW5IJaeY7uLXaMYUVL1qG3gbH6xQ3HUC6holT629Sbon9zARdcuGlUVuJRYNE7lV0cEioMzkm/Uioxt1e4FPMHahJjHsomyWAlWeD2JOl8t6bbt3hwtmLzyP/XTRPTBOci2bo015uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187420; c=relaxed/simple;
	bh=6QDDaFd9eTHSjGZ+Gq69MqmItflrTqKnpwZ5H6nspls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnL+TFwrcUYsxQqN9zpORcLrV4bKRGRHoFUaxwW5aWat5KRpRXiMinpOOXWgwZ30aQAlrNBSHDDBeCvduP+baz4IXvIugxS1DFAAcDJPi0SZLbb7ufltgVxtN1qpUtJ6HjHbOwVoDqQ84yDD301jWmi978JH58UlFOZxjemS41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hHkgNq3j; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hHkgNq3j"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57030fa7381so725678a12.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187418; x=1713792218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsPjsW5vGyGQYslNcZfnPrf8zdlh6X3WXkIuouRF3Dg=;
        b=hHkgNq3j11jpufAWixcbZO7I0UuUjkHt9ylHixS4YdGTEMGwtzoL5Cue08IQWZdH3T
         jbnzZo4yXbVs9qdikxeraN4anNCnmT9XLOtBEXtGO+lKL7WI0sPOkBp/XdPSOJ3kGm02
         5mEKBr5/KvHPOAw+tPfjnlCLZpAiIGuq71BWP/MDIDwm8NqzvAgJ9YBi69Se8wbjclMx
         aMmkGCYJAYvmz3bpW0s5/o4DQ/hN9zFtk4jM7KW35/D+oxQfS/IXB/vfpncFHo/1Ggpn
         cM0lgmCavQpgH8u3hkGhe1sKV0hqCbrY7Yr0sAc4VHHV0SFn62euq4dI9znKeZ90aPgL
         IK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187418; x=1713792218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsPjsW5vGyGQYslNcZfnPrf8zdlh6X3WXkIuouRF3Dg=;
        b=nKUt6mpnpm1ADcAvxreQfg1A4+8Zm7HVtLtpTTwoPxVSmihXAslkfR53HB5qoOLOkq
         dbh1cBnZsQuTmOVefOQNIX+tHY5goSqilsGU3PEq/wjxKfCD6Fic9Lkww9M12NdNL2oc
         gEjf9buQPusdNIr/PByrcWgR+vfDCEwsjOvWWOjIj11XqGvgjkOmYiPUoqzDjlL/7r+G
         Ln3mfXontKURp4EJjj/eY6nLwJ1n4ksqqd0fwtWHWCHw8k/GnsObQh1+yjfC36CuSGR1
         w4chNsZsJh3hiRygDwMURWQkmohByGsyBOTSi+6HzfF0nzgyvkyiChfkbwdG/Ruqoy0n
         IuxA==
X-Forwarded-Encrypted: i=1; AJvYcCXQk8Tmm0ibPWrR/5tHBgz6LbGGhB0K1csr9JRP3SpMbpFIpUZp/0WYOxztTk0KZ0XUloQ1JihzWQ4B2mvlKf8U19HiqXOvUyZVdwwQ8Lc=
X-Gm-Message-State: AOJu0YzXW487sFIxwA5PuK5dgnfcCJ1AS2t+2kr72m3FZeu2s2wfT9bM
	jNgr32mcAw5VPqqvtaMiw2q5D9G9dlI46pf2zUI3IkWNaCRpc2tXTxiVLD84Chk=
X-Google-Smtp-Source: AGHT+IHklOBQ3iGKHu088UkpOHw/VxcGUKSaeMTX9Gz3utwCjBi1O3+vYBQcukgR3YGBfTGMHvrvUA==
X-Received: by 2002:a17:906:f1c7:b0:a52:fb9:27ad with SMTP id gx7-20020a170906f1c700b00a520fb927admr6011866ejb.48.1713187416663;
        Mon, 15 Apr 2024 06:23:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ji16-20020a170907981000b00a5244a80cfcsm3480965ejc.91.2024.04.15.06.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:23:36 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:23:35 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 14/24] RISC-V: KVM: Add perf sampling support for
 guests
Message-ID: <20240415-cdc6d5bc6c5145f9d6f54afc@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-15-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-15-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:42PM -0700, Atish Patra wrote:
> KVM enables perf for guest via counter virtualization. However, the
> sampling can not be supported as there is no mechanism to enabled
> trap/emulate scountovf in ISA yet. Rely on the SBI PMU snapshot
> to provide the counter overflow data via the shared memory.
> 
> In case of sampling event, the host first sets the guest's LCOFI
> interrupt and injects to the guest via irq filtering mechanism defined
> in AIA specification. Thus, ssaia must be enabled in the host in order
> to use perf sampling in the guest. No other AIA dependency w.r.t kernel
> is required.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h          |  3 +-
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |  3 ++
>  arch/riscv/include/uapi/asm/kvm.h     |  1 +
>  arch/riscv/kvm/aia.c                  |  5 ++
>  arch/riscv/kvm/vcpu.c                 | 15 ++++--
>  arch/riscv/kvm/vcpu_onereg.c          |  6 +++
>  arch/riscv/kvm/vcpu_pmu.c             | 68 +++++++++++++++++++++++++--
>  7 files changed, 93 insertions(+), 8 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
