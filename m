Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0613E04A
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821524; cv=none; b=T3Ofc5cMS1ePmttt/3hPOtBTzXhc+/f7x43DfJ05+17kCkBMq7y3j21S3T+fCauMpvxLLaXwyVBmMDhd2ruOcu7AHGeVrGaib2LH4OX2UGWjdW8ijORNQie972B2aFlXAcsj+koD+N4No4yFdYcFBYdwZCNo9/Iba5Qvw+kKGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821524; c=relaxed/simple;
	bh=jVTgERzLmYSTnbK6BX20guTVY29hU1wrqk54ruOXXcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckc2BVKRsB7bW6Dxf6+Q+UAsdWdkbquOdQMfx/GWCoJbvc01pzQjoN9ll9o7/7IcNyAEy7LoqCD4rWDh9LopGkWUZq/hsddEByQdycGFKvDYsmKkzOSGrR4z9YFf0nY2aFmcUq6TyFrgwPpze3Yphdxhntz+hn8i3d5SGl8WPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=n7ImQdQr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="n7ImQdQr"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e6f4ee104so4153629a12.2
        for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712821521; x=1713426321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aH2Dc8j8I8xIvPcUDdCDU7Xxp8EkAEDRyp5XNqYeoic=;
        b=n7ImQdQreOFAVKpKhkuMhQwHp2e0LcM3dseRTaI2gXkTUTMQBHXzNNYl0vePueRkUa
         j+yPDciRhKAcKbdTePMvFLH1lxmQ7rMnbEVXotHRqcqGZie1iYd2OCt7WC3Wj+8vU+EO
         k87vlU24bIVyMXh6o4AxfMIHlo3nCxF681lSR7w+4Fq4so4zJIYbCJWDegP8Fc0er9vW
         w6CcxlVKGjgkj4R3y1Ofijrly4qQ1N70zIGYI+LYFzUqbhA32Q09M75cmVQjepFaaNOa
         DMfMyjC+Afyqq3RWzmZVwk4k8JO4LkwrSX6JyJWWQ3JXsX1SzXjkzXoRBbho5HRLjwOk
         a4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821521; x=1713426321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH2Dc8j8I8xIvPcUDdCDU7Xxp8EkAEDRyp5XNqYeoic=;
        b=E4lcyO3g/lxBDskYh5gOHUg9YntSBmRUIdL/V2IXagjSdxRWQxXJg5K8UsufzbaV2C
         agZm91TIJZdfHW3odDivagb+KJ3xVVyuJ76yk1U2AZS8kVPeOIlWuj416Q+Jj8DGzpMp
         T29p91RZKW4tc9yZMQOsUOamguP1oU5PYVhPc15KCH4z9EV3hrXUL7rJeR7k7X16yUwG
         3G+LraYsvnROFKZF+X0GtMLuAhxvnKgkt556Fi3yg8pWe+iOzI541WvUBR8TtJllHCOx
         yJOPmiOl7YJdr46GD8yQSCjS6yLTn+JFLLMwBRw9xgm4XVtTmEKLKVyM6AwemQDtlNAP
         rV7w==
X-Forwarded-Encrypted: i=1; AJvYcCVlI5CqcGudQ7fqP6In6myyvl3R91R94Iy9QofZYNVn/4FvXq9v1M0mHbdDjn/ySAV3o8B4a7GnViOsbGs5A2UVFyi1x3yxUONCm1V9In4=
X-Gm-Message-State: AOJu0YxGp3JvboOEjcVSrwgIOaKqJ/sYDxibTAiVAXD/iAN/gN/cvTSL
	R3AXPg/RMjnyuZWHqmMsfr7Za6i3h8ZPcoMb8to69PqUl88Gj/VO1mQNIld8RK0=
X-Google-Smtp-Source: AGHT+IGXjQgcemnZ/eu1Pazqcv6W8xDCpaPihHKrZ7vRNQjLlX8nqWL204fGLinJDjejI9EZkPgjUg==
X-Received: by 2002:a17:907:7f87:b0:a4e:6b81:49db with SMTP id qk7-20020a1709077f8700b00a4e6b8149dbmr3626235ejc.8.1712821520961;
        Thu, 11 Apr 2024 00:45:20 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906561900b00a5223233b4asm278978ejq.117.2024.04.11.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:45:20 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:45:19 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 06/22] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Message-ID: <20240411-688dc97b08bb3b63511dcf6e@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-7-atishp@rivosinc.com>
 <20240404-4303d1805800fad18b6d9768@orel>
 <170cc87a-5b55-45be-a0de-213aabd852dc@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170cc87a-5b55-45be-a0de-213aabd852dc@rivosinc.com>

On Wed, Apr 10, 2024 at 03:29:21PM -0700, Atish Patra wrote:
> On 4/4/24 04:52, Andrew Jones wrote:
> > On Wed, Apr 03, 2024 at 01:04:35AM -0700, Atish Patra wrote:
...
> > > +static int pmu_sbi_snapshot_disable(void)
> > > +{
> > > +	struct sbiret ret;
> > > +
> > > +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
> > > +			-1, 0, 0, 0, 0);
> > > +	if (ret.error) {
> > > +		pr_warn("failed to disable snapshot shared memory\n");
> > > +		return sbi_err_map_linux_errno(ret.error);
> > > +	}
> > 
> > Also need to set snapshot_set_done to false, but I'm not yet convinced
> 
> Done.
> 
> > that we need snapshot_set_done, especially if we don't allow
> > snapshot_addr_phys to be zero, since zero can then mean set-not-done,
> > but ~0UL is probably a better invalid physical address choice than zero.
> > 
> 
> Agreed. But I don't see any benefit either way. snapshot_set_done is just
> more explicit way of doing the same thing without interpreting what zero
> means.
> 
> If you think there is a benefit or you feel storngly about it, I can change
> it you suggested approach.
>

I don't have a strong opinion on it. I'm just reluctant to add redundant
state, not only because it increases size, but also because we have to
keep track of it, like in the example above, where we needed to remember
to reset the extra state to false.

Of course, giving invalid addresses additional meanings also comes with
its own code maintenance trade-offs, so either way...

Thanks,
drew
