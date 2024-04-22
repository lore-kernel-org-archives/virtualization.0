Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174F18E1F
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763505; cv=none; b=XbYJE+Dp7OXcyb+YPlFp71JCqt/wgCcY46EfO2Vrxn3YGF/FDK+/u2cpb80LlQjFkviqd9ehqvfxcKXuz5ff8V+A6CygWVjHOCS2JyufNttk4Kq3jtKhcQk8GB3CSwdeufsGd8tPTYBttT16jiZtSIML5IdNmk4rM31DOj8Kx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763505; c=relaxed/simple;
	bh=Ik9DM1QNpRlU+dZ0CiUmfKQUt5GK17SQR7pdunVTi1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HM8OXm1XDeu40C6g8h7fNfrx2abK+cx0lMX5vza7bGutpKKKZbbYQIBkPWpTcCfRzrm07Xcb9A5lShgrRfHUnsfZhohqmDjSq6Vm7EHxEbaTBeQJfYwAEt1A/EWYpw9hpN3Qm/keusG1HiECdiqiVCeYqzv6u5zursdfChUlXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=MFSIraAN; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="MFSIraAN"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36c0ef5f7ebso1263665ab.0
        for <virtualization@lists.linux.dev>; Sun, 21 Apr 2024 22:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763503; x=1714368303; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF7iMXOY4VDDCKv5qNAPNo7XCDSpEYvkOWLnZnfiQso=;
        b=MFSIraANS2eSH70U/4Z3KwpXCTMGqvJg3zmmhh3jj+ePGWIvUyYuWaogB55LlNLwYD
         RJC2sCAWrpFMyohAPTv0m9/8MiViM7WitcwhQdoRsOlRkqW/tvT7q+jXu1sYqdxSOxJY
         PFd1Qo6XB/vt33Jsk8mNjR24P9m+Y0JiD6VGVWB9gBqNfWymX7qSDfUeUQaZe/TciFXD
         rsGHgzvb90F2Hx1EAOXLy4vnDsewnjOkrPCro47L8RDctYHEIRjQHQxMw1lRd83QUmBX
         l9x8JxRde8G6Tcj4pssWJcsjpWl61sQQpBtcs/xCyDd1HeopsfHtJHgbL9DUTHejnSfB
         4B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763503; x=1714368303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF7iMXOY4VDDCKv5qNAPNo7XCDSpEYvkOWLnZnfiQso=;
        b=bM+45/iS1jz+wQYoj3ZNZ76Er1xy2JQNKmctGf1A73sitLScKCCc1GstX3BGGGF1vH
         kwL2ussWN89KNcapu7q3iXFGClBd9GGkIl9uV/TXMCzDF3VDDj2L+zXDDoDR756gK+gM
         8DvvzIXIjjGBR9IP0shTiwf+ydJefwgrvgFXmkZl4PtA08JhG1RM0hpzDfyEA+VX6O8M
         Sibd/n2EnrNrWUDDSRWvH1icvZKzHKVAdpnu6+WAQvJe8l3lVGQGz/lff7q3LPrjormq
         XTIjZcTed58b7Ny5bMhO8Z//S1qVewZ6sg8Tt3oulkZvv4T24ue1H2mqePu6uGecmZ+f
         bMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/zAhSo5Ax6EwddJkjp2vhyIhBPv9FE/7swLMbPfjMmnXlM8jHAiHCfzvN218+y43J3tEVBhNxSZHtUmXV3ETxDdmdOd8g0HXrhb7ylM=
X-Gm-Message-State: AOJu0YxZK2KWBznaTnREAcO+6LJ344gTcu5OyfBZLbWU0sHbaPAl6FRc
	VgV4LDfyN82GYaLiZZipjZ4Jkzaa/sXa6qEHpMJx9kSHGqrNQoIKoOamP5XjNXGecHHRMUvxojo
	4jbuljhM63y9xcVeyyhHgt6ba0A5GslVyvVBxgA==
X-Google-Smtp-Source: AGHT+IHdn2npWqT6eXE8OXOJ8aeE+1uvyLE2k3jLpLR2kMrW4luyMtoF2cYuLh1aaMn2GPPBLemb20goD4jLZbNz7Kk=
X-Received: by 2002:a05:6e02:152e:b0:36c:a46:e018 with SMTP id
 i14-20020a056e02152e00b0036c0a46e018mr5159166ilu.24.1713763503545; Sun, 21
 Apr 2024 22:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-11-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-11-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:54:52 +0530
Message-ID: <CAAhSdy34VhGY3v9h3cw167MafKHOF1dL6zqB7Wi6A9Z4fo7ZNg@mail.gmail.com>
Subject: Re: [PATCH v8 10/24] RISC-V: KVM: Fix the initial sample period value
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> The initial sample period value when counter value is not assigned
> should be set to maximum value supported by the counter width.
> Otherwise, it may result in spurious interrupts.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86391a5061dd..cee1b9ca4ec4 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pm=
c)
>         u64 sample_period;
>
>         if (!pmc->counter_val)
> -               sample_period =3D counter_val_mask + 1;
> +               sample_period =3D counter_val_mask;
>         else
>                 sample_period =3D (-pmc->counter_val) & counter_val_mask;
>
> --
> 2.34.1
>
