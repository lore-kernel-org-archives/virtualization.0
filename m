Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672D199D6
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="s+5e7Wle"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04B8F821F9
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:09:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04B8F821F9
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=s+5e7Wle
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6t5PLp3eqg68
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:09:56 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8FA2821E3
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:09:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8FA2821E3
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28afca4b321so72081a91.0
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702631395; x=1703236195; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRrFErKdc/04UBQ46Of7g4qIAB2fgJlnfCxFKl8Le9w=;
        b=s+5e7WleJK2eAQvzga0CJ7aMFnocoNiTlH9k6Ep0qfRFhLKpLSsyIVLTPOT9aEc6U7
         0dzXYQUT23cXj25PFlJAYW9Tay87WcIy+5CaddJb4t31FbWKeCxBJBa9L/ISAeHfMdn4
         Vu5Ef+dfsoxPzzxKaKROehGZuab4v4DAO4LQNozKgp033KsTtviNVUdlF5We4GTDGh4n
         /jWRZzXD/SZzZvWDA6pWZWoiOWYpItbWU+EfjUgxRMldZvC3dEuEFm3DGvyAlDDb/k8Q
         JPY2q/autMjohd1X6CTBmIB+kDLJLDTYgieKXrRQjorCYk5c297ROJ2klr3VG2ehiOjj
         iEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631395; x=1703236195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRrFErKdc/04UBQ46Of7g4qIAB2fgJlnfCxFKl8Le9w=;
        b=MsF0zg1GTNAXCzLvu6Aeg/3VG487hscWSw6iwqt2WM7ogjvagTnrCK6h+Agm7Mq3Qs
         ODWEeAXn6zcsmsXT04w/2NUndWzzEgBrOf/BARr56ehSYcV+ZDgBUiWQNa/LSm43RSM0
         2XxcOCD25WrtzVHuEJ29E/vUXvnjq+S/jwDmJgdOErPzVjPDUdzD8nOQi+jcPKoHtA4S
         eL81vdk5Sz7dxYfkfL/jsKdDeQLdvSfsNW78ylKMJaoJC6LjYowhI6qDZGCdsIeBIZmZ
         8pibTZ8G5/aGcgWTMSdBK6JLuNChpuLgHF7FCsva23q5jQTcQgsKSN2k/02N3n1y3fuC
         ltwA==
X-Gm-Message-State: AOJu0YycCoUfT4lzCycyNmdqUQvuArboUy7Tn7oxIhhciuuCqDM5xtGA
	xxtTWxiEYdrq+g8a1ry0aYMPlsAcOeCFbc9S5yeJUQ==
X-Google-Smtp-Source: AGHT+IFEgF7O0UoDmG1ENrjKpK3+8Yrz86/YISk0VX2ZKXX/2c3BqxWpkR2W6ihSNHbrncn+v9qRo32lhbhPrWHSrFE=
X-Received: by 2002:a17:90b:f10:b0:28a:dd96:dd5b with SMTP id
 br16-20020a17090b0f1000b0028add96dd5bmr1785511pjb.35.1702631395076; Fri, 15
 Dec 2023 01:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-22-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-22-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:39:43 +0530
Message-ID: <CAAhSdy1ByuUM0veVZWKaBS_RV2Q_X5VS2gfVM_8GXht6HB7sfA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] RISC-V: KVM: Add support for SBI extension registers
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
> Some SBI extensions have state that needs to be saved / restored
> when migrating the VM. Provide a get/set-one-reg register type
> for SBI extension registers. Each SBI extension that uses this type
> will have its own subtype. There are currently no subtypes defined.
> The next patch introduces the first one.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++
>  arch/riscv/include/uapi/asm/kvm.h     |  3 ++
>  arch/riscv/kvm/vcpu_onereg.c          | 42 +++++++++++++++++--
>  arch/riscv/kvm/vcpu_sbi.c             | 58 +++++++++++++++++++++++++++
>  4 files changed, 103 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index 99c23bb37a37..dd60f73b5c36 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -60,6 +60,10 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vc=
pu,
>                                    const struct kvm_one_reg *reg);
>  int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
>                                    const struct kvm_one_reg *reg);
> +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> +                              const struct kvm_one_reg *reg);
> +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> +                              const struct kvm_one_reg *reg);
>  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>                                 struct kvm_vcpu *vcpu, unsigned long exti=
d);
>  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index e961d79622fb..30f89a0e855f 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -242,6 +242,9 @@ enum KVM_RISCV_SBI_EXT_ID {
>  #define KVM_REG_RISCV_VECTOR_REG(n)    \
>                 ((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsign=
ed long))
>
> +/* Registers for specific SBI extensions are mapped as type 10 */
> +#define KVM_REG_RISCV_SBI              (0x0a << KVM_REG_RISCV_TYPE_SHIFT=
)
> +
>  /* Device Control API: RISC-V AIA */
>  #define KVM_DEV_RISCV_APLIC_ALIGN              0x1000
>  #define KVM_DEV_RISCV_APLIC_SIZE               0x4000
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 11cdbf844291..901480e73817 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -961,6 +961,29 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcp=
u *vcpu)
>         return copy_sbi_ext_reg_indices(vcpu, NULL);
>  }
>
> +static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
> +{
> +       return 0;
> +}
> +
> +static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindi=
ces)
> +{
> +       int n =3D num_sbi_regs(vcpu);
> +
> +       for (int i =3D 0; i < n; i++) {
> +               u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 |
> +                         KVM_REG_RISCV_SBI | i;
> +
> +               if (uindices) {
> +                       if (put_user(reg, uindices))
> +                               return -EFAULT;
> +                       uindices++;
> +               }
> +       }
> +
> +       return n;
> +}
> +
>  static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
>  {
>         if (!riscv_isa_extension_available(vcpu->arch.isa, v))
> @@ -1028,6 +1051,7 @@ unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vc=
pu *vcpu)
>         res +=3D num_vector_regs(vcpu);
>         res +=3D num_isa_ext_regs(vcpu);
>         res +=3D num_sbi_ext_regs(vcpu);
> +       res +=3D num_sbi_regs(vcpu);
>
>         return res;
>  }
> @@ -1083,6 +1107,12 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcp=
u *vcpu,
>         ret =3D copy_sbi_ext_reg_indices(vcpu, uindices);
>         if (ret < 0)
>                 return ret;
> +       uindices +=3D ret;
> +
> +       ret =3D copy_sbi_reg_indices(vcpu, uindices);
> +       if (ret < 0)
> +               return ret;
> +       uindices +=3D ret;
>
>         return 0;
>  }
> @@ -1105,12 +1135,14 @@ int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
>         case KVM_REG_RISCV_FP_D:
>                 return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_D);
> +       case KVM_REG_RISCV_VECTOR:
> +               return kvm_riscv_vcpu_set_reg_vector(vcpu, reg);
>         case KVM_REG_RISCV_ISA_EXT:
>                 return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
>         case KVM_REG_RISCV_SBI_EXT:
>                 return kvm_riscv_vcpu_set_reg_sbi_ext(vcpu, reg);
> -       case KVM_REG_RISCV_VECTOR:
> -               return kvm_riscv_vcpu_set_reg_vector(vcpu, reg);
> +       case KVM_REG_RISCV_SBI:
> +               return kvm_riscv_vcpu_set_reg_sbi(vcpu, reg);
>         default:
>                 break;
>         }
> @@ -1136,12 +1168,14 @@ int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
>         case KVM_REG_RISCV_FP_D:
>                 return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_D);
> +       case KVM_REG_RISCV_VECTOR:
> +               return kvm_riscv_vcpu_get_reg_vector(vcpu, reg);
>         case KVM_REG_RISCV_ISA_EXT:
>                 return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
>         case KVM_REG_RISCV_SBI_EXT:
>                 return kvm_riscv_vcpu_get_reg_sbi_ext(vcpu, reg);
> -       case KVM_REG_RISCV_VECTOR:
> -               return kvm_riscv_vcpu_get_reg_vector(vcpu, reg);
> +       case KVM_REG_RISCV_SBI:
> +               return kvm_riscv_vcpu_get_reg_sbi(vcpu, reg);
>         default:
>                 break;
>         }
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 088daaa23dd8..834176242ddf 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -325,6 +325,64 @@ int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *=
vcpu,
>         return 0;
>  }
>
> +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> +                              const struct kvm_one_reg *reg)
> +{
> +       unsigned long __user *uaddr =3D
> +                       (unsigned long __user *)(unsigned long)reg->addr;
> +       unsigned long reg_num =3D reg->id & ~(KVM_REG_ARCH_MASK |
> +                                           KVM_REG_SIZE_MASK |
> +                                           KVM_REG_RISCV_SBI);
> +       unsigned long reg_subtype, reg_val;
> +
> +       if (KVM_REG_SIZE(reg->id) !=3D sizeof(unsigned long))
> +               return -EINVAL;
> +
> +       if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
> +               return -EFAULT;
> +
> +       reg_subtype =3D reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
> +       reg_num &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +       switch (reg_subtype) {
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> +                              const struct kvm_one_reg *reg)
> +{
> +       unsigned long __user *uaddr =3D
> +                       (unsigned long __user *)(unsigned long)reg->addr;
> +       unsigned long reg_num =3D reg->id & ~(KVM_REG_ARCH_MASK |
> +                                           KVM_REG_SIZE_MASK |
> +                                           KVM_REG_RISCV_SBI);
> +       unsigned long reg_subtype, reg_val;
> +       int ret;
> +
> +       if (KVM_REG_SIZE(reg->id) !=3D sizeof(unsigned long))
> +               return -EINVAL;
> +
> +       reg_subtype =3D reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
> +       reg_num &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +       switch (reg_subtype) {
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (ret)
> +               return ret;
> +
> +       if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>                                 struct kvm_vcpu *vcpu, unsigned long exti=
d)
>  {
> --
> 2.43.0
>
