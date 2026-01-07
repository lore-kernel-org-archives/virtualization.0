Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com [209.85.167.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C08331A6A
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817501; cv=none; b=Bodksh4mjvnr2RbnjIXURhFaCf4edGnZeHB8SgbKpOlJit7g93Ky9OePft88LjOHYb/4vMSAXCNEcaEfSWZTHg4t/FL+E6gXbOrnrqUwZ416+QhzHtQdU4UcXIezejGdJWOU5We44yBwfaxDBjpHPeyTJj7coq99UlBbYgjhV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817501; c=relaxed/simple;
	bh=r11/Ufcev321fPtyC477taw82p3yQHKJeJaU6ETpkWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXWjpxY0yPgK4wcjlUHAP6Av3Ygvi/Tq5GN2Rvf4T7Fk1X94oa/60zBgKQ281m18mEpxDM7lNQEjmch62RImx26fYsD5zyFOhyDGmND3k2VAX+KbTXUyS8R1kaCAY7Wfo+shPli43mta8BZJ1e8gW3rU64R2EnzUAmzA3huXfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gaDqNg52; arc=none smtp.client-ip=209.85.167.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gaDqNg52"
Received: by mail-oi1-f226.google.com with SMTP id 5614622812f47-455dc1cf59aso1499156b6e.0
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 12:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817499; x=1768422299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AojCRT0od10+Ud81n/eLNQSyI9wJA2R4G5VpVEYo8Tw=;
        b=NHfX4VhNTDccaDqMg1lSm+TWX9XwTrqhhxl6fyxkx0D6p040neWKKcNrmRl3jiFHd0
         8TwZR6TFQgGL+LqJ+6GCKTPCijLFk2ngjEnQTS5/GqtAIIksieIhUKQ6n1wPfc3NBv8o
         I9vYIyGpGcklSwiMb53EkYhUiP3VNk5UnBwNAbyAcNao5I5BQy8Wb0yxGrXq4KIbQikJ
         SBRc7/nMYyGI8SyxzC4fS8BP4EzmRep3kyNqUOO7YvPggRlYpN3p0Fhuz2n8+3Dza+j0
         HaFHqEuVJvB937lIYRHeyEhg8nGYyhlmglSYbjQnR0deH5T5HA/QpiWG+GcKuzNaCwzj
         H0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIn1ztX/puqohnXasb0ryTuTM7vUYrAVp08x7njegailg35p7NU164MLiAwZHktPBHcjMiFUT1BqDo2KD90A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+5mhs2jbYqpxeFvEh2YM1v8R6h1SAP7/wn4T6pLCSK2klz66U
	26tjLBAOiQ6DbIn1yFJGHzsMcHWDHL/uacm0hTpJ32OLgrYZte7qn+BXra08cGgXVfbTJJkvR5V
	GaY8hZ15EAlkc2qE8ysqFYiV70n8WxRdir1+1YN0apz5jCWxj2QBi95helCJbGBleh/O8VF67th
	Nt5o7bm+5wdfhfGJQymxFkqBhsvHxWehw74zBgQbdAUMDvZoIkWYYT8566J7P8ZAN6Rdsb852Wd
	pKJDreiobA8Sa2AjFkOWhYc/w==
X-Gm-Gg: AY/fxX4jHUYKHxt2QsxyT+N0f/VM7579TqjuO690+bsKnoeCrMg1TGJs/BWznr7as1b
	FBM9OF4qRVB2C/mtYsUc5thjMYrIvNR5fJ7wDCkoQjYHuenxJ1+qsWCL1faRmUvWq8nP2WomRj3
	NdLCptlxzjoK9fr9oxS3y/fbcoKA+PCF729vgVDV92DSqhslpkfWO8WGm/sExs/4/95I2PUIdt1
	0QHqzn3YIdGrv6cR32q1kMbXTdUpZ6PQ5o9YlhagEy4ND+mzMxzhSkrcTCU7FlMPAUbN/YzSIx/
	5DXXhQy5/XfqHqLEn7X70u7JNJFXP824HOqxYL2hazaUyNMYmiDDCJGN+7u0RmjGOCRSA5das9Y
	2IJ4UbUrgopCkMv4Ri7cm6zPOBUmIxKCK752dQvobCwdBZWyfHanjk4jSdAkX8FKXzeXwfDfL/9
	MI6K6uVPfKW6p7QTEfNAF0eMNVNphAjUOcWSI5MtCVPMspcQ==
X-Google-Smtp-Source: AGHT+IFdgNjGxD7/XB+Y6Nlotnv8epdxlh1r4p448HgKnsCt5GXrCKqdEJEuD6oFXw3+9kv/XWhFVhFn1tcq
X-Received: by 2002:a05:6808:1451:b0:453:50af:c3c2 with SMTP id 5614622812f47-45a6bea491bmr1519469b6e.50.1767817498860;
        Wed, 07 Jan 2026 12:24:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ce4789e847sm898217a34.6.2026.01.07.12.24.58
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 12:24:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c38129a433so629662085a.2
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 12:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767817497; x=1768422297; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AojCRT0od10+Ud81n/eLNQSyI9wJA2R4G5VpVEYo8Tw=;
        b=gaDqNg52BrnE41wR4FL+5gKISVQ32PPoFk3sRni55uNi9OkVExIyEeoK6EyugvV8/v
         4G8GNdDIcIdDO6gQT3I1amRHDuSdNBo/4ccA70P0zW4gb1m8uf/uWDMC8TDgPt9AuPYp
         WEZ5Z+04R3v0Ey7n8fFzEgadfptwtIVAllb70=
X-Forwarded-Encrypted: i=1; AJvYcCXzEITpkQNFcH7ukpMZC5t9yBK6ZXpuMtpvIX7LaBcDzneh9GBfDG1eLSQJ8yYBnYBShBJAXQRzxGjw0E3TPg==@lists.linux.dev
X-Received: by 2002:a05:620a:4804:b0:8b2:7536:bd2c with SMTP id af79cd13be357-8c3894188a8mr512813385a.78.1767817497596;
        Wed, 07 Jan 2026 12:24:57 -0800 (PST)
X-Received: by 2002:a05:620a:4804:b0:8b2:7536:bd2c with SMTP id af79cd13be357-8c3894188a8mr512809585a.78.1767817497067;
        Wed, 07 Jan 2026 12:24:57 -0800 (PST)
Received: from [10.66.193.70] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b9c31sm437112185a.20.2026.01.07.12.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 12:24:56 -0800 (PST)
Message-ID: <75651326-1d18-4db0-8995-ff4dd6dc1da3@broadcom.com>
Date: Wed, 7 Jan 2026 12:24:53 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] x86/paravirt: Use XOR r32,r32 to clear
 register in pv_vcpu_is_preempted()
To: Uros Bizjak <ubizjak@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260105093944.52387-1-ubizjak@gmail.com>
 <20260105093944.52387-2-ubizjak@gmail.com>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20260105093944.52387-2-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 1/5/26 1:39 AM, Uros Bizjak wrote:
> x86_64 zero extends 32bit operations, so for 64bit operands,
> XOR r32,r32 is functionally equal to XOR r64,r64, but avoids
> a REX prefix byte when legacy registers are used.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>   arch/x86/include/asm/paravirt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 4f6ec60b4cb3..59aec695ae5f 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -577,7 +577,7 @@ static __always_inline void pv_kick(int cpu)
>   static __always_inline bool pv_vcpu_is_preempted(long cpu)
>   {
>   	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
> -				"xor %%" _ASM_AX ", %%" _ASM_AX,
> +				"xor %%eax, %%eax",
>   				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
>   }
>   

Acked-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
