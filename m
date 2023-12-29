Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C023A1
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="d99+fJfS"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9691B40363
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 06:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9691B40363
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=d99+fJfS
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GcJitKgyvdRu
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 06:53:03 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A07B4032E
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 06:53:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A07B4032E
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b7d55d7717so309384639f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 28 Dec 2023 22:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1703832782; x=1704437582; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbWp45UYJe7tU3hlGSLFrqg8BGzZGAFYMRe8xTKog1o=;
        b=d99+fJfSS9zOB0BWxuNsP+gcTbXAo8CjBdN4CMAsHuG6+C9z64L2R+z27r9ro9e3kN
         m4uxJ+aPWke9O9zHJEV/1hCw8VjCr7Z/DxNTFnn4QOdzv1s/46UwLXi5cSBVo/S5pl+0
         UTUQsz22ihhz3bIkY3/rLlwZGXRSN2+5bgTL/Kf2VRUNVjnTUM6PVIk/KLVXnhRaMZzd
         FEVZsSPpG+sB4UPnnDDOI2fjSHA0CPU3nz7RlHgD4cOaI3vL4rsVTVk6y8sIXc9mBnLf
         Kj2kwYK+bfv5ghj6cSQjfHbRpz+erwxcHioHudpsXlxQZk/295YpVxQ1H4uBYk+UhbUg
         iqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703832782; x=1704437582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbWp45UYJe7tU3hlGSLFrqg8BGzZGAFYMRe8xTKog1o=;
        b=ONvxEoLeTpZE0Ek03k2G8YqV1RYmgYbKMpDvzLWHQz5I0OazOiXnsCEM8QgXH2AC/v
         z4sVUvYt2zreUgVoPs6pNNwa9Q0oCscKx/Z0KGLHMDjYVKteSjnWu1ud36sqCCRNxMSD
         l0M5jSghcoyQ6zcX1sPrg91E2WpRZvKq3BtrGWlak4OYRwwn+V0LeWxh95jAM9HY07vC
         8p8Hcsjj7Skx+C4UE5Y/mO6UZo+C25Hie7ndFg+XbZwoLsol8zgITx033fT4sBN3yYSS
         LC9fDq/gx3RytYL0LnDUUnHSa4q3eFF+ltq62SffBZ9l0t0yLqROtmuBgdYWvjRnxOpa
         co/A==
X-Gm-Message-State: AOJu0YwmC5k03ybYeLAgkc4/GwvajoT0iXDx8RgMwbSBL32HKQAY/feb
	YmJSrAm5GlaP+kYiYCo6FtXTnlmE5Dvpvz7FAY523JYFmloxwg==
X-Google-Smtp-Source: AGHT+IGjtoW3ZKMNvTG22T56ZE06r07SaCF79NbMkxT+Ps8tRkOe6zAuixK6sGX5beJkL1A0gI4pkU1aIJ1tup+tTn0=
X-Received: by 2002:a92:c549:0:b0:35f:ee15:742c with SMTP id
 a9-20020a92c549000000b0035fee15742cmr9850970ilj.7.1703832782053; Thu, 28 Dec
 2023 22:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220160012.40184-15-ajones@ventanamicro.com>
In-Reply-To: <20231220160012.40184-15-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 29 Dec 2023 12:22:50 +0530
Message-ID: <CAAhSdy3V3c6D16iCdGuXGPwgcT2Jqj_=3b-WbghRPQNTtruzHw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] RISC-V: Add steal-time support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:30=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> One frequently touted benefit of virtualization is the ability to
> consolidate machines, increasing resource utilization.  It may even be
> desirable to overcommit, at the risk of one or more VCPUs having to wait.
> Hypervisors which have interfaces for guests to retrieve the amount of
> time each VCPU had to wait give observers within the guests ways to
> account for less progress than would otherwise be expected. The SBI STA
> extension[1] provides a standard interface for guest VCPUs to retrieve
> the amount of time "stolen".
>
> This series has three parts:
>  1) Patches 01-03 - Add paravirt support to RISC-V and implement
>                     steal-time accounting support using the SBI STA
>                     extension.
>  2) Patches 04-09 - Implement SBI STA in KVM so KVM guests, such as
>                     Linux guests which enable the paravirt steal-time
>                     support, can be enlightened about stolen time.
>  3) Patches 10-13 - Add RISC-V support to the KVM selftests steal_time
>                     test and the SBI extension regs in the get-reg-list
>                     test.
>
> These patches are based on kvm-riscv/riscv_kvm_queue
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-st=
eal-time.adoc
>
> This patches are also available here
> https://github.com/jones-drew/linux/commits/kvm/steal-time-v4
>
> Changes since v3:
>  - Use work "Computing" instead of "using" in pr_info [Atish]
>  - Rename KVM_REG_RISCV_SBI to KVM_REG_RISCV_SBI_STATE [Atish, Anup]
>  - Picked up r-b's from Atish and Anup
>
> Changes since v2:
>  - Always check sequence in case the SBI impl isn't writing steal
>    atomically [Anup]
>  - Create a reset function for sta and also reset last_steal [Anup]
>  - Picked up Anup's r-b's
>
> Changes since v1:
>  - sbi_sta_steal_time_set_shmem() now maps SBI errors to linux errors [Co=
nor]
>  - Squashed v1 patch 4 into v1 patch 3 [Conor]
>  - Moved kvm_riscv_vcpu_set/get_reg_sbi() to arch/riscv/kvm/vcpu_sbi.c
>    which seems like a more appropriate file for them
>  - Rebased on kvm-riscv/riscv_kvm_queue which has all the dependencies
>
> Changes since RFC:
>  - Rebased on v6.7-rc3 (plus the patches mentioned above)
>  - Added defines for the -1's [Conor]
>  - Added a comment to the steal read sequence [Conor]
>  - Only do the steal read sequence for 32-bit and added READ_ONCE's
>  - Check for SBI v2.0 implementation
>  - Rename set_steal_time_shmem to steal_time_set_shmem
>  - Add get-reg-list support and test with get-reg-list kselftest
>  - A few other minor improvements
>  - Picked up one r-b from Conor
>
> Thanks,
> drew
>
>
> Andrew Jones (13):
>   RISC-V: paravirt: Add skeleton for pv-time support
>   RISC-V: Add SBI STA extension definitions
>   RISC-V: paravirt: Implement steal-time support
>   RISC-V: KVM: Add SBI STA extension skeleton
>   RISC-V: KVM: Add steal-update vcpu request
>   RISC-V: KVM: Add SBI STA info to vcpu_arch
>   RISC-V: KVM: Add support for SBI extension registers
>   RISC-V: KVM: Add support for SBI STA registers
>   RISC-V: KVM: Implement SBI STA extension
>   RISC-V: KVM: selftests: Move sbi_ecall to processor.c
>   RISC-V: KVM: selftests: Add guest_sbi_probe_extension
>   RISC-V: KVM: selftests: Add steal_time test support
>   RISC-V: KVM: selftests: Add get-reg-list test for STA registers

Queued this series for Linux-6.8

Thanks,
Anup

>
>  .../admin-guide/kernel-parameters.txt         |   6 +-
>  arch/riscv/Kconfig                            |  19 ++
>  arch/riscv/include/asm/kvm_host.h             |  10 +
>  arch/riscv/include/asm/kvm_vcpu_sbi.h         |  10 +
>  arch/riscv/include/asm/paravirt.h             |  28 +++
>  arch/riscv/include/asm/paravirt_api_clock.h   |   1 +
>  arch/riscv/include/asm/sbi.h                  |  17 ++
>  arch/riscv/include/uapi/asm/kvm.h             |  13 ++
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/kernel/paravirt.c                  | 134 +++++++++++
>  arch/riscv/kernel/time.c                      |   3 +
>  arch/riscv/kvm/Kconfig                        |   1 +
>  arch/riscv/kvm/Makefile                       |   1 +
>  arch/riscv/kvm/vcpu.c                         |   7 +
>  arch/riscv/kvm/vcpu_onereg.c                  |  51 ++++-
>  arch/riscv/kvm/vcpu_sbi.c                     |  67 ++++++
>  arch/riscv/kvm/vcpu_sbi_sta.c                 | 208 ++++++++++++++++++
>  tools/testing/selftests/kvm/Makefile          |   5 +-
>  .../selftests/kvm/include/riscv/processor.h   |  22 ++
>  .../selftests/kvm/lib/riscv/processor.c       |  45 ++++
>  tools/testing/selftests/kvm/lib/riscv/ucall.c |  26 ---
>  .../selftests/kvm/riscv/get-reg-list.c        |  43 ++++
>  tools/testing/selftests/kvm/steal_time.c      |  99 +++++++++
>  23 files changed, 782 insertions(+), 35 deletions(-)
>  create mode 100644 arch/riscv/include/asm/paravirt.h
>  create mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
>  create mode 100644 arch/riscv/kernel/paravirt.c
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c
>
> --
> 2.43.0
>
