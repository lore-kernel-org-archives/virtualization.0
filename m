Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A104168D4
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ovHky2Mn"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F30DF4173F
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:07:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F30DF4173F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ovHky2Mn
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3PFWaKmBVe2E
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:07:45 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D18141713
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:07:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D18141713
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5ca0b968d8dso141328a12.1
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702631264; x=1703236064; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeNy5WoYNimz0qlJYnYNhVgKjfHasDk0kNBc3x9neVY=;
        b=ovHky2MnIbfxvSFiiyKKA4p1JtFJEjtj176w6IaYPR+pDpwQbkZCuHRunoJU28VtsC
         ojDKBljf/kRncoCmk6wCMlXDpX30QMvKwstDHt0PBRBkhtgAyTKFZ/QaiguxUVAlAe/K
         As96ZKOyCJ/9wiIFI1ZiSJz+UmaTAKwKGsQX7lBK1EIBZlFnUXBVxslJBfVWE8vvQJ4m
         VpQb8GqxdaNPxuPBvcacv4YH8TcwvB4bnOdllMINdKzZUCRotBCpJJ38PZQ758OI9F/S
         FuJreVveJnMDjIhdWMUSUBgvwHG1VryYnxs7qUT7Bws95kWGju7I3VsMLY+c060aUpj1
         aj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631264; x=1703236064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeNy5WoYNimz0qlJYnYNhVgKjfHasDk0kNBc3x9neVY=;
        b=JXgVPep+UdugblNbMtMBLMkkhoouCnXa1iSM58dvIx72oJD8MWbUTXi75rIlE4uNqF
         W7Ap0jSOrpcDA+okUDazu8Te/RTQj+nEIXm/TsCwijGx3zgMzDYjBByMkj3PjKL7yKB9
         5hAkXkW4/b/c/UqzWD0FBRetziOgWvn+N2bO9oYXoxWeJGdgVdfp1DJzN4YT3U/bzjq/
         f9QPLTEzsvLWqrDSdUS67FeNXcKKoQqQqu5BrdGkLVRQeVlaAQlYtncTXVaOlZOnLzec
         teBsdYb3e44aFK238kqI/MANJaDyaMhAjd+OdQ2KWdjjJmMoUpodWMd+drQjpDz5Bc8Y
         jrqQ==
X-Gm-Message-State: AOJu0YxyrFYwKeml42F+CnTWnJRcZFaXtoua7RErXjcBa/YsBwg0mhZf
	u8X58dBcSUceH15iqjAflZyu+6nklcGzPM4Vz9j6qw==
X-Google-Smtp-Source: AGHT+IHVKBYLQc96eIs84OQQuU8ObCe40O4pE2+IdlKa0U42LtO6XbDGby2kqSphbcTpeEo8AEAGzB//CC3g+x1X8iM=
X-Received: by 2002:a17:90a:c257:b0:28a:eac8:a4b2 with SMTP id
 d23-20020a17090ac25700b0028aeac8a4b2mr1691973pjx.60.1702631264120; Fri, 15
 Dec 2023 01:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-21-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-21-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:37:32 +0530
Message-ID: <CAAhSdy2tWPqoq=tZXtfkvsksAf4PPXeR3DOoKMvcfw-2YaDSvQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] RISC-V: KVM: Add SBI STA info to vcpu_arch
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
> KVM's implementation of SBI STA needs to track the address of each
> VCPU's steal-time shared memory region as well as the amount of
> stolen time. Add a structure to vcpu_arch to contain this state
> and make sure that the address is always set to INVALID_GPA on
> vcpu reset. And, of course, ensure KVM won't try to update steal-
> time when the shared memory address is invalid.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h | 6 ++++++
>  arch/riscv/kvm/vcpu.c             | 2 ++
>  arch/riscv/kvm/vcpu_sbi_sta.c     | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 230b82c3118d..b10026fb6412 100644
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
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 6995b8b641e4..fec4f5fd0fa7 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -83,6 +83,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>         vcpu->arch.hfence_tail =3D 0;
>         memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue=
));
>
> +       vcpu->arch.sta.shmem =3D INVALID_GPA;
> +

I think we should also set last_steal to zero as well.

Also, let's add kvm_riscv_vcpu_sbi_sta_reset() in vcpu_sbi_sta.c
to reset VCPU STA state.

>         /* Reset the guest CSRs for hotplug usecase */
>         if (loaded)
>                 kvm_arch_vcpu_load(vcpu, smp_processor_id());
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index e28351c9488b..157c199be0b4 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -10,6 +10,10 @@
>
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

Apart from the above, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
