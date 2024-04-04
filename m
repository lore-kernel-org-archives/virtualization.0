Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1A8286B
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232123; cv=none; b=rCExPlzzl/v1xHI+hBkO2kt8vQ0iz4KDzEzvh/guZC+7JdgZ5Lx4z8Zin89/9gE+3OKTGwcLaSUsZR8S/9xvi3qbiWVD3xrmiFkfkzUbYr0lrEkQkJotWHSEvZGjd8xubK6AOE0uWt014gTPY4KSdqeGkdYGIL9JIX3HxiSqYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232123; c=relaxed/simple;
	bh=W9ko0RfNE+S1DiS7+KgLkrYBPHmkmYztpcltRdxaN5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6BO4GC9trS/dTwxjPIs07DYf2PhnwC+nHsAHb5I0ElQP6AyVx3kUuEX8rL7sB6IdoAruBoGF9soSzU3BzxkNv0J8ars92s/+JfKDue6dF0FGPJv2hK8z8UiT4qYeaFv5WwDcBe9yKqnDNTmd6x2Vd4LF0GYQ+IoU59uk7ZdpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Fp8TbqZB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Fp8TbqZB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a47385a4379so380873466b.0
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712232120; x=1712836920; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6sgTwxk9jhbJgHBwC7uiEgEw3bNU/OxwYHoyLaglJk=;
        b=Fp8TbqZBhxXwmJQUMEENZEX5wLMGrZi9X+ymeflSgfrpUe9hoL4EPTxMqwtv8EyuGG
         WieS/hqpc2PB0IgmA/uckyVrhITB53hYpgw6ewQvAHIoQTBv0T36PYY9XfhRBdYrmoz4
         4cXGvj9v11BtPNwIJVaCRskzA/6COrLKhhy2XF1z/M4G3u0CLIp7nLDFVmdv7obalfGt
         jH1akeiSA3L8w3LXVpJG1o/NBDthmuJv+IbS3ufZ8mEpPVy+YO+sLC/HwPl/VZJrnEAm
         CKGo28rmsNZWpy11w2JZR8PStLz7j7xoGP7jZg9wBzx87rpUBYw1ESGcDLzH4lI6ZH+T
         ImGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712232120; x=1712836920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6sgTwxk9jhbJgHBwC7uiEgEw3bNU/OxwYHoyLaglJk=;
        b=XDc9jkU5I544oVDlE112hjJpGJHaDb6xwFtdwbSNCJQ/hiu63Bvj5JF4bnF4xEGajT
         dTL8FuPGNuOY76ag8Gd/u1buUDBSblF3BPz2oMrJ+lNHQ4N/A6RBlEM1JVEyNjbfptKh
         icCruqpJhGNIG8IHmNfi9D0ckMqT9XGqgBFQf5AUlXaois083AbfiZhuuJLHnDZzDcYa
         /YTeEXhkx7GTXET7M4k3/m8TxO7aDsXFPWk2zzjBLw7WL+0NFuUlFL3HIapVrT2Jvyls
         nyAJAfblEtVS58K9rATXthl8V2X/LbwHH/EInENKJo40m8orpOeaqevvcv+pvnvK620D
         x1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW2l3rnADsoXXznmOB7ruK197phdjZwVgfLUzPT+TfVAtiypM1XoEUUVERzPCtM6GoEO4HpK9Hy+3ViGL4moE28Dcw10lhCkuf2XTGdaJU=
X-Gm-Message-State: AOJu0YzWd9CxQtK7nsATY0638j1xpXPhWAIe+blnH73ftjt5mWPjaNqm
	xCizP8xv9EbvtBM2SU3e4mFRhdzssyEgJvBGbkCLZJQRSmUSkjmYWyhtIejg/i0=
X-Google-Smtp-Source: AGHT+IFp9TuLXZRqsWbkDSS4HE72CGMNStdZzxnFkRk5hlzliQxjfRqdZTW+nZQ93k29lkL/Bq+HhA==
X-Received: by 2002:a17:906:f912:b0:a4e:13ee:5dec with SMTP id lc18-20020a170906f91200b00a4e13ee5decmr4834184ejb.17.1712232119747;
        Thu, 04 Apr 2024 05:01:59 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id la6-20020a170907780600b00a4e2db8ffdcsm8202481ejc.111.2024.04.04.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:01:59 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:01:58 +0200
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
Message-ID: <20240404-bbfb02e3aec944f9e11745ae@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-7-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-7-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:35AM -0700, Atish Patra wrote:
...
> +static int pmu_sbi_snapshot_disable(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
> +			-1, 0, 0, 0, 0);

The "Rename the SBI_STA_SHMEM_DISABLE" patch should come before this
patch so SBI_SHMEM_DISABLE can be used instead of the -1's here.

Thanks,
drew
