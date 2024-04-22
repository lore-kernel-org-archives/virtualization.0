Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCD179AA
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763685; cv=none; b=NLeE9TYOTAJpLiQLIpwZBy+EXAeaGibV7kFmVU5W6rNlaPcO8IP6/RBCCRgOCmMd8RUsekocAk1d9t4LNc/IUMLPzL0vCKv4fhGEmrINxZAUlE35JpIml5KUlPHYCS/SUQJLE64U3grCamE9tYB1tVcCHlVqCAvc7oKCSOLMzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763685; c=relaxed/simple;
	bh=V2+wR1VquizoISUogbMZX4hsB+MQCVKsXvKepUwkfXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrki7q00WX4dE6a+mGc9Habre/PBwgHS5kbX89b3GrEz4TLvn8AChvxu5++uXLdeqyX+vyvob3iP83Qtp3LFGVmZ8AwryfLczAnh1vOnWHS/46VYy5DHB7pVHVPY3BEaq75+4WJvWZpSkfVzZtK9aqveqE2x5z2QqI+4nqV8aks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=TSFqKj4k; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="TSFqKj4k"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36b30909b01so17341235ab.2
        for <virtualization@lists.linux.dev>; Sun, 21 Apr 2024 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763682; x=1714368482; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPFOp2DnZ2SqsScIHARn1DLTXZkW+97s6tf/2J2vkiU=;
        b=TSFqKj4k1AXA5C0nrv81S8/hUyp1FqKyHvpazEPDieoAA6IppBapuNUeo8Vj1WC649
         zLuwRFOkJUJBcgJUIAXVoWz0BWA60leb1JEVv6Jk23jz3TK9sUPExrWtTABeXOedXZOv
         aeriOsUgNtTEjiJaIoyNVNod7uTCvTY/QOH3GKRYCDt2+FBKRLdRyBpvthat2lIQwpWQ
         KxQQS9u8Oay+16YKbHHtNSqd5Ml1dgoJEibIqLlt3FeJGXcUjReN6T1MmqjtUJRJfuDO
         vxyvHgROJPkkd51/gNROGj14OgEE1J3REcAHXuUCa460mPrOpZfs04WDWbKd8gMtCw/G
         IKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763682; x=1714368482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPFOp2DnZ2SqsScIHARn1DLTXZkW+97s6tf/2J2vkiU=;
        b=HN8kixp16hV1/Ty2/qa0jLVDkQTkiUh2pRDAdjjdhpDK3H0IQBafLQj/2DGQDJaYA5
         lGqViiHN+lqDtzziNdK16IvCo/2MhocO67u9xQfNJznBhnTEH7lmc73pSr2F4iLYhWuf
         rPUuWazg8SwAvbeweHjSwA3zGGgXyOVhbd15UCczd7O3wCvnE7cCjAIp4Mzgl8jInhPq
         Gqpi9joUx5rEy4mdunQT2Bt2tIeRtsMPeaNDKxGhbubvZy4ElpmqYCXyevI86dCEi/wG
         Zt56jzcMowJIm2UrRK+39eTFP9rEKGuE24H05dCIIPKW6lXtEywXseiMjcCsenVph+WG
         +jLA==
X-Forwarded-Encrypted: i=1; AJvYcCWwg6WI1jhNzPpusP7b45mLwTYxA4/WIGQYUmvK1kyWuIdN6KxnIL7aNYkO/HfziNFA0t9j73nkOwn6ZQN/5ljTEZeh4PRmuQMI2zXxtoI=
X-Gm-Message-State: AOJu0YzLNUd8XlzCF29gMMYoffToay0HvcX48Ny51AQzVDF8PUb7AHTV
	v9pbqZhlEy4YJljlyMCt5Sf5GEGudn7ZlnWahywy/9hKa46KHiOiST5ElvZmHTW6VjMCyLachkx
	FBKgxpS+voCxaTdFAnDSV8pqO24w2Z7zJCsnX8A==
X-Google-Smtp-Source: AGHT+IF2fN1BF/BA5zZpPH9awO2iybqu2/U//6hw9xuoA3CAPNDIqio5oxlctD7wg/x5fuL+ITh10xGQjApKCSUO04E=
X-Received: by 2002:a05:6e02:b26:b0:36a:3ef4:aa0a with SMTP id
 e6-20020a056e020b2600b0036a3ef4aa0amr12065915ilu.24.1713763682385; Sun, 21
 Apr 2024 22:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-18-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-18-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:57:51 +0530
Message-ID: <CAAhSdy0KMApgSh4q1zxgv1AKrT44bSEL3+GaFbA8M1XL6UMoJw@mail.gmail.com>
Subject: Re: [PATCH v8 17/24] KVM: riscv: selftests: Move sbi definitions to
 its own header file
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
> The SBI definitions will continue to grow. Move the sbi related
> definitions to its own header file from processor.h
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  .../selftests/kvm/include/riscv/processor.h   | 39 ---------------
>  .../testing/selftests/kvm/include/riscv/sbi.h | 50 +++++++++++++++++++
>  .../selftests/kvm/include/riscv/ucall.h       |  1 +
>  tools/testing/selftests/kvm/steal_time.c      |  4 +-
>  4 files changed, 54 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index ce473fe251dd..3b9cb39327ff 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -154,45 +154,6 @@ void vm_install_interrupt_handler(struct kvm_vm *vm,=
 exception_handler_fn handle
>  #define PGTBL_PAGE_SIZE                                PGTBL_L0_BLOCK_SI=
ZE
>  #define PGTBL_PAGE_SIZE_SHIFT                  PGTBL_L0_BLOCK_SHIFT
>
> -/* SBI return error codes */
> -#define SBI_SUCCESS                            0
> -#define SBI_ERR_FAILURE                                -1
> -#define SBI_ERR_NOT_SUPPORTED                  -2
> -#define SBI_ERR_INVALID_PARAM                  -3
> -#define SBI_ERR_DENIED                         -4
> -#define SBI_ERR_INVALID_ADDRESS                        -5
> -#define SBI_ERR_ALREADY_AVAILABLE              -6
> -#define SBI_ERR_ALREADY_STARTED                        -7
> -#define SBI_ERR_ALREADY_STOPPED                        -8
> -
> -#define SBI_EXT_EXPERIMENTAL_START             0x08000000
> -#define SBI_EXT_EXPERIMENTAL_END               0x08FFFFFF
> -
> -#define KVM_RISCV_SELFTESTS_SBI_EXT            SBI_EXT_EXPERIMENTAL_END
> -#define KVM_RISCV_SELFTESTS_SBI_UCALL          0
> -#define KVM_RISCV_SELFTESTS_SBI_UNEXP          1
> -
> -enum sbi_ext_id {
> -       SBI_EXT_BASE =3D 0x10,
> -       SBI_EXT_STA =3D 0x535441,
> -};
> -
> -enum sbi_ext_base_fid {
> -       SBI_EXT_BASE_PROBE_EXT =3D 3,
> -};
> -
> -struct sbiret {
> -       long error;
> -       long value;
> -};
> -
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -                       unsigned long arg1, unsigned long arg2,
> -                       unsigned long arg3, unsigned long arg4,
> -                       unsigned long arg5);
> -
> -bool guest_sbi_probe_extension(int extid, long *out_val);
> -
>  static inline void local_irq_enable(void)
>  {
>         csr_set(CSR_SSTATUS, SR_SIE);
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/test=
ing/selftests/kvm/include/riscv/sbi.h
> new file mode 100644
> index 000000000000..ba04f2dec7b5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RISC-V SBI specific definitions
> + *
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#ifndef SELFTEST_KVM_SBI_H
> +#define SELFTEST_KVM_SBI_H
> +
> +/* SBI return error codes */
> +#define SBI_SUCCESS                             0
> +#define SBI_ERR_FAILURE                                -1
> +#define SBI_ERR_NOT_SUPPORTED                  -2
> +#define SBI_ERR_INVALID_PARAM                  -3
> +#define SBI_ERR_DENIED                         -4
> +#define SBI_ERR_INVALID_ADDRESS                        -5
> +#define SBI_ERR_ALREADY_AVAILABLE              -6
> +#define SBI_ERR_ALREADY_STARTED                        -7
> +#define SBI_ERR_ALREADY_STOPPED                        -8
> +
> +#define SBI_EXT_EXPERIMENTAL_START             0x08000000
> +#define SBI_EXT_EXPERIMENTAL_END               0x08FFFFFF
> +
> +#define KVM_RISCV_SELFTESTS_SBI_EXT            SBI_EXT_EXPERIMENTAL_END
> +#define KVM_RISCV_SELFTESTS_SBI_UCALL          0
> +#define KVM_RISCV_SELFTESTS_SBI_UNEXP          1
> +
> +enum sbi_ext_id {
> +       SBI_EXT_BASE =3D 0x10,
> +       SBI_EXT_STA =3D 0x535441,
> +};
> +
> +enum sbi_ext_base_fid {
> +       SBI_EXT_BASE_PROBE_EXT =3D 3,
> +};
> +
> +struct sbiret {
> +       long error;
> +       long value;
> +};
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +                       unsigned long arg1, unsigned long arg2,
> +                       unsigned long arg3, unsigned long arg4,
> +                       unsigned long arg5);
> +
> +bool guest_sbi_probe_extension(int extid, long *out_val);
> +
> +#endif /* SELFTEST_KVM_SBI_H */
> diff --git a/tools/testing/selftests/kvm/include/riscv/ucall.h b/tools/te=
sting/selftests/kvm/include/riscv/ucall.h
> index be46eb32ec27..a695ae36f3e0 100644
> --- a/tools/testing/selftests/kvm/include/riscv/ucall.h
> +++ b/tools/testing/selftests/kvm/include/riscv/ucall.h
> @@ -3,6 +3,7 @@
>  #define SELFTEST_KVM_UCALL_H
>
>  #include "processor.h"
> +#include "sbi.h"
>
>  #define UCALL_EXIT_REASON       KVM_EXIT_RISCV_SBI
>
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> index bae0c5026f82..2ff82c7fd926 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -11,7 +11,9 @@
>  #include <pthread.h>
>  #include <linux/kernel.h>
>  #include <asm/kvm.h>
> -#ifndef __riscv
> +#ifdef __riscv
> +#include "sbi.h"
> +#else
>  #include <asm/kvm_para.h>
>  #endif
>
> --
> 2.34.1
>
