Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029374429
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186401; cv=none; b=D3ZP6GKUVJ2o3j959VGNaFw0N3PHwWghLuqkoLKVGriQZ9+05vMLE6m1NJrvByugI5jZlaZ0LcaYkI6yrblrHy70WwKbLjsQh8PMLEexc2E5toKiQ7ZhGSnBn5jaWPqpqf3OJdzX/IVZh3rMUwJL8/2mAy7rTujwZsNxZAeCat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186401; c=relaxed/simple;
	bh=ROXk9XS99J8mzxWv8tUd/6Kf37JaYFVRZLkuT1TMEa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHCOwCLPfX1Jt2rujkNbY1f6nAXQmyASXLxAbneOc5YQntqvAWZyxPtQOMoQUqZDy+0A0p44MhfULQsZC88VwQHmb1JhPh8c368LENJouyabb/FRJOwaRdJY+//vJrBuE3v+2Xm2TB2OsiFsfbbo7GHJaCLzNeGC/iRV9M5V0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EF4kcVpy; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EF4kcVpy"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so30411011fa.3
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713186397; x=1713791197; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+QRCDHPbz+mQnU+rPEOfZ5PlBfWp32GZiq6bjgpQeA=;
        b=EF4kcVpyPXUF49SqxfTm1l05ojSzzxGrpan+obTq/okqKFYArAD7ZBn2+8qZVeOrPZ
         rgDYQQQfDvIQ8pVO5fBBUaH5ETGot5r3CcbBR4jJjBkHbfexs41iXSc5e7LIslfmSYGC
         YDe7sVRDkGNwALvIiCdZP46SFPtfPthYyzZeDDJn2XAyeLTxnPTAolC3O+ny+GAyJQb7
         hHhzmVTa4myAjBo7CdPPSlBWZ51rMcm75g5Q8+IdGs4u80NfKQlGGWM0B/Uv9Ha3HTrB
         udtE2U7YUCG6YlyTDxBeSYcPMH5yQcCPycazYEBy7JkwKq4jtLqRv571Ho9goFbT2Zyv
         ioOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713186397; x=1713791197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+QRCDHPbz+mQnU+rPEOfZ5PlBfWp32GZiq6bjgpQeA=;
        b=EJdzdvAmCZdmVG7Ux4PvJwKu/CDMp8jNuo2TefygWNx3MNSJg+jeHr6PrORRURomCG
         9ikqV3fuPndsorxEZ4yxWyLSAHqRYzPT52JFcEQ33shzoxK7yVx3jpyGekaRogs3P6mZ
         MhcEUM2qHh921w/0ox4WJk+hDdiqP+qZuSjcSeLkcI7myTS7+buguSAs8+lGVoJ/kWiN
         tnAy+jK4pm2VqZkcDDGtS4vtxb0MJ+/KjakY0fXEV8YDbh4fq3hhV4lDfkw6yaJgEnvR
         /XOT9DuU4NuxNj03wJGYc4DXkR/B4FodD4GtZPw2VDufBSdWUbhEmEPe62hmxFl/wtT5
         9jeg==
X-Forwarded-Encrypted: i=1; AJvYcCXD6sS7BnconOD0tcmj4dFR4lhwNsego5VamjuHG6qsWe1PC3jsrWDi4NyGiQZ+EFM9D6qfMvPpY6eIDs/9NeHP+8FyKsPHw7C+BjSg3HY=
X-Gm-Message-State: AOJu0YzzkPq7j8dZr6dYWdlQzhSLv7v3RrMT0G/eao6n2nRqLEMQzjWm
	rC/KmixOpkhJDzvRQmDWs8NY7BSMoBKoRd2LERt5PVNTLxOU8M7kh5YiP2zurbw=
X-Google-Smtp-Source: AGHT+IGFmVnC0mQLQib6YvAkM+B394OqmZQ8G1VQ5hm0jgJqcVKUD4C5OhCM3fHue9y8M9iXA9JCIw==
X-Received: by 2002:a2e:be8b:0:b0:2d8:dd28:878e with SMTP id a11-20020a2ebe8b000000b002d8dd28878emr7797631ljr.2.1713186397221;
        Mon, 15 Apr 2024 06:06:37 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0041624ddff48sm19436126wms.28.2024.04.15.06.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:06:36 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:06:35 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 07/24] RISC-V: Use the minor version mask while
 computing sbi version
Message-ID: <20240415-e229bb33ad53ce43e3534f5a@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-8-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-8-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:35PM -0700, Atish Patra wrote:
> As per the SBI specification, minor version is encoded in the
> lower 24 bits only. Make sure that the SBI version is computed
> with the appropriate mask.
> 
> Currently, there is no minor version in use. Thus, it doesn't
> change anything functionality but it is good to be compliant with
> the specification.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index f31650b10899..935b082d6a6c 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
>  static inline unsigned long sbi_mk_version(unsigned long major,
>  					    unsigned long minor)
>  {
> -	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> -		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
> +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));

The previous version had ((major & major_mask) << major_shift) | minor
(parentheses around all the major bits before the OR). Now we have
parentheses around everything, which aren't necessary, and no longer
have them around all the major bits before the OR. We don't need the
parentheses around the major bits, since shift has higher precedence
than OR, but I'd probably keep them.

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

>  }
>  
>  int sbi_err_map_linux_errno(int err);
> -- 
> 2.34.1
> 
