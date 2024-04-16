Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0168613E
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257365; cv=none; b=rtaYfoxp1ZS71jQwyxecN8oDlgFyIsqWqSiCX6vfMsX3BzwKe4qpQuDYm+a/nN02eUl4KReMED3mZVxRsUCCO1lkb7nzVA9uOcCD7mvirJXViFq0jGbI2PYUuX2GP9q1vkhXdPvvieXCKhpHNiBMM009tLjGEPDqPEKmzOu4Vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257365; c=relaxed/simple;
	bh=9xIdHRnzV2O632j4RhG1uswWHNVqgDuU4PlluAj30g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsBEIcdFgXxlCydRckA2s+nEIRmL63FGbb2vv8BPqMSc6q5CWPe6XF4vGtnlOXAFqp6e6Q8UM5FJnRfYViUExo8b0Izyl5MbciHHcuR/k6uiw/G3SHNFNDcMOdoBFjL5bqhRp5LmNxlw26JmzP7lhpcerccrdKkzk6BSt+5yOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VfIL8r3V; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VfIL8r3V"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4189a6a71dcso1445015e9.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713257362; x=1713862162; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvwae8C2beujv4aHEun0iITe/+EHhljfurmTw9uDoMY=;
        b=VfIL8r3VWX9AJibxdbQgg8TDqLHxIiz0DHI8580h/Wke3UpbLZesJDRjy/Dbscrxof
         DNzTG9LZOXPCJcZsyur9zqBPUQR8ir+EgajGhvIEd9SYtggYZs0Ucj1UFXLxO3iCVyAE
         6ylmPUfs2HroOtNFMLdW6kZfVbWpbKJFeyGjA5wfjSAOfaaLkvRFoeeMVC87s27YyCOQ
         gqBq9gQegmqLqYm9eoANXKVQXg6yFg85XItp/mTuISWLUjh2CLEjbG8P1S7oJaPozpyV
         07Mfz9Z4nf5QW3WY1SFgLZZcd6Sbx8+diRpO96tP+Xlilr5NaV6w4YyH25HOu7g6Moec
         zcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257362; x=1713862162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvwae8C2beujv4aHEun0iITe/+EHhljfurmTw9uDoMY=;
        b=oLL1OY4b83P+zDfVDACEt+nqNtncLQ8B8hc2g1xDekhZoBgw7wimTkisyaoda66WR7
         2KIhRJGqT3vnlZrgRBEyip3iOkHwPD2fsorTufAZbNEAu0ZhMIVdp/TtD8ZAfJOsq9s7
         paL7/oKrUopYV78oMKPGnPH+GEHFiQ8DVDu0PninjY6obO9puY5OjG5FecKktjZXdI45
         s2Bf7cl28k4JgN2INdqMwEIsmbLmWiciSH482x7Ew6oBxjvDMwt5//4V+q1Y+jaHmic8
         4CC1D1G+pIhIP40rsBL4d/5mb2OZXyQaKNqM2pzrg/gnj9JKUoS3mImGmNCyQzGjjpc+
         A+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJZlz2FNB1/voeFMHTGSglXhqBT+9DXsje+LtnGPnu6BWCiBbuGW9W9Lw/RVlRl5rFLu1D5FemZr0qjXusGE4ZVZ2rBA81HNKpUTuHhdM=
X-Gm-Message-State: AOJu0YyI323EvMKCt8FmQ73PQbxZ39Arnlo0YbhuviJIGzB+t8ZYpb+l
	O5fXIxji7PIPyAXH0F3nhYAoqMGmAu4t54WwrxrPYcY1zvc/S1PUK69d9UF0Vwk=
X-Google-Smtp-Source: AGHT+IERQO7yDpvVx0Ze29NzNiatXbTnAhDW6vGus8ihCC8tUM3/GY995t+6Bsj2kugS44iI1F1GAA==
X-Received: by 2002:a05:600c:45d0:b0:416:3317:5951 with SMTP id s16-20020a05600c45d000b0041633175951mr8879758wmo.6.1713257362109;
        Tue, 16 Apr 2024 01:49:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b00418729383a4sm5208029wmq.46.2024.04.16.01.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:49:21 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:49:20 +0200
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
Message-ID: <20240416-1a9f7ea9700c4c6c3e52a1b1@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-8-atishp@rivosinc.com>
 <20240415-e229bb33ad53ce43e3534f5a@orel>
 <2a63d7da-91b6-496d-9966-e6c0a0aa6c6c@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a63d7da-91b6-496d-9966-e6c0a0aa6c6c@rivosinc.com>

On Tue, Apr 16, 2024 at 01:31:27AM -0700, Atish Patra wrote:
> On 4/15/24 06:06, Andrew Jones wrote:
> > On Wed, Apr 10, 2024 at 05:07:35PM -0700, Atish Patra wrote:
> > > As per the SBI specification, minor version is encoded in the
> > > lower 24 bits only. Make sure that the SBI version is computed
> > > with the appropriate mask.
> > > 
> > > Currently, there is no minor version in use. Thus, it doesn't
> > > change anything functionality but it is good to be compliant with
> > > the specification.
> > > 
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >   arch/riscv/include/asm/sbi.h | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > > index f31650b10899..935b082d6a6c 100644
> > > --- a/arch/riscv/include/asm/sbi.h
> > > +++ b/arch/riscv/include/asm/sbi.h
> > > @@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
> > >   static inline unsigned long sbi_mk_version(unsigned long major,
> > >   					    unsigned long minor)
> > >   {
> > > -	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> > > -		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> > > +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
> > > +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));
> > 
> > The previous version had ((major & major_mask) << major_shift) | minor
> > (parentheses around all the major bits before the OR). Now we have
> > parentheses around everything, which aren't necessary, and no longer
> 
> We have to use parentheses around | to avoid compiler warnings
> (-Wparentheses)
> 
> Are you only concerned about the outer parentheses ? I have removed it.
> 
> > have them around all the major bits before the OR. We don't need the
> > parentheses around the major bits, since shift has higher precedence
> > than OR, but I'd probably keep them.
> > 
> 
> Is this what you prefer?
> 
> return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> SBI_SPEC_VERSION_MAJOR_SHIFT) | (minor & SBI_SPEC_VERSION_MINOR_MASK);

Yup

Thanks,
drew

> 
> 
> 
> 
> > Otherwise,
> > 
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > 
> > >   }
> > >   int sbi_err_map_linux_errno(int err);
> > > -- 
> > > 2.34.1
> > > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
