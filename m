Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B317CB
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="tBL8bIgH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A526A400AF
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:49:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A526A400AF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=tBL8bIgH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HFJA3qhNUOAX
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 01:49:41 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 63EF44004A
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:49:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63EF44004A
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50e0d1f9fe6so4792429e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702950579; x=1703555379; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXupCfZjlayUGqvnZ/pHvI3Hd0Fi7PKTAe8bvJZrq+g=;
        b=tBL8bIgHIS4mCeVTebwigK5HM9X+jQYc+LaSLVY7ySjimch91yElpV9db7kkFEQAVL
         uFGd7F4GJfdS1J+AdWXpDeOmfzVrosc82T30nmSx9uLQfstD+xDrwPk9wlBWp69TKv6w
         78W1UErrfB2k+84F5DgVQld22GXtjN9dYfmvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702950579; x=1703555379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXupCfZjlayUGqvnZ/pHvI3Hd0Fi7PKTAe8bvJZrq+g=;
        b=Q+/MP+BxeKzKfnGA3UFwGPB7nSvcbrKqsS2OCsyaTepphDfOBJcNTfn3tlqSv6BlQU
         3xz4espvRk56ldWAKT3vPrW902Q3BEe0VaSZrl4FL0+drSpbPYOfAmmcbCGLBlgLNhEO
         kXj6xGGnbzCqJVAy1EzU7rmi1VH1ioFbkqWzuKtIu/qy6toO/SKmqZU+cW14WVV0redv
         /JRK8NVt9FkXop5NQRRiZm6hazcTMyvPVDwusuRZRINbVqV/w69u2mF++3fwJiHXfWSj
         eGQHeaQK6aLx6c0EcqnrfnEw3GZROJzoNJnExxND96NyN1QSykh0asmE7Vd6pX9QarI/
         rSGw==
X-Gm-Message-State: AOJu0Yys2WW3ykhbsqtuHi4KR3Q+wI9Tv4TKNieCWjkdNU4WUyM0lPkm
	nlnb6KwjgDGSHPPDR75b0np7e5j0AJyygo68Mw2Q
X-Google-Smtp-Source: AGHT+IFv/S++K/NorCWyXa4ngqbfiuzNecqNa+IousyaO9WQD3cwMU0REyzIMxqLFKI8EuOug0JRkdHZexu+dE5RMWw=
X-Received: by 2002:ac2:4e0f:0:b0:50e:1eae:a980 with SMTP id
 e15-20020ac24e0f000000b0050e1eaea980mr3172901lfr.118.1702950579045; Mon, 18
 Dec 2023 17:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-21-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-21-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 18 Dec 2023 17:49:27 -0800
Message-ID: <CAOnJCU+6MBadxbry5TeoWxYXDrCQRqSdqMNgQxFYzZXjM-=YRg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] RISC-V: KVM: Add SBI STA info to vcpu_arch
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
> KVM's implementation of SBI STA needs to track the address of each
> VCPU's steal-time shared memory region as well as the amount of
> stolen time. Add a structure to vcpu_arch to contain this state
> and make sure that the address is always set to INVALID_GPA on
> vcpu reset. And, of course, ensure KVM won't try to update steal-
> time when the shared memory address is invalid.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h |  7 +++++++
>  arch/riscv/kvm/vcpu.c             |  2 ++
>  arch/riscv/kvm/vcpu_sbi_sta.c     | 10 ++++++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 230b82c3118d..525cba63e0c5 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -263,6 +263,12 @@ struct kvm_vcpu_arch {
>
>         /* 'static' configurations which are set only once */
>         struct kvm_vcpu_config cfg;
> +
> +       /* SBI steal-time accounting */
> +       struct {
> +               gpa_t shmem;
> +               u64 last_steal;
> +       } sta;
>  };
>
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> @@ -373,6 +379,7 @@ bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *v=
cpu, u64 mask);
>  void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
>
> +void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
>
>  #endif /* __RISCV_KVM_HOST_H__ */
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 6995b8b641e4..b5ca9f2e98ac 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -83,6 +83,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>         vcpu->arch.hfence_tail =3D 0;
>         memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue=
));
>
> +       kvm_riscv_vcpu_sbi_sta_reset(vcpu);
> +
>         /* Reset the guest CSRs for hotplug usecase */
>         if (loaded)
>                 kvm_arch_vcpu_load(vcpu, smp_processor_id());
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index e28351c9488b..6592d287fc4e 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -8,8 +8,18 @@
>  #include <asm/kvm_vcpu_sbi.h>
>  #include <asm/sbi.h>
>
> +void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
> +{
> +       vcpu->arch.sta.shmem =3D INVALID_GPA;
> +       vcpu->arch.sta.last_steal =3D 0;
> +}
> +
>  void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
>  {
> +       gpa_t shmem =3D vcpu->arch.sta.shmem;
> +
> +       if (shmem =3D=3D INVALID_GPA)
> +               return;
>  }
>
>  static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
> --
> 2.43.0
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
