Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADCD17C68
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763779; cv=none; b=UVClg2L5iA1kXQ3aXM9dr79OIlMM7+JsD0ApxZiQdPVoS8I4rlw8wRa2yfkyRniqA//7+2y/28W+iQjVhENSDALPpp0H58fZcNj2/WL/km2ypZTojih2qU/y1vvGKuU0c+JXJqM3i0qGGSOyTIGUTx9HXsdtS1EC9106Zk8AHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763779; c=relaxed/simple;
	bh=hfR8wFHUTqy0PtbXA2fJ051uKSvhoqdLre89/yRBZd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD9KeAA6mfnW35CcE6IwU94DbqNt32B0+3CGfKMY33PN1LTWbcaWJFVleZGl6oR2tHcGrUCiGfTp8Kfb/dgDPYeQPYPLWsTueb2jMrAZSmWxWRcY8+1d8pSn33rEZUkJS14eJ310gOjGSHhF6X0TjTproMeBkIiR2MrgIqiqCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=qORqieJS; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="qORqieJS"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a15df0f8cso18061385ab.1
        for <virtualization@lists.linux.dev>; Sun, 21 Apr 2024 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763776; x=1714368576; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u4byTUlDNwKD7I4IoEN6osZEpNF6BpvONGOZchupOs=;
        b=qORqieJSUi0rTUimYYxuVec4fP2IDMFcB9VnUbl5Yaz5cq/0031A0tbNYlMutqMH0l
         JhMwpQjXmdsQTaqxqfR03FEjwMSoXuyRP6ys+OzQhsbNUfIyIbgJ2k2AQzJkmUKhYeee
         lX3rNUMKArdQP4ykwcjBuR4kowwcduElSx13G5tE6DxkRU77xzCgYJfTgv/vqTtsgCh1
         hA/CkwGMAycyYhtaaOqm0rNaWgJhoYFRA+usmX6som1aS1mLyz/BBOAuX+QWx5lFTb8v
         CLdiHF8hYIuCIm7cNJFACZrIcZBzkf6sOU15b23scC1wzzSTOpPztTocbdtijXvNLJDF
         nnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763776; x=1714368576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u4byTUlDNwKD7I4IoEN6osZEpNF6BpvONGOZchupOs=;
        b=eb3znKijxKI4ZBPiwOxxR2CC275MEJMuxlYEPAx9ZPp2jUB0AOJ2W5iVLZQQUwh8Rn
         uuDQefwiu11Q/Wb3987tj8rucxJkgSfILSDVQ6hc0n5JCEy29lS9d9+iL2HrDsteSPyp
         zBSa+06Wt/HpzWe1XlodWKzQ/kO0hGb/YOtsnC+wEUbayQmRZNyNeEJ3+ZLd+9CDrb+E
         oweYBAmsDjDh49mxkVnUnKtoAD688gnFPS4VpKK5IG5PzLV/bfy79MkrGXyE2nA02cEf
         JOqGGWd3Ti1MdxOBICCfXA9dOwk1QweyT49TMcgRnCJJGmwQTfsDftsORfVdCqUPdEdL
         pnpw==
X-Forwarded-Encrypted: i=1; AJvYcCXSXYDeG3fSVCMj2fc/d6HfnXsqlG6vJanLtqW2ZQvekjsOhZ6vRZVyn4yp5iyEXOQkptF1Eil99gzS+R4Vdrr79uaX7dHam5/3XbDOFTE=
X-Gm-Message-State: AOJu0Yw9PnVyoF8xjPljhC87QfyKnFdcfpqsBWWCt6vE8r2HEw5lBz/Z
	FB/9cnijzivwaCni/vWuOL8qCXH4SL1TpRKUlJ+9Jy1hcqZkcyj0BXxK/nusb0y1c7PmOfrJH0K
	lb+bzufMRFq0tp3+AmYX4CUzdHGJiu0b8lls2eQ==
X-Google-Smtp-Source: AGHT+IFC/ggrORFQDRIsgf3m5CDc64LQxhFUDaRtJHNN1AtIkubwk7+EwLTGLb3mIW99QlL7g0zTkCXH/qKaaakQzOk=
X-Received: by 2002:a92:cd89:0:b0:36a:fa7a:629f with SMTP id
 r9-20020a92cd89000000b0036afa7a629fmr13121951ilb.21.1713763776638; Sun, 21
 Apr 2024 22:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-19-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-19-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:59:25 +0530
Message-ID: <CAAhSdy0OmAjs1oHUjPzwUydsnGtqUd_HKTZKZzJpQQFEXvPX8w@mail.gmail.com>
Subject: Re: [PATCH v8 18/24] KVM: riscv: selftests: Add helper functions for
 extension checks
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
> __vcpu_has_ext can check both SBI and ISA extensions when the first
> argument is properly converted to SBI/ISA extension IDs. Introduce
> two helper functions to make life easier for developers so they
> don't have to worry about the conversions.
>
> Replace the current usages as well with new helpers.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
>  tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index 3b9cb39327ff..5f389166338c 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uin=
t64_t subtype,
>
>  bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
>
> +static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t is=
a_ext)
> +{
> +       return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
> +}
> +
> +static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sb=
i_ext)
> +{
> +       return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
> +}
> +
>  struct ex_regs {
>         unsigned long ra;
>         unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testi=
ng/selftests/kvm/riscv/arch_timer.c
> index 0f9cabd99fd4..735b78569021 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
>         int nr_vcpus =3D test_args.nr_vcpus;
>
>         vm =3D vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> -       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RIS=
CV_ISA_EXT_SSTC)),
> +       __TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SST=
C),
>                                    "SSTC not available, skipping test\n")=
;
>
>         vm_init_vector_tables(vm);
> --
> 2.34.1
>
