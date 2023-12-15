Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206979E5
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ooBHpdtd"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B90F60F78
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 06:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B90F60F78
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ooBHpdtd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLdBLfDLH705
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 06:11:30 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0DC8360EFC
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 06:11:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DC8360EFC
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5916c6b2e0fso294239eaf.3
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 22:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702620689; x=1703225489; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4CuwslJCLZdFAvkNN2l2KjFdYLuERyqcydxPniI+xQ=;
        b=ooBHpdtdLW8gPI6cf6np3IBwk3BHE9BsbsKjdNx08ptKhEIDoOqH0G6WnXyuWCov6b
         vhF4b1ssQ7XxSKIS3N3rwMWkhB2AXPCt5LIE/ECV4F9+KdVd/5bPuSJFlaptdM0T+j2G
         N2XphbiUntUMuPCGH/xpinADNOxcETC6jCxz+o3W/phzFFF/QN4V+DW6qxR6RjRq9SWI
         84IrUM8jePaVT1+ktjcdrSGZnNmpd9Ie0q1dkveh6a2N8pmhxzQa7JmIDVv2m7IGFVoh
         92bXFZUElgUlDOgS4Qp8NHxfXANosT6uvjKhRU/32IIToeNL/K7AvOX6uVjP/bNNKoS6
         7EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702620689; x=1703225489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4CuwslJCLZdFAvkNN2l2KjFdYLuERyqcydxPniI+xQ=;
        b=s/QgYQLTgyDUKWBd5Q76qaeMjVLO9h62mDfmO7s8dhMyAU3scSri1z5GxbPbXWpP7+
         yZz9gCTIWk5sA5Uw6e5MX8svrh5ZE4d+mZVZMWRoYuj1VqGW1TUh8VAedkCrxwQ/VXrI
         UvyMx4cLD6rBiDoIWVz1IdUdJtylpaJ14WMq9nN0hutSuxomfoMt3IGqpk4lBZ65LkvA
         K/2hYH+YOJ/UVuYoQ4h2ebU1Prm/fOwn8ZeTmo5TQ/BR/ju8GOfEjnSSBKNsnKv9jSDV
         DKIG+Vev0GymVFUsStmF4tMD1kZeWXhF+zaUa4ooiWlUVXxYh11aWXJKjzicyuJJJSjg
         YLYg==
X-Gm-Message-State: AOJu0Yx/dFuIDlu9w1MHGkdM563yujy8X8aJ1ZsuHOtWQAEvaaJTWUUE
	/gslXGaThhT0bh8rGsD+14gcBXKIf+iqTTeeZFNutQ==
X-Google-Smtp-Source: AGHT+IGeNpSlR68lmDkvGx8mLKM0Vwb+RiJh/2h+wPwgctdIm3RPWxskr9cb3Bmda3SSGjTEZ21zTzYuwPeGh3WWFfw=
X-Received: by 2002:a05:6358:ca9:b0:170:309e:fbac with SMTP id
 o41-20020a0563580ca900b00170309efbacmr7378009rwj.55.1702620688704; Thu, 14
 Dec 2023 22:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-19-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-19-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 11:41:16 +0530
Message-ID: <CAAhSdy2DOyDP_dE3MUN=+9UhkzdMHaOHUbCJYgF9ZtWWpodWcg@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] RISC-V: KVM: Add SBI STA extension skeleton
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
> Add the files and functions needed to support the SBI STA
> (steal-time accounting) extension. In the next patches we'll
> complete the functions to fully enable SBI STA support.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  1 +
>  arch/riscv/include/uapi/asm/kvm.h     |  1 +
>  arch/riscv/kvm/Makefile               |  1 +
>  arch/riscv/kvm/vcpu_sbi.c             |  4 +++
>  arch/riscv/kvm/vcpu_sbi_sta.c         | 47 +++++++++++++++++++++++++++
>  5 files changed, 54 insertions(+)
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index bffda0ac59b6..99c23bb37a37 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -76,6 +76,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext=
_rfence;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 60d3b21dead7..e961d79622fb 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -157,6 +157,7 @@ enum KVM_RISCV_SBI_EXT_ID {
>         KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>         KVM_RISCV_SBI_EXT_VENDOR,
>         KVM_RISCV_SBI_EXT_DBCN,
> +       KVM_RISCV_SBI_EXT_STA,
>         KVM_RISCV_SBI_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 4c2067fc59fc..c9646521f113 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -26,6 +26,7 @@ kvm-$(CONFIG_RISCV_SBI_V01) +=3D vcpu_sbi_v01.o
>  kvm-y +=3D vcpu_sbi_base.o
>  kvm-y +=3D vcpu_sbi_replace.o
>  kvm-y +=3D vcpu_sbi_hsm.o
> +kvm-y +=3D vcpu_sbi_sta.o
>  kvm-y +=3D vcpu_timer.o
>  kvm-$(CONFIG_RISCV_PMU_SBI) +=3D vcpu_pmu.o vcpu_sbi_pmu.o
>  kvm-y +=3D aia.o
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index dcdff4458190..088daaa23dd8 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -70,6 +70,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_=
ext[] =3D {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_DBCN,
>                 .ext_ptr =3D &vcpu_sbi_ext_dbcn,
>         },
> +       {
> +               .ext_idx =3D KVM_RISCV_SBI_EXT_STA,
> +               .ext_ptr =3D &vcpu_sbi_ext_sta,
> +       },
>         {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>                 .ext_ptr =3D &vcpu_sbi_ext_experimental,
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> new file mode 100644
> index 000000000000..839911dcd837
> --- /dev/null
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/kvm_vcpu_sbi.h>
> +#include <asm/sbi.h>
> +
> +static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
> +{
> +       return SBI_ERR_FAILURE;
> +}
> +
> +static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run=
 *run,
> +                                  struct kvm_vcpu_sbi_return *retdata)
> +{
> +       struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
> +       unsigned long funcid =3D cp->a6;
> +       int ret;
> +
> +       switch (funcid) {
> +       case SBI_EXT_STA_STEAL_TIME_SET_SHMEM:
> +               ret =3D kvm_sbi_sta_steal_time_set_shmem(vcpu);
> +               break;
> +       default:
> +               ret =3D SBI_ERR_NOT_SUPPORTED;
> +               break;
> +       }
> +
> +       retdata->err_val =3D ret;
> +
> +       return 0;
> +}
> +
> +static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
> +{
> +       return 0;
> +}
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta =3D {
> +       .extid_start =3D SBI_EXT_STA,
> +       .extid_end =3D SBI_EXT_STA,
> +       .handler =3D kvm_sbi_ext_sta_handler,
> +       .probe =3D kvm_sbi_ext_sta_probe,
> +};
> --
> 2.43.0
>
