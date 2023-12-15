Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091316429
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="hxCZF/sX"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1434460BCB
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:22:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1434460BCB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=hxCZF/sX
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GR8xPkrALrD5
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:22:06 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E1B360B3D
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:22:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E1B360B3D
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so380261b3a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702632125; x=1703236925; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAbH1XjkuKAQeNjFuhosk36+OO0YVuHDGozy0cI8OmU=;
        b=hxCZF/sXWHDAFCHxQnm6xQeeg4ozi/mSFXZJZ4JvsHg1Q33kWBVV1FjlW4aK8cfK2A
         3zM5S2MwWd/HO6K/CEeK5fOfFM/+GqLbo3rwoi4T0hKEFlCFW2F+JsnEFEoziLIuWroV
         uXqjOs6NmXAN5j+3rpBj9LV2J5nzL40w+Rl2VMG1JZRdmarlV/TbXdHHQliFj+orzciE
         RbZ02SROUIe3JstFL1Aw5O2+J8RnhpNWAdAqUrlfz0z5kjBi0cvepPtWaEvpmyjgMv3l
         QHeFOJeXcqqDlFaJKR4zlU9PsA0eXEZ7uB3CcipKV7S7CTYhtxUj66rhIYod5CEhrMho
         vuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632125; x=1703236925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAbH1XjkuKAQeNjFuhosk36+OO0YVuHDGozy0cI8OmU=;
        b=lH95TGauECnp/Qr9xrgNrVONTfK5QVPvtuq+i6DEnb/OfIDdD4DBmNRkmoeT5lySyx
         n4SV5Vw4qBQtWBg5pqjLEKydK/YoJsdNvLNfzFyI2HFkSTRraJ5OWCUmrLvze4IYyj1B
         eRkQJFaAPIQW6cuGzuyG2l0SGM7fwLrnzGxrgMiGANcPGXYaXaMEZdxBRoglyQ95OEqt
         456hrQj7swy+hYnengHScTJbV485o8jOR4ebWY8sAsNjIDrKbE0MGNhVQXHnAjHPXdIm
         JieijVdXlFvySK83tGOko039aqanCzEsYOhoYxKn5flJ00o/cEn2Z4sq9lVUqpr3eGSA
         FFEA==
X-Gm-Message-State: AOJu0YxFquuSviNGK/5BXEUs6KYympbdzmTuJHrgbg0NszyY68QjmR9Z
	lonZ2LHOCadl+sFe5SaQUNFvpTLIRpoLnjqSo/nI2Q==
X-Google-Smtp-Source: AGHT+IEivqz1Ru0ihRRp2JOPBdzO3cralWqI2XAtdMOT19Ynm8jHLjx3Kk2xK+N1a0MV4Lia/LBevSgec+5/RZ0syAo=
X-Received: by 2002:a05:6a20:5648:b0:18f:97c:617e with SMTP id
 is8-20020a056a20564800b0018f097c617emr11157689pzc.123.1702632125595; Fri, 15
 Dec 2023 01:22:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-26-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-26-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:51:53 +0530
Message-ID: <CAAhSdy26X3Ou_+df=dcUhW80JwmR5R_SORyc38pqMx378PaF6A@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] RISC-V: KVM: selftests: Add guest_sbi_probe_extension
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
> Add guest_sbi_probe_extension(), allowing guest code to probe for
> SBI extensions. As guest_sbi_probe_extension() needs
> SBI_ERR_NOT_SUPPORTED, take the opportunity to bring in all SBI
> error codes. We don't bring in all current extension IDs or base
> extension function IDs though, even though we need one of each,
> because we'd prefer to bring those in as necessary.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  .../selftests/kvm/include/riscv/processor.h   | 21 +++++++++++++++++++
>  .../selftests/kvm/lib/riscv/processor.c       | 19 +++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index e70ccda2011b..dc50ad62e150 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -108,6 +108,17 @@ static inline uint64_t __kvm_reg_id(uint64_t type, u=
int64_t subtype,
>  #define SATP_ASID_SHIFT                                44
>  #define SATP_ASID_MASK                         _AC(0xFFFF, UL)
>
> +/* SBI return error codes */
> +#define SBI_SUCCESS                            0
> +#define SBI_ERR_FAILURE                                -1
> +#define SBI_ERR_NOT_SUPPORTED                  -2
> +#define SBI_ERR_INVALID_PARAM                  -3
> +#define SBI_ERR_DENIED                         -4
> +#define SBI_ERR_INVALID_ADDRESS                        -5
> +#define SBI_ERR_ALREADY_AVAILABLE              -6
> +#define SBI_ERR_ALREADY_STARTED                        -7
> +#define SBI_ERR_ALREADY_STOPPED                        -8
> +
>  #define SBI_EXT_EXPERIMENTAL_START             0x08000000
>  #define SBI_EXT_EXPERIMENTAL_END               0x08FFFFFF
>
> @@ -115,6 +126,14 @@ static inline uint64_t __kvm_reg_id(uint64_t type, u=
int64_t subtype,
>  #define KVM_RISCV_SELFTESTS_SBI_UCALL          0
>  #define KVM_RISCV_SELFTESTS_SBI_UNEXP          1
>
> +enum sbi_ext_id {
> +       SBI_EXT_BASE =3D 0x10,
> +};
> +
> +enum sbi_ext_base_fid {
> +       SBI_EXT_BASE_PROBE_EXT =3D 3,
> +};
> +
>  struct sbiret {
>         long error;
>         long value;
> @@ -125,4 +144,6 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned lo=
ng arg0,
>                         unsigned long arg3, unsigned long arg4,
>                         unsigned long arg5);
>
> +bool guest_sbi_probe_extension(int extid, long *out_val);
> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index 6905a4348380..7ca736fb4194 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -393,3 +393,22 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned l=
ong arg0,
>
>         return ret;
>  }
> +
> +bool guest_sbi_probe_extension(int extid, long *out_val)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
> +                       0, 0, 0, 0, 0);
> +
> +       __GUEST_ASSERT(!ret.error || ret.error =3D=3D SBI_ERR_NOT_SUPPORT=
ED,
> +                      "ret.error=3D%ld, ret.value=3D%ld\n", ret.error, r=
et.value);
> +
> +       if (ret.error =3D=3D SBI_ERR_NOT_SUPPORTED)
> +               return false;
> +
> +       if (out_val)
> +               *out_val =3D ret.value;
> +
> +       return true;
> +}
> --
> 2.43.0
>
