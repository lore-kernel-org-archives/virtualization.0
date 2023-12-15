Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34332C6B3
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T5Ku9RUH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 797D66104C
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 12:52:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 797D66104C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=T5Ku9RUH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rkoJySbUmQSl
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 12:52:56 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20C7760B1F
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 12:52:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20C7760B1F
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3332efd75c9so452162f8f.2
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 04:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702644774; x=1703249574; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zXcFYrTG2R8DEyXiSysplwJ8JzdV6spJFQB5ZFHy7XU=;
        b=T5Ku9RUHNdwfvfU+cqrpBphTIsQfeGLaTKUj49iDtAjjFH0WbGfhHW/As54Ke273RU
         FeO66AG20xOHu8GZqo0sy7OKL8bmJ+uqDWQCE3rcLOBQl4CwkqhVuHqtaAc2LDB3Juey
         II5w1/7ZJ0jCuERKSzkApmW0n62koC3EVANWYRFNSpdCVJ3Ngu01wyxC15MCuzuJVy/+
         MSyq1kkooZWkeljsr90iDM1phEDOj8GLta+j+R8GDdlPUmz1Wf9HKSm5GxtB872VykzF
         yUAFLn+uFqeeKT5HNV47Vo17znrtS18T21/uW5zHsEr9KD/0r726qHi3JK7RbUyeB6F4
         VdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702644774; x=1703249574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXcFYrTG2R8DEyXiSysplwJ8JzdV6spJFQB5ZFHy7XU=;
        b=X8MFYujCYXK/Ob2pPQbrCrM8h3ua0IHX2oz7+S0EPLxgG68podBNQAcIMNZnpqb8NT
         w0wxxsbud04fU0gjdJga2mWqxVeQ55CxknODK2OBOJKPKCM1InrCjk2+F8NCGXuScBzd
         BRjBrjDiOPLAPbQCdzKEoZxWCv/F4U0RZ70l5VOq1f/HIllec1r8xdwHCS1j6DVyax+v
         //3S0sNVcctWDvYUKAkchivjnINeKqw0RBSUmhbzGDF/fQeIyPEhCepGJrGmNSM/L72D
         NJyjCw+KlimNlJvHxAgBupqtRY1ox+wHJhwS5FwvgkWvh1W9liCjDNGfUhQa1dwXnXdx
         CI2Q==
X-Gm-Message-State: AOJu0YyAXQckosWyjLaMUwwA0+8/GoSTx/UP6dvhN/kN4tWne39hq9Yi
	oy3S37HoLiCe7UOi+VoJOhbVuQ==
X-Google-Smtp-Source: AGHT+IGz38QbYMbYn/T15/XpWQRdFLF3er3wHBKyyCK2Dmp4kBjc8hX3P2CRJ+snm39vTRA+2fY97w==
X-Received: by 2002:adf:e5cb:0:b0:336:365c:619a with SMTP id a11-20020adfe5cb000000b00336365c619amr1403454wrn.277.1702644773878;
        Fri, 15 Dec 2023 04:52:53 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d46cc000000b003335c061a2asm18774642wrs.33.2023.12.15.04.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 04:52:53 -0800 (PST)
Date: Fri, 15 Dec 2023 13:52:51 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <anup@brainfault.org>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, pbonzini@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH v2 06/13] RISC-V: KVM: Add SBI STA info to vcpu_arch
Message-ID: <20231215-e338fe29468bed2a02dcdc3a@orel>
References: <20231214101552.100721-15-ajones@ventanamicro.com>
 <20231214101552.100721-21-ajones@ventanamicro.com>
 <CAAhSdy2tWPqoq=tZXtfkvsksAf4PPXeR3DOoKMvcfw-2YaDSvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy2tWPqoq=tZXtfkvsksAf4PPXeR3DOoKMvcfw-2YaDSvQ@mail.gmail.com>

On Fri, Dec 15, 2023 at 02:37:32PM +0530, Anup Patel wrote:
> On Thu, Dec 14, 2023 at 3:46 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > KVM's implementation of SBI STA needs to track the address of each
> > VCPU's steal-time shared memory region as well as the amount of
> > stolen time. Add a structure to vcpu_arch to contain this state
> > and make sure that the address is always set to INVALID_GPA on
> > vcpu reset. And, of course, ensure KVM won't try to update steal-
> > time when the shared memory address is invalid.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/kvm_host.h | 6 ++++++
> >  arch/riscv/kvm/vcpu.c             | 2 ++
> >  arch/riscv/kvm/vcpu_sbi_sta.c     | 4 ++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> > index 230b82c3118d..b10026fb6412 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -263,6 +263,12 @@ struct kvm_vcpu_arch {
> >
> >         /* 'static' configurations which are set only once */
> >         struct kvm_vcpu_config cfg;
> > +
> > +       /* SBI steal-time accounting */
> > +       struct {
> > +               gpa_t shmem;
> > +               u64 last_steal;
> > +       } sta;
> >  };
> >
> >  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 6995b8b641e4..fec4f5fd0fa7 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -83,6 +83,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
> >         vcpu->arch.hfence_tail = 0;
> >         memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue));
> >
> > +       vcpu->arch.sta.shmem = INVALID_GPA;
> > +
> 
> I think we should also set last_steal to zero as well.
> 
> Also, let's add kvm_riscv_vcpu_sbi_sta_reset() in vcpu_sbi_sta.c
> to reset VCPU STA state.

Will do.

> 
> >         /* Reset the guest CSRs for hotplug usecase */
> >         if (loaded)
> >                 kvm_arch_vcpu_load(vcpu, smp_processor_id());
> > diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> > index e28351c9488b..157c199be0b4 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> > @@ -10,6 +10,10 @@
> >
> >  void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
> >  {
> > +       gpa_t shmem = vcpu->arch.sta.shmem;
> > +
> > +       if (shmem == INVALID_GPA)
> > +               return;
> >  }
> >
> >  static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
> > --
> > 2.43.0
> >
> 
> Apart from the above, it looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
drew
