Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F71799F
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763611; cv=none; b=PU4G5wUCyFSuTfNRXQREArlc8ZXV6bEfUFLTUCNBO8UHDL6icqy3nWgb8J6k8sZVk16+COfJ6BBAlM2Pzv2h+KBpvZX/zICOjuTV0/ZF85r/iwekzvWsHnEgBP4zlNtDQ725F9L+7GcknrUhwm/IPo4w/tzUmWuuRnVhtotmnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763611; c=relaxed/simple;
	bh=S8RSp/2q15SRYkEZDE5+H+zC8HJZOOYbv21axv7mTXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiDkokxycy5XO8oY7dFynxPz2T6sKXtRSZQnNoLa4oxymkVmRU7daayOjrkpkCYSwFZhMhfOQOecDC7HsS6p8abUH5gk6qCZb2Q3gp8ybOMmTdyuFz1bdloDHqkZxaaeq2E4RWWqqqfaC2n00NkszngppSjUXnpg412UFvsze1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=h4ttIl5f; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="h4ttIl5f"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36b08fc1913so11968285ab.0
        for <virtualization@lists.linux.dev>; Sun, 21 Apr 2024 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763608; x=1714368408; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cial3YyC1sggqpy7QrWZpU+HgoNnfN50j0VIzR/hees=;
        b=h4ttIl5fApkl30/0jwEwKVV+2RKiIs5vX88+KGoe39qZ16fnCQ0PKlU0u/a13ydW84
         5IHW5RvLaokChxzoCqSY81QyDbNFVxBfm/ot1AM+kJCL8pbeMVkSkAWNODQUxNpiakoP
         SiygFLCsck18uJuL/rttX94Sf78Ni5IpmWy4g7d3LUICAE0iIhrCOaEomNiaKNj+Nho0
         7AmBSrnRphLKqNmcyXgRoeTR14WMe+Bar0OAJhNPyxZ47+Gt/aIl/aGkH1Z9NmPJOMfD
         lY6AvOfmAWl42PV4aK3Cj7475WzMWHG6O1xZ/Lu8iEtpxLnyn8XGmXx0aDnqgfMaK4uY
         JYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763608; x=1714368408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cial3YyC1sggqpy7QrWZpU+HgoNnfN50j0VIzR/hees=;
        b=kRxjXIiurJAr2UB4EkrkvNMcTlsuc7wVHSHdnJq8iJTYg2vtoDMOphcZ1gsFRli7AM
         Y5IL3AlZUJWhmGitjkALBx/eFKIyqkGJSQ5Irl2HuKCnmI/q2uU3l/wGcstej9iQNimd
         l0csfaghCeAYjaYPExvGZ2GXCIxVWh1qXmTwIjzYgZiEpjWRJ9iqtYM8j8jSUs3jQLwH
         rkPLfPbEbOldWNcNyRvk7oFaZ+VkzlSpFCn9ecs+MgGtBJ9S+3g5KB/CA816aRj7IOuq
         7R3lyaVxrsXub+f+LU5HqzGqdRP2lxjwygKkpOZ+XaOCibmGMdIziLAubDZNbbz651Id
         fr9A==
X-Forwarded-Encrypted: i=1; AJvYcCW/L0s8glcA7T/98XAeqevhrJLFS0Z/3E7sa4B2KyZb/GFrR6z1MXHigRtrzJNI+XUW59kVreqoLMYbyqmGSdblcjGzLsDRhlJ1AE1wUwQ=
X-Gm-Message-State: AOJu0YxzwAqKk1iindKNpgtXc4imoWLNhEEfcwyjmfRkPw460IMe7PlO
	LqHH3b5XxhC6epKhS4whiWu9/F8QU/OASWndwUHwltQLks70AE+Eo9PFZzP8hbj9AwcSpy1eTjV
	aZOr7x6Lytp0K43kVeGGzWDByMTUJZvSM20/1Lw==
X-Google-Smtp-Source: AGHT+IEABacZ9QXPS+L5TLIrF699DxFIKbW3bDrYQOc34jyt+qHXpuDOMiVpMcu9RlTxm6mqruBv7i/++4LrvmLUpRQ=
X-Received: by 2002:a05:6e02:1386:b0:36b:aae:613 with SMTP id
 d6-20020a056e02138600b0036b0aae0613mr12274364ilo.10.1713763608202; Sun, 21
 Apr 2024 22:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-17-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-17-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:56:37 +0530
Message-ID: <CAAhSdy0OPv3Fg1CWV9vzE_nHo943TNRh6-xxt8WTK6fOFg_ptg@mail.gmail.com>
Subject: Re: [PATCH v8 16/24] RISC-V: KVM: Improve firmware counter read function
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Rename the function to indicate that it is meant for firmware
> counter read. While at it, add a range sanity check for it as
> well.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h | 2 +-
>  arch/riscv/kvm/vcpu_pmu.c             | 7 ++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/a=
sm/kvm_vcpu_pmu.h
> index 55861b5d3382..fa0f535bbbf0 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> @@ -89,7 +89,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *v=
cpu, unsigned long ctr_ba
>                                      unsigned long ctr_mask, unsigned lon=
g flags,
>                                      unsigned long eidx, u64 evtdata,
>                                      struct kvm_vcpu_sbi_return *retdata)=
;
> -int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cid=
x,
> +int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long =
cidx,
>                                 struct kvm_vcpu_sbi_return *retdata);
>  int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned lo=
ng cidx,
>                                       struct kvm_vcpu_sbi_return *retdata=
);
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e1409ec9afc0..04db1f993c47 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -235,6 +235,11 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsig=
ned long cidx,
>         u64 enabled, running;
>         int fevent_code;
>
> +       if (cidx >=3D kvm_pmu_num_counters(kvpmu) || cidx =3D=3D 1) {
> +               pr_warn("Invalid counter id [%ld] during read\n", cidx);
> +               return -EINVAL;
> +       }
> +
>         pmc =3D &kvpmu->pmc[cidx];
>
>         if (pmc->cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> @@ -747,7 +752,7 @@ int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu=
 *vcpu, unsigned long cidx,
>         return 0;
>  }
>
> -int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cid=
x,
> +int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long =
cidx,
>                                 struct kvm_vcpu_sbi_return *retdata)
>  {
>         int ret;
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.=
c
> index cf111de51bdb..e4be34e03e83 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -62,7 +62,7 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>                 ret =3D kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1,=
 cp->a2, retdata);
>                 break;
>         case SBI_EXT_PMU_COUNTER_FW_READ:
> -               ret =3D kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata=
);
> +               ret =3D kvm_riscv_vcpu_pmu_fw_ctr_read(vcpu, cp->a0, retd=
ata);
>                 break;
>         case SBI_EXT_PMU_COUNTER_FW_READ_HI:
>                 if (IS_ENABLED(CONFIG_32BIT))
> --
> 2.34.1
>
