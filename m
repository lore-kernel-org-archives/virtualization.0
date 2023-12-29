Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB230629
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ialVJ0vb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A3E6404B9
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A3E6404B9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ialVJ0vb
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqI5G2KkTas7
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 00:16:07 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DCB7A404FF
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCB7A404FF
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso4882304a12.2
        for <virtualization@lists.linux-foundation.org>; Thu, 28 Dec 2023 16:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1703808966; x=1704413766; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaiBamP1ZrgGVOA1x9thdMvEUyAh0k54wDBeqiex9tQ=;
        b=ialVJ0vbzTJhZpdOdZyNQzECvjGCtoie7joVrrrKtHkFw98I09Vdm0TmgZDDJnMp8W
         sUuaeZlxuR/KsiroNj2/679bLWI94npyyFWGz4V0RMoO/5QX0gjqM29yHg8p2w7j1UvN
         HOaviUsmCSzfb/jDyfLho/2GEJmtePq3i9jr43GnuAgo16kTkRKvRohTKa/HxHDhBazQ
         vqa//huI9hfa9OEuiIT6uerPSnEVO9ZNT1Pf9peJEBWDge2c8pYaNJiOZSxV5nO5eUde
         YeDSZK5u3Pf9kcROnQ5YCRNRSk/UbSqModt03/hB/hidbYYT+r+Uias/H8bHko5cNVBo
         bZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703808966; x=1704413766;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaiBamP1ZrgGVOA1x9thdMvEUyAh0k54wDBeqiex9tQ=;
        b=N++giELKuoeUmfUHSUeakHPLU/kjzHXCTlqfUwccSfXm3zq4ugLDa5xD2ZtC7sY56P
         P1bLHlOUKgN4wRTOOk6VRLSJ8AaVFu5aC0Xmn839VGXdewiDqTIAiiIUhLE86XX2k6Ot
         cgn3SwOXkdv2uZ7dhhaAEYyOzqV/jW5EFJW1y0GPDbFSVJeiXj9aebt8HkjULm5YKZzO
         ZdbYhWgLHYiji4AvNRKO+Ejvoju7fWe9CGN2Q+Xt+J5q8uOkY7FmQH3XvKaUnl7TV+2k
         MScbOJ2DPxemMFTXnzvpYsc2mxOKXwj2vMzyp0rpnKZL3hS+pRhYYC9QIfeUM4ee/g75
         0Cug==
X-Gm-Message-State: AOJu0YxiFLNsqXiurmHuiOQkaYS60hmNoHWINgKxILuNZDMaer3nf3S7
	clg1s2vuDf0qrrx8v7yhDdNilxUhKBKoqg==
X-Google-Smtp-Source: AGHT+IGrTD0Zn7Buyuyy772W+6XimqueZcV/zBY8TrLV4vlEhpDWdr/f0anYg4OhyHZcJ1Kwr9C+Cg==
X-Received: by 2002:a05:6a21:819f:b0:196:14d4:cfe8 with SMTP id pd31-20020a056a21819f00b0019614d4cfe8mr4003643pzb.26.1703808966135;
        Thu, 28 Dec 2023 16:16:06 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00230a00b006da1d9f4adcsm1935153pfh.127.2023.12.28.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 16:16:04 -0800 (PST)
Date: Thu, 28 Dec 2023 16:16:04 -0800 (PST)
X-Google-Original-Date: Thu, 28 Dec 2023 16:15:29 PST (-0800)
Subject:     Re: [PATCH v4 01/13] RISC-V: paravirt: Add skeleton for pv-time support
In-Reply-To: <20231220160012.40184-16-ajones@ventanamicro.com>
CC: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
  virtualization@lists.linux-foundation.org, anup@brainfault.org, atishp@atishpatra.org, pbonzini@redhat.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu,
  guoren@kernel.org, Conor Dooley <conor.dooley@microchip.com>, Atish Patra <atishp@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ajones@ventanamicro.com
Message-ID: <mhng-e6ad083f-423f-48c7-842f-bc2477c5a843@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 20 Dec 2023 08:00:14 PST (-0800), ajones@ventanamicro.com wrote:
> Add the files and functions needed to support paravirt time on
> RISC-V. Also include the common code needed for the first
> application of pv-time, which is steal-time. In the next
> patches we'll complete the functions to fully enable steal-time
> support.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
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
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..a0d9259e4857 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3985,9 +3985,9 @@
>  			vulnerability. System may allow data leaks with this
>  			option.
>
> -	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES] Disable paravirtualized
> -			steal time accounting. steal time is computed, but
> -			won't influence scheduler behaviour
> +	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES,RISCV] Disable
> +			paravirtualized steal time accounting. steal time is
> +			computed, but won't influence scheduler behaviour
>
>  	nosync		[HW,M68K] Disables sync negotiation for all devices.
>
> diff --git a/arch/riscv/include/asm/paravirt.h b/arch/riscv/include/asm/paravirt.h
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
> +	return static_call(pv_steal_clock)(cpu);
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
> diff --git a/arch/riscv/include/asm/paravirt_api_clock.h b/arch/riscv/include/asm/paravirt_api_clock.h
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
> @@ -85,6 +85,7 @@ obj-$(CONFIG_SMP)		+= sbi-ipi.o
>  obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>  endif
>  obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
> +obj-$(CONFIG_PARAVIRT)		+= paravirt.o
>  obj-$(CONFIG_KGDB)		+= kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
>  obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
> diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> new file mode 100644
> index 000000000000..080c95d2a295
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
> +	return 0;
> +}
> +
> +DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
> +
> +static bool steal_acc = true;
> +static int __init parse_no_stealacc(char *arg)
> +{
> +	steal_acc = false;
> +	return 0;
> +}
> +
> +early_param("no-steal-acc", parse_no_stealacc);
> +
> +static bool __init has_pv_steal_clock(void)
> +{
> +	return false;
> +}
> +
> +static int pv_time_cpu_online(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +static int pv_time_cpu_down_prepare(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +static u64 pv_time_steal_clock(int cpu)
> +{
> +	return 0;
> +}
> +
> +int __init pv_time_init(void)
> +{
> +	int ret;
> +
> +	if (!has_pv_steal_clock())
> +		return 0;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +				"riscv/pv_time:online",
> +				pv_time_cpu_online,
> +				pv_time_cpu_down_prepare);
> +	if (ret < 0)
> +		return ret;
> +
> +	static_call_update(pv_steal_clock, pv_time_steal_clock);
> +
> +	static_key_slow_inc(&paravirt_steal_enabled);
> +	if (steal_acc)
> +		static_key_slow_inc(&paravirt_steal_rq_enabled);
> +
> +	pr_info("Computing paravirt steal-time\n");
> +
> +	return 0;
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
>  	timer_probe();
>
>  	tick_setup_hrtimer_broadcast();
> +
> +	pv_time_init();
>  }

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
