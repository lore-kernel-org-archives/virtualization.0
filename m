Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2823F413
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470124; cv=none; b=HErA9IAiTn4GvwwUYbMuj9mmQS+zqi1XQ0nu30dxKU4xS2VXNUtQkX+hZ/FRDkI8XC2nFYxlioupOWg1KQaeCZ3/nlI9agqdBW2Jk3LIXAoWP3xmHZjC9lBHChwbFdPdDMgvcVLBjB/FrxbrOjrU8CW4dh+Hwfb86EYuxNnvuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470124; c=relaxed/simple;
	bh=pFdS3qA9WYaaq00VcckqdlanD8dVirrH/4YapO6gIKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD4Ty1Cjg8eek7lOB1WzVmoCRp0ws4n/T/BWMBIEWhmAtvmYUGxXbtRyjwoGKUB51TsRbjiJrQxmCR3g60pqGrW1Fgf3cMxHW9UkmKV5AxdMdnQgETDjQ9fo9YYGpre0aDa8fY+nlmTI7Ps8ZeT7hHhRLtlU5TSiwZ9QAp/GN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMqQa2aT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMqQa2aT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A07C4AF12
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763470124;
	bh=pFdS3qA9WYaaq00VcckqdlanD8dVirrH/4YapO6gIKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fMqQa2aTQ6QF14qLJfJbMc6WGc1Ys3sI/GyLVlEzdBvuuuEsY6XzJHkHz4pjo84l4
	 dHD9bcQF3Bhdhw+Ypaj2EcRHzNp/pEssVAJLhWwQVuYhog6MwqhUcnjVFjotGydDr7
	 z7pqrkStgWHoq2a4p4v8uKLBbdwp4RXgAVrdlm5iUXqD2plGgZpZLWyXktJT1EL5qL
	 3BeJ/VzACeGzcyx3Xn4+qTNBzh3QVMRQjW7vb6Ww615PYDnxvjJtuzbl2k6eR9XzR8
	 1b5f7GexfHo3BK0Gnhn39sNsvrGkLyBWcrwdAxtA3+FE9BftcCZw69uabqKI17JNA/
	 pnp3HFw+oWWIg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7379641791so502068266b.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 04:48:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYjfadNZzmg5YgZGqt/hPlhXBcsujxDFZJjDGBBSEjSEdxH5UrI4kQhd+/cmRw1RaenQpLVdYNtoGaMBjaJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlZS5cmcDQcpRKPuts5JeABW49ghvF+owrNCj5jWN1lz+A9Y6E
	9yd7TuYH74CEkpsHS5rlesBXDObz39qdvTujXE5mh0jxAWZhRBLTnFOo1tkPsNdTzdSyJWNLECn
	DNw1XrEYpRi+o2gXygOhqfsNbl4gWxq0=
X-Google-Smtp-Source: AGHT+IEDrP2TdyUTahNPJRfPwcoYAoS5gMqEHUbAvm5d4Dycw7x0zFNGBRQFdUMDmaXX2ULGwzkJBFq6jE806ti0w0o=
X-Received: by 2002:a17:907:a44:b0:b73:544d:ba2e with SMTP id
 a640c23a62f3a-b736780d5bamr1948345866b.25.1763470120092; Tue, 18 Nov 2025
 04:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251118080656.2012805-1-maobibo@loongson.cn> <20251118080656.2012805-3-maobibo@loongson.cn>
In-Reply-To: <20251118080656.2012805-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 18 Nov 2025 20:48:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4hoS0Wo3TS+FdikXMkb7qjWNFSPDoajQr0bzdeROJwGw@mail.gmail.com>
X-Gm-Features: AWmQ_bkSeXCgy-qK2rzvP-hL92k0XNXRWWttKpPo-xMdgC-eo-zjb1mltVmpNY4
Message-ID: <CAAhV-H4hoS0Wo3TS+FdikXMkb7qjWNFSPDoajQr0bzdeROJwGw@mail.gmail.com>
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

Hi, Bibo,

On Tue, Nov 18, 2025 at 4:07=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Function vcpu_is_preempted() is used to check whether vCPU is preempted
> or not. Here add implementation with vcpu_is_preempted() when option
> CONFIG_PARAVIRT is enabled.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/smp.h      |  1 +
>  arch/loongarch/include/asm/spinlock.h |  5 +++++
>  arch/loongarch/kernel/paravirt.c      | 16 ++++++++++++++++
>  arch/loongarch/kernel/smp.c           |  6 ++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index 3a47f52959a8..5b37f7bf2060 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -18,6 +18,7 @@ struct smp_ops {
>         void (*init_ipi)(void);
>         void (*send_ipi_single)(int cpu, unsigned int action);
>         void (*send_ipi_mask)(const struct cpumask *mask, unsigned int ac=
tion);
> +       bool (*vcpu_is_preempted)(int cpu);
>  };
>  extern struct smp_ops mp_ops;
>
> diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/inclu=
de/asm/spinlock.h
> index 7cb3476999be..c001cef893aa 100644
> --- a/arch/loongarch/include/asm/spinlock.h
> +++ b/arch/loongarch/include/asm/spinlock.h
> @@ -5,6 +5,11 @@
>  #ifndef _ASM_SPINLOCK_H
>  #define _ASM_SPINLOCK_H
>
> +#ifdef CONFIG_PARAVIRT
> +#define vcpu_is_preempted      vcpu_is_preempted
> +bool vcpu_is_preempted(int cpu);
> +#endif
Maybe paravirt.h is a better place?

> +
>  #include <asm/processor.h>
>  #include <asm/qspinlock.h>
>  #include <asm/qrwlock.h>
> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/par=
avirt.c
> index b1b51f920b23..b99404b6b13f 100644
> --- a/arch/loongarch/kernel/paravirt.c
> +++ b/arch/loongarch/kernel/paravirt.c
> @@ -52,6 +52,13 @@ static u64 paravt_steal_clock(int cpu)
>  #ifdef CONFIG_SMP
>  static struct smp_ops native_ops;
>
> +static bool pv_vcpu_is_preempted(int cpu)
> +{
> +       struct kvm_steal_time *src =3D &per_cpu(steal_time, cpu);
> +
> +       return !!(src->preempted & KVM_VCPU_PREEMPTED);
> +}
> +
>  static void pv_send_ipi_single(int cpu, unsigned int action)
>  {
>         int min, old;
> @@ -308,6 +315,9 @@ int __init pv_time_init(void)
>                 pr_err("Failed to install cpu hotplug callbacks\n");
>                 return r;
>         }
> +
> +       if (kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT))
> +               mp_ops.vcpu_is_preempted =3D pv_vcpu_is_preempted;
>  #endif
>
>         static_call_update(pv_steal_clock, paravt_steal_clock);
> @@ -332,3 +342,9 @@ int __init pv_spinlock_init(void)
>
>         return 0;
>  }
> +
> +bool notrace vcpu_is_preempted(int cpu)
> +{
> +       return mp_ops.vcpu_is_preempted(cpu);
> +}

We can simplify the whole patch like this, then we don't need to touch
smp.c, and we can merge Patch-2/3.

+bool notrace vcpu_is_preempted(int cpu)
+{
+  if (!kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT))
+     return false;
+ else {
+     struct kvm_steal_time *src =3D &per_cpu(steal_time, cpu);
+     return !!(src->preempted & KVM_VCPU_PREEMPTED);
+ }
+}
Huacai

> +EXPORT_SYMBOL(vcpu_is_preempted);
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 46036d98da75..f04192fedf8d 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -307,10 +307,16 @@ static void loongson_init_ipi(void)
>                 panic("IPI IRQ request failed\n");
>  }
>
> +static bool loongson_vcpu_is_preempted(int cpu)
> +{
> +       return false;
> +}
> +
>  struct smp_ops mp_ops =3D {
>         .init_ipi               =3D loongson_init_ipi,
>         .send_ipi_single        =3D loongson_send_ipi_single,
>         .send_ipi_mask          =3D loongson_send_ipi_mask,
> +       .vcpu_is_preempted      =3D loongson_vcpu_is_preempted,
>  };
>
>  static void __init fdt_smp_setup(void)
> --
> 2.39.3
>
>
