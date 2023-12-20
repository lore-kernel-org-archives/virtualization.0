Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B71F5F3
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Sq/UEZ5L"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6431341E20
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6431341E20
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=Sq/UEZ5L
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tTwisd0V-1N
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 06:16:31 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3DDFB41DF1
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DDFB41DF1
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c31f18274so67425345e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 22:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703052989; x=1703657789; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XDPpb0kvBP7vFKiPEfONGKMRv2fjFsuqlGEOfdYBtlQ=;
        b=Sq/UEZ5LTa8wFxS9jdIEZeY1bKYfRZtLqOb6RnCIkzeEBNL1Skagh0ObJOb4WL8SEK
         6mNPuorXahKGuPEsfMCpNawG1J6fFnDqzFG9RPP6VhfaBnQH3OPWdWoBLu44WHcj4S87
         uWJKfUZ+mqgOr4UI5Zw8Lfc3RleuVBgsvs5C2nHxeZKC6UAUDiCrQKuy+A0raSojICk9
         AW7fGTkzy7Z64w3IOjaA5V8e5ewLsTPkYm7Oc1wvXZcoe9GYuF1Q/f5DIHjineRKJEG1
         C9YEa9caujppZXSw2rr1m8qdb1OLoDXn8yhNZBwIYJrXUUemRI01Il5V1cHZIZ61OQww
         gbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703052989; x=1703657789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDPpb0kvBP7vFKiPEfONGKMRv2fjFsuqlGEOfdYBtlQ=;
        b=FPHqZ1ZM5tfhCmZK+pV1iA/E+hvs4lxJ66l5Wtm8zNnkrIlY0QNUJuBR1q4Dks5Prl
         u1y8cyI8kIHJPDhCK7Y33ygXNKWK1vNHZGTKJt2Gtm905+SOIRPgDxAVyfFsxrE6Tv2k
         1pN608mZm59pS8xH5719p/j88gjgyBjAEIhTTWlNvPdQZ/b07aa0SdWkBQmCyB0oexGW
         IbdVMeain0hZjOMzc37swQosS7Nx/JcCzcb+aFrdmg8Bm/nXbhSymB+OJ4C75XNg/l+Z
         tblp4sawiM6QXZvU2I2bKVsucCT6KwPXv6Stv2K4xzRSxA6tC4yJy87PBCSh7za6hteM
         bZJg==
X-Gm-Message-State: AOJu0YzHerZN6YJvWrptjM4lK0jqzlRNgULtGNqaqjkHrQj/WHmMIKCp
	PXvYRoIDB3Vi7UIEgD+Petrnnw==
X-Google-Smtp-Source: AGHT+IE3AKsriIrfCPH83yc3qmLPxWkE+DTa30TEC11zj67e+ie9UuYObWs/1uSN/Ufz7ozS7iGmqQ==
X-Received: by 2002:a05:600c:19c9:b0:40c:386b:9358 with SMTP id u9-20020a05600c19c900b0040c386b9358mr9601230wmq.154.1703052989116;
        Tue, 19 Dec 2023 22:16:29 -0800 (PST)
Received: from localhost (cst-prg-1-247.cust.vodafone.cz. [46.135.1.247])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c4ed300b0040b30be6244sm6005343wmq.24.2023.12.19.22.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 22:16:28 -0800 (PST)
Date: Wed, 20 Dec 2023 07:16:26 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, pbonzini@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH v3 07/13] RISC-V: KVM: Add support for SBI extension
 registers
Message-ID: <20231220-c59e78c640f00495c3976343@orel>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
 <20231217204019.36492-22-ajones@ventanamicro.com>
 <CAOnJCU+h_ed-x7L5oFwWTWoKAq8M3Vk8XUQo1-jhPPaty5Y7Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCU+h_ed-x7L5oFwWTWoKAq8M3Vk8XUQo1-jhPPaty5Y7Jg@mail.gmail.com>

On Tue, Dec 19, 2023 at 11:58:27AM -0800, Atish Patra wrote:
> On Sun, Dec 17, 2023 at 12:40 PM Andrew Jones <ajones@ventanamicro.com> wrote:
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
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > index 99c23bb37a37..dd60f73b5c36 100644
> > --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > @@ -60,6 +60,10 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
> >                                    const struct kvm_one_reg *reg);
> >  int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
> >                                    const struct kvm_one_reg *reg);
> > +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> > +                              const struct kvm_one_reg *reg);
> > +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> > +                              const struct kvm_one_reg *reg);
> >  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
> >                                 struct kvm_vcpu *vcpu, unsigned long extid);
> >  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
> > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> > index e961d79622fb..30f89a0e855f 100644
> > --- a/arch/riscv/include/uapi/asm/kvm.h
> > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > @@ -242,6 +242,9 @@ enum KVM_RISCV_SBI_EXT_ID {
> >  #define KVM_REG_RISCV_VECTOR_REG(n)    \
> >                 ((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsigned long))
> >
> > +/* Registers for specific SBI extensions are mapped as type 10 */
> > +#define KVM_REG_RISCV_SBI              (0x0a << KVM_REG_RISCV_TYPE_SHIFT)
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

OK, will do for v4.

> 
> 
> >  /* Device Control API: RISC-V AIA */
> >  #define KVM_DEV_RISCV_APLIC_ALIGN              0x1000
> >  #define KVM_DEV_RISCV_APLIC_SIZE               0x4000
> > diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> > index 11cdbf844291..901480e73817 100644
> > --- a/arch/riscv/kvm/vcpu_onereg.c
> > +++ b/arch/riscv/kvm/vcpu_onereg.c
> > @@ -961,6 +961,29 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
> >         return copy_sbi_ext_reg_indices(vcpu, NULL);
> >  }
> >
> > +static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> > +{
> > +       int n = num_sbi_regs(vcpu);
> > +
> > +       for (int i = 0; i < n; i++) {
> > +               u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 |
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
> >  static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
> >  {
> >         if (!riscv_isa_extension_available(vcpu->arch.isa, v))
> > @@ -1028,6 +1051,7 @@ unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vcpu *vcpu)
> >         res += num_vector_regs(vcpu);
> >         res += num_isa_ext_regs(vcpu);
> >         res += num_sbi_ext_regs(vcpu);
> > +       res += num_sbi_regs(vcpu);
> >
> >         return res;
> >  }
> > @@ -1083,6 +1107,12 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
> >         ret = copy_sbi_ext_reg_indices(vcpu, uindices);
> >         if (ret < 0)
> >                 return ret;
> > +       uindices += ret;
> > +
> > +       ret = copy_sbi_reg_indices(vcpu, uindices);
> > +       if (ret < 0)
> > +               return ret;
> > +       uindices += ret;
> >
> >         return 0;
> >  }
> > @@ -1105,12 +1135,14 @@ int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
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
> > @@ -1136,12 +1168,14 @@ int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
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
> > @@ -325,6 +325,64 @@ int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
> >         return 0;
> >  }
> >
> > +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> > +                              const struct kvm_one_reg *reg)
> > +{
> > +       unsigned long __user *uaddr =
> > +                       (unsigned long __user *)(unsigned long)reg->addr;
> > +       unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
> > +                                           KVM_REG_SIZE_MASK |
> > +                                           KVM_REG_RISCV_SBI);
> > +       unsigned long reg_subtype, reg_val;
> > +
> > +       if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
> > +               return -EINVAL;
> > +
> > +       if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
> > +               return -EFAULT;
> > +
> > +       reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
> > +       reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
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
> > +       unsigned long __user *uaddr =
> > +                       (unsigned long __user *)(unsigned long)reg->addr;
> > +       unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
> > +                                           KVM_REG_SIZE_MASK |
> > +                                           KVM_REG_RISCV_SBI);
> > +       unsigned long reg_subtype, reg_val;
> > +       int ret;
> > +
> > +       if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
> > +               return -EINVAL;
> > +
> > +       reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
> > +       reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
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
> >                                 struct kvm_vcpu *vcpu, unsigned long extid)
> >  {
> > --
> > 2.43.0
> >
> 
> Other than that, lgtm.
> 
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Thanks,
drew
