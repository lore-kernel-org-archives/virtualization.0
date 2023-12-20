Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CE125A2
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LQAd/01o"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3CE7340140
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:32:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CE7340140
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=LQAd/01o
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HdIYt8wZWXvZ
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 06:32:15 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DAAEA400EC
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:32:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAAEA400EC
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c2308faedso62596095e9.1
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 22:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703053932; x=1703658732; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ljoOXU7dM/4xhuAcxiFqwp6oUgqoh+Yh28AnmfqG6tM=;
        b=LQAd/01orJaxuAT4wnBTnmAdHZ3iroBMMU0IxVGxuBsf96STmwgVgTIcKpooq2ak3t
         UUBYUEa3npsC9afEsz0Ib1a/dsldhGBPDpijXN4Sjyu6n4BUEGv3Q8DQxPxAfOcCZpiW
         kq3oCAueNVA8PXaeb8w/woKBTeA0F9c3S65hEr+pBAzWGxzlIr8JG+9Wp1zGHw3urWKm
         disJFB6uhNIZlxRjbDaegkpCd7xoBPqZL6OlIufDV1tp+DQmc0o6Ypky1wCFylzGhZxh
         enj28WgyYOjyMIaPSUKhMsi92TSweCcaBZP9zSMu1LOQUQxf0YaF8imkK+UQF176Qmk0
         aZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703053932; x=1703658732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljoOXU7dM/4xhuAcxiFqwp6oUgqoh+Yh28AnmfqG6tM=;
        b=UWMBgxJzIlAp1UCkMiH4z8xZs5UXyeFTkmRdCyLgiVmVa8bPZeMXyvossHkE982aoU
         xtVytyG0PabyK6OYDNPZO1GLh/4rtaSvyBYgtNRGMPk+TVjJzE/2xmZ4oHZdXDq8i9Cy
         pOxRKfhqg5pGaHJwP4YW0BuRtjpAqwP90xE9qvo0DuwcGnX9h3j+wHSPAlTGTU1p540c
         pXq30EKryhzVIy8aBOl2+x+n7/lKVqnDgE02hVKLXm3G8CQdtIIWwqDZ41D9i+KR0PrK
         oTcj37kWeI1/JuMnzy8wn7VSho0FFiu0Xfctl31lTiJ+4qc5mu9lKEaBFXQyC6bMA5kz
         8ttg==
X-Gm-Message-State: AOJu0YxaOoF6g1GlRdNk59P07Wq7zViE4DWSGFVm0scgxg1lr+rnVmH2
	HwSnuvemu2RMYpnnZmpYkmBV8A==
X-Google-Smtp-Source: AGHT+IGmP6oLdWYoNgJnFzkf7BpxRCt/SjM4/QOIlc8F05xBQ7SLBG/FHbNnZAcyv67HwgTU96GYkQ==
X-Received: by 2002:a05:600c:a3af:b0:40c:2c36:2a23 with SMTP id hn47-20020a05600ca3af00b0040c2c362a23mr9512791wmb.180.1703053932493;
        Tue, 19 Dec 2023 22:32:12 -0800 (PST)
Received: from localhost (cst-prg-1-247.cust.vodafone.cz. [46.135.1.247])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b003367d48520dsm253699wry.46.2023.12.19.22.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 22:32:12 -0800 (PST)
Date: Wed, 20 Dec 2023 07:32:10 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atishp@atishpatra.org>, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, virtualization@lists.linux-foundation.org, anup@brainfault.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, guoren@kernel.org, 
	conor.dooley@microchip.com
Subject: Re: [PATCH v3 07/13] RISC-V: KVM: Add support for SBI extension
 registers
Message-ID: <20231220-b68357fb121f79bec9dd1a24@orel>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
 <20231217204019.36492-22-ajones@ventanamicro.com>
 <CAOnJCU+h_ed-x7L5oFwWTWoKAq8M3Vk8XUQo1-jhPPaty5Y7Jg@mail.gmail.com>
 <CAK9=C2XQb3=PbU+Ggpp1jEnDbc-DER+eEY9j=w8w=_6DNjcdDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2XQb3=PbU+Ggpp1jEnDbc-DER+eEY9j=w8w=_6DNjcdDg@mail.gmail.com>

On Wed, Dec 20, 2023 at 11:49:46AM +0530, Anup Patel wrote:
> On Wed, Dec 20, 2023 at 1:28 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Sun, Dec 17, 2023 at 12:40 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > Some SBI extensions have state that needs to be saved / restored
> > > when migrating the VM. Provide a get/set-one-reg register type
> > > for SBI extension registers. Each SBI extension that uses this type
> > > will have its own subtype. There are currently no subtypes defined.
> > > The next patch introduces the first one.
> > >
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++
> > >  arch/riscv/include/uapi/asm/kvm.h     |  3 ++
> > >  arch/riscv/kvm/vcpu_onereg.c          | 42 +++++++++++++++++--
> > >  arch/riscv/kvm/vcpu_sbi.c             | 58 +++++++++++++++++++++++++++
> > >  4 files changed, 103 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > > index 99c23bb37a37..dd60f73b5c36 100644
> > > --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > > +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > > @@ -60,6 +60,10 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
> > >                                    const struct kvm_one_reg *reg);
> > >  int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
> > >                                    const struct kvm_one_reg *reg);
> > > +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> > > +                              const struct kvm_one_reg *reg);
> > > +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> > > +                              const struct kvm_one_reg *reg);
> > >  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
> > >                                 struct kvm_vcpu *vcpu, unsigned long extid);
> > >  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
> > > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> > > index e961d79622fb..30f89a0e855f 100644
> > > --- a/arch/riscv/include/uapi/asm/kvm.h
> > > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > > @@ -242,6 +242,9 @@ enum KVM_RISCV_SBI_EXT_ID {
> > >  #define KVM_REG_RISCV_VECTOR_REG(n)    \
> > >                 ((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsigned long))
> > >
> > > +/* Registers for specific SBI extensions are mapped as type 10 */
> > > +#define KVM_REG_RISCV_SBI              (0x0a << KVM_REG_RISCV_TYPE_SHIFT)
> > > +
> >
> >
> > nit comment: KVM_REG_RISCV_SBI looks bit odd when we already have
> > KVM_REG_RISCV_SBI_EXT for
> > extension enabling/disabling.
> >
> > How about renaming this to KVM_REG_RISCV_SBI_EXT_STATE or something
> > similar indicate that this
> > for a specific extension state ?
> 
> How about KVM_REG_RISCV_SBI_STATE  ?

Also works for me.

Thanks,
drew
