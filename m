Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7278C9B
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187898; cv=none; b=q1W5ZifC2hgtqj5QKXdZDapLKZE5oOl0q/YaGmWrbl7ICjYWtQIP2TBuY2FbmyEGlRyjHHY2jcztdhy08Lvhii97zueO5asRlr3+9s1tGxZe5M2frUdCNtvg87H03TlKI3zy2EM80FyNH/HcpeJ6MY1V4bqUUWhUNwQ+p6aRR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187898; c=relaxed/simple;
	bh=5WAhOh6+YNFbemGNWCEJZjikj9RLzeY4/BZOTZkwkkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCJoj2OY9PztNytWoWkSguollqmHLDLTrV18C64kzTmPByrdPUd/rCZH0hl1WOBh+XotRU4zUSRpdr274wLPrEvgh4GLA+2WY9NcfqbGryGKOFAlWq1nJQZ+XTtiM8CqYHkEmVkJd+Qsj2bRlksGHWZ744/7nW5WueHmmta+S1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aw9oIbMl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aw9oIbMl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4187d5f08c2so1960645e9.3
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187893; x=1713792693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KE+Cpvnrr9PFeeWoK6ioKoV8XULExBLcSObfZiwRf6E=;
        b=aw9oIbMlRuzoiACfwk8aIlYy0caIY9Yi0NKAh9N6vGMEaYqrdiJ1jPLOkUnHRcOyq2
         MRVtkYqE4LjOwZzuaJg2oDq+zDwHQI62DOW1oJizHTuQY1lR0oPcZvXj5W77qHxputBX
         +Js1cGMtFR0pgx4SgV8EwzinnRAFpj00DW39lu8EfYw2NchxrT8p0zYZgp8Jow5Y9Pro
         NVfdtxo061qGT+aK6aiAkfO+3ZacboS5EcrWz0EIrlxy4teabUfmfWyJS7blCqTfFLkN
         PKSLB60xjYL+A28TsIjC2Ivu1ZuAfitij9VMX0cKIs/n/awKpF2GVZ67JXeKnlcn71a1
         C9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187893; x=1713792693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE+Cpvnrr9PFeeWoK6ioKoV8XULExBLcSObfZiwRf6E=;
        b=ldGSHDA/BFB074j6hfF96JcJfhFOETkmdQahFpiFY1ciACT5bqoS6iZhx9zolDZfrE
         7b6JX1wovEp+AB4z3PV8bFRnIWzSECs6PJobL6MvBYfpFsjq2m9UD/UgFWXTfK8xJVkY
         V4jbn5ZXYzB7TmEvY5eSOtYn4nTno2Scq7lOkR472DFP38KqAmHZ0T+LLga1DdFpN5dX
         U/1Vv4zs08sEqIRtaIuP4r/uOK6N2koFAlXi7ImDbF6DZ/JTN07i9hwzRX7XuiKbqJNr
         fZDYmAvsoR3SrJEr+UbX3fgbec6M9iqf+nR+1CPR4urb8Kfi7kHl5fMI/nxzlR4/q83a
         EZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWYXvBTnN9ONyvs9v2UHm1as8CxCYnVLoStjZFNJmxyb63/1KjMcP0JWA3mu0zDYSWjUYSHO15cdj1LLtyDfwnIYgDUUqQhXHteM+xtspk=
X-Gm-Message-State: AOJu0Yz7yyCUl2cwAm2TrQyg+QJgLg50BiX/Rw01kFGDjNQRksWiamy2
	3DUO2bekqnzzj4eiwY1qwPsA7K+Gf1DBeBpOYM2+etJsupoK4FfUPLFZdHKGU9s=
X-Google-Smtp-Source: AGHT+IEyD5MBvbEAjbw0tg7O5uE23K2svhSCaSMgsgY2nQ2IFrtDTCQqzK+yEHIFjtQaAGU4qZut+A==
X-Received: by 2002:a05:600c:3b98:b0:417:e00c:fdb8 with SMTP id n24-20020a05600c3b9800b00417e00cfdb8mr8462561wms.1.1713187893433;
        Mon, 15 Apr 2024 06:31:33 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm19061196wmq.35.2024.04.15.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:31:33 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:31:32 +0200
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
Subject: Re: [PATCH v6 21/24] KVM: riscv: selftests: Add SBI PMU selftest
Message-ID: <20240415-05af8386b8ebe9aecf37c1c8@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-22-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-22-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:49PM -0700, Atish Patra wrote:
> This test implements basic sanity test and cycle/instret event
> counting tests.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 369 ++++++++++++++++++
>  2 files changed, 370 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
