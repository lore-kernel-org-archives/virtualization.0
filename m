Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40E210EE;
	Sat, 24 Feb 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708766125; cv=none; b=J8LwtPCA0iAqZmpNKbWL4ZsFtzklDl17SzdrUkoX1ysXmNXZpD6LbPCLMUOPGl6g6PktLKYkzSxlgVocxTKVOhZJNtqhXUDKXchj6oAVhED0pn2/ZDgi2Yzd1xTKr2Tf3qe7M9uqx+boh6gJL0rAJfsoQbzdkac+WexmarY5cLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708766125; c=relaxed/simple;
	bh=ceMZ/jeHgp6flFBYvkQprkuw1qvDVVPhmtGre7/57j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yi36lDB4BEnv6TAQ4VHitYeyh4XcCUXDfX0EJcqzMJUoo1AMRu48L8/Bdv5Ak9+HUSQWE2AlvYWvFRhM6hFIyQ8+2FBdJNmWW5kwCyLntXcEGEzEbcFcL8zfqX4uorX3FH/5Ws48j9Uox/geL6yiARP0VEd5F6EuCdH7OQGp5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq8CHtPh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq8CHtPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D646DC433C7;
	Sat, 24 Feb 2024 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708766123;
	bh=ceMZ/jeHgp6flFBYvkQprkuw1qvDVVPhmtGre7/57j0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yq8CHtPhQ/I6P57SmcIIjXv2jfsWDCr4WeVeJCK0dw8MeqXJeWaxmucUZEACYs7iL
	 /CPjv0nWxccsUWzUpyCetNDtpy/ZUvZNmL1fdkpa4Pho41EVwn82J5OyvSC+B1FCYU
	 RCzl0ujUDPsvsoJwkV1WJzmfZ992PHx1Xs3zgykhWUmoq3ZBkHSuz1Ds1ikR4K8dWe
	 5yt5e0fja4zeEFKJflIUlIFD4f1ANCO0L8f4tuuKfwQ3tWS6alwnKVSI+pSuMbKexy
	 Ex/WACMzqOK2EGNGNAXCzfz2y2T7+Fb3ZfuDQK2cRKDi2y1bY9U/rd97hppDd2mUlU
	 1q0MkTyRTxXTg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso284783166b.0;
        Sat, 24 Feb 2024 01:15:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQWEAWINbbGhBKnDg3RfHRCSBWqMub1RjSsCDN+C/rD09Wh/W+utBV85JqhL95Q7m+QP9tBqmkOzE1U9bvUil8u8NYwN4PunPm4M35XW2Yh+ZiL7jdzP4gfzTWp23gSZ2AKdOqxEpPQ6Q=
X-Gm-Message-State: AOJu0YyNe8FzDUU0IJbfxI0tsYiV0s2o/QDVLYMNmb345dDR7bJbIpy3
	E0+3KmVJPdHiSwoK2Gs4NNwpkG8E7+BwTywYYeKAEt3Hz+K1pGiCWP9A09467pwK3U/xxFCmEA3
	KHsz/vqVIPcMiFPRTS8xxgSPbgME=
X-Google-Smtp-Source: AGHT+IFJunhuX+axu6drNAci1eNU37HjBOkQoC2FR6Yzuz71bJBWLyXqoD1jaiHsE1cZlmjzBeb8/rVTDt7QTPkyV1Q=
X-Received: by 2002:a17:906:f116:b0:a3f:52dc:786b with SMTP id
 gv22-20020a170906f11600b00a3f52dc786bmr1672248ejb.23.1708766122183; Sat, 24
 Feb 2024 01:15:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240222032803.2177856-1-maobibo@loongson.cn> <20240222032803.2177856-5-maobibo@loongson.cn>
In-Reply-To: <20240222032803.2177856-5-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 24 Feb 2024 17:15:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4FiP+msu4heG00Hw89Wy3oeJd5rJ7+twhwVqph_tO4Mw@mail.gmail.com>
Message-ID: <CAAhV-H4FiP+msu4heG00Hw89Wy3oeJd5rJ7+twhwVqph_tO4Mw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] LoongArch: Add paravirt interface for guest kernel
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Feb 22, 2024 at 11:28=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Paravirt interface pv_ipi_init() is added here for guest kernel, it
> firstly checks whether system runs on VM mode. If kernel runs on VM mode,
> it will call function kvm_para_available() to detect current VMM type.
> Now only KVM VMM type is detected,the paravirt function can work only if
> current VMM is KVM hypervisor, since there is only KVM hypervisor
> supported on LoongArch now.
>
> There is not effective with pv_ipi_init() now, it is dummy function.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/Kconfig                        |  9 ++++
>  arch/loongarch/include/asm/kvm_para.h         |  7 ++++
>  arch/loongarch/include/asm/paravirt.h         | 27 ++++++++++++
>  .../include/asm/paravirt_api_clock.h          |  1 +
>  arch/loongarch/kernel/Makefile                |  1 +
>  arch/loongarch/kernel/paravirt.c              | 41 +++++++++++++++++++
>  arch/loongarch/kernel/setup.c                 |  1 +
>  7 files changed, 87 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/paravirt.h
>  create mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
>  create mode 100644 arch/loongarch/kernel/paravirt.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 929f68926b34..fdaae9a0435c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -587,6 +587,15 @@ config CPU_HAS_PREFETCH
>         bool
>         default y
>
> +config PARAVIRT
> +       bool "Enable paravirtualization code"
> +       depends on AS_HAS_LVZ_EXTENSION
> +       help
> +          This changes the kernel so it can modify itself when it is run
> +         under a hypervisor, potentially improving performance significa=
ntly
> +         over full virtualization.  However, when run without a hypervis=
or
> +         the kernel is theoretically slower and slightly larger.
> +
>  config ARCH_SUPPORTS_KEXEC
>         def_bool y
>
> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/inclu=
de/asm/kvm_para.h
> index d48f993ae206..af5d677a9052 100644
> --- a/arch/loongarch/include/asm/kvm_para.h
> +++ b/arch/loongarch/include/asm/kvm_para.h
> @@ -2,6 +2,13 @@
>  #ifndef _ASM_LOONGARCH_KVM_PARA_H
>  #define _ASM_LOONGARCH_KVM_PARA_H
>
> +/*
> + * Hypercall code field
> + */
> +#define HYPERVISOR_KVM                 1
> +#define HYPERVISOR_VENDOR_SHIFT                8
> +#define HYPERCALL_CODE(vendor, code)   ((vendor << HYPERVISOR_VENDOR_SHI=
FT) + code)
> +
>  /*
>   * LoongArch hypercall return code
>   */
> diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/inclu=
de/asm/paravirt.h
> new file mode 100644
> index 000000000000..58f7b7b89f2c
> --- /dev/null
> +++ b/arch/loongarch/include/asm/paravirt.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_LOONGARCH_PARAVIRT_H
> +#define _ASM_LOONGARCH_PARAVIRT_H
> +
> +#ifdef CONFIG_PARAVIRT
> +#include <linux/static_call_types.h>
> +struct static_key;
> +extern struct static_key paravirt_steal_enabled;
> +extern struct static_key paravirt_steal_rq_enabled;
> +
> +u64 dummy_steal_clock(int cpu);
> +DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
> +
> +static inline u64 paravirt_steal_clock(int cpu)
> +{
> +       return static_call(pv_steal_clock)(cpu);
> +}
> +
> +int pv_ipi_init(void);
> +#else
> +static inline int pv_ipi_init(void)
> +{
> +       return 0;
> +}
> +
> +#endif // CONFIG_PARAVIRT
> +#endif
> diff --git a/arch/loongarch/include/asm/paravirt_api_clock.h b/arch/loong=
arch/include/asm/paravirt_api_clock.h
> new file mode 100644
> index 000000000000..65ac7cee0dad
> --- /dev/null
> +++ b/arch/loongarch/include/asm/paravirt_api_clock.h
> @@ -0,0 +1 @@
> +#include <asm/paravirt.h>
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 3c808c680370..662e6e9de12d 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_MODULES)         +=3D module.o module-sect=
ions.o
>  obj-$(CONFIG_STACKTRACE)       +=3D stacktrace.o
>
>  obj-$(CONFIG_PROC_FS)          +=3D proc.o
> +obj-$(CONFIG_PARAVIRT)         +=3D paravirt.o
>
>  obj-$(CONFIG_SMP)              +=3D smp.o
>
> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/par=
avirt.c
> new file mode 100644
> index 000000000000..5cf794e8490f
> --- /dev/null
> +++ b/arch/loongarch/kernel/paravirt.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <linux/jump_label.h>
> +#include <linux/kvm_para.h>
> +#include <asm/paravirt.h>
> +#include <linux/static_call.h>
> +
> +struct static_key paravirt_steal_enabled;
> +struct static_key paravirt_steal_rq_enabled;
> +
> +static u64 native_steal_clock(int cpu)
> +{
> +       return 0;
> +}
> +
> +DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
> +
> +static bool kvm_para_available(void)
> +{
> +       static int hypervisor_type;
> +       int config;
> +
> +       if (!hypervisor_type) {
> +               config =3D read_cpucfg(CPUCFG_KVM_SIG);
> +               if (!memcmp(&config, KVM_SIGNATURE, 4))
> +                       hypervisor_type =3D HYPERVISOR_KVM;
> +       }
> +
> +       return hypervisor_type =3D=3D HYPERVISOR_KVM;
> +}
> +
> +int __init pv_ipi_init(void)
> +{
> +       if (!cpu_has_hypervisor)
> +               return 0;
> +       if (!kvm_para_available())
> +               return 0;
> +
> +       return 1;
> +}
pv_ipi_init() and its declaration should also be moved to the last
patch. And if you think this patch is too small, you can squash the
whole patch to the last one.

Huacai

> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index edf2bba80130..b79a1244b56f 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -43,6 +43,7 @@
>  #include <asm/efi.h>
>  #include <asm/loongson.h>
>  #include <asm/numa.h>
> +#include <asm/paravirt.h>
>  #include <asm/pgalloc.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
> --
> 2.39.3
>
