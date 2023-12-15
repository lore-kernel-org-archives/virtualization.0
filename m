Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E99C8F5
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="rGAuh9U2"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20032409DF
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:54:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20032409DF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=rGAuh9U2
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w_Drnc20BkgX
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 05:54:20 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 416E94098B
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 416E94098B
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-425fbac8fc7so2847231cf.3
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 21:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702619659; x=1703224459; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIlGBUI7+xyayXLeWefjq6qjRUJDvM6KcbCYeer1jRk=;
        b=rGAuh9U2sL6JvMtf0+KrorkulBwA0EAZPJNlgpcOtk5Rrvea8bhIZvxGwuIlu3Az9x
         O8lnR4fks1355f76+Gd37XU2roBB9U5CDM+THhNLf6vBCDTXIfHQ99CAJQ/SKq0oc6fN
         NRy17CG2Ful8GlctK6kYoDEsAd6sOkSagYZf+bbS0D9PdLCZEOSxm9Bpstvq3Khi/MML
         Aw05cNpJ1km9lMjiFxY1tzxieikyWwyffzk3BR5l5xqNYX32tTV3m+XZ2d7Km+xBran8
         B4RUMXRwbUNnku81wy8z8nsSmj38Be5mCQ39NZCd95aqZAT1cJ74T+2iIYnB3fXYrquf
         /1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702619659; x=1703224459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIlGBUI7+xyayXLeWefjq6qjRUJDvM6KcbCYeer1jRk=;
        b=VuGogEuxQiOhVntqA9L1fr/0+p8WW6H9NKii3GfLPtycU7lYWYnZR54TzDBVWLErEn
         XXLEOobirdhtZmlDYCMVSGgySFDKAt1m3bgxsxh6sS6jopCTQ+5brZg0TNgYWMVau3Mh
         itAOIOIwiRm+awCz3BJGKUvq7BPxnPM+0eAOPVcav+KGI7bPrXYydkU6zy0P7n4S09JC
         xhLI+W8pXqjMq4ObW7/SGbg/fEiHt8F2PTHF4eE5vmJv1IrCFqCZffSW6oWlMrL+gu0T
         eYiS1eC+VG3jNp7XnMYuJJX8M7lxYKoeJ/zgexbH+LQ7rUpHSJ4EHmbA8Qrut3OzCVeo
         7mLg==
X-Gm-Message-State: AOJu0Yy3t1mcrJeCFunklnqjiorITsFv1Yaxdi8IDl4n0QXxhP1L3vFT
	H/MTpaERAMVa9x5ERe9Muk3tRrPHqukX0/sEqOS5Zw==
X-Google-Smtp-Source: AGHT+IHOyrKLgnQy+W8sgXbtsBZvEa32nid80KmWXfHMez/R3halXXDJw+VufpLEgn2w4DBWuWK08pywPMQMUQMgxdk=
X-Received: by 2002:a05:622a:100f:b0:425:4043:18ce with SMTP id
 d15-20020a05622a100f00b00425404318cemr14467505qte.129.1702619658984; Thu, 14
 Dec 2023 21:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-18-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-18-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 11:24:06 +0530
Message-ID: <CAAhSdy0zYkQLTuERqV4rePC8akQa90bvMNmG_QHm_5kHn1DVnw@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] RISC-V: paravirt: Implement steal-time support
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
> When the SBI STA extension exists we can use it to implement
> paravirt steal-time support. Fill in the empty pv-time functions
> with an SBI STA implementation and add the Kconfig knobs allowing
> it to be enabled.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/Kconfig           | 19 ++++++++++
>  arch/riscv/kernel/paravirt.c | 67 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 83 insertions(+), 3 deletions(-)
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
> index 141dbcc36fa2..b09dfd81bcd2 100644
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
> @@ -31,24 +40,76 @@ static int __init parse_no_stealacc(char *arg)
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
> +       if (IS_ENABLED(CONFIG_32BIT)) {
> +               /*
> +                * Check the sequence field before and after reading the =
steal
> +                * field. Repeat the read if it is different or odd.
> +                */
> +               do {
> +                       sequence =3D READ_ONCE(st->sequence);
> +                       virt_rmb();
> +                       steal =3D READ_ONCE(st->steal);
> +                       virt_rmb();
> +               } while ((le32_to_cpu(sequence) & 1) ||
> +                        sequence !=3D READ_ONCE(st->sequence));

Actually, we should be doing this sequence for both RV64 and RV32
because for RV64 the steal time value is valid only when sequence is
an even number.

> +       } else {
> +               steal =3D READ_ONCE(st->steal);
> +       }
> +
> +       return le64_to_cpu(steal);
>  }
>
>  int __init pv_time_init(void)
> --
> 2.43.0
>

Regards,
Anup
