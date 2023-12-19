Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30E7E5
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="ARClUmVh"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13A95822C6
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 00:48:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13A95822C6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=ARClUmVh
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MPMONioiGND
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 00:48:19 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC3068226A
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 00:48:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC3068226A
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2cc7d2c1ff0so4739061fa.3
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 16:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702946896; x=1703551696; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfmiZoxnEujNpK/QKOQEdu9h16TcZmxEb8csURcCvlQ=;
        b=ARClUmVhJZSKsD65wgCQK4k8hCS1FjEZx4jQE6Mu6OYUBpRaVGGD7JKjz5b64nGYWh
         geCMd8+DLtwmyceHYFWemzwZ43sxHMnztOfTnjQ8YkgJi53oD1Jc0168I0zGt8nADTQn
         lVgmVHQnHDyi2NzCd9UTs5gge2FzrqOXonFyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946896; x=1703551696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfmiZoxnEujNpK/QKOQEdu9h16TcZmxEb8csURcCvlQ=;
        b=r8Y9hsl6KUKN/YjL+a8zCTVPv0uxlyIcTs2KjJru6hoJ/HNDajTaZ/kp32c++WiwHI
         XGZQGLbgg6BLgURMl01v23nu3N2iU2wlLGilRfJ26/MFfFfdKvupyzcNAodohmgc5NK4
         QRalTalQ5wR/edJP9rTNMqNnlhMQOVH0q8qcMT7bzrWx45VfsdzhwgnaASLATRtTCVXz
         PuPrRXHg8gEuMnFgPSUUZoOq4SpDjde0DZFIKn5O5omFfMJMtFaiZk8g/ftNwu+AqrbB
         mf6RXlBYsQQfpto45nZ8vWeR5MfYjtpvv1u9PmGRbAZwo9aodkJD6y4gBWm36fWUAcjN
         s/4Q==
X-Gm-Message-State: AOJu0Yz/w1IfmkWxMT2euD1kaM0jqNK6vsDrN2BaohVnprhql8lrac0e
	z5aBeFpHXVK9xIf9lrxJyORPV7UpVnt+02vyA1/M
X-Google-Smtp-Source: AGHT+IEX4Q5CXL74e1jhAWq5FiHwMTwWZetq9ol6xah42+KvGWoEgGIy5+NiAF0E4PgEQEzhwecjOTVkAT95zk3EJpI=
X-Received: by 2002:a2e:9403:0:b0:2ca:30f5:7e02 with SMTP id
 i3-20020a2e9403000000b002ca30f57e02mr8605011ljh.78.1702946895973; Mon, 18 Dec
 2023 16:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-16-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-16-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 18 Dec 2023 16:48:04 -0800
Message-ID: <CAOnJCULYeMz63LA-MR-Y9HqCU+dhBQdXf7Shwhu1FXFuck5gWA@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] RISC-V: paravirt: Add skeleton for pv-time support
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
> Add the files and functions needed to support paravirt time on
> RISC-V. Also include the common code needed for the first
> application of pv-time, which is steal-time. In the next
> patches we'll complete the functions to fully enable steal-time
> support.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +-
>  arch/riscv/include/asm/paravirt.h             | 28 +++++++
>  arch/riscv/include/asm/paravirt_api_clock.h   |  1 +
>  arch/riscv/kernel/Makefile                    |  1 +
>  arch/riscv/kernel/paravirt.c                  | 77 +++++++++++++++++++
>  arch/riscv/kernel/time.c                      |  3 +
>  6 files changed, 113 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/include/asm/paravirt.h
>  create mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
>  create mode 100644 arch/riscv/kernel/paravirt.c
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 65731b060e3f..a0d9259e4857 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3985,9 +3985,9 @@
>                         vulnerability. System may allow data leaks with t=
his
>                         option.
>
> -       no-steal-acc    [X86,PV_OPS,ARM64,PPC/PSERIES] Disable paravirtua=
lized
> -                       steal time accounting. steal time is computed, bu=
t
> -                       won't influence scheduler behaviour
> +       no-steal-acc    [X86,PV_OPS,ARM64,PPC/PSERIES,RISCV] Disable
> +                       paravirtualized steal time accounting. steal time=
 is
> +                       computed, but won't influence scheduler behaviour
>
>         nosync          [HW,M68K] Disables sync negotiation for all devic=
es.
>
> diff --git a/arch/riscv/include/asm/paravirt.h b/arch/riscv/include/asm/p=
aravirt.h
> new file mode 100644
> index 000000000000..c0abde70fc2c
> --- /dev/null
> +++ b/arch/riscv/include/asm/paravirt.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_PARAVIRT_H
> +#define _ASM_RISCV_PARAVIRT_H
> +
> +#ifdef CONFIG_PARAVIRT
> +#include <linux/static_call_types.h>
> +
> +struct static_key;
> +extern struct static_key paravirt_steal_enabled;
> +extern struct static_key paravirt_steal_rq_enabled;
> +
> +u64 dummy_steal_clock(int cpu);
> +
> +DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
> +
> +static inline u64 paravirt_steal_clock(int cpu)
> +{
> +       return static_call(pv_steal_clock)(cpu);
> +}
> +
> +int __init pv_time_init(void);
> +
> +#else
> +
> +#define pv_time_init() do {} while (0)
> +
> +#endif /* CONFIG_PARAVIRT */
> +#endif /* _ASM_RISCV_PARAVIRT_H */
> diff --git a/arch/riscv/include/asm/paravirt_api_clock.h b/arch/riscv/inc=
lude/asm/paravirt_api_clock.h
> new file mode 100644
> index 000000000000..65ac7cee0dad
> --- /dev/null
> +++ b/arch/riscv/include/asm/paravirt_api_clock.h
> @@ -0,0 +1 @@
> +#include <asm/paravirt.h>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fee22a3d1b53..807c2bde1f83 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_SMP)             +=3D sbi-ipi.o
>  obj-$(CONFIG_SMP) +=3D cpu_ops_sbi.o
>  endif
>  obj-$(CONFIG_HOTPLUG_CPU)      +=3D cpu-hotplug.o
> +obj-$(CONFIG_PARAVIRT)         +=3D paravirt.o
>  obj-$(CONFIG_KGDB)             +=3D kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)       +=3D kexec_relocate.o crash_save_regs.o m=
achine_kexec.o
>  obj-$(CONFIG_KEXEC_FILE)       +=3D elf_kexec.o machine_kexec_file.o
> diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> new file mode 100644
> index 000000000000..141dbcc36fa2
> --- /dev/null
> +++ b/arch/riscv/kernel/paravirt.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Ventana Micro Systems Inc.
> + */
> +
> +#define pr_fmt(fmt) "riscv-pv: " fmt
> +
> +#include <linux/cpuhotplug.h>
> +#include <linux/init.h>
> +#include <linux/jump_label.h>
> +#include <linux/printk.h>
> +#include <linux/static_call.h>
> +#include <linux/types.h>
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
> +static bool steal_acc =3D true;
> +static int __init parse_no_stealacc(char *arg)
> +{
> +       steal_acc =3D false;
> +       return 0;
> +}
> +
> +early_param("no-steal-acc", parse_no_stealacc);
> +
> +static bool __init has_pv_steal_clock(void)
> +{
> +       return false;
> +}
> +
> +static int pv_time_cpu_online(unsigned int cpu)
> +{
> +       return 0;
> +}
> +
> +static int pv_time_cpu_down_prepare(unsigned int cpu)
> +{
> +       return 0;
> +}
> +
> +static u64 pv_time_steal_clock(int cpu)
> +{
> +       return 0;
> +}
> +
> +int __init pv_time_init(void)
> +{
> +       int ret;
> +
> +       if (!has_pv_steal_clock())
> +               return 0;
> +
> +       ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +                               "riscv/pv_time:online",
> +                               pv_time_cpu_online,
> +                               pv_time_cpu_down_prepare);
> +       if (ret < 0)
> +               return ret;
> +
> +       static_call_update(pv_steal_clock, pv_time_steal_clock);
> +
> +       static_key_slow_inc(&paravirt_steal_enabled);
> +       if (steal_acc)
> +               static_key_slow_inc(&paravirt_steal_rq_enabled);
> +
> +       pr_info("using paravirt steal-time\n");
> +

Nit comment:
If the scheduler doesn't take stolen time into consideration (when If
no-steal-acc is specified in the command line),
the above log is a bit misleading ? ARM64 also seems to be doing the
same thing.

Maybe the intention of the log is to steal time extension presence
rather than actual usage in place ?

> +       return 0;
> +}
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 23641e82a9df..ba3477197789 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -12,6 +12,7 @@
>  #include <asm/sbi.h>
>  #include <asm/processor.h>
>  #include <asm/timex.h>
> +#include <asm/paravirt.h>
>
>  unsigned long riscv_timebase __ro_after_init;
>  EXPORT_SYMBOL_GPL(riscv_timebase);
> @@ -45,4 +46,6 @@ void __init time_init(void)
>         timer_probe();
>
>         tick_setup_hrtimer_broadcast();
> +
> +       pv_time_init();
>  }
> --
> 2.43.0
>

Other than that, lgtm.

Reviewed-by: Atish Patra <atishp@rivosinc.com>


--=20
Regards,
Atish
