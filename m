Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B327F7D1
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228260; cv=none; b=UWN6U7D0XLBXT0Zvg9dCinpsb75y2CUnI2lL2IkhmvbmOClAJV6A939NDvg19zPzkHYmLuoXWb41Hc2tffovNj5eiLZEKz2FIQrolDcPZs98TBQPFpzY9dMLqJHemO4IUWmUk65/lzX1W9OTzOSYpqBRBba4ZjFeZZBsFnQSvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228260; c=relaxed/simple;
	bh=ABMMBOx08NYLaWVA70cAng/zCf9URmS/qE7QPN7wSqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4ipEi/ZOqO4kTzcTKgOmWX4R0EPV065TXh4O+JOKq+ojDNdg5BKSL5IqFTWcXj0F0/c5JIBNNtd/OoJC02RfGtQZdSqCGVur24Tcf4j/kVPUcy7xNy1+1adeiblK/De8T0TlnOqPxfAY55BgxsNmM0g9jF2q2jowTAfYo5OEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Zl82u+ru; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Zl82u+ru"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso391744f8f.1
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228256; x=1712833056; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfiVdFmLV4FF6ye93fatZUexM6Nb9SSia8q2nnOXyFw=;
        b=Zl82u+rufkPYAs3T7EWVIHW5OBJc3ZEqCxUY4+zLwFx+4UW7+zYW1+k+HjcsE0EFo+
         oKzMtW7oxapzmyxPPjFXPp7SlowJHz5274Fy+Gg0V1WoiiNEiWc7qUKbjwrKMY6vVQ0O
         4zEV4QgNURqvKfy2xQ9mFxzqEdU/A9cZnzIbBvaGkggK6Msyyvp3ngkizKyjpLbwCeCS
         WunSAafiHpDyq8EsJvY/yfOhV4D3KYhgcAXsewBEriNL2HEATxn348Luggzg2rTC+VwP
         qv0dEXdbokdkm6fPlp5H77FYKtWKehfzLBP6d9iEZYqB8oacI8O5gCzN0nUOJCUpIwHu
         2l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228256; x=1712833056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfiVdFmLV4FF6ye93fatZUexM6Nb9SSia8q2nnOXyFw=;
        b=DhyoHJUz942ml2Z9yT2qXHwzTilCWuQ96n5XSuGvxHD4syoIBIDDy3xQBnJ8U9c1hX
         3i/VOzTPrAfvv+UKeth4dbYgJevCoDytJSDIBRA3nLvFJEkvYuTuv21+K5GTSQ/o+8ic
         g9tvZmlAbSBkPsjqgORzL1z7QipPOdJ1J8p03/w5v5VKkXwajehwtrL1r4n/qxT0j9a2
         TbuHY95fml81fIzQ6WQIOOcVsrLx8k21IRYU3YI9ztMqckjUj/F6kfKkPgoo9x7w2/Ip
         76THLqxCBBftnAvuT145KTXMm9C6UBYxbfkyqqkGk8ui+eUTB/urwZuPSWWucpqY4k8J
         GswA==
X-Forwarded-Encrypted: i=1; AJvYcCUCTPyK6C/pqh1RNH/APQjjKEu/iCMPRHiQvUmKa05x0VNViNACP+CovKu5cnHtDpfnk48WF7AMu/7EIqYE8vh6yULFPLEoyAajcDv9Mp8=
X-Gm-Message-State: AOJu0YzcnHaw3KdTEykfoXY9HFQDeeC3B1B+SOkUmYoNFkW/QySyQJmx
	HAHiUWhT/CeGCpT57JA24uHOjw1b3hrsShnn7WCItgIYb46mNtXCM+ycepqfFdA=
X-Google-Smtp-Source: AGHT+IEnFxataSYbqmGau+kOJUtlvfE0YzrGrXzfyVqVkslxmfUNW4m89ij6/Ce78ACjrYhuGGGyAQ==
X-Received: by 2002:a5d:51cf:0:b0:343:9fec:eb35 with SMTP id n15-20020a5d51cf000000b003439feceb35mr1526223wrv.24.1712228256052;
        Thu, 04 Apr 2024 03:57:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id bo15-20020a056000068f00b003434c6d9916sm11436771wrb.110.2024.04.04.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:57:35 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:57:34 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Anup Patel <anup@brainfault.org>, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 02/22] RISC-V: Add FIRMWARE_READ_HI definition
Message-ID: <20240404-6fc14e149cd82bb0ee8f088c@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-3-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403080452.1007601-3-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:31AM -0700, Atish Patra wrote:
> SBI v2.0 added another function to SBI PMU extension to read
> the upper bits of a counter with width larger than XLEN.
> 
> Add the definition for that function.
> 
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..ef8311dafb91 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -131,6 +131,7 @@ enum sbi_ext_pmu_fid {
>  	SBI_EXT_PMU_COUNTER_START,
>  	SBI_EXT_PMU_COUNTER_STOP,
>  	SBI_EXT_PMU_COUNTER_FW_READ,
> +	SBI_EXT_PMU_COUNTER_FW_READ_HI,
>  };
>  
>  union sbi_pmu_ctr_info {
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
