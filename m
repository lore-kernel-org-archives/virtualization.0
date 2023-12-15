Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C817994
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="oxXTglL/"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDD8782F77
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:18:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDD8782F77
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=oxXTglL/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VUWmcTyhtYM7
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:18:59 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 37E8B82F57
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:18:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37E8B82F57
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso396030a12.0
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702631938; x=1703236738; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogCR1hdsdWpS1HZE8WOgSCTe1uLlA6/5RFfX8dEYAdw=;
        b=oxXTglL/WHAYFL6EcfB2E/wXk9t2ugXdH6KkzZK6eGL7VjkJqcmLBG+Lx1p9sDmOHM
         51STONEILDPPeppm/e1HGAIXGES7kuiCw6bzEnvIi4nhflK+V9DKHXVG5w4ITDTEZFKX
         D9K6kMsNGt+LkXnHqbZ53kt9FtdfTK/3mAXiTtLSLTENjoWnR6pKMOcMY6rE1kw+xl4p
         3EV2jGdRZJK7uUiUNA/GBGTJQcxwkIgOIsJ8R4NiJd7Oc5gnmJrd9qLcGlFz76BNJpdo
         xy+vAxggN6V8j9nckEOJ7ttAO39vecXYtLwZ6yDIPkUlSOQKtHs+dpWE3ZyGxIJJBpVx
         QtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631938; x=1703236738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogCR1hdsdWpS1HZE8WOgSCTe1uLlA6/5RFfX8dEYAdw=;
        b=fqMVQkJ9XGn51e1AQ6flz0Euzs5lhXv5N761yMQ1c9hOd7LF0u00VMdZbXBRQCXhau
         FtGvJ0t6KMrHW/mbQHZQeHwDeqPEIQnSAanbe2D2h3Af3OYq00KZGumFi6v2fJAB+x8k
         hRXvmeRmYbhX1MqGcAsEz17JOAr0cC9YOP39SHl2ha2NxfNLaFH/5mSo90XIKdBS7F/z
         ry/TcvQqWbKGKFFrsPcObljtl4Yzt64nEXkWUE2rzkDuw02yCAvyWRIeDhhrk9/qRiBL
         pSwYye71HmyF++Hc31/DQYHwzOECLNN1mtxqDaVBLVFAAx88fGRGe9FuEcozOFxURyuB
         7EiQ==
X-Gm-Message-State: AOJu0Ywq1r1Hp228s0iNT6cNWeMmcHwgIgElU5GEHAmelDUgAhDwed0q
	5d0rpi2gRal1zfaW7sX4yQ0g9fSDkIO22MNOgCZuzw==
X-Google-Smtp-Source: AGHT+IEHecuvvH5gisdbjy3dPL+3H8VHk5BQAOo3GiAQRSkKpe6jgUyrKDtpN/xDOgincMfaXjWTYnD9YGwNqf7qpig=
X-Received: by 2002:a05:6a20:9149:b0:18b:92b3:7c80 with SMTP id
 x9-20020a056a20914900b0018b92b37c80mr14686916pzc.22.1702631938474; Fri, 15
 Dec 2023 01:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-24-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-24-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:48:46 +0530
Message-ID: <CAAhSdy2P0ORPzVQCigFFQY_4vgU+5TaPnpTi7zF0-MFKJOSR6A@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] RISC-V: KVM: Implement SBI STA extension
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
> Add a select SCHED_INFO to the KVM config in order to get run_delay
> info. Then implement SBI STA's set-steal-time-shmem function and
> kvm_riscv_vcpu_record_steal_time() to provide the steal-time info
> to guests.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/Kconfig        |  1 +
>  arch/riscv/kvm/vcpu_sbi_sta.c | 96 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index dfc237d7875b..148e52b516cf 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -32,6 +32,7 @@ config KVM
>         select KVM_XFER_TO_GUEST_WORK
>         select MMU_NOTIFIER
>         select PREEMPT_NOTIFIERS
> +       select SCHED_INFO
>         help
>           Support hosting virtualized guest machines.
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.=
c
> index 073bc47013b7..8b8dbee5500a 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -6,21 +6,113 @@
>  #include <linux/kconfig.h>
>  #include <linux/kernel.h>
>  #include <linux/kvm_host.h>
> +#include <linux/mm.h>
> +#include <linux/sizes.h>
>
> +#include <asm/bug.h>
> +#include <asm/current.h>
>  #include <asm/kvm_vcpu_sbi.h>
> +#include <asm/page.h>
>  #include <asm/sbi.h>
> +#include <asm/uaccess.h>
>
>  void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
>  {
>         gpa_t shmem =3D vcpu->arch.sta.shmem;
> +       u64 last_steal =3D vcpu->arch.sta.last_steal;
> +       u32 *sequence_ptr, sequence;
> +       u64 *steal_ptr, steal;
> +       unsigned long hva;
> +       gfn_t gfn;
>
>         if (shmem =3D=3D INVALID_GPA)
>                 return;
> +
> +       /*
> +        * shmem is 64-byte aligned (see the enforcement in
> +        * kvm_sbi_sta_steal_time_set_shmem()) and the size of sbi_sta_st=
ruct
> +        * is 64 bytes, so we know all its offsets are in the same page.
> +        */
> +       gfn =3D shmem >> PAGE_SHIFT;
> +       hva =3D kvm_vcpu_gfn_to_hva(vcpu, gfn);
> +
> +       if (WARN_ON(kvm_is_error_hva(hva))) {
> +               vcpu->arch.sta.shmem =3D INVALID_GPA;
> +               return;
> +       }
> +
> +       sequence_ptr =3D (u32 *)(hva + offset_in_page(shmem) +
> +                              offsetof(struct sbi_sta_struct, sequence))=
;
> +       steal_ptr =3D (u64 *)(hva + offset_in_page(shmem) +
> +                           offsetof(struct sbi_sta_struct, steal));
> +
> +       if (WARN_ON(get_user(sequence, sequence_ptr)))
> +               return;
> +
> +       sequence =3D le32_to_cpu(sequence);
> +       sequence +=3D 1;
> +
> +       if (WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr)))
> +               return;
> +
> +       if (!WARN_ON(get_user(steal, steal_ptr))) {
> +               steal =3D le64_to_cpu(steal);
> +               vcpu->arch.sta.last_steal =3D READ_ONCE(current->sched_in=
fo.run_delay);
> +               steal +=3D vcpu->arch.sta.last_steal - last_steal;
> +               WARN_ON(put_user(cpu_to_le64(steal), steal_ptr));
> +       }
> +
> +       sequence +=3D 1;
> +       WARN_ON(put_user(cpu_to_le32(sequence), sequence_ptr));
> +
> +       kvm_vcpu_mark_page_dirty(vcpu, gfn);
>  }
>
>  static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
>  {
> -       return SBI_ERR_FAILURE;
> +       struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
> +       unsigned long shmem_phys_lo =3D cp->a0;
> +       unsigned long shmem_phys_hi =3D cp->a1;
> +       u32 flags =3D cp->a2;
> +       struct sbi_sta_struct zero_sta =3D {0};
> +       unsigned long hva;
> +       bool writable;
> +       gpa_t shmem;
> +       int ret;
> +
> +       if (flags !=3D 0)
> +               return SBI_ERR_INVALID_PARAM;
> +
> +       if (shmem_phys_lo =3D=3D SBI_STA_SHMEM_DISABLE &&
> +           shmem_phys_hi =3D=3D SBI_STA_SHMEM_DISABLE) {
> +               vcpu->arch.sta.shmem =3D INVALID_GPA;
> +               return 0;
> +       }
> +
> +       if (shmem_phys_lo & (SZ_64 - 1))
> +               return SBI_ERR_INVALID_PARAM;
> +
> +       shmem =3D shmem_phys_lo;
> +
> +       if (shmem_phys_hi !=3D 0) {
> +               if (IS_ENABLED(CONFIG_32BIT))
> +                       shmem |=3D ((gpa_t)shmem_phys_hi << 32);
> +               else
> +                       return SBI_ERR_INVALID_ADDRESS;
> +       }
> +
> +       hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writ=
able);
> +       if (kvm_is_error_hva(hva) || !writable)
> +               return SBI_ERR_INVALID_ADDRESS;
> +
> +       ret =3D kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zero_=
sta));
> +       if (ret)
> +               return SBI_ERR_FAILURE;
> +
> +       vcpu->arch.sta.shmem =3D shmem;
> +       vcpu->arch.sta.last_steal =3D current->sched_info.run_delay;
> +
> +       return 0;
>  }
>
>  static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run=
 *run,
> @@ -46,7 +138,7 @@ static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>
>  static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
>  {
> -       return 0;
> +       return !!sched_info_on();
>  }
>
>  const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta =3D {
> --
> 2.43.0
>
