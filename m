Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815D4439
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="GmzkGZrq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 511464099B
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:41:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 511464099B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=GmzkGZrq
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sg9Mn5vFYi6D
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 01:41:28 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 465E8408D0
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:41:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 465E8408D0
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso4922954e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702950086; x=1703554886; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3GQ8Cq3fEaLyXdJSkPx9cu4LnZ4Irsf5B+p1ptTVYg=;
        b=GmzkGZrq53tSBjiwT7/BtaOOLntcyuLMjzq9HV3SLn5rAP8Ael4XpRXQgdRL7PV3J6
         xKWD2iE2KAEm1KNZa+6Zbryv9+nBvkur024mlBlHdI/QldkIUN6Ah/uvpWrTXwi0uMbS
         k0vjFPo+1aNsg8jQh3mZ1ML+464AjxHfx+BtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702950086; x=1703554886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3GQ8Cq3fEaLyXdJSkPx9cu4LnZ4Irsf5B+p1ptTVYg=;
        b=CzIOQmgfBHAyquzPqUtvMRL7YzepHflX4yRuKEkk9VkdDBjlBpaeluX0mufk6QENJ9
         SYdBA9s5mJdayhvGoT5z38fUqymoLKnFwQr2TJWzC4QZN7Kyi2YTQ2BtGJUIMNcnBJmx
         JEPkuSeppLuc6X36Xzk0u34ga1Wfx7xO3Pv1bc7vszon+EjYucoEV6P/SkXGSxeBrVN9
         C0Pp8F8H59/zHirWl9ItSG07FHyEnQai0Z4vp0Bth/wwuxjG9mTvNySOA9yCqIx61ny1
         r2wSYrJHKNJsO06nSzLX2LC0SkNAtvS2wQyYyxm6GtVXwCF+d3InZvWsYYSkf5ihoCqE
         y4VA==
X-Gm-Message-State: AOJu0YxSd8N7bEk485MV4GBWfQU1cujjlcvsOerPZSUJCVMaxy4m/OsN
	lvlJgJ5UJ+8L6j4xSrB7C0dEz4/KhhgKo5K8BDTq
X-Google-Smtp-Source: AGHT+IEefQ2JnjyFtLTwkydICnlsVATVYwHTYFdOjgKYjKt/9xal7sqttNovsA4VHYaDleVY0jkTlDg2m5TphPJhyFw=
X-Received: by 2002:a05:6512:242:b0:50e:3771:fa01 with SMTP id
 b2-20020a056512024200b0050e3771fa01mr142659lfo.4.1702950086006; Mon, 18 Dec
 2023 17:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-18-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-18-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 18 Dec 2023 17:41:14 -0800
Message-ID: <CAOnJCU+ospMOmJ7PnF8ynD90cN3A3YP8gx8VHgmVzLjAQsr7eQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] RISC-V: paravirt: Implement steal-time support
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
> When the SBI STA extension exists we can use it to implement
> paravirt steal-time support. Fill in the empty pv-time functions
> with an SBI STA implementation and add the Kconfig knobs allowing
> it to be enabled.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/Kconfig           | 19 +++++++++++
>  arch/riscv/kernel/paravirt.c | 63 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 79 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 95a2a06acc6a..b99fd8129edf 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -724,6 +724,25 @@ config COMPAT
>
>           If you want to execute 32-bit userspace applications, say Y.
>
> +config PARAVIRT
> +       bool "Enable paravirtualization code"
> +       depends on RISCV_SBI
> +       help
> +         This changes the kernel so it can modify itself when it is run
> +         under a hypervisor, potentially improving performance significa=
ntly
> +         over full virtualization.
> +
> +config PARAVIRT_TIME_ACCOUNTING
> +       bool "Paravirtual steal time accounting"
> +       depends on PARAVIRT
> +       help
> +         Select this option to enable fine granularity task steal time
> +         accounting. Time spent executing other tasks in parallel with
> +         the current vCPU is discounted from the vCPU power. To account =
for
> +         that, there can be a small performance impact.
> +
> +         If in doubt, say N here.
> +
>  config RELOCATABLE
>         bool "Build a relocatable kernel"
>         depends on MMU && 64BIT && !XIP_KERNEL
> diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> index 141dbcc36fa2..cc6a85432678 100644
> --- a/arch/riscv/kernel/paravirt.c
> +++ b/arch/riscv/kernel/paravirt.c
> @@ -6,12 +6,21 @@
>  #define pr_fmt(fmt) "riscv-pv: " fmt
>
>  #include <linux/cpuhotplug.h>
> +#include <linux/compiler.h>
> +#include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/jump_label.h>
> +#include <linux/kconfig.h>
> +#include <linux/kernel.h>
> +#include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/static_call.h>
>  #include <linux/types.h>
>
> +#include <asm/barrier.h>
> +#include <asm/page.h>
> +#include <asm/sbi.h>
> +
>  struct static_key paravirt_steal_enabled;
>  struct static_key paravirt_steal_rq_enabled;
>
> @@ -31,24 +40,72 @@ static int __init parse_no_stealacc(char *arg)
>
>  early_param("no-steal-acc", parse_no_stealacc);
>
> +DEFINE_PER_CPU(struct sbi_sta_struct, steal_time) __aligned(64);
> +
>  static bool __init has_pv_steal_clock(void)
>  {
> +       if (sbi_spec_version >=3D sbi_mk_version(2, 0) &&
> +           sbi_probe_extension(SBI_EXT_STA) > 0) {
> +               pr_info("SBI STA extension detected\n");
> +               return true;
> +       }
> +
>         return false;
>  }
>
> -static int pv_time_cpu_online(unsigned int cpu)
> +static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long =
hi,
> +                                       unsigned long flags)
>  {
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
> +                       lo, hi, flags, 0, 0, 0);
> +       if (ret.error) {
> +               if (lo =3D=3D SBI_STA_SHMEM_DISABLE && hi =3D=3D SBI_STA_=
SHMEM_DISABLE)
> +                       pr_warn("Failed to disable steal-time shmem");
> +               else
> +                       pr_warn("Failed to set steal-time shmem");
> +               return sbi_err_map_linux_errno(ret.error);
> +       }
> +
>         return 0;
>  }
>
> +static int pv_time_cpu_online(unsigned int cpu)
> +{
> +       struct sbi_sta_struct *st =3D this_cpu_ptr(&steal_time);
> +       phys_addr_t pa =3D __pa(st);
> +       unsigned long lo =3D (unsigned long)pa;
> +       unsigned long hi =3D IS_ENABLED(CONFIG_32BIT) ? upper_32_bits((u6=
4)pa) : 0;
> +
> +       return sbi_sta_steal_time_set_shmem(lo, hi, 0);
> +}
> +
>  static int pv_time_cpu_down_prepare(unsigned int cpu)
>  {
> -       return 0;
> +       return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
> +                                           SBI_STA_SHMEM_DISABLE, 0);
>  }
>
>  static u64 pv_time_steal_clock(int cpu)
>  {
> -       return 0;
> +       struct sbi_sta_struct *st =3D per_cpu_ptr(&steal_time, cpu);
> +       u32 sequence;
> +       u64 steal;
> +
> +       /*
> +        * Check the sequence field before and after reading the steal
> +        * field. Repeat the read if it is different or odd.
> +        */
> +       do {
> +               sequence =3D READ_ONCE(st->sequence);
> +               virt_rmb();
> +               steal =3D READ_ONCE(st->steal);
> +               virt_rmb();
> +       } while ((le32_to_cpu(sequence) & 1) ||
> +                sequence !=3D READ_ONCE(st->sequence));
> +
> +       return le64_to_cpu(steal);
>  }
>
>  int __init pv_time_init(void)
> --
> 2.43.0
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
