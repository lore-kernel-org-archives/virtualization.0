Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6069011C80
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cGrwxkCp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA1C260EE6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA1C260EE6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=cGrwxkCp
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jXbc51B5ynoi
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 06:20:01 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A32760BD4
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:20:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A32760BD4
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so413465e87.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 22:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703053199; x=1703657999; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq944v4nSeSikyHdsdYtfrdROmlHCgSLi5LRBnPeVUw=;
        b=cGrwxkCp9Vsn20elUYLDa2pqb+mldGCtD99+bMtlJdTZyb5CqaUMgwPvi/ynVg3QCY
         ACSX5bmsPenkSbdidwSlpCRLl15zB4v4jGiSUEg1xlPOUPC/7j5VMl5VznRpe6h5XM1i
         UcY7f5y2soWmmOwQ2jrdx66zfrXKBqINtVFcGGBg5q/uBs27BFxdiwfGqAcpShbpOSq7
         aANiHtM7xRfruTdwbVQrYYLj1ZsJ43A+xPNE6jo9RdlMo00nznbQBlM6thG7FUYRQD08
         sc6JVO3ihaFH+TIbdxNacRGcNsywrODkuOTBZsQooaCq/b+yRxCFKSwq3T75FMdZ0uAG
         yXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703053199; x=1703657999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iq944v4nSeSikyHdsdYtfrdROmlHCgSLi5LRBnPeVUw=;
        b=kO/4r+8N4RimTgwbF+zLJIgvso90mix6+j6v3u07FsHrhGVzzQQhLyWm13Q3yT2qrl
         XksjXuQD8TYEhMjjTtQawqfOY32SpOXH9tzsU8gXbixiDJGblis0D5SAMUFwAgJIxXMu
         65EpEJDn3kAMhfGaK7MAzWJJx2TTOaViB3FJvfLOYlJIIoj55unly7D1in+1EpzLQfU2
         10M0o6XavnSK1/jm9rGq+fHC3h5mrIYrzRoR5MfiMYZwUmQhmv5a143iT2BT7ZCeawaj
         5zJCCYRNdXgsj8XD+KtvFxaOzWEsr3Rh6TDVz/WYCytShkl2Ma+IpHAhuSnDgtdOA9py
         OZFw==
X-Gm-Message-State: AOJu0YwySjSOaH5Zx2R0iUoAzamxFu1q/Ss9XpcaOi0JXWKuDTeQ9p/k
	AOuwLCAOGvAKh6laaXeAvladJfLLs+Ztf89TyFZJx7moAVTUkw==
X-Google-Smtp-Source: AGHT+IFPJlTUg6BHzAvdJt855u7MZHbyR+qyE/TBfh5oGHB1OTelOhMorv0vev6lm6fkeDiwOZOZcQ8dkSzvVYDU6sA=
X-Received: by 2002:a05:6512:3e29:b0:50e:4ec7:a89d with SMTP id
 i41-20020a0565123e2900b0050e4ec7a89dmr727373lfv.26.1703053198852; Tue, 19 Dec
 2023 22:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com>
 <20231217204019.36492-22-ajones@ventanamicro.com> <CAOnJCU+h_ed-x7L5oFwWTWoKAq8M3Vk8XUQo1-jhPPaty5Y7Jg@mail.gmail.com>
In-Reply-To: <CAOnJCU+h_ed-x7L5oFwWTWoKAq8M3Vk8XUQo1-jhPPaty5Y7Jg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 20 Dec 2023 11:49:46 +0530
Message-ID: <CAK9=C2XQb3=PbU+Ggpp1jEnDbc-DER+eEY9j=w8w=_6DNjcdDg@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] RISC-V: KVM: Add support for SBI extension registers
To: Atish Patra <atishp@atishpatra.org>
Cc: Andrew Jones <ajones@ventanamicro.com>, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, virtualization@lists.linux-foundation.org, 
	anup@brainfault.org, pbonzini@redhat.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:28=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Sun, Dec 17, 2023 at 12:40=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> >
> > Some SBI extensions have state that needs to be saved / restored
> > when migrating the VM. Provide a get/set-one-reg register type
> > for SBI extension registers. Each SBI extension that uses this type
> > will have its own subtype. There are currently no subtypes defined.
> > The next patch introduces the first one.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++
> >  arch/riscv/include/uapi/asm/kvm.h     |  3 ++
> >  arch/riscv/kvm/vcpu_onereg.c          | 42 +++++++++++++++++--
> >  arch/riscv/kvm/vcpu_sbi.c             | 58 +++++++++++++++++++++++++++
> >  4 files changed, 103 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include=
/asm/kvm_vcpu_sbi.h
> > index 99c23bb37a37..dd60f73b5c36 100644
> > --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > @@ -60,6 +60,10 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *=
vcpu,
> >                                    const struct kvm_one_reg *reg);
> >  int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
> >                                    const struct kvm_one_reg *reg);
> > +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> > +                              const struct kvm_one_reg *reg);
> > +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> > +                              const struct kvm_one_reg *reg);
> >  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
> >                                 struct kvm_vcpu *vcpu, unsigned long ex=
tid);
> >  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
> > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uap=
i/asm/kvm.h
> > index e961d79622fb..30f89a0e855f 100644
> > --- a/arch/riscv/include/uapi/asm/kvm.h
> > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > @@ -242,6 +242,9 @@ enum KVM_RISCV_SBI_EXT_ID {
> >  #define KVM_REG_RISCV_VECTOR_REG(n)    \
> >                 ((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsi=
gned long))
> >
> > +/* Registers for specific SBI extensions are mapped as type 10 */
> > +#define KVM_REG_RISCV_SBI              (0x0a << KVM_REG_RISCV_TYPE_SHI=
FT)
> > +
>
>
> nit comment: KVM_REG_RISCV_SBI looks bit odd when we already have
> KVM_REG_RISCV_SBI_EXT for
> extension enabling/disabling.
>
> How about renaming this to KVM_REG_RISCV_SBI_EXT_STATE or something
> similar indicate that this
> for a specific extension state ?

How about KVM_REG_RISCV_SBI_STATE  ?

Regards,
Anup

>
>
> >  /* Device Control API: RISC-V AIA */
> >  #define KVM_DEV_RISCV_APLIC_ALIGN              0x1000
> >  #define KVM_DEV_RISCV_APLIC_SIZE               0x4000
> > diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.=
c
> > index 11cdbf844291..901480e73817 100644
> > --- a/arch/riscv/kvm/vcpu_onereg.c
> > +++ b/arch/riscv/kvm/vcpu_onereg.c
> > @@ -961,6 +961,29 @@ static unsigned long num_sbi_ext_regs(struct kvm_v=
cpu *vcpu)
> >         return copy_sbi_ext_reg_indices(vcpu, NULL);
> >  }
> >
> > +static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uin=
dices)
> > +{
> > +       int n =3D num_sbi_regs(vcpu);
> > +
> > +       for (int i =3D 0; i < n; i++) {
> > +               u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 |
> > +                         KVM_REG_RISCV_SBI | i;
> > +
> > +               if (uindices) {
> > +                       if (put_user(reg, uindices))
> > +                               return -EFAULT;
> > +                       uindices++;
> > +               }
> > +       }
> > +
> > +       return n;
> > +}
> > +
> >  static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcp=
u)
> >  {
> >         if (!riscv_isa_extension_available(vcpu->arch.isa, v))
> > @@ -1028,6 +1051,7 @@ unsigned long kvm_riscv_vcpu_num_regs(struct kvm_=
vcpu *vcpu)
> >         res +=3D num_vector_regs(vcpu);
> >         res +=3D num_isa_ext_regs(vcpu);
> >         res +=3D num_sbi_ext_regs(vcpu);
> > +       res +=3D num_sbi_regs(vcpu);
> >
> >         return res;
> >  }
> > @@ -1083,6 +1107,12 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_v=
cpu *vcpu,
> >         ret =3D copy_sbi_ext_reg_indices(vcpu, uindices);
> >         if (ret < 0)
> >                 return ret;
> > +       uindices +=3D ret;
> > +
> > +       ret =3D copy_sbi_reg_indices(vcpu, uindices);
> > +       if (ret < 0)
> > +               return ret;
> > +       uindices +=3D ret;
> >
> >         return 0;
> >  }
> > @@ -1105,12 +1135,14 @@ int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcp=
u,
> >         case KVM_REG_RISCV_FP_D:
> >                 return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
> >                                                  KVM_REG_RISCV_FP_D);
> > +       case KVM_REG_RISCV_VECTOR:
> > +               return kvm_riscv_vcpu_set_reg_vector(vcpu, reg);
> >         case KVM_REG_RISCV_ISA_EXT:
> >                 return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
> >         case KVM_REG_RISCV_SBI_EXT:
> >                 return kvm_riscv_vcpu_set_reg_sbi_ext(vcpu, reg);
> > -       case KVM_REG_RISCV_VECTOR:
> > -               return kvm_riscv_vcpu_set_reg_vector(vcpu, reg);
> > +       case KVM_REG_RISCV_SBI:
> > +               return kvm_riscv_vcpu_set_reg_sbi(vcpu, reg);
> >         default:
> >                 break;
> >         }
> > @@ -1136,12 +1168,14 @@ int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcp=
u,
> >         case KVM_REG_RISCV_FP_D:
> >                 return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
> >                                                  KVM_REG_RISCV_FP_D);
> > +       case KVM_REG_RISCV_VECTOR:
> > +               return kvm_riscv_vcpu_get_reg_vector(vcpu, reg);
> >         case KVM_REG_RISCV_ISA_EXT:
> >                 return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
> >         case KVM_REG_RISCV_SBI_EXT:
> >                 return kvm_riscv_vcpu_get_reg_sbi_ext(vcpu, reg);
> > -       case KVM_REG_RISCV_VECTOR:
> > -               return kvm_riscv_vcpu_get_reg_vector(vcpu, reg);
> > +       case KVM_REG_RISCV_SBI:
> > +               return kvm_riscv_vcpu_get_reg_sbi(vcpu, reg);
> >         default:
> >                 break;
> >         }
> > diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> > index 088daaa23dd8..834176242ddf 100644
> > --- a/arch/riscv/kvm/vcpu_sbi.c
> > +++ b/arch/riscv/kvm/vcpu_sbi.c
> > @@ -325,6 +325,64 @@ int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu=
 *vcpu,
> >         return 0;
> >  }
> >
> > +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> > +                              const struct kvm_one_reg *reg)
> > +{
> > +       unsigned long __user *uaddr =3D
> > +                       (unsigned long __user *)(unsigned long)reg->add=
r;
> > +       unsigned long reg_num =3D reg->id & ~(KVM_REG_ARCH_MASK |
> > +                                           KVM_REG_SIZE_MASK |
> > +                                           KVM_REG_RISCV_SBI);
> > +       unsigned long reg_subtype, reg_val;
> > +
> > +       if (KVM_REG_SIZE(reg->id) !=3D sizeof(unsigned long))
> > +               return -EINVAL;
> > +
> > +       if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
> > +               return -EFAULT;
> > +
> > +       reg_subtype =3D reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
> > +       reg_num &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> > +
> > +       switch (reg_subtype) {
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> > +                              const struct kvm_one_reg *reg)
> > +{
> > +       unsigned long __user *uaddr =3D
> > +                       (unsigned long __user *)(unsigned long)reg->add=
r;
> > +       unsigned long reg_num =3D reg->id & ~(KVM_REG_ARCH_MASK |
> > +                                           KVM_REG_SIZE_MASK |
> > +                                           KVM_REG_RISCV_SBI);
> > +       unsigned long reg_subtype, reg_val;
> > +       int ret;
> > +
> > +       if (KVM_REG_SIZE(reg->id) !=3D sizeof(unsigned long))
> > +               return -EINVAL;
> > +
> > +       reg_subtype =3D reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
> > +       reg_num &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> > +
> > +       switch (reg_subtype) {
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
> > +               return -EFAULT;
> > +
> > +       return 0;
> > +}
> > +
> >  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
> >                                 struct kvm_vcpu *vcpu, unsigned long ex=
tid)
> >  {
> > --
> > 2.43.0
> >
>
> Other than that, lgtm.
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>
> --
> Regards,
> Atish
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
