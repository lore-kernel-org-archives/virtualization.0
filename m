Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E61369
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="EdO0Kzpa"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1110402F5
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1110402F5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=EdO0Kzpa
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMPBDZKAYlfV
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 00:16:11 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D54EF402BC
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D54EF402BC
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d49ba98456so1393245ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 28 Dec 2023 16:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1703808971; x=1704413771; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCCWg3zCfFlDDxfkxeDJPjn4BouEaEsgkuf/xE9DZn0=;
        b=EdO0KzpaYsNmeb3Q8pktxG9HHgCOAkKrK/UKtgEc3Mdsi/CF0hhRpjvsybzCnhqSCf
         3xpiSb3B+81UxVpH/hboyoE2HZ1wKsgSOIBR+0S2sex83hrBp2Tvv/iI2AZd2nttsZ51
         IdjBT50/Cy30PqK2TJ/hwwaTjVB8Bz8hR7HWnmfqoo7h3omFOfraAWcaXtYJH2qpDQdc
         jca8PbGiauoUIrN4K13EMRMs6GM0IxvYSpMIGVSfEan5w1Xr9YeExlMBKkrcZ+TFsA+7
         5uYLkA3yT7k0FHbeZR1fmpi0zMQev3uils//6m6E6mUok9sQZoU7b0Pzj9IiE3hxTPrv
         cgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703808971; x=1704413771;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCCWg3zCfFlDDxfkxeDJPjn4BouEaEsgkuf/xE9DZn0=;
        b=hAajFAVT2DQammXDamf9QBBpC9Vvi1jbzUoodLO92I46FYshpn49g06IjFQ2FQBUPQ
         xXD5gqJA+9y2/4MmmyIiy/pzVVVEDsy9fZ+S6GtyGEU4A6AhuMLrJrMOiFUzu+Nm2gBv
         RmrGCh/KWrBIlEzQGEvCFtMkCHVPb+lMhcZ/TEjhDivI3Pk3bDqyc/+nSEgm1P9zozs8
         KG30a4BPPZQ7EiZqK2+jv6JgRFEdnO1qzC9shxZft//TleJv6nM3pTnNYvcuxT9mTccM
         eBqDBKmViY9kg5VYSIz8prYzZuMsi/iQunxKKaBbs9zBytS0SyzPSwc0aWp44bQmB0Zu
         k9RA==
X-Gm-Message-State: AOJu0YzS7aIisSMe5afbJqJEDelnaBP/u3rrWBwEowxHmHF4HjrG7HTW
	J41ANI2OqTqvtOQT/UCSDGrXDw6yzxi6jA==
X-Google-Smtp-Source: AGHT+IE6TOg1Zt1mvSgMf96HO7o2qmmvFcOdRJ6N4O6lR8m94TX1vHCfBbyS6w2+EV/hbSI1cmgXrg==
X-Received: by 2002:a17:902:d548:b0:1d4:4c00:1c3f with SMTP id z8-20020a170902d54800b001d44c001c3fmr4934861plf.83.1703808971116;
        Thu, 28 Dec 2023 16:16:11 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001c407fac227sm14508873plr.41.2023.12.28.16.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 16:16:09 -0800 (PST)
Date: Thu, 28 Dec 2023 16:16:09 -0800 (PST)
X-Google-Original-Date: Thu, 28 Dec 2023 16:15:56 PST (-0800)
Subject:     Re: [PATCH v4 03/13] RISC-V: paravirt: Implement steal-time support
In-Reply-To: <20231220160012.40184-18-ajones@ventanamicro.com>
CC: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
  virtualization@lists.linux-foundation.org, anup@brainfault.org, atishp@atishpatra.org, pbonzini@redhat.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu,
  guoren@kernel.org, Conor Dooley <conor.dooley@microchip.com>, Atish Patra <atishp@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ajones@ventanamicro.com
Message-ID: <mhng-d9c62544-f8d3-438f-819a-58ebc65a3242@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 20 Dec 2023 08:00:16 PST (-0800), ajones@ventanamicro.com wrote:
> When the SBI STA extension exists we can use it to implement
> paravirt steal-time support. Fill in the empty pv-time functions
> with an SBI STA implementation and add the Kconfig knobs allowing
> it to be enabled.
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
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
>  	  If you want to execute 32-bit userspace applications, say Y.
>
> +config PARAVIRT
> +	bool "Enable paravirtualization code"
> +	depends on RISCV_SBI
> +	help
> +	  This changes the kernel so it can modify itself when it is run
> +	  under a hypervisor, potentially improving performance significantly
> +	  over full virtualization.
> +
> +config PARAVIRT_TIME_ACCOUNTING
> +	bool "Paravirtual steal time accounting"
> +	depends on PARAVIRT
> +	help
> +	  Select this option to enable fine granularity task steal time
> +	  accounting. Time spent executing other tasks in parallel with
> +	  the current vCPU is discounted from the vCPU power. To account for
> +	  that, there can be a small performance impact.
> +
> +	  If in doubt, say N here.
> +
>  config RELOCATABLE
>  	bool "Build a relocatable kernel"
>  	depends on MMU && 64BIT && !XIP_KERNEL
> diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> index 080c95d2a295..574733b2bbea 100644
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
> +	if (sbi_spec_version >= sbi_mk_version(2, 0) &&
> +	    sbi_probe_extension(SBI_EXT_STA) > 0) {
> +		pr_info("SBI STA extension detected\n");
> +		return true;
> +	}
> +
>  	return false;
>  }
>
> -static int pv_time_cpu_online(unsigned int cpu)
> +static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
> +					unsigned long flags)
>  {
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
> +			lo, hi, flags, 0, 0, 0);
> +	if (ret.error) {
> +		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
> +			pr_warn("Failed to disable steal-time shmem");
> +		else
> +			pr_warn("Failed to set steal-time shmem");
> +		return sbi_err_map_linux_errno(ret.error);
> +	}
> +
>  	return 0;
>  }
>
> +static int pv_time_cpu_online(unsigned int cpu)
> +{
> +	struct sbi_sta_struct *st = this_cpu_ptr(&steal_time);
> +	phys_addr_t pa = __pa(st);
> +	unsigned long lo = (unsigned long)pa;
> +	unsigned long hi = IS_ENABLED(CONFIG_32BIT) ? upper_32_bits((u64)pa) : 0;
> +
> +	return sbi_sta_steal_time_set_shmem(lo, hi, 0);
> +}
> +
>  static int pv_time_cpu_down_prepare(unsigned int cpu)
>  {
> -	return 0;
> +	return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
> +					    SBI_STA_SHMEM_DISABLE, 0);
>  }
>
>  static u64 pv_time_steal_clock(int cpu)
>  {
> -	return 0;
> +	struct sbi_sta_struct *st = per_cpu_ptr(&steal_time, cpu);
> +	u32 sequence;
> +	u64 steal;
> +
> +	/*
> +	 * Check the sequence field before and after reading the steal
> +	 * field. Repeat the read if it is different or odd.
> +	 */
> +	do {
> +		sequence = READ_ONCE(st->sequence);
> +		virt_rmb();
> +		steal = READ_ONCE(st->steal);
> +		virt_rmb();
> +	} while ((le32_to_cpu(sequence) & 1) ||
> +		 sequence != READ_ONCE(st->sequence));
> +
> +	return le64_to_cpu(steal);
>  }
>
>  int __init pv_time_init(void)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
