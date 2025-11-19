Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03822DC35F
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537800; cv=none; b=ljq/xImeY/J4nowNqm6QqYtzbtWiyUIaVqWvfGqf620CSyT7T1BPONCjORw2WiAlDpzbfhRRJwR3SL8rlBQ3YduL5DEqSjLQOOLJiEaopaDyF6CdTBk2b1bCJKvZq3I1yOv8V6njNQnMsHY+5AFXd3mx9Ro71rQAUxwMP/NY1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537800; c=relaxed/simple;
	bh=0mw9HAO5e/CcMMOTv7byl0dh9fytC5W4l+OFeGAMB2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT8U8JPil8QOxALw+HM/WlpameUrvfiGukVASRV3ERCkKAMAjpXZUu8eAkFnHhprCvH9RUKeo6QIrZPiEmPF3tglIyY6MaHlS5783iNNATnyOgz7W4CucjCrsdqWUSgNEv2gRelG8hXAnvAhQ0CqkzpTylAuplHkBwWP7pnDURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5Lb3BTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5Lb3BTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF9C2BCB6
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763537800;
	bh=0mw9HAO5e/CcMMOTv7byl0dh9fytC5W4l+OFeGAMB2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d5Lb3BTw8ubPy3s52ZbTIkv3HZzLKk5sPDIa1k4H6CB+2gsS2SVhOt75kIMy6OBpS
	 d02dNyYd2R/dx5DKp5ytEzWyspnod9c1ZVJ2lCKbR5Kfo9bQGJHhz4wQKm0vtztKBm
	 T2g0Ria/wKTHPHPdBKOP5tAEvzVj2UF0QUpo9KTzSVAkH003IBA6IIUIHKrYjQ8hZw
	 zRRt+kJEp2mf0NmN7VWB7gho/Licm9Qjv/rBvHS3Ls+VrbkVkUvvCyRSpBSVUbModx
	 PjA0qfrMp7Rk8DfQRexgi25LcPSC/aFzJ5TrexEQbltFUOezq7Cpdk3AcT1wRwMHAe
	 +Wy9P65BlwyOQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so436378666b.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:36:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjCAibA9cUZZzXAKUouvVwNahPmoykVeU6tvsg3h2vH8WVpA285JQMTrlhGpW57YktQRSzddusxXTh4iBcsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmNsAdVYQWc82XGN/lOHZWv9P4ku1dj/1umE7sLSSKiWujUjDh
	Hfe6zSZ4lTrNxLNj/81kRHj185o0cLB/PWVXWJRveQ/l/hI5aQKm8xBlLLYiDzveKQlHPmTYBYl
	8wtIu3fUIpVk2STqsmv+573AOHksSbjk=
X-Google-Smtp-Source: AGHT+IEYFg5ZA8XnpMfOTN7CUf7qX6/Go1Z0jJ+SibsPCNQ3YzH2ZASnZ4vVQmcrzmzM07sEeohXk2w2wI9W5Hs4u7A=
X-Received: by 2002:a17:907:3cc3:b0:b73:2d99:d8a3 with SMTP id
 a640c23a62f3a-b736782d0a8mr2250337166b.26.1763537797864; Tue, 18 Nov 2025
 23:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251118080656.2012805-1-maobibo@loongson.cn> <20251118080656.2012805-3-maobibo@loongson.cn>
 <CAAhV-H4hoS0Wo3TS+FdikXMkb7qjWNFSPDoajQr0bzdeROJwGw@mail.gmail.com> <77814b6c-7a51-e130-5006-d27a172e69aa@loongson.cn>
In-Reply-To: <77814b6c-7a51-e130-5006-d27a172e69aa@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Nov 2025 15:36:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4m0SqQ06eqnJi_LwFxuYSFY4Xi1FSD1dd1w3258NEHew@mail.gmail.com>
X-Gm-Features: AWmQ_bkiBYHhLhC1TqLDPY4R0uxjwyZ0GlwygRfvid2KBRr4h7RxU8RV64RXIeg
Message-ID: <CAAhV-H4m0SqQ06eqnJi_LwFxuYSFY4Xi1FSD1dd1w3258NEHew@mail.gmail.com>
Subject: Re: [PATCH 2/3] LoongArch: Add paravirt support with vcpu_is_preempted()
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:53=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2025/11/18 =E4=B8=8B=E5=8D=888:48, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Tue, Nov 18, 2025 at 4:07=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> Function vcpu_is_preempted() is used to check whether vCPU is preempte=
d
> >> or not. Here add implementation with vcpu_is_preempted() when option
> >> CONFIG_PARAVIRT is enabled.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/smp.h      |  1 +
> >>   arch/loongarch/include/asm/spinlock.h |  5 +++++
> >>   arch/loongarch/kernel/paravirt.c      | 16 ++++++++++++++++
> >>   arch/loongarch/kernel/smp.c           |  6 ++++++
> >>   4 files changed, 28 insertions(+)
> >>
> >> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include=
/asm/smp.h
> >> index 3a47f52959a8..5b37f7bf2060 100644
> >> --- a/arch/loongarch/include/asm/smp.h
> >> +++ b/arch/loongarch/include/asm/smp.h
> >> @@ -18,6 +18,7 @@ struct smp_ops {
> >>          void (*init_ipi)(void);
> >>          void (*send_ipi_single)(int cpu, unsigned int action);
> >>          void (*send_ipi_mask)(const struct cpumask *mask, unsigned in=
t action);
> >> +       bool (*vcpu_is_preempted)(int cpu);
> >>   };
> >>   extern struct smp_ops mp_ops;
> >>
> >> diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/in=
clude/asm/spinlock.h
> >> index 7cb3476999be..c001cef893aa 100644
> >> --- a/arch/loongarch/include/asm/spinlock.h
> >> +++ b/arch/loongarch/include/asm/spinlock.h
> >> @@ -5,6 +5,11 @@
> >>   #ifndef _ASM_SPINLOCK_H
> >>   #define _ASM_SPINLOCK_H
> >>
> >> +#ifdef CONFIG_PARAVIRT
> >> +#define vcpu_is_preempted      vcpu_is_preempted
> >> +bool vcpu_is_preempted(int cpu);
> >> +#endif
> > Maybe paravirt.h is a better place?
> how about put it in asm/qspinlock.h since it is included by header file
> asm/spinlock.h already?
qspinlock.h is better than spinlock.h

Huacai

>
> >
> >> +
> >>   #include <asm/processor.h>
> >>   #include <asm/qspinlock.h>
> >>   #include <asm/qrwlock.h>
> >> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/=
paravirt.c
> >> index b1b51f920b23..b99404b6b13f 100644
> >> --- a/arch/loongarch/kernel/paravirt.c
> >> +++ b/arch/loongarch/kernel/paravirt.c
> >> @@ -52,6 +52,13 @@ static u64 paravt_steal_clock(int cpu)
> >>   #ifdef CONFIG_SMP
> >>   static struct smp_ops native_ops;
> >>
> >> +static bool pv_vcpu_is_preempted(int cpu)
> >> +{
> >> +       struct kvm_steal_time *src =3D &per_cpu(steal_time, cpu);
> >> +
> >> +       return !!(src->preempted & KVM_VCPU_PREEMPTED);
> >> +}
> >> +
> >>   static void pv_send_ipi_single(int cpu, unsigned int action)
> >>   {
> >>          int min, old;
> >> @@ -308,6 +315,9 @@ int __init pv_time_init(void)
> >>                  pr_err("Failed to install cpu hotplug callbacks\n");
> >>                  return r;
> >>          }
> >> +
> >> +       if (kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT))
> >> +               mp_ops.vcpu_is_preempted =3D pv_vcpu_is_preempted;
> >>   #endif
> >>
> >>          static_call_update(pv_steal_clock, paravt_steal_clock);
> >> @@ -332,3 +342,9 @@ int __init pv_spinlock_init(void)
> >>
> >>          return 0;
> >>   }
> >> +
> >> +bool notrace vcpu_is_preempted(int cpu)
> >> +{
> >> +       return mp_ops.vcpu_is_preempted(cpu);
> >> +}
> >
> > We can simplify the whole patch like this, then we don't need to touch
> > smp.c, and we can merge Patch-2/3.
> >
> > +bool notrace vcpu_is_preempted(int cpu)
> > +{
> > +  if (!kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT))
> > +     return false;
> > + else {
> > +     struct kvm_steal_time *src =3D &per_cpu(steal_time, cpu);
> > +     return !!(src->preempted & KVM_VCPU_PREEMPTED);
> > + }
> > +}
> > Huacai
> >
> >> +EXPORT_SYMBOL(vcpu_is_preempted);
> >> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> >> index 46036d98da75..f04192fedf8d 100644
> >> --- a/arch/loongarch/kernel/smp.c
> >> +++ b/arch/loongarch/kernel/smp.c
> >> @@ -307,10 +307,16 @@ static void loongson_init_ipi(void)
> >>                  panic("IPI IRQ request failed\n");
> >>   }
> >>
> >> +static bool loongson_vcpu_is_preempted(int cpu)
> >> +{
> >> +       return false;
> >> +}
> >> +
> >>   struct smp_ops mp_ops =3D {
> >>          .init_ipi               =3D loongson_init_ipi,
> >>          .send_ipi_single        =3D loongson_send_ipi_single,
> >>          .send_ipi_mask          =3D loongson_send_ipi_mask,
> >> +       .vcpu_is_preempted      =3D loongson_vcpu_is_preempted,
> >>   };
> >>
> >>   static void __init fdt_smp_setup(void)
> >> --
> >> 2.39.3
> >>
> >>
>
>
