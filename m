Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05084FAA
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231861; cv=none; b=TdRva57FEeF4d+13I2GWKYSyv9/COD14/htk1pczqARuh+X7JDW3CgA7EJyjwY2t9AOQOz2hIO50qBQfdMxUvUOrN0FyDow4/4wbW66ma+LTDA9JeNv4MaFqxIEavj4Zq927X/VfEiBWDJeyKiPPIaUmE8LL0RGsCAUr7o+oLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231861; c=relaxed/simple;
	bh=r2y5XgIeaVFD9YYVCCQXxvPJe8jenW3QZdB/CzLVRdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC7iBRGOk+eLRPPxVKx3fC0iorsNrjF8iifNXC1SMqJbfOpExO0geV2siP4xflsi7cPzCTAePNTm+eFVciiBxzUy6kncFx6A2tZ9CxoKV20hZntbQ/9QZfqFdekSGeISuhs6OAUp55eQe5Ndf1RbHBKSai36UScPQbjMz/5i0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iCr/4eF4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iCr/4eF4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e0e1d162bso833023a12.1
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712231857; x=1712836657; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWw71C7jU1cEwI+5ODGcknLMAR0yYHVr8hihh6Lqglg=;
        b=iCr/4eF4EU7QfZpTNfw9QucHJrPlu//iTBoGAXOW/+A7elIFRZznFlBpY06eeflBp1
         w/vpkqTsIFyN537xQMhZ/7FdC6gUp2GcFN7erMmmrm0XeuEK7NNfGz0qg3FYOyO21dhf
         eTfy00+JRM7t99f40VHgViuKdPyRcfsM0HNaROIc7JnewFTmEWekPfF2eXwRSY1QWg9A
         BzFPGBO2IOQKA45cfoE0Ba3exuev7jjyz28Zt5odxr8iOrxrEC5t4HXwki0gGAoTFYke
         Orm+VVjX06M0PcjzvEG1orXqaPHZOglY7b5DPiJPnXVmaFd3sMhjBHOx+6Xs6Cz/JIyr
         0CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231857; x=1712836657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWw71C7jU1cEwI+5ODGcknLMAR0yYHVr8hihh6Lqglg=;
        b=hxMTkhEhQ03CKKtAenKP591tipkASUhjH26n2mq8OAoImqmb/3DyNYA7Cm+OznXg9t
         ii4VmmDfmThDXXXxrcF911Pc89ibPXYUKemRknsiMSPOAt3qIzZQzYICtfhm4KxUAqnM
         ce9v1VjUtlccQ34Xp5nifqlNSsI7bqbvhKVKcK7hC0iXdE1Kzi3WCfB+vVusPthCPQyN
         yqmsVUNeDpgc2p7i9fLHVezzgJJH37BosiLDHlMoIwRkQKz+SaztFG+KIuyamOIpEMdm
         qwm33tSJbddB1bFPUTN607aVMD04byAZOqHpftTefZPrSOZZWYCFOtASRzX8VYnwWJ/5
         tMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9rqyLZgeIpoeLy9EgjQs2N7fKFsfMswYrlRJChRiR7RiwXdRgCzs3yohCm5pYTOM1PAXVswvobdVeYevOWbyQuXVoEjYp0awT5hG7w4=
X-Gm-Message-State: AOJu0YwHIFPyQFClkhnStMRf79ei2hXh03rVMRLfmTniBc342ft+IvnO
	CfyrCLBwKfrx1dntcZKtHv0fZQmK69kk2gfw2DoTsNmvQu/GVyg4OPAjO9ctDNY=
X-Google-Smtp-Source: AGHT+IF8SdqZ3HyZZ91FGKimTKayOc7UTusAbOGT6GeUZ2TkAX0/2dzA77WUR8ICDxbEhjc/oE44yQ==
X-Received: by 2002:a17:907:c0d:b0:a50:f172:6994 with SMTP id ga13-20020a1709070c0d00b00a50f1726994mr1816047ejc.73.1712231857594;
        Thu, 04 Apr 2024 04:57:37 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906538f00b00a4e98679e7dsm2355698ejo.87.2024.04.04.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:57:37 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:57:36 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 08/22] RISC-V: KVM: Fix the initial sample period value
Message-ID: <20240404-1c3dc9b63f80fc451d3a732a@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-9-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-9-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:37AM -0700, Atish Patra wrote:
> The initial sample period value when counter value is not assigned
> should be set to maximum value supported by the counter width.
> Otherwise, it may result in spurious interrupts.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86391a5061dd..cee1b9ca4ec4 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
>  	u64 sample_period;
>  
>  	if (!pmc->counter_val)
> -		sample_period = counter_val_mask + 1;
> +		sample_period = counter_val_mask;
>  	else
>  		sample_period = (-pmc->counter_val) & counter_val_mask;
>  
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
