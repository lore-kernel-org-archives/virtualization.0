Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713982D98
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188168; cv=none; b=m63ShoPMjZWGn9nxDXYE/vfitjicNHoSi1KmuEu06lg0ziXUc5oqB5GHHXBwi+Dpjolhc+bTo0vYzmfNGex3S3rBs+abrot9xrYm2aVcM/JJoLyiRnSENH1NhlajBlrl150bt8GoI+RoQ7mmj6FP9Wy8iwSgOxWpT1seQklHMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188168; c=relaxed/simple;
	bh=ozqYEnii4rkQXzes4moBBaVstK2FV6J0b7MHvEFXy4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4RweSO5JpRPn6V5njBCsdCTNM5CRcP3IZV7uz+GngDP3JyAts05bfHuZ54JP6VmHQAWYL/sb/Um+wiNR/8cFr9s/0tQC2+G0ZsHhayW0PJHl5VI/ZW1TIRSLF/bcZeUZd5b1w1WbvRjIpbDogE37OWKjJUVJxq8DZoNT9uugS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YDGk5t4o; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YDGk5t4o"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5700a9caee0so2413784a12.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713188164; x=1713792964; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik1rd9kTZT4cDzsiZg8RCbbgRc5INy51wGM0TkC03wk=;
        b=YDGk5t4ovfSgp19IIjCJ8T58kMqYxnBodkAZXg7npyiE7ocW6PAARVKE9CoUrQBYKy
         hp7UuQsPUTZdRA20cmH+uAjWZq9ITBG4ippa8P0xpspSebFSLsQ1N94tp+zWLOm+Mmcs
         GGgaC7BvCaOUze68ZXf/e15PJdUADo5JpjEWM+0BpQ6CRp4602YNXxoqMkCsHV8XFK2D
         2r01cAS4d5KTbIrKHUE4tcYV1jiOuBbaXB3JA2NZtNt7L2v2UCMg+zeLZpgENCQGcnRm
         fGsYJ4x2aIk4YhH5AHfM0kTJqJTph73JaWyKIbHWYieQrotBUaRlaSBxMM7mU2r05m2b
         aFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713188164; x=1713792964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik1rd9kTZT4cDzsiZg8RCbbgRc5INy51wGM0TkC03wk=;
        b=w65X1iO/4EmK0triwf6KO8g7tZKSa3E5h33N/IxbMllWkteqtMRDpJqyMJUqtc1Nee
         1ZxDKu41AD9ZgvsDRv7G4JRMI+aqxZGEm/FZCQvU5gk4P/lkYalIddNupIH46UQb0kIS
         OmW5REXlbtARhcNM7Wku8OozOvTSiZ7mUCbHxsdLExP2jUmvlRe2CPOZB8Ip0nDfKBWu
         nFXwd4At2mLP84KWnbY/utHQ3cBlUQdFyGyO1upVIPj5TE3b7JSbV/wJy4e5T4Hl9zzM
         nnc6wjZYBZ2s3++fFjN43KTRLx/3aG/EHbJpEz38eDYVqCT7Q9OnBfTFW0TnExir5E/n
         CLbg==
X-Forwarded-Encrypted: i=1; AJvYcCU7WYBdLTV7qOvERy5L2PdcxOLbwdIOceQ2NjpRcE8ZlDbwyxbgTWumHjRcMykPzcM4lSOZSXlJ8aNYlJb40SP5yId7zHY1n9UD0jf28Is=
X-Gm-Message-State: AOJu0YwK+D9ARPo/5FvswpCHccs2smZQJRX7GVRJr/H3gOilfmGp3sS+
	BNFfwGJhVODJU9Q6Qz7fkfGMIDQKdB7Ckj5SrRSZP2f15kGj37s5tpHM3DFoKQ0=
X-Google-Smtp-Source: AGHT+IEBkh8/VlmJkVNcbXTlR7xWxfl1Gb/HA9GDVYEQgXUvmj0tPoU+uxzOFA/Tf9vaZXoxYUtgyw==
X-Received: by 2002:a50:8a92:0:b0:56c:3dfb:a1f5 with SMTP id j18-20020a508a92000000b0056c3dfba1f5mr7405106edj.22.1713188163639;
        Mon, 15 Apr 2024 06:36:03 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id fd23-20020a056402389700b0057021b811eesm1735813edb.67.2024.04.15.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:36:03 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:36:02 +0200
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
Subject: Re: [PATCH v6 23/24] KVM: riscv: selftests: Add a test for counter
 overflow
Message-ID: <20240415-418eb2e18cfeb613d252fff0@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-24-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-24-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:51PM -0700, Atish Patra wrote:
> Add a test for verifying overflow interrupt. Currently, it relies on
> overflow support on cycle/instret events. This test works for cycle/
> instret events which support sampling via hpmcounters on the platform.
> There are no ISA extensions to detect if a platform supports that. Thus,
> this test will fail on platform with virtualization but doesn't
> support overflow on these two events.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
