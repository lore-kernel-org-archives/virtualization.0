Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58974E03
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187204; cv=none; b=kh4Lv65dOamlWEIiBxt03IQD73NjuT86qU+6E+w7mQshgdRgXeK/WRO9KQ7U+yrSVOI7eEJl0Go1V4cy8ii3kqvkASzF78XK5DFhUWHe+ZZLqeK/3pikQtpJ4YoAVGv5RcneLpWnTNIbbw6GicfSdavCip7oj+884q4qVxHzxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187204; c=relaxed/simple;
	bh=xdTgOzFrIrINaykwQW5f5NzvyMD3au3ek0a7qZ3i9fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDBUZSrgDi1aW+0Jn7YDMw4if6zcD4PnkDD25NOGTT8CeFTxpqT5E+/HSsusledhtzHZmwH843i9+HDUylS4mbt5agHk2FMmbKGikCvoJYizD4Zwrb8C4t4pCbM+7oPN8DeDxanzA/c1STpIaAzyE10rBwsKNlxM3tJTMqDikDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eDbr770W; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eDbr770W"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d8b194341eso27135271fa.3
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187201; x=1713792001; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXmg35GKlfduv7MXmhtmlNfK7GX2Rv8iwiDs44M8/A8=;
        b=eDbr770WgsUiumb5m9P9fL8pgOZJk6IwHIiC5ivFBJye9LtDIWe4w+aAmx96Q7oeeR
         LL4stNg4ApxgFI0u7IgKLMhX2C6yZAj+Q9bgxDLQ124gCocIyp/qzl6RD3bQOAKzabC9
         buMTdD5TPvcicgKBC4H/jYdy7WZzHv79WEYjdMsFMBBuVpT7q4FMMnGHRCl7sSzopaqL
         h+ecapwAwESWffIH/LfnQLWs8tFElBpwsdgMvpovoBgPgEi4LXcR0qNKqqz1BGh1bvBl
         s3GC+Ee30uxsPzxvz8V6jX4PKojX/s28t0KIH/Ex7ldxCSTVgQlSpJlxpU9wvy20zb3V
         5iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187201; x=1713792001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXmg35GKlfduv7MXmhtmlNfK7GX2Rv8iwiDs44M8/A8=;
        b=W2ZwTiQri+DCIL27SIdamvOZ9rcIiUtWU8JJPg5J3hqKy6846az/cTabdV56Sz20Be
         986Fe2ADWIMyhqrFAzDMxIdE83+tgavXoJ9QZEVz51JKdgpDR678/sMenfJhKXpyDaZo
         UWLLlncBUDxURvpjnugms8aivds6o/G8Lbh0Dl4nUmyVlaxDIU6HiC5WamoOgxmp/hnT
         CNnRyg27TpjbMcJ1tuPJG60g+1a/EPLU6lHR50gcQsVZ2UPYFd9Jxg4c4h+z/711jXct
         KovnvN1fb23rQEjprGPlkwsL29VBAD9toNqJC9ms6E9Kl52z8AVsa4S7eyFYOq8Yg/6A
         oyKg==
X-Forwarded-Encrypted: i=1; AJvYcCVtRFrUcgdAsPmyiSl/Q3P9fAobLXy0wgToNm6nalD3M97B1oYF/PlhiPQhHSXWzscdCm8SIJrQGZoKTigfT5Xd7LADaMeI0tSz0NULNbU=
X-Gm-Message-State: AOJu0Yy16eAIhWKRCYd+zeUPSfM+oh4v7CwYk4AID4qXsjtOywDjZDgR
	JQR1tAlLXkFxTiKfLOanAxynpmYGQzwsaUqQOtbaxoMEAhmI3Y57fUxPMBFG1hI=
X-Google-Smtp-Source: AGHT+IHC4az2rFSCiUuGCh3xwdRVNxly/Qg8h6dhI2uDrhLenj+lI0/6ysFeUkGc4sRDSnzFxzxDsA==
X-Received: by 2002:a2e:9b1a:0:b0:2d8:b2e:7bf3 with SMTP id u26-20020a2e9b1a000000b002d80b2e7bf3mr5838228lji.0.1713187201312;
        Mon, 15 Apr 2024 06:20:01 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b0041663c75ef1sm16363175wmq.32.2024.04.15.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:20:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:19:59 +0200
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
Subject: Re: [PATCH v6 13/24] RISC-V: KVM: Implement SBI PMU Snapshot feature
Message-ID: <20240415-74754b02ead9b89dcaef6d3a@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-14-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-14-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:41PM -0700, Atish Patra wrote:
> PMU Snapshot function allows to minimize the number of traps when the
> guest access configures/access the hpmcounters. If the snapshot feature
> is enabled, the hypervisor updates the shared memory with counter
> data and state of overflown counters. The guest can just read the
> shared memory instead of trap & emulate done by the hypervisor.
> 
> This patch doesn't implement the counter overflow yet.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |   7 ++
>  arch/riscv/kvm/vcpu_pmu.c             | 121 +++++++++++++++++++++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
>  3 files changed, 130 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
