Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82310D266
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="rbpV9GR6"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3C884012F
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:37:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3C884012F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=rbpV9GR6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8WjVYDjiGJ6R
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 05:37:38 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A4A02400EC
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:37:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4A02400EC
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c6b9583dcbso287079a12.2
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 21:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702618658; x=1703223458; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNqbOmNvKh9QFAYj74aoI4A4kXa8MDiFHewVGG4RU68=;
        b=rbpV9GR6K+v8YtW8TaC6J0zCDxuoXGAjbIFbBZ96N719Aw4ftLCCxudkJnRwSCRWZl
         +Eo9rYWl7mnqBp1r8x4e9yj/ISlfwb0nQ2L/bzzfDEFBi6UNJW5YGmhZ2QZUS++dba4O
         VoUMn6UaDE1RcTNGis4V46Km4NTsT37IiRTMScvqAYUus6M0kVtFiC4HNIZ+xmJv3QQ9
         cSd64qKsIgrLaDcJp0IMBowmhZhb4ZdxBGFUfqeNA+ErV/WcezLaMCo/vpGSiTNOzUXE
         zeNPiqKfCMcr+eMz4bCoys0CrOfZ5/JS08y5FDNlrwDFVeN7KVwp2G9K8/OAPx8Kprw+
         UR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702618658; x=1703223458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNqbOmNvKh9QFAYj74aoI4A4kXa8MDiFHewVGG4RU68=;
        b=mKvMtqRPmxKje1YcrUd0ReNCyHvB62rlbPKX2UpaNsHc0/Iv41FRyJpeszxHbicgDc
         yMBVQmsknHXbkqNIKSHSwWjVZfJyPcDWBW7vLVoJO4ZdGYcDrFQCXFpn71UvM3BhgRur
         JhE4enUIZ23LCsTTgZvKJjMYTBaUyOO2hKS3u8S0AISi4hOZ71pKrL617boKAPcrA1O7
         nCdNI+qRQcs8lGWw9DDoBW8barab4FRAxlS0FnJ3Af/7ZfOhcDvwj0A+15t5LX/XTpPe
         2zoiHqiw+yYRO7JNlik2pdQvJvoZXzF9IjqPLDICdq0UdRmopWw0FHR6vOr3r+3i9MpM
         iNeg==
X-Gm-Message-State: AOJu0YyNziV/xMcYmglAauHZZ4a13I6Qj4jNNfjb4EFSyNk8eY90XpsW
	P0tPeFeERzkN2Sux/5HfLhkK5arlC+dLY0Qi6xxXfQ==
X-Google-Smtp-Source: AGHT+IGMPFzX6BnHAZZwS4eYoD32gnEMTkQyv5/KvIJMQ7kFvWswZP724l8JJstjtYoR7wdKTFfd8/FBru1MYAQnkuE=
X-Received: by 2002:a05:6a21:6da1:b0:18f:97c:9792 with SMTP id
 wl33-20020a056a216da100b0018f097c9792mr13715490pzb.122.1702618657743; Thu, 14
 Dec 2023 21:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-16-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-16-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 11:07:24 +0530
Message-ID: <CAAhSdy0JgONbwAc_oaT6e7WAv9PjjmC-_zHGbHqpQ=BoZJQBEQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] RISC-V: paravirt: Add skeleton for pv-time support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:45=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> Add the files and functions needed to support paravirt time on
> RISC-V. Also include the common code needed for the first
> application of pv-time, which is steal-time. In the next
> patches we'll complete the functions to fully enable steal-time
> support.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
