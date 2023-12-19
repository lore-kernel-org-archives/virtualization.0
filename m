Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D23D0AC
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="TxBtCAiH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FFC0832DB
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:52:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FFC0832DB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=TxBtCAiH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v0JKLNHzVV9U
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 21:52:53 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AE29832C7
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AE29832C7
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2cc6d9b4c6aso37622411fa.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 13:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1703022771; x=1703627571; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGYqDmvJYSPUgdSgjNzmGLfpp5zFNjScmhEqHTFUBFM=;
        b=TxBtCAiHRae6hm/t8gofmOG74yhAT/cAkydqmoZ4+EVrRFOyAkE+C0n3f17zrpCyBS
         CFnFotGXfHK3phm4NdBofSop7uexC/eUxCFKTipMOQTuN057sFYXUtFVUg6GVdkVmkD6
         Ee9AMqpzzRWesoaRziSXR7JxxigpUiYJ2ENOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703022771; x=1703627571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGYqDmvJYSPUgdSgjNzmGLfpp5zFNjScmhEqHTFUBFM=;
        b=NGHFJerZYlkDib5NdQk7SqF4LqbWsNPsaV5Y3UwqQQG9b1mitemvh7rcl82cSWU/ha
         N9dSdMhPGb7klRpRXw4ku8UAYAw66eD8dkn+VQFSCXQabtRdRnhv/vvNTAQBG0uG6MuU
         9zlww7bh3wejK+0DlCsIFYtwFCdPIh9bCzx0117nJsKAkbJ3f61PJBDjwAYqxa0G/UfZ
         +5IkkzvW4WnGJJ9tj6n8rrLAznLGSg5cZDfpV9Je3EOzft03m8ACIpeiqMnTuU95DETE
         dSiyq5f554XduVn3ghdzL9mmZZgx1pB6SWmX8ZjFaN/i8nj+GPgjjmhScKrSGlR6Kc/x
         F0xA==
X-Gm-Message-State: AOJu0YyRcSSmsc8JqfvGdirqZ44RvmHKEd4w9rRxcn4AYM5SdNSkH7uJ
	6pB/gcQ7UHZ3H2WWQO16YNc7OpXHNu93I1JQP9un
X-Google-Smtp-Source: AGHT+IGJ1Dk5FqPYJMWEZ00gC2yrTzHHyYbCJaUloc/hcmvfoQTmoOLvwXeT7pty+rWkyLbS/j+i8JgZiq0lKTIa/0c=
X-Received: by 2002:a2e:711:0:b0:2cc:1fb6:9955 with SMTP id
 17-20020a2e0711000000b002cc1fb69955mr7233339ljh.86.1703022770651; Tue, 19 Dec
 2023 13:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-24-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-24-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 19 Dec 2023 13:52:38 -0800
Message-ID: <CAOnJCUJNhZ1AnhpK7zUu-v2UeCoddGTY1k8v5=uRFh=EUzFH=A@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] RISC-V: KVM: Implement SBI STA extension
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
> Add a select SCHED_INFO to the KVM config in order to get run_delay
> info. Then implement SBI STA's set-steal-time-shmem function and
> kvm_riscv_vcpu_record_steal_time() to provide the steal-time info
> to guests.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kvm/Kconfig        |  1 +
>  arch/riscv/kvm/vcpu_sbi_sta.c | 96 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index dfc237d7875b..148e52b516cf 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -32,6 +32,7 @@ config KVM
>         select KVM_XFER_TO_GUEST_WORK
>         select MMU_NOTIFIER
>         select PREEMPT_NOTIFIERS
> +       select SCHED_INFO
>         help
>           Support hosting virtualized guest machines.
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index 87bf1a5f05ce..01f09fe8c3b0 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -6,9 +6,15 @@
>  #include <linux/kconfig.h>
>  #include <linux/kernel.h>
>  #include <linux/kvm_host.h>
> +#include <linux/mm.h>
> +#include <linux/sizes.h>
>
> +#include <asm/bug.h>
> +#include <asm/current.h>
>  #include <asm/kvm_vcpu_sbi.h>
> +#include <asm/page.h>
>  #include <asm/sbi.h>
> +#include <asm/uaccess.h>
>
>  void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
>  {
> @@ -19,14 +25,100 @@ void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *v=
cpu)
>  void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
>  {
>         gpa_t shmem =3D vcpu->arch.sta.shmem;
> +       u64 last_steal =3D vcpu->arch.sta.last_steal;
> +       u32 *sequence_ptr, sequence;
> +       u64 *steal_ptr, steal;
> +       unsigned long hva;
> +       gfn_t gfn;
>
>         if (shmem =3D=3D INVALID_GPA)
>                 return;
> +
> +       /*
> +        * shmem is 64-byte aligned (see the enforcement in
> +        * kvm_sbi_sta_steal_time_set_shmem()) and the size of sbi_sta_st=
ruct
> +        * is 64 bytes, so we know all its offsets are in the same page.
> +        */
> +       gfn =3D shmem >> PAGE_SHIFT;
> +       hva =3D kvm_vcpu_gfn_to_hva(vcpu, gfn);
> +
> +       if (WARN_ON(kvm_is_error_hva(hva))) {
> +               vcpu->arch.sta.shmem =3D INVALID_GPA;
> +               return;
> +       }
> +
> +       sequence_ptr =3D (u32 *)(hva + offset_in_page(shmem) +
> +                              offsetof(struct sbi_sta_struct, sequence))=
;
> +       steal_ptr =3D (u64 *)(hva + offset_in_page(shmem) +
> +                           offsetof(struct sbi_sta_struct, steal));
> +
> +       if (WARN_ON(get_user(sequence, sequence_ptr)))
> +               return;
> +
> +       sequence =3D le32_to_cpu(sequence);
> +       sequence +=3D 1;
> +
> +       if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
> +               return;
> +
> +       if (!WARN_ON(get_user(steal, steal_ptr))) {
> +               steal =3D le64_to_cpu(steal);
> +               vcpu->arch.sta.last_steal =3D READ_ONCE(current->sched_in=
fo.run_delay);
> +               steal +=3D vcpu->arch.sta.last_steal - last_steal;
> +               WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
> +       }
> +
> +       sequence +=3D 1;
> +       WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
> +
> +       kvm_vcpu_mark_page_dirty(vcpu, gfn);
>  }
>
>  static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
>  {
> -       return SBI_ERR_FAILURE;
> +       struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
> +       unsigned long shmem_phys_lo =3D cp->a0;
> +       unsigned long shmem_phys_hi =3D cp->a1;
> +       u32 flags =3D cp->a2;
> +       struct sbi_sta_struct zero_sta =3D {0};
> +       unsigned long hva;
> +       bool writable;
> +       gpa_t shmem;
> +       int ret;
> +
> +       if (flags !=3D 0)
> +               return SBI_ERR_INVALID_PARAM;
> +
> +       if (shmem_phys_lo =3D=3D SBI_STA_SHMEM_DISABLE &&
> +           shmem_phys_hi =3D=3D SBI_STA_SHMEM_DISABLE) {
> +               vcpu->arch.sta.shmem =3D INVALID_GPA;
> +               return 0;
> +       }
> +
> +       if (shmem_phys_lo & (SZ_64 - 1))
> +               return SBI_ERR_INVALID_PARAM;
> +
> +       shmem =3D shmem_phys_lo;
> +
> +       if (shmem_phys_hi !=3D 0) {
> +               if (IS_ENABLED(CONFIG_32BIT))
> +                       shmem |=3D ((gpa_t)shmem_phys_hi << 32);
> +               else
> +                       return SBI_ERR_INVALID_ADDRESS;
> +       }
> +
> +       hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writ=
able);
> +       if (kvm_is_error_hva(hva) || !writable)
> +               return SBI_ERR_INVALID_ADDRESS;
> +
> +       ret =3D kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_=
sta));
> +       if (ret)
> +               return SBI_ERR_FAILURE;
> +
> +       vcpu->arch.sta.shmem =3D shmem;
> +       vcpu->arch.sta.last_steal =3D current->sched_info.run_delay;
> +
> +       return 0;
>  }
>
>  static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run=
 *run,
> @@ -52,7 +144,7 @@ static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>
>  static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
>  {
> -       return 0;
> +       return !!sched_info_on();
>  }
>
>  const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta =3D {
> --
> 2.43.0
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
