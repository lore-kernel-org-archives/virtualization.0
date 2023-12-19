Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482E3DB80
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="akoJxb0g"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92D4D401A4
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 23:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92D4D401A4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=akoJxb0g
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jg8N6vmLBMet
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 23:40:49 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E80ED40004
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 23:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E80ED40004
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2cc3facf0c0so2162371fa.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1703029247; x=1703634047; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCi2t1W6pKq3yvd5hq6jD1cRXXQEKYYgdb3VO0qkSBg=;
        b=akoJxb0gtgioljPKS46ZlaTbLQE/i2MnJDAMlY1EPHZB2K4MUAVsnmdqWYseLoFLVX
         FnAAGIW4oi/DBQuQ+eSGkaEFupsbUJrmGgGOti/NQXP6wwn6RaSW8Odf/WPVTF5JAWfJ
         Wuo0qZun75/bj7dueIVy8i+P2aUJNq770FwV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703029247; x=1703634047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCi2t1W6pKq3yvd5hq6jD1cRXXQEKYYgdb3VO0qkSBg=;
        b=C0+YGE3VRujQM1uXQ3/9t8v+60SGZT3VnevJRGRzxgLpW0HUQGKJMHwh/GmBv0xQhA
         qiYSr9yZWAsCSYWz5bs1ZZBhP5GtjFSA0x6etU3mFcAfIAt6KFtDTpOI864klZUeDAV7
         g0gZ8v+y2iwEK9fw/JtXxP3ilgTcvWyeLhWAtG2M78acgzlzZd44ZE2FObl/Irjngq1P
         fNfHebGY1pAdfDB/gZC7C5JJ3w/9ZNntBr8ZZEZCGPbITB2JWJoJWSiicCFqMdMYlQoa
         j6Au3nkCZBzu7bygGx3+msYz2IPPbMdWpfqsxjDQvGUPiEdaR9duz4QsIWUDkhjzjG9s
         kE9g==
X-Gm-Message-State: AOJu0YydlgTDL28YOwiyKdvmOxpMdJdqZEIz5CAmKubI6NgBBFTj0Tet
	wBhtNnBLVSYM8S6HZtWe2nu2UPohdN97tRB5tZwx
X-Google-Smtp-Source: AGHT+IGcgFMWmhRM+UvuHN6NK7hZQIoCiJxodaYktQklOrqE0UjCAwtQM1aBD0C5P5/mP5Gg1LUzIKLDa39sNEkmN5g=
X-Received: by 2002:a05:651c:103a:b0:2cc:72fc:c906 with SMTP id
 w26-20020a05651c103a00b002cc72fcc906mr1102587ljm.1.1703029246653; Tue, 19 Dec
 2023 15:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-28-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-28-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 19 Dec 2023 15:40:35 -0800
Message-ID: <CAOnJCU+CUqafAF8nPQCh+awOhp+nEOYdwbkpuath0BFZyROuug@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] RISC-V: KVM: selftests: Add get-reg-list test
 for STA registers
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 12:41=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> Add SBI STA and its two registers to the get-reg-list test.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index b8da2e86bf9c..55dd1fc3c536 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -71,6 +71,7 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV=
_SBI_EXT_HSM:
>         case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV=
_SBI_EXT_PMU:
>         case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV=
_SBI_EXT_DBCN:
> +       case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV=
_SBI_EXT_STA:
>         case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV=
_SBI_EXT_EXPERIMENTAL:
>         case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV=
_SBI_EXT_VENDOR:
>                 return true;
> @@ -461,6 +462,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg=
_off)
>                 KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SRST),
>                 KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_HSM),
>                 KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_PMU),
> +               KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
>                 KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
>                 KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
>                 KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_DBCN),
> @@ -509,6 +511,32 @@ static const char *sbi_ext_id_to_str(const char *pre=
fix, __u64 id)
>         return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, re=
g_off);
>  }
>
> +static const char *sbi_sta_id_to_str(__u64 reg_off)
> +{
> +       switch (reg_off) {
> +       case 0: return "KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG=
(shmem_lo)";
> +       case 1: return "KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG=
(shmem_hi)";
> +       }
> +       return strdup_printf("KVM_REG_RISCV_SBI_STA | %lld /* UNKNOWN */"=
, reg_off);
> +}
> +
> +static const char *sbi_id_to_str(const char *prefix, __u64 id)
> +{
> +       __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_SBI);
> +       __u64 reg_subtype =3D reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +       assert((id & KVM_REG_RISCV_TYPE_MASK) =3D=3D KVM_REG_RISCV_SBI);
> +
> +       reg_off &=3D ~KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +       switch (reg_subtype) {
> +       case KVM_REG_RISCV_SBI_STA:
> +               return sbi_sta_id_to_str(reg_off);
> +       }
> +
> +       return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, re=
g_off);
> +}
> +
>  void print_reg(const char *prefix, __u64 id)
>  {
>         const char *reg_size =3D NULL;
> @@ -565,6 +593,10 @@ void print_reg(const char *prefix, __u64 id)
>                 printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT | %s=
,\n",
>                                 reg_size, sbi_ext_id_to_str(prefix, id));
>                 break;
> +       case KVM_REG_RISCV_SBI:
> +               printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI | %s,\n"=
,
> +                               reg_size, sbi_id_to_str(prefix, id));
> +               break;
>         default:
>                 printf("\tKVM_REG_RISCV | %s | 0x%llx /* UNKNOWN */,\n",
>                                 reg_size, id & ~REG_MASK);
> @@ -651,6 +683,12 @@ static __u64 sbi_base_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR,
>  };
>
> +static __u64 sbi_sta_regs[] =3D {
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA,
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI | KVM_REG_=
RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_lo),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI | KVM_REG_=
RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi),
> +};
> +
>  static __u64 zicbom_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_R=
EG_RISCV_CONFIG_REG(zicbom_block_size),
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
> @@ -757,6 +795,9 @@ static __u64 fp_d_regs[] =3D {
>  #define SUBLIST_SBI_BASE \
>         {"sbi-base", .feature_type =3D VCPU_FEATURE_SBI_EXT, .feature =3D=
 KVM_RISCV_SBI_EXT_V01, \
>          .regs =3D sbi_base_regs, .regs_n =3D ARRAY_SIZE(sbi_base_regs),}
> +#define SUBLIST_SBI_STA \
> +       {"sbi-sta", .feature_type =3D VCPU_FEATURE_SBI_EXT, .feature =3D =
KVM_RISCV_SBI_EXT_STA, \
> +        .regs =3D sbi_sta_regs, .regs_n =3D ARRAY_SIZE(sbi_sta_regs),}
>  #define SUBLIST_ZICBOM \
>         {"zicbom", .feature =3D KVM_RISCV_ISA_EXT_ZICBOM, .regs =3D zicbo=
m_regs, .regs_n =3D ARRAY_SIZE(zicbom_regs),}
>  #define SUBLIST_ZICBOZ \
> @@ -832,6 +873,7 @@ static struct vcpu_reg_list config_sbi_##ext =3D {   =
         \
>  /* Note: The below list is alphabetically sorted. */
>
>  KVM_SBI_EXT_SUBLIST_CONFIG(base, BASE);
> +KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
>  KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
>  KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
>
> @@ -858,6 +900,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zihpm, ZIHPM);
>
>  struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_sbi_base,
> +       &config_sbi_sta,
>         &config_sbi_pmu,
>         &config_sbi_dbcn,
>         &config_aia,
> --
> 2.43.0
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
