Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089B82490
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187961; cv=none; b=myrOmjuxg1wgK6A6A25c9fK5BP1KPuFIp+5ocUv1ICi2fo68cbBtDrruCo8VDWTH4KOtNtitB9SmmPgAxZSSgDASD+mkGf28OZnTOpLMzVizs/HT08Uu+K91odxavi50U5Lb8jfGvcmNLX9RFgiwvNeiPm5wSh1f/E9s7B3nzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187961; c=relaxed/simple;
	bh=47KwHEpTElLjbNjsJm1t+l/GmTOAMw2E7SYcceePcgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPXpDWNrlj9k0QhYGQYI6cCeVqFzbFk6TXifJii6zThsNqL+Ih8thpde0/kOVf+lQvszKoUnQCDOAZteg4qU5eC+7qsw5OdRDVcM+R/gJu0dkRUVCzV3yp5v8khT0J8Ub7yAzHrjoHJnt13zFxQtMEt1go8gC/FnqB+hG/bhepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HDQx0Ea5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HDQx0Ea5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so17641485e9.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187958; x=1713792758; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfFnCtrCdaYweGdW7b/X7wLS8PykVIhbaLaFH/3RBKs=;
        b=HDQx0Ea5zOv8Di7tdkRS8uN4fxWGOGakCLltQUyvhU7H2RAMwYQiYGf2djJ9R75VYm
         M1Sp3n29Rp16n27C2ADX1MfrGMdsOL3qwbwQuZKriSUPfaXoCQLEloquc1qiJ0cCHWBu
         VCmrEJIoFDnXGvVg6J+OlBqVvosUr/qJAXaooXalpLIIN7HxgcuRVbd4P5xxEF/LAY1t
         0wxTbNxPT31/NNozWazbQTEdBmGoWRFYxU5Lk2+HDB+wuKOMqM0lbnfk1Ec3qy2UkRvG
         5cgNlMHtT9s0CSMgIZ/pI1614JPUelxwE3/hQTi8lAi4/9ZqJWXQGTVA6WuIFrxB0Zrf
         3JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187958; x=1713792758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfFnCtrCdaYweGdW7b/X7wLS8PykVIhbaLaFH/3RBKs=;
        b=o++HE0uVIDWT/8ugRBmF+Rfx6vJlqscE8V1qmljGHejc7odDRd6X/30Kfa2QmtC4ZP
         uo2/9vLBYsgxu1OurAQesvCUHOV5D4bK9r6TFgqNFNvN8rX/+5rYR9TlAqRJGy3u0RFW
         yfzyH9uU2OmFRFwyHlRfPA295QZAjdY8QkGEmR/69/Rpj8tjgiZ2mTO4IXS78/6JxCkF
         btVY4a5m6sNBstjXmiTP6gY9fhNesAphqBGVF5au3RXHAvlmX68YbjEIkzEmAD2uDDNH
         iXx7CSlmv0VH726r40ceWsz61YnQlp4BgoS8Nry5er1cCxWIE0avUaS7A/LsJ1c6bfnF
         zlkw==
X-Forwarded-Encrypted: i=1; AJvYcCVCHc+1ZIYPYAs1TT4au237sHfAhPH4uFIuL993l0gZtO4cff6YrQGmlYXJwvRJZs16z7Ir8sfzLHavP/k1JbtsOdQkpTOYMB2O/seiXgg=
X-Gm-Message-State: AOJu0YzKCPMytT/vwpYZWx6MooHqnqucDQC/7Vvc1JJMole92U9uIFCh
	Smy/Gi40c7MoDHs0n2m0uPX5rLAWCgjOuPp7QBS8aR3zVvYMZpXAb9P9Hs4RNbo=
X-Google-Smtp-Source: AGHT+IFoZFoMz1NB27raXr0+F36UbAh0bYI/huPwqdYpnuJ5dY1VU+ZBhab3Ez4blLLhX5Tys86QcQ==
X-Received: by 2002:a05:600c:5115:b0:418:5e81:415f with SMTP id o21-20020a05600c511500b004185e81415fmr2552795wms.14.1713187958349;
        Mon, 15 Apr 2024 06:32:38 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b00414659ba8c2sm16357094wmq.37.2024.04.15.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:32:37 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:32:37 +0200
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
Subject: Re: [PATCH v6 22/24] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Message-ID: <20240415-f6d8638ff922ccd58d1abf41@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-23-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-23-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:50PM -0700, Atish Patra wrote:
> Verify PMU snapshot functionality by setting up the shared memory
> correctly and reading the counter values from the shared memory
> instead of the CSR.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../testing/selftests/kvm/include/riscv/sbi.h |  25 +++
>  .../selftests/kvm/lib/riscv/processor.c       |  12 ++
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 144 ++++++++++++++++++
>  3 files changed, 181 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> index 6675ca673c77..1b995481a3fa 100644
> --- a/tools/testing/selftests/kvm/include/riscv/sbi.h
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -8,6 +8,12 @@
>  #ifndef SELFTEST_KVM_SBI_H
>  #define SELFTEST_KVM_SBI_H
>  
> +/* SBI spec version fields */
> +#define SBI_SPEC_VERSION_DEFAULT	0x1
> +#define SBI_SPEC_VERSION_MAJOR_SHIFT	24
> +#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
> +
>  /* SBI return error codes */
>  #define SBI_SUCCESS				 0
>  #define SBI_ERR_FAILURE				-1
> @@ -33,6 +39,9 @@ enum sbi_ext_id {
>  };
>  
>  enum sbi_ext_base_fid {
> +	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
> +	SBI_EXT_BASE_GET_IMP_ID,
> +	SBI_EXT_BASE_GET_IMP_VERSION,
>  	SBI_EXT_BASE_PROBE_EXT = 3,
>  };
>  enum sbi_ext_pmu_fid {
> @@ -60,6 +69,12 @@ union sbi_pmu_ctr_info {
>  	};
>  };
>  
> +struct riscv_pmu_snapshot_data {
> +	u64 ctr_overflow_mask;
> +	u64 ctr_values[64];
> +	u64 reserved[447];
> +};
> +
>  struct sbiret {
>  	long error;
>  	long value;
> @@ -113,4 +128,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  
>  bool guest_sbi_probe_extension(int extid, long *out_val);
>  
> +/* Make SBI version */
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +					    unsigned long minor)
> +{
> +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
> +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));

Same parentheses comment as the other patch.

Thanks,
drew
