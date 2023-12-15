Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC817986
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2F+gN92r"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91AFF830A8
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:27:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91AFF830A8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2F+gN92r
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.89
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wbm8vdymaXhq
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:27:27 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF4A38309A
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:27:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF4A38309A
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso373014b3a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702632446; x=1703237246; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udsPV/VQaJ4AO8i8EMXOtjozTv+5BniWSBVr366jyD0=;
        b=2F+gN92rHNXXRCTZ5d06zTLQidDtDojAq+xMetpqGazCrHNChvrYdWbPcHCnfPnG9w
         qULVACvUjxbFzrRM4A/73PTAj2+YawQPbHdiS6kJajMqxMipT+D1VeURLdkPt8khcTK2
         XkKWSa+TI1VHx06Q45VnLO7HNn/yMdxRrgcfxSyREPiODDft8D/atySMTIO/b6OWvbHR
         v578iuR0ft1yD1WIzVkUqWD5juSEhm6iWLhvXZpr1y3zOpGfOWrDYHh8Iev40mo/IkNu
         15AHZHh1UED3bdm1sgBsjladMfJNT45O0AoL6yD7fQUsBV/GBjoBITUPUcN6P53y044V
         UVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632446; x=1703237246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udsPV/VQaJ4AO8i8EMXOtjozTv+5BniWSBVr366jyD0=;
        b=g8OltBlEMGHvud872xPI2he2gsbSaEcnrXXVh3NMK8Ypcqhisp3fhdjutR+AUMOTIt
         jznWPTDskblq3WWSAniNT+xGyV/SMtfoPuSO56s5bbbYqswkhSYdvK2i/AynDY8zVWQr
         FLRKVsF6eiaOxcuyk0KUZj1WpnmVtElNeeNEf0bizZXTFVL0KWGCxXmiI/nK/qHhRWWL
         bCTwq/xBwhTPg+/rvdlDvgvJamC+CGNHCr2a83xdfNOlXF0n6xzLc7fTf0BINi34lbCj
         N7inMazAIZvoE196SULQDXsf+TWXMnTGwGnxAq/B4D3MC6zArST9nd3HdfvHCyFubIB4
         DWZQ==
X-Gm-Message-State: AOJu0YyACN3DM0qpDY3nF/kIaVzUwRdOBIMAQGoInr7ZSjPlT4Kby9uN
	W/16pa44W47jt9QmiiQhTWptBvTFg/egfWvDp0d2Nw==
X-Google-Smtp-Source: AGHT+IG+darEbBfGmFu/ezPSaQBc4sEoCDK8zjt6Rg+83U9sTkOWkfUswf3ppwTTKCE/eJFluBbYK3r0BJ4QkRN0lBk=
X-Received: by 2002:a05:6a20:8f09:b0:190:97a3:8d64 with SMTP id
 b9-20020a056a208f0900b0019097a38d64mr15046804pzk.17.1702632446111; Fri, 15
 Dec 2023 01:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-28-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-28-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:57:13 +0530
Message-ID: <CAAhSdy1Qr8vjaHVBLypBByN-Yt4MJhPBWs=zYoX8xWJDzEM3cQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] RISC-V: KVM: selftests: Add get-reg-list test
 for STA registers
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
> Add SBI STA and its two registers to the get-reg-list test.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
