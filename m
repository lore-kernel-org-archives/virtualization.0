Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427B101EE
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869794; cv=none; b=tZUtY4EcRyFA2MPBsPzDz1M89U/Hu2PozRFsLKBwAMgX8onJNrwRugkBhWGWNGmhxvJDl9nERmcygao0lYAN2SJh5rFHx7ZYmOGJ68Q8UMGx/zXTJgF43bJl5O7vqUZ7VDbLxTHV2s+zvojiyN7jKMMFAz3MAjUCgkRWDgSsNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869794; c=relaxed/simple;
	bh=o3+E/pVcXMqGN2IqmycMoE4DCLdrwAivCv4tvzqB9Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jssnuYZkj15TwMT/vrISiW4uc26Eb7Pa90ZkkdNrJ3ADVcUiX0wrGXi63ZG3kemwojF6oNeDarKDVl2uIqIiCjYzrNzvjKDHegfpdeNlzHtlJBgpHJOKZhFTW0J0BznsLM269O+Iud5kU2z4He7QEIXRQcONtcnCZJSSbb7bo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fP2UKl0Z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fP2UKl0Z"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4702457ccbso614176166b.3
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713869792; x=1714474592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7A3dJbrWY/9z1NTPLr/SP8VA+syiS13CnbQZQzTmh4=;
        b=fP2UKl0ZqahXDnAJ925j5dokTwp4xJpkpmB812pe+tYFFN3TVtqz2ibqk97cCddE3r
         WLc2LBe9rEsBEVfPfwpyutqOO2G4RMedLJBg7M//g8ObxWdQ6SitHewpxEUw3plYegka
         qI6WxViPN9lJ+hYpJHs20o+rd3uaJuLAnXboC4B+TjpmxdYLRRDOoNcbEhqGbHoxOFVR
         LAt0GyDF74Dp46eNZmlx3Xw9t5KMZD8sqAb0QBEfV4pMpuSKBtGrXYu0Fk1uNBlJ/Oc1
         umRXHlzgtPc8jFLa2bjx/zEHrdmM2gx+GWOsWNwvtS19DSFpnAh8eNZmgQ6XBUU0wHUO
         uTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869792; x=1714474592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7A3dJbrWY/9z1NTPLr/SP8VA+syiS13CnbQZQzTmh4=;
        b=L+u7vM0uuG8ilH5b2GQ4q1Sqe5FojjU4JkqOjMFWrh3nuiMG74jIJ8eDkSnLgaDRGG
         znt0jlSBzhhQVje7H3c8OUpnJ+4FznU6BC8Ni7SyEie7kPwkxlJA3ScfO1Ny5arywXPy
         cpn1fvqsPrgNNLuIwQTQU5TIF1KsNEY0pT7jIp7tAuC7+JiXCp1NFJdDNFxNHQaC7Mkk
         L1HbjSnRdmpIwe3RDlw7icO/phQ+KtektYGiKaWl1u1wcApVsNJ1g2usUPfeshXdlTzr
         xhCSw+hYyApVJG8UqDdQa7wv38QJBKbKyCaUuwWMXJKQqTM25Vr/SzbSjUygqmtApkNb
         BGUw==
X-Forwarded-Encrypted: i=1; AJvYcCWXxzXgy9uYsDKg+7KYphzNm/pBrUkc1UwhNKrlu2ct/zQQqdyEtrWpJKdVNT3PlMqgL8VYqJWPdSZGyn1iWLqbt97Iv85Tz/pjGM0QGFo=
X-Gm-Message-State: AOJu0YwpoJCH8Wmt+BacwbpC3iqHEO7JOYR4LYJnPSQDrLAah4ygMQQP
	Fl1HRpQfk4mWS5tdsIXkFyVBzCsTaE+luz0E0+zn7I8iW5fS+VV/tQDoSDd8WJc=
X-Google-Smtp-Source: AGHT+IGuxCj+bPVMezQTiiqaIkHubBLsXlhj+D610GPwkEGBc0PyN8R4nZYOrEBNLFuAizVxpXXs2w==
X-Received: by 2002:a17:906:3502:b0:a52:22c4:8158 with SMTP id r2-20020a170906350200b00a5222c48158mr8092139eja.56.1713869791624;
        Tue, 23 Apr 2024 03:56:31 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906d19b00b00a5557bc8920sm6916846ejz.54.2024.04.23.03.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:56:31 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:56:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v8 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
Message-ID: <20240423-b25d0b1540d2092f5370afa5@orel>
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-25-atishp@rivosinc.com>
 <724a4797-18dc-4011-ba48-445c1cb6a976@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724a4797-18dc-4011-ba48-445c1cb6a976@collabora.com>

On Tue, Apr 23, 2024 at 02:03:29PM +0500, Muhammad Usama Anjum wrote:
...
> > +	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
> A little weird that we have pr_info named helper to print logs when it is a
> userspace application, not kernel code. I'll check it in the source who
> added it to the KVM tests.
>

It was me, as git-blame will easily show you. Why is it "weird"?
Applications have needs for pr_info-like functions too, and the pr_info
name isn't reserved for the kernel. The only thing weird I see is that
I didn't differentiate pr_debug and pr_info messages. I probably should
have at least given pr_debug output a 'debug:' prefix.

Thanks,
drew
