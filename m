Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE54482C9
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="omIi2mc2"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A75FE61524
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A75FE61524
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=omIi2mc2
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RV8qsE8dx0Me
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:11:58 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9F2161523
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9F2161523
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50e59505881so104303e87.1
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088715; x=1703693515; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGx3mvOX20FMBsOoq/Rtz9Ujh/ImS9qvHUsXKwO1l94=;
        b=omIi2mc2pBV2tVSebudvz89mrOwmdCy9vm2jNoEvyuZfgZVdsIYZ/SNm5nKZU097tg
         XPUzXygSEWCBGvGxHMbfcjk0yJvMLn/Xnos1aF7iOyQd/nEj6kbb3zeR75NKidE/DMsn
         yA+r1OIpNQC+V8r3zwPCzfnYtBS4U+8ld5Ej9o/s6mTIF65jSNLilDHJo4PxX9RfNe/C
         u+ZfMGHeNjalUtgOZG5SOJUmV9XlIaF6lW4UMWFzjjz7RkKQEm5iSIgi6NIdPnnUK/KR
         SqrjHpFwHu2U00ja9gYykg+XY3FlX3tihe68Pss1zRAJgeVu89heZkT+sCUzI4rzy+Hs
         5UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088715; x=1703693515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGx3mvOX20FMBsOoq/Rtz9Ujh/ImS9qvHUsXKwO1l94=;
        b=ciCLXueEzAaHdO3bDeJECl40GhNI7ZYLAE2TDGK5xn9Zzmf1NBQgNWPO/XlldqxLR2
         s0z7k4vJz9czoTra0xei6WhFph+WWbfRpMhb9nwL9No6VLWfsS0MX5bArcowjEb2J4Mf
         1+YPrA4ECERIcsJxk32GyHic8mgX1v6QijyzcLo9I2LbgT9zWoA9SGgdlGw7HHRE+o5G
         VL7IQpjZcizFiWqVvr79wn5UEANDEb4ZeYGTlSX6AZnElbYNQv73uCnSLtZcPbBG4pTt
         /kncMQHtKfRRYQEab8mNz9F9rpi+W3s03gUkzd5zhNSEElSrLqv17wT1HvcaoyLqVTr4
         qUWA==
X-Gm-Message-State: AOJu0YxkfR9XdCQRsi0tkOWlzY19A9miTU5uP0PaGhtMREtSsoAtfyMm
	5i11I7mtjQaIeRu/NPe/ny8QPQjnddPzXrukIQd92g==
X-Google-Smtp-Source: AGHT+IHTIBxn/hAWuX2YpEeUprzxay2hcYxN4T2+QPQhdmFxKBZSfCel3BGt1XgcPLx+r4rAxV26oNPcsoEoxPZnobw=
X-Received: by 2002:a05:6512:3e1a:b0:50e:4ffa:589e with SMTP id
 i26-20020a0565123e1a00b0050e4ffa589emr895516lfv.42.1703088715341; Wed, 20 Dec
 2023 08:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220160012.40184-15-ajones@ventanamicro.com>
In-Reply-To: <20231220160012.40184-15-ajones@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 20 Dec 2023 21:41:43 +0530
Message-ID: <CAK9=C2Vzp=P6Cg-WEDZGCAsKW01fkNWbozGqNn0fYAA7qCbOYA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] RISC-V: Add steal-time support
To: palmer@dabbelt.com, Palmer Dabbelt <palmer@rivosinc.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, 
	atishp@atishpatra.org, pbonzini@redhat.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

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

Can you please review and ack the first three patches ?

Regards,
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
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
