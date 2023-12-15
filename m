Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031577470
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Z7RR2alF"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79DDB8378A
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 08:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79DDB8378A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=Z7RR2alF
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYSuNrpQwny4
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 08:19:59 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BECAC83578
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 08:19:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BECAC83578
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso5084155e9.1
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 00:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702628396; x=1703233196; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=woYgeynbPro+dnEqCaDchShODMHQ544hR1/ce1FiDk8=;
        b=Z7RR2alF+W8fmUst5fHj+NfgpkFoKPFUSogK9CVlmWNA/rQQmQ9Qv9fOrU0z9XkJnb
         slODUokeKZOVAizFSMwTEY0hkInLzbT7e7e4mAWe3x7YFHUm0ZX/U0FK3KhJ1VR9Bqnp
         WooGun0naWURaMI9/Id4MNF/6ZrjOUo1NmSKczRjsNNxA7MuFsYiLzxLU34Zptu/K/fB
         qLJH8FG+q6AwNSuZKuuguvxuDaq/U4qixsarzyfhAJ+5W+9uufnWnKNzKGe/qB1JDxuZ
         H/uDUqKpFY/K7iBkm2+XhzcnX3/l8CcVQzPHfNkNqZTvVzHvG3f9Mrl5SDgMKAU/1tvH
         Az9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628396; x=1703233196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woYgeynbPro+dnEqCaDchShODMHQ544hR1/ce1FiDk8=;
        b=iZ9Eh7N3rfW1qVfOq7PMJeJEfQlZy6mCMSD2WEdF4j7kFyWhb5421+XWxZ4HISv/my
         0ztUNTONwqEHKEAzO9tw175qn23uaezEIyliNZ8Momis3VDuTPbkZ5lMGb89OqJUz6k9
         jzxTEMRIQZt4yrFRkPopHrjRmHaOsePO3kxQ1JRUdwaKwQbih0XsIwOV3uM4n5162YUt
         5bllwD5LWrJMAYuFRQB3aBsItLSbzkjU7IV6E/UNH+EAEhnbH1r4XD4gXK8chuJhnnu3
         0Kcji2BkO3ljHZSfW7ANm9hQDmKO3oFZdisOvlAtx+Fbrjgr/sCcik3Wx00PyVGcImdW
         O/Cg==
X-Gm-Message-State: AOJu0YwNyz1SKh0K2imDQKoPxqFQSXJoQgUoeLXtqj0ULNXUtNT6NrdF
	MRj+7BocfEkqS+DEQAgHg97Pdg==
X-Google-Smtp-Source: AGHT+IFmXA4U67Evgro3vYjs1InyjgMQwMhLVv7zZQ5Hg3wTPC9uFA8eoU72oEWCIW5lwgoXUGJWLg==
X-Received: by 2002:a05:600c:2047:b0:40c:3dd7:98dc with SMTP id p7-20020a05600c204700b0040c3dd798dcmr5373829wmg.75.1702628396370;
        Fri, 15 Dec 2023 00:19:56 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0040b538047b4sm30491981wmq.3.2023.12.15.00.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:19:55 -0800 (PST)
Date: Fri, 15 Dec 2023 09:19:54 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <anup@brainfault.org>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, pbonzini@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH v2 03/13] RISC-V: paravirt: Implement steal-time support
Message-ID: <20231215-f77bbb9f70e95c12a74c267b@orel>
References: <20231214101552.100721-15-ajones@ventanamicro.com>
 <20231214101552.100721-18-ajones@ventanamicro.com>
 <CAAhSdy0zYkQLTuERqV4rePC8akQa90bvMNmG_QHm_5kHn1DVnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy0zYkQLTuERqV4rePC8akQa90bvMNmG_QHm_5kHn1DVnw@mail.gmail.com>

On Fri, Dec 15, 2023 at 11:24:06AM +0530, Anup Patel wrote:
> On Thu, Dec 14, 2023 at 3:45 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > When the SBI STA extension exists we can use it to implement
> > paravirt steal-time support. Fill in the empty pv-time functions
> > with an SBI STA implementation and add the Kconfig knobs allowing
> > it to be enabled.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig           | 19 ++++++++++
> >  arch/riscv/kernel/paravirt.c | 67 ++++++++++++++++++++++++++++++++++--
> >  2 files changed, 83 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 95a2a06acc6a..b99fd8129edf 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -724,6 +724,25 @@ config COMPAT
> >
> >           If you want to execute 32-bit userspace applications, say Y.
> >
> > +config PARAVIRT
> > +       bool "Enable paravirtualization code"
> > +       depends on RISCV_SBI
> > +       help
> > +         This changes the kernel so it can modify itself when it is run
> > +         under a hypervisor, potentially improving performance significantly
> > +         over full virtualization.
> > +
> > +config PARAVIRT_TIME_ACCOUNTING
> > +       bool "Paravirtual steal time accounting"
> > +       depends on PARAVIRT
> > +       help
> > +         Select this option to enable fine granularity task steal time
> > +         accounting. Time spent executing other tasks in parallel with
> > +         the current vCPU is discounted from the vCPU power. To account for
> > +         that, there can be a small performance impact.
> > +
> > +         If in doubt, say N here.
> > +
> >  config RELOCATABLE
> >         bool "Build a relocatable kernel"
> >         depends on MMU && 64BIT && !XIP_KERNEL
> > diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> > index 141dbcc36fa2..b09dfd81bcd2 100644
> > --- a/arch/riscv/kernel/paravirt.c
> > +++ b/arch/riscv/kernel/paravirt.c
> > @@ -6,12 +6,21 @@
> >  #define pr_fmt(fmt) "riscv-pv: " fmt
> >
> >  #include <linux/cpuhotplug.h>
> > +#include <linux/compiler.h>
> > +#include <linux/errno.h>
> >  #include <linux/init.h>
> >  #include <linux/jump_label.h>
> > +#include <linux/kconfig.h>
> > +#include <linux/kernel.h>
> > +#include <linux/percpu-defs.h>
> >  #include <linux/printk.h>
> >  #include <linux/static_call.h>
> >  #include <linux/types.h>
> >
> > +#include <asm/barrier.h>
> > +#include <asm/page.h>
> > +#include <asm/sbi.h>
> > +
> >  struct static_key paravirt_steal_enabled;
> >  struct static_key paravirt_steal_rq_enabled;
> >
> > @@ -31,24 +40,76 @@ static int __init parse_no_stealacc(char *arg)
> >
> >  early_param("no-steal-acc", parse_no_stealacc);
> >
> > +DEFINE_PER_CPU(struct sbi_sta_struct, steal_time) __aligned(64);
> > +
> >  static bool __init has_pv_steal_clock(void)
> >  {
> > +       if (sbi_spec_version >= sbi_mk_version(2, 0) &&
> > +           sbi_probe_extension(SBI_EXT_STA) > 0) {
> > +               pr_info("SBI STA extension detected\n");
> > +               return true;
> > +       }
> > +
> >         return false;
> >  }
> >
> > -static int pv_time_cpu_online(unsigned int cpu)
> > +static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
> > +                                       unsigned long flags)
> >  {
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
> > +                       lo, hi, flags, 0, 0, 0);
> > +       if (ret.error) {
> > +               if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
> > +                       pr_warn("Failed to disable steal-time shmem");
> > +               else
> > +                       pr_warn("Failed to set steal-time shmem");
> > +               return sbi_err_map_linux_errno(ret.error);
> > +       }
> > +
> >         return 0;
> >  }
> >
> > +static int pv_time_cpu_online(unsigned int cpu)
> > +{
> > +       struct sbi_sta_struct *st = this_cpu_ptr(&steal_time);
> > +       phys_addr_t pa = __pa(st);
> > +       unsigned long lo = (unsigned long)pa;
> > +       unsigned long hi = IS_ENABLED(CONFIG_32BIT) ? upper_32_bits((u64)pa) : 0;
> > +
> > +       return sbi_sta_steal_time_set_shmem(lo, hi, 0);
> > +}
> > +
> >  static int pv_time_cpu_down_prepare(unsigned int cpu)
> >  {
> > -       return 0;
> > +       return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
> > +                                           SBI_STA_SHMEM_DISABLE, 0);
> >  }
> >
> >  static u64 pv_time_steal_clock(int cpu)
> >  {
> > -       return 0;
> > +       struct sbi_sta_struct *st = per_cpu_ptr(&steal_time, cpu);
> > +       u32 sequence;
> > +       u64 steal;
> > +
> > +       if (IS_ENABLED(CONFIG_32BIT)) {
> > +               /*
> > +                * Check the sequence field before and after reading the steal
> > +                * field. Repeat the read if it is different or odd.
> > +                */
> > +               do {
> > +                       sequence = READ_ONCE(st->sequence);
> > +                       virt_rmb();
> > +                       steal = READ_ONCE(st->steal);
> > +                       virt_rmb();
> > +               } while ((le32_to_cpu(sequence) & 1) ||
> > +                        sequence != READ_ONCE(st->sequence));
> 
> Actually, we should be doing this sequence for both RV64 and RV32
> because for RV64 the steal time value is valid only when sequence is
> an even number.

Oh, right. The spec states

"""
The supervisor-mode software MUST check this field before
and after reading the steal field, and repeat the read if
it is different or odd.
"""

which gives the SBI implementation the freedom to update the steal bits
non-atomically.

I'll fix this for v3.

Thanks,
drew


> 
> > +       } else {
> > +               steal = READ_ONCE(st->steal);
> > +       }
> > +
> > +       return le64_to_cpu(steal);
> >  }
> >
> >  int __init pv_time_init(void)
> > --
> > 2.43.0
> >
> 
> Regards,
> Anup
