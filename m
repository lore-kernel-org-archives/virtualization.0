Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B5137C
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="QfrMz6lp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD4C61040
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CD4C61040
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=QfrMz6lp
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lkn_yJfMC25U
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 01:42:18 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E60C060E71
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:42:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E60C060E71
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2cc7087c6c4so21721261fa.2
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702950135; x=1703554935; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DJ6HujQaSqLNJaBNcsY++yK3kKdhHXKU0SDGTiPnm0=;
        b=QfrMz6lpTv4KZ/6KKwdAe5qLdc5C5wxiFGcNLtPhUYN2o8dmfX51SxANqp4YSbUcvi
         AmImbaBjSRmeOVvRzyqVmzM8b42JojWomBd8nDPRNxBr+DuWqDVUSmfSCattqiP3ELHN
         wOMJd6yiLlOYAunxqOQEnZt2FZ29T6w1iSwdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702950135; x=1703554935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DJ6HujQaSqLNJaBNcsY++yK3kKdhHXKU0SDGTiPnm0=;
        b=gz/RB6DKvtwgcyOInWeNgJAJxX+YA+waszEqkSuMGRTL7Oe83rCSUD/8wBVqeRoKcB
         iaTLuQXU3WP3zFd1baarah5bWiK1oKKbqIcyIHsv4DDkeFr9KygA+vdHd8tRktZ8HTtE
         v7N0wEszbhAJrVQbEFxF1b90uhZqTBeUHr3bII67rOcV+lMflrX6Zdqjgc6y65n0P/Tx
         dSWgEmrRTQOIruvR9ijLmYg8penFsHwMlrT4GuJaIqbKOQbZliQOfwx1PXeU6k1ZTRRu
         OgLVKIW0EysCboyW8tPD8gBTEexmzhP9gvfxCGP8OiliU5IPCbeYx/PT30AuF0DpLB64
         KB1w==
X-Gm-Message-State: AOJu0YzOcdNEC9QSAkVQZDOavY/TEl4iCIpX36v+A09UPbwJlBp1kBrw
	xZmhD3rS6ZZbE87P0lSPA4MKIp5IMZ3YidzClhHg
X-Google-Smtp-Source: AGHT+IGwmcBMd08oX7B8LObsbJ2O5rBGx51j04oYfIwxY8UVjXjH6a+FsM8o++Q7AdsMWjN3xu1zxG0FTTto6CSLGFI=
X-Received: by 2002:a2e:8645:0:b0:2cc:5cd5:9662 with SMTP id
 i5-20020a2e8645000000b002cc5cd59662mr2113474ljj.51.1702950135470; Mon, 18 Dec
 2023 17:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-19-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-19-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 18 Dec 2023 17:42:04 -0800
Message-ID: <CAOnJCUKsSyWmK0kkoTZ-R0dnaO2cONK8oD_kbRfipbZZ7Hrqig@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] RISC-V: KVM: Add SBI STA extension skeleton
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 12:40=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> Add the files and functions needed to support the SBI STA
> (steal-time accounting) extension. In the next patches we'll
> complete the functions to fully enable SBI STA support.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  1 +
>  arch/riscv/include/uapi/asm/kvm.h     |  1 +
>  arch/riscv/kvm/Makefile               |  1 +
>  arch/riscv/kvm/vcpu_sbi.c             |  4 +++
>  arch/riscv/kvm/vcpu_sbi_sta.c         | 47 +++++++++++++++++++++++++++
>  5 files changed, 54 insertions(+)
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index bffda0ac59b6..99c23bb37a37 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -76,6 +76,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext=
_rfence;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 60d3b21dead7..e961d79622fb 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -157,6 +157,7 @@ enum KVM_RISCV_SBI_EXT_ID {
>         KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>         KVM_RISCV_SBI_EXT_VENDOR,
>         KVM_RISCV_SBI_EXT_DBCN,
> +       KVM_RISCV_SBI_EXT_STA,
>         KVM_RISCV_SBI_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 4c2067fc59fc..c9646521f113 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -26,6 +26,7 @@ kvm-$(CONFIG_RISCV_SBI_V01) +=3D vcpu_sbi_v01.o
>  kvm-y +=3D vcpu_sbi_base.o
>  kvm-y +=3D vcpu_sbi_replace.o
>  kvm-y +=3D vcpu_sbi_hsm.o
> +kvm-y +=3D vcpu_sbi_sta.o
>  kvm-y +=3D vcpu_timer.o
>  kvm-$(CONFIG_RISCV_PMU_SBI) +=3D vcpu_pmu.o vcpu_sbi_pmu.o
>  kvm-y +=3D aia.o
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index dcdff4458190..088daaa23dd8 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -70,6 +70,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_=
ext[] =3D {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_DBCN,
>                 .ext_ptr =3D &vcpu_sbi_ext_dbcn,
>         },
> +       {
> +               .ext_idx =3D KVM_RISCV_SBI_EXT_STA,
> +               .ext_ptr =3D &vcpu_sbi_ext_sta,
> +       },
>         {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>                 .ext_ptr =3D &vcpu_sbi_ext_experimental,
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> new file mode 100644
> index 000000000000..839911dcd837
> --- /dev/null
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/kvm_vcpu_sbi.h>
> +#include <asm/sbi.h>
> +
> +static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
> +{
> +       return SBI_ERR_FAILURE;
> +}
> +
> +static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run=
 *run,
> +                                  struct kvm_vcpu_sbi_return *retdata)
> +{
> +       struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
> +       unsigned long funcid =3D cp->a6;
> +       int ret;
> +
> +       switch (funcid) {
> +       case SBI_EXT_STA_STEAL_TIME_SET_SHMEM:
> +               ret =3D kvm_sbi_sta_steal_time_set_shmem(vcpu);
> +               break;
> +       default:
> +               ret =3D SBI_ERR_NOT_SUPPORTED;
> +               break;
> +       }
> +
> +       retdata->err_val =3D ret;
> +
> +       return 0;
> +}
> +
> +static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
> +{
> +       return 0;
> +}
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta =3D {
> +       .extid_start =3D SBI_EXT_STA,
> +       .extid_end =3D SBI_EXT_STA,
> +       .handler =3D kvm_sbi_ext_sta_handler,
> +       .probe =3D kvm_sbi_ext_sta_probe,
> +};
> --
> 2.43.0
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
