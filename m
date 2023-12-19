Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E953D0AF
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="ZnHd9LDB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7415560A9C
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 20:31:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7415560A9C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=ZnHd9LDB
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ed7xFZttOMCv
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 20:31:03 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EDD8360803
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 20:31:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDD8360803
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50e2786e71fso4789681e87.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 12:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1703017860; x=1703622660; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBXPtwsHoN/y3oBVcJ4j9bS0WDSveiGxnooAJbDddFY=;
        b=ZnHd9LDBnkwYNNa/cbv3ynnmPvpbwVblbJ9/IQ53wEA7yFaXLyQJj8akaChh5e408l
         1xAZLS7hu7TEVYyISgQlonNloV2GNy/CuZHVQSHdPXjS24xZiMwD4QPQkI3p7rVEimYU
         ap9UICQoNnzt/38eotPANe8SeEmykCyUBl6+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017860; x=1703622660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBXPtwsHoN/y3oBVcJ4j9bS0WDSveiGxnooAJbDddFY=;
        b=XqxlnAz5Q6183ZtbfvQq6Gk041fa+fFF6hRlG68unjMzIbWmh8i7fiuPUZjx8xnSbP
         20UPep1GFTdgJtI2ab8CnujKMpnrUIXqMbwhBz/V+3NuSuI0EEyTbeeUqfZ7JCpTLLB5
         tWAfcic6TFiNFET3f2ltVh6sj4x53ynesaiG34Bkpa9nuhxBooFUKWokinETUJcg+QaY
         gvlB57ZSgI8ZPsaIyub39efA6TS9KqFS07MDy+5oZkz1PkNVCsI3tkEju6wgBuj/erP0
         jjVQx7gH3PNdmn5crczsBErlnBWK0AQCwiF9mlU57xl4z81Eo5P2kdc/WxFAwhl30YNQ
         W27w==
X-Gm-Message-State: AOJu0Yws20UXo1Ju8dm/9fnI174kq5hbXXJCXxUlNuQ5NCiPEDQaONTj
	bfD9VVURsVNC10M1Tc0AjnDmP2CvQzs3jgiMpq9O
X-Google-Smtp-Source: AGHT+IFhh2BhKn9eaWUi0jdJt0KBfiD8LuYgsySbAFsT9G5a2qptjImSjPNjyCOZVP5/Pba8EeFwiP69zlO3zCsJK8k=
X-Received: by 2002:a05:6512:1031:b0:50b:f15b:827f with SMTP id
 r17-20020a056512103100b0050bf15b827fmr7329196lfr.73.1703017860628; Tue, 19
 Dec 2023 12:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-23-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-23-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 19 Dec 2023 12:30:49 -0800
Message-ID: <CAOnJCULcYE_VV-6SrWcWuKOHxOxFA0BygqyyAgNM0877SzLgPQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] RISC-V: KVM: Add support for SBI STA registers
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:16=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> KVM userspace needs to be able to save and restore the steal-time
> shared memory address. Provide the address through the get/set-one-reg
> interface with two ulong-sized SBI STA extension registers (lo and hi).
> 64-bit KVM userspace must not set the hi register to anything other
> than zero and is allowed to completely neglect saving/restoring it.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  5 +++
>  arch/riscv/include/uapi/asm/kvm.h     |  9 +++++
>  arch/riscv/kvm/vcpu_onereg.c          | 36 +++++++++++-------
>  arch/riscv/kvm/vcpu_sbi.c             |  5 +++
>  arch/riscv/kvm/vcpu_sbi_sta.c         | 55 +++++++++++++++++++++++++++
>  5 files changed, 96 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index dd60f73b5c36..b96705258cf9 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -70,6 +70,11 @@ bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu=
, int idx);
>  int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run)=
;
>  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
>
> +int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long =
reg_num,
> +                                  unsigned long *reg_val);
> +int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long =
reg_num,
> +                                  unsigned long reg_val);
> +
>  #ifdef CONFIG_RISCV_SBI_V01
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01;
>  #endif
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 30f89a0e855f..d8974f954f2a 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -161,6 +161,12 @@ enum KVM_RISCV_SBI_EXT_ID {
>         KVM_RISCV_SBI_EXT_MAX,
>  };
>
> +/* SBI STA extension registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG *=
/
> +struct kvm_riscv_sbi_sta {
> +       unsigned long shmem_lo;
> +       unsigned long shmem_hi;
> +};
> +
>  /* Possible states for kvm_riscv_timer */
>  #define KVM_RISCV_TIMER_STATE_OFF      0
>  #define KVM_RISCV_TIMER_STATE_ON       1
> @@ -244,6 +250,9 @@ enum KVM_RISCV_SBI_EXT_ID {
>
>  /* Registers for specific SBI extensions are mapped as type 10 */
>  #define KVM_REG_RISCV_SBI              (0x0a << KVM_REG_RISCV_TYPE_SHIFT=
)
> +#define KVM_REG_RISCV_SBI_STA          (0x0 << KVM_REG_RISCV_SUBTYPE_SHI=
FT)
> +#define KVM_REG_RISCV_SBI_STA_REG(name)                \
> +               (offsetof(struct kvm_riscv_sbi_sta, name) / sizeof(unsign=
ed long))
>
>  /* Device Control API: RISC-V AIA */
>  #define KVM_DEV_RISCV_APLIC_ALIGN              0x1000
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 901480e73817..66d8fa648cfe 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -961,27 +961,35 @@ static unsigned long num_sbi_ext_regs(struct kvm_vc=
pu *vcpu)
>         return copy_sbi_ext_reg_indices(vcpu, NULL);
>  }
>
> -static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
> -{
> -       return 0;
> -}
> -
>  static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindi=
ces)
>  {
> -       int n =3D num_sbi_regs(vcpu);
> +       struct kvm_vcpu_sbi_context *scontext =3D &vcpu->arch.sbi_context=
;
> +       int total =3D 0;
>
> -       for (int i =3D 0; i < n; i++) {
> -               u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 |
> -                         KVM_REG_RISCV_SBI | i;
> +       if (scontext->ext_status[KVM_RISCV_SBI_EXT_STA] =3D=3D KVM_RISCV_=
SBI_EXT_STATUS_ENABLED) {
> +               u64 size =3D IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 =
: KVM_REG_SIZE_U64;
> +               int n =3D sizeof(struct kvm_riscv_sbi_sta) / sizeof(unsig=
ned long);
>
> -               if (uindices) {
> -                       if (put_user(reg, uindices))
> -                               return -EFAULT;
> -                       uindices++;
> +               for (int i =3D 0; i < n; i++) {
> +                       u64 reg =3D KVM_REG_RISCV | size |
> +                                 KVM_REG_RISCV_SBI | KVM_REG_RISCV_SBI_S=
TA | i;
> +
> +                       if (uindices) {
> +                               if (put_user(reg, uindices))
> +                                       return -EFAULT;
> +                               uindices++;
> +                       }
>                 }
> +
> +               total +=3D n;
>         }
>
> -       return n;
> +       return total;
> +}
> +
> +static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
> +{
> +       return copy_sbi_reg_indices(vcpu, NULL);
>  }
>
>  static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 834176242ddf..0689f6813968 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -345,6 +345,8 @@ int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
>         reg_num &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
>
>         switch (reg_subtype) {
> +       case KVM_REG_RISCV_SBI_STA:
> +               return kvm_riscv_vcpu_set_reg_sbi_sta(vcpu, reg_num, reg_=
val);
>         default:
>                 return -EINVAL;
>         }
> @@ -370,6 +372,9 @@ int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
>         reg_num &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
>
>         switch (reg_subtype) {
> +       case KVM_REG_RISCV_SBI_STA:
> +               ret =3D kvm_riscv_vcpu_get_reg_sbi_sta(vcpu, reg_num, &re=
g_val);
> +               break;
>         default:
>                 return -EINVAL;
>         }
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index 157c199be0b4..073bc47013b7 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -3,6 +3,8 @@
>   * Copyright (c) 2023 Ventana Micro Systems Inc.
>   */
>
> +#include <linux/kconfig.h>
> +#include <linux/kernel.h>
>  #include <linux/kvm_host.h>
>
>  #include <asm/kvm_vcpu_sbi.h>
> @@ -53,3 +55,56 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta =
=3D {
>         .handler =3D kvm_sbi_ext_sta_handler,
>         .probe =3D kvm_sbi_ext_sta_probe,
>  };
> +
> +int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu,
> +                                  unsigned long reg_num,
> +                                  unsigned long *reg_val)
> +{
> +       switch (reg_num) {
> +       case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
> +               *reg_val =3D (unsigned long)vcpu->arch.sta.shmem;
> +               break;
> +       case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
> +               if (IS_ENABLED(CONFIG_32BIT))
> +                       *reg_val =3D upper_32_bits(vcpu->arch.sta.shmem);
> +               else
> +                       *reg_val =3D 0;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu,
> +                                  unsigned long reg_num,
> +                                  unsigned long reg_val)
> +{
> +       switch (reg_num) {
> +       case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
> +               if (IS_ENABLED(CONFIG_32BIT)) {
> +                       gpa_t hi =3D upper_32_bits(vcpu->arch.sta.shmem);
> +
> +                       vcpu->arch.sta.shmem =3D reg_val;
> +                       vcpu->arch.sta.shmem |=3D hi << 32;
> +               } else {
> +                       vcpu->arch.sta.shmem =3D reg_val;
> +               }
> +               break;
> +       case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
> +               if (IS_ENABLED(CONFIG_32BIT)) {
> +                       gpa_t lo =3D lower_32_bits(vcpu->arch.sta.shmem);
> +
> +                       vcpu->arch.sta.shmem =3D ((gpa_t)reg_val << 32);
> +                       vcpu->arch.sta.shmem |=3D lo;
> +               } else if (reg_val !=3D 0) {
> +                       return -EINVAL;
> +               }
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> --
> 2.43.0
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
