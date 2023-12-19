Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE093D0A3
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="WaFYSgmz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26A2781352
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:53:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26A2781352
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=WaFYSgmz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ya5Uoi9tvn19
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 21:53:36 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A7FB8131E
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:53:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A7FB8131E
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2cc5ee69960so40434461fa.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1703022814; x=1703627614; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz/U2VSJdAaxY/ib1h0wELKaoKa/2va1tfa/T+ld9zo=;
        b=WaFYSgmz0VoV1WdAF18OI7BdvHv3xiFfBYTadd3qrrnjyUhMSquOaYP1rRmx4Aa25P
         ZwkQdpJIS9JqazrXZ4AICpViMIUR2Qd4NhseZj+84FgFTTbPFOEHLaYzR77+e4/QOPhx
         R2yEUIgAeWPDx/oNhhqlwMmut3hSXUA5sVHXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703022814; x=1703627614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz/U2VSJdAaxY/ib1h0wELKaoKa/2va1tfa/T+ld9zo=;
        b=kiF4v7MkTR9xMN9HK0dwB8a6tlNLZ5/0b68QKuLhwxCxlqBS2CvThdd0zxZI2Z2SQ3
         mj9N6DwIilsD4bw0brcombkpWetOuZyWQzui4vFS7XLjkTnO12JxL54nUbzrT9totlpc
         eyGJiNyghOzUEESEgFiqPVoDBhe/SfyNPR1fsJ0P/DoTElH+0heST1MPyAQUvIf0VwrH
         vYAOHb8pvvHP2dL8Cv/N6zTqr0ox2DJiORUoJtH67kt+WERcW/WGidtlyXwzbs5ZQ+E9
         13UZqFNkhQr/keWNX/pmlh6S17lVvDPzqKImyy/QyFoto+b2B3dEYHaT0n955UL8oHNW
         Icyw==
X-Gm-Message-State: AOJu0YyzlwHlgk8YWtzRk3SfvYKuAKzfyqfCujLwOx9iVVcN/PP7HKTN
	XTXjyBqdTdUsNsSqO1hzoPl9DlLyfPWIRrdRWY55
X-Google-Smtp-Source: AGHT+IEBI/bpIQ97l43rPyGytCgY4JqCor6+evISM+YPjrCC06haZziIPngNt1u6GflI29QtDoc1RNL0LruJeUSt7h0=
X-Received: by 2002:a2e:a989:0:b0:2cc:8760:64db with SMTP id
 x9-20020a2ea989000000b002cc876064dbmr498888ljq.96.1703022814064; Tue, 19 Dec
 2023 13:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-25-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-25-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 19 Dec 2023 13:53:22 -0800
Message-ID: <CAOnJCU+-Ocyc7JPz9Bo48fTke9s+XrW40K-NETCjCzDYbx_K5Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] RISC-V: KVM: selftests: Move sbi_ecall to processor.c
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:16=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> sbi_ecall() isn't ucall specific and its prototype is already in
> processor.h. Move its implementation to processor.c.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  .../selftests/kvm/lib/riscv/processor.c       | 26 +++++++++++++++++++
>  tools/testing/selftests/kvm/lib/riscv/ucall.c | 26 -------------------
>  2 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index 6c25f7843ef4..6905a4348380 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -367,3 +367,29 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned i=
nt num, ...)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +                       unsigned long arg1, unsigned long arg2,
> +                       unsigned long arg3, unsigned long arg4,
> +                       unsigned long arg5)
> +{
> +       register uintptr_t a0 asm ("a0") =3D (uintptr_t)(arg0);
> +       register uintptr_t a1 asm ("a1") =3D (uintptr_t)(arg1);
> +       register uintptr_t a2 asm ("a2") =3D (uintptr_t)(arg2);
> +       register uintptr_t a3 asm ("a3") =3D (uintptr_t)(arg3);
> +       register uintptr_t a4 asm ("a4") =3D (uintptr_t)(arg4);
> +       register uintptr_t a5 asm ("a5") =3D (uintptr_t)(arg5);
> +       register uintptr_t a6 asm ("a6") =3D (uintptr_t)(fid);
> +       register uintptr_t a7 asm ("a7") =3D (uintptr_t)(ext);
> +       struct sbiret ret;
> +
> +       asm volatile (
> +               "ecall"
> +               : "+r" (a0), "+r" (a1)
> +               : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (=
a7)
> +               : "memory");
> +       ret.error =3D a0;
> +       ret.value =3D a1;
> +
> +       return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testin=
g/selftests/kvm/lib/riscv/ucall.c
> index fe6d1004f018..14ee17151a59 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> @@ -10,32 +10,6 @@
>  #include "kvm_util.h"
>  #include "processor.h"
>
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -                       unsigned long arg1, unsigned long arg2,
> -                       unsigned long arg3, unsigned long arg4,
> -                       unsigned long arg5)
> -{
> -       register uintptr_t a0 asm ("a0") =3D (uintptr_t)(arg0);
> -       register uintptr_t a1 asm ("a1") =3D (uintptr_t)(arg1);
> -       register uintptr_t a2 asm ("a2") =3D (uintptr_t)(arg2);
> -       register uintptr_t a3 asm ("a3") =3D (uintptr_t)(arg3);
> -       register uintptr_t a4 asm ("a4") =3D (uintptr_t)(arg4);
> -       register uintptr_t a5 asm ("a5") =3D (uintptr_t)(arg5);
> -       register uintptr_t a6 asm ("a6") =3D (uintptr_t)(fid);
> -       register uintptr_t a7 asm ("a7") =3D (uintptr_t)(ext);
> -       struct sbiret ret;
> -
> -       asm volatile (
> -               "ecall"
> -               : "+r" (a0), "+r" (a1)
> -               : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (=
a7)
> -               : "memory");
> -       ret.error =3D a0;
> -       ret.value =3D a1;
> -
> -       return ret;
> -}
> -
>  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_run *run =3D vcpu->run;
> --
> 2.43.0
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
