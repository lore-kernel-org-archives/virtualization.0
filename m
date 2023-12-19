Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C138FBA
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="hAsxyn1t"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55AD98139F
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55AD98139F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=hAsxyn1t
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NdS-NfJ1g_r9
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 19:58:41 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1565C81367
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1565C81367
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso3533232e87.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1703015918; x=1703620718; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUpc0GIaihpMqWIzUEOt1vmY7MxFwzzDxw8L+NYF9YA=;
        b=hAsxyn1tQLgcWE68izd8csUJ/rw576C61LJMxM5y8j1Pjms5DkzD6u0RMYBDGFPcZx
         WZn8zoxPJmFAPb670Xu8GwE50AFRNAN2+duOsOs9pqnkGMwHQq/cYjXFb/QIySok+h/7
         0ehx+MTERd325S7IcuQSDgFxUP0HejRqCstv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703015918; x=1703620718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUpc0GIaihpMqWIzUEOt1vmY7MxFwzzDxw8L+NYF9YA=;
        b=RVTimLivUJzZJinjUUUOZYirb0wTa23IxRQWIV6bdXhelzfSiyYCzRFzxRsqA0kXyq
         jPG+nghV4Xsnd+j1FBfjLffLVYfaL8D4mrofcJNCTWtowl5mOJi6f/VMQZdEX4pt2zRn
         PoT8y2E43n7yNDXbGf6rOUdmhgpX1hbsuac3X5VK3F3jK3od2bQ2yVebcnPj5S2XhrlY
         /kvEdJcGZfogwGQurfPqkFeXQA00HF7OC9lo29Gdu0pELQUvMGZiMtfSx6kjXH/VJxSn
         rgG3TIK6zQSfu2XHQOvGaIYTdhaXHb3+9O6tbLu+BUy9pDZUETbj2Udl7fBTKsP8+5QT
         zxdw==
X-Gm-Message-State: AOJu0YyrUo3Jwx4rK5we0tPCo38x/01ABh7JcyItBfvsuJEv9l5zZHog
	4NYiuX5NQbbgLdpdRCl/4e3iwPPvZFGkkORQ1NWX
X-Google-Smtp-Source: AGHT+IHbDvdbFCmSHNu4I6rDIJ0rzafYpLMCvgEz4R0ldqhXLtEPZBIGa+TqATNzpuKkojMuX/jsq7nCAmVGY78wKXc=
X-Received: by 2002:ac2:5edd:0:b0:50e:3568:4875 with SMTP id
 d29-20020ac25edd000000b0050e35684875mr1147236lfq.219.1703015918327; Tue, 19
 Dec 2023 11:58:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-22-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-22-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 19 Dec 2023 11:58:27 -0800
Message-ID: <CAOnJCU+h_ed-x7L5oFwWTWoKAq8M3Vk8XUQo1-jhPPaty5Y7Jg@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] RISC-V: KVM: Add support for SBI extension registers
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
> Some SBI extensions have state that needs to be saved / restored
> when migrating the VM. Provide a get/set-one-reg register type
> for SBI extension registers. Each SBI extension that uses this type
> will have its own subtype. There are currently no subtypes defined.
> The next patch introduces the first one.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
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


nit comment: KVM_REG_RISCV_SBI looks bit odd when we already have
KVM_REG_RISCV_SBI_EXT for
extension enabling/disabling.

How about renaming this to KVM_REG_RISCV_SBI_EXT_STATE or something
similar indicate that this
for a specific extension state ?


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

Other than that, lgtm.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
