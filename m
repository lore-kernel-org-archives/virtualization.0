Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660E6D22
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="aXrYJYQ6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46AD360F78
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 06:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46AD360F78
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=aXrYJYQ6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2Sa0JEm8rYp
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 06:16:39 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A1EC760EFC
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 06:16:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1EC760EFC
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso182115a12.1
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 22:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702620999; x=1703225799; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9EIXmi9RDoP7rccsl9U0oMb2l9OcBTii8Dhub5RMMk=;
        b=aXrYJYQ6cNxNXRJBIik0H4ogy6Y+qzXwNA4biLJY/Mty/9JjyV7ihJGuuCcPAyLPsw
         MYxUpvje8HNozMe0XQTMc6izodNeD3yFR5V6BsKZlOJ4yAxAPsPXmVoM5kGWNkSDn2PK
         wJDWoM7Z6S+B47/MLyzChrQS4yVRHOHOFgggXxwIEOam+Xc6byvMAix3bsSMtYczGxqW
         zO4T0PF7yKH6Haye2YWpL44AOGVaNEZXsG/LmL2lShNpOlL3sj2+zSLI1IwLdhcZLE8q
         famG+ReIpf0cCz5O86ckUw4CM7xJbE61T4b1ZycaNoBWKkPv5eSmfIUxfnW+VmX2UVwb
         F76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702620999; x=1703225799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9EIXmi9RDoP7rccsl9U0oMb2l9OcBTii8Dhub5RMMk=;
        b=A1LG0tlgjYdSKJNM5oinqHxQLQd/LjpzZH9oui0gb7Qe10cuJh4TC3spIY4X8QKawt
         nHw6G/2lejNwUTJtzREKXPasJBlhk2FB1+gn7Onu6t1yRd/d3O2B0ezNHpJbySktJ9LU
         KXV7ai1l2jU0zw7SJTz2mj4N6giDUPC9tJOuJAcng+0eW4uFLMOU1vDTIlJhf8R4bwXa
         o5dVwWP2PNr85mRrG1a70UqAWTYcGq007NSIlcOg/90eJyKdikR02NBGAxGXDCci6WlG
         SYsMGoZmfpiKkuaB29wFTIV2RgexrgyhGVu+rSLMg2GOWTj1S1O7O0jDsE1CEMdGoLOF
         cd+A==
X-Gm-Message-State: AOJu0Yx4e7JHcSMb6KSEkyLgDLRUPoEn/IYM8Nmf70z76rOl2f+R1ooQ
	ILPJ3oULTOH0+mZmj00XhCoj0tVHxfKQo7cRDRdrrA==
X-Google-Smtp-Source: AGHT+IFjhL7dlHllUS2KAD8BgI4rWoZajkqicwug9dHFSlvZnSWL6mrvQEvs4yUR2Rdz1L4VbeFgSoZsfiB9WJgF9Ws=
X-Received: by 2002:a17:90b:911:b0:28b:7d0:17fa with SMTP id
 bo17-20020a17090b091100b0028b07d017famr3050811pjb.31.1702620998930; Thu, 14
 Dec 2023 22:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-20-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-20-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 11:46:26 +0530
Message-ID: <CAAhSdy0UKQ6v9yVxnyAjPEkpEkOLpsKXqUKccQLpzmPVwcQP2Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] RISC-V: KVM: Add steal-update vcpu request
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
> Add a new vcpu request to inform a vcpu that it should record its
> steal-time information. The request is made each time it has been
> detected that the vcpu task was not assigned a cpu for some time,
> which is easy to do by making the request from vcpu-load. The record
> function is just a stub for now and will be filled in with the rest
> of the steal-time support functions in following patches.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
