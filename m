Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDEF1864A
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="RhFXrIoe"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EF4582F57
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:16:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EF4582F57
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=RhFXrIoe
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ED6Igo5G20W
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:16:43 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3554E82F4A
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:16:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3554E82F4A
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c21e185df5so400063a12.1
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702631802; x=1703236602; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMcOhAwsWCbAfYbdVJkvW816pD0Yemk90HmjiUkezJ8=;
        b=RhFXrIoeKpM9xhLDN20kKkkasl9JLthloPAtOv9TEPUC90d+LfzSo0pPxndGAKeQAk
         dKKf8+LcxtbyUli3m4N7AVYfIqzy979DUE9c9sy5h4KHpnqGnmkkl+5Sx3nMv7vPjkPg
         EISxrQthcmDVjp/9NkcON8wLSmhmCRh72j0Zi8uf/Ybg8568u5y+EhdzO8MtB4uK9J+c
         yDIMDycHDIjRP07GV+G/VyHbnST7ZO3DcVbsYCsNKb+OeC1uz3BMCEyGIcUvSvEVoDae
         iIYx4m43I0V9mnnpJpaWZaFg/hbyoy2BvKG2+f/cenuRFyqg9nRcAUyf2ric/cJ8ZOrL
         cKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631802; x=1703236602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMcOhAwsWCbAfYbdVJkvW816pD0Yemk90HmjiUkezJ8=;
        b=Wv81Ht5cY5IH3diYPqyz+VyGXoKLiOy5enj/Dgcj1UBiT+cOujBuHszP0AUSTG6MGl
         fYyeHqvY/qHAdYzIs/a97hVlE0HHXqiEmWH2QHAMujYM7NSdP4lTgQI0GAzCmo/IKI77
         G8QYc7Jo/5L/iRG3bQ0kztY9jsiuRJe0fetsFiaaT74KDpeY/ChJnS4JGcFTn0OxxYCc
         Ts91ryVI7UbZnxeWUVUb7W7swRJm+Rtg/plL4SNigTk0caFnJhkWoDQCdCICmH/HjfY9
         ThK8JOxKQ/X0SpjwkY13gCrmkDChVGJeT6w2XVFPNVIQvxVeT1QeZNJvuC8jKoIaQxKo
         Ap4g==
X-Gm-Message-State: AOJu0YzhiPvqXRtlzWTyGdU34P+Dnd21bJC+txRm9HRIbddBh4NNI975
	h2vJ7R2CdRW1yfQsX4DeG2HVK3yJnkbTXg2yI1JCeA==
X-Google-Smtp-Source: AGHT+IEsVE/M56LfpP/PhfR9bYnI+du754CZcOqtgiP+hhiXuEtARE9yi4FDBv4Y8kozeZa/+nxFkTjIwYsjHxMo0A0=
X-Received: by 2002:a05:6a20:561a:b0:18f:97c:9791 with SMTP id
 ir26-20020a056a20561a00b0018f097c9791mr11934769pzc.121.1702631802411; Fri, 15
 Dec 2023 01:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-23-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-23-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:46:30 +0530
Message-ID: <CAAhSdy3WXKh79Scxu4kEHV9wb0itzttyz47Q0zP9-H==eDHAUg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] RISC-V: KVM: Add support for SBI STA registers
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:46=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> KVM userspace needs to be able to save and restore the steal-time
> shared memory address. Provide the address through the get/set-one-reg
> interface with two ulong-sized SBI STA extension registers (lo and hi).
> 64-bit KVM userspace must not set the hi register to anything other
> than zero and is allowed to completely neglect saving/restoring it.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
