Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A3125AC
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="LD0GSGLR"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA3C141E3A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:41:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA3C141E3A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LD0GSGLR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JY3kw5r4_rzv
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 06:41:54 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E4E641E27
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:41:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E4E641E27
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58dd3528497so3777673eaf.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 22:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1703054513; x=1703659313; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN8ws6aob+i7GzJge6YLErack05h3kL4ycYwmV8Hv9E=;
        b=LD0GSGLRwVRPtjbhK2/qLGjBNbhyxZ9zPEHqoOdhBniBmWbaAypWET8Cgs5vO4/Qwf
         R/hEaZmQiQA1My7Jalk2E5oqrgC+H35qIMCKOFBwj+nywS448p7mFjyeSBCL+kic7g7l
         FRWrhipFXUa2SfhKlBkGGtiwiaQ9j6ap+6HjVmJFDxQcJiZTb1Bt0y9oe0U/UzcSbcHB
         B6h/BZBWXOlVgrsANQCTK9GKlIPfkqnTsmhwJsnP06OqjyqBEIWuJPm6yhsAY6bKP48C
         jiAQRTKi33tLfMBx3Et3OSlwlt0OMv9yJmxmmTPO8831KHkyPlG3VUPoyKw8IXcuL9U7
         W2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703054513; x=1703659313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN8ws6aob+i7GzJge6YLErack05h3kL4ycYwmV8Hv9E=;
        b=CGUHp2XiBfL3Im0UURanjMYtCfdbqGsTjXSnUsKspXoBnCcvJobJcJ+beziguXkmBA
         GLlpS7huOHI99Hpg2zEOrxn0mpwxTLqu98BEjkiFtn2Gtu0aq/MRFgPwEoNMtGA3g8w3
         c8SBKTkWqx3jMEIUPuZNRauDzPZVlhpyhtLeYd+Y+S/szKJMAKsBZRg3/pXSYujsm6iD
         7ah7TA9dfXfIypOdLJpShfpeWvw3GjnPDONS3WkUpSPXuweK6nO7J2TAUSCXFHh31unP
         yu/hg/xkhnrRPj73dWqZgcwWf6PafxBHoNyQAudPodmkniEl9UoM59KWXOrYWrPfd8M/
         tGEw==
X-Gm-Message-State: AOJu0Yx4SV15KCH9RXlTBtQBAk6WCv2bEWOyi2jFWPcEz1DWPtZh0GNL
	Ie24mGHHaijmooT2VuKnCzsXU4HOVyivQz0VMiJvfw==
X-Google-Smtp-Source: AGHT+IE4lLzB3fcAVMK0KRAhjf1irt6O7ewgUPrYZ00fT9i/H81XeJGqessePq38WFZQ+QslVvsXvtIcssmbbvmqkrI=
X-Received: by 2002:a05:6358:6503:b0:173:b44:1889 with SMTP id
 v3-20020a056358650300b001730b441889mr199232rwg.16.1703054513140; Tue, 19 Dec
 2023 22:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-18-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-18-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 20 Dec 2023 12:11:40 +0530
Message-ID: <CAAhSdy2y_scAkgEnW2VMq-VD8-pUUEfT3eFnozZBRbJ_uGgeYg@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] RISC-V: paravirt: Implement steal-time support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:10=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> When the SBI STA extension exists we can use it to implement
> paravirt steal-time support. Fill in the empty pv-time functions
> with an SBI STA implementation and add the Kconfig knobs allowing
> it to be enabled.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
