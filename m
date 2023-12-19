Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D774409
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="ADc5iUI1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5A8781973
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5A8781973
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=ADc5iUI1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GU0yRZ1OcEaZ
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 01:46:21 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A64C818D4
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 01:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A64C818D4
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50e3c6f1c10so2070036e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 17:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702950379; x=1703555179; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUM/d5YEXMN7h3iJw/LF6wzvQMD8RKrNFiOD59rIiqs=;
        b=ADc5iUI1nLa5MCU9WLgNTvD3hOlDMFVrlwJ/Z4tD1essVKcfafGU4hqXE2ZjYksyU9
         HPQczp8b8PSwaIzDjOUxJECV40c3I+VXFWVLb4CB2YrGMAII7WC5X6dvimLgIbI6l6db
         g1vaRzV+BbCs86IKtAeNi+Wvillfhda8hx/HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702950379; x=1703555179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUM/d5YEXMN7h3iJw/LF6wzvQMD8RKrNFiOD59rIiqs=;
        b=YiQyHfsz7mKHitLImJyFItlxbS79wLQfl8LVc/0Cfevo23YakiZuerR9lAKHRa3OPu
         Te22TxYgVrILY5bUubwVVyBelQd/iqDL9pBVWS+z0SxkfKJ4xP6SqQzo/n/M/BaF937h
         UaPhM7+eq2619/G+wCZ00Ti19VOgSkoVDKW4Wg3HVqAPv5JLO3OwYiXp8YQ/JU0A+JRN
         x6fROMlH9WPninzi/sXO00Npg2MQSjPt6DGWU/6aErLd3FxKxPhXVF6DJZFUHRDEqRfg
         nMoYK9VDLyqoqyTFcuFkao+qeuLqYfmQOYcuCkZqSoI0JzBuGDruHA2+7hK2LRkYEWGS
         Zm2Q==
X-Gm-Message-State: AOJu0YwvVEEDnfJoFiwZK0crue988d4pu8Z37w7eN47EsuC/9hokgzvU
	3ff1ZxWiXyKHe36KmHS8/dJoSUu4NwePD3tFa4Ti
X-Google-Smtp-Source: AGHT+IG9OPczqbtbKBh9wdJXjP5g18U9WG0KvN+wDryDNyFx2mZvZFlGjalfwzenwSYw63RdwqBcYVcYoxGLYIClXrU=
X-Received: by 2002:a05:6512:3f09:b0:50b:f2ea:5454 with SMTP id
 y9-20020a0565123f0900b0050bf2ea5454mr5395285lfa.118.1702950379327; Mon, 18
 Dec 2023 17:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-20-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-20-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 18 Dec 2023 17:46:08 -0800
Message-ID: <CAOnJCUL5a_Kb1=9esM1qxXpSg2n03mWAahm3z1T3tCe1RdDtqA@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] RISC-V: KVM: Add steal-update vcpu request
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
> Add a new vcpu request to inform a vcpu that it should record its
> steal-time information. The request is made each time it has been
> detected that the vcpu task was not assigned a cpu for some time,
> which is easy to do by making the request from vcpu-load. The record
> function is just a stub for now and will be filled in with the rest
> of the steal-time support functions in following patches.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h | 3 +++
>  arch/riscv/kvm/vcpu.c             | 5 +++++
>  arch/riscv/kvm/vcpu_sbi_sta.c     | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 0eefd9c991ae..230b82c3118d 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -41,6 +41,7 @@
>         KVM_ARCH_REQ_FLAGS(4, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_HFENCE                 \
>         KVM_ARCH_REQ_FLAGS(5, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> +#define KVM_REQ_STEAL_UPDATE           KVM_ARCH_REQ(6)
>
>  enum kvm_riscv_hfence_type {
>         KVM_RISCV_HFENCE_UNKNOWN =3D 0,
> @@ -372,4 +373,6 @@ bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *v=
cpu, u64 mask);
>  void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
>
> +void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
> +
>  #endif /* __RISCV_KVM_HOST_H__ */
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index bf3952d1a621..6995b8b641e4 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -541,6 +541,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cp=
u)
>
>         kvm_riscv_vcpu_aia_load(vcpu, cpu);
>
> +       kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
> +
>         vcpu->cpu =3D cpu;
>  }
>
> @@ -614,6 +616,9 @@ static void kvm_riscv_check_vcpu_requests(struct kvm_=
vcpu *vcpu)
>
>                 if (kvm_check_request(KVM_REQ_HFENCE, vcpu))
>                         kvm_riscv_hfence_process(vcpu);
> +
> +               if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
> +                       kvm_riscv_vcpu_record_steal_time(vcpu);
>         }
>  }
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index 839911dcd837..e28351c9488b 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -8,6 +8,10 @@
>  #include <asm/kvm_vcpu_sbi.h>
>  #include <asm/sbi.h>
>
> +void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
> +{
> +}
> +
>  static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
>  {
>         return SBI_ERR_FAILURE;
> --
> 2.43.0
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
