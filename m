Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CE3B783
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="sBBshmBF"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE07540480
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:57:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE07540480
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=sBBshmBF
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M-JgtVw-2orZ
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 21:57:35 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 042ED40004
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 21:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 042ED40004
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso61841091fa.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 13:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1703023052; x=1703627852; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flfYg+kGL4SvX7qyMdFuJAdPbCDixB8UEJxEUpxAFlw=;
        b=sBBshmBF/B5grvJufodlYE1Va5Xnw3++GuruGYzjVPLUf0iPRbf1elDhf3JQwaTpof
         gTaJHHf9Al1a9lWhH9+eCVMbnB31mBJ27UUR94QrAZAPZJ143Y2N2jauh+Aozj9jPkU2
         pXIsLzAGElvnCjNQxg/fQNsG83j2Qe1P38IPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023052; x=1703627852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flfYg+kGL4SvX7qyMdFuJAdPbCDixB8UEJxEUpxAFlw=;
        b=Q+5Cs1/rAT2XHdwbTabEjUYIm178p99KAOLNhFkHal/g9W6HMK+2hxMI6Ne9lmGWws
         0jo5mNA1KHuzaw8G6MhBd9oMM1aDSM0VEoKZVSo4rClxdVtavl2Sdskti/w8DnUVzOLl
         e7Tfs5LqbHPUHKlNS0HlnQYDiIFIGTjF6R9CCfbjKhIBpsBqERuPxeAniVfWvc4u6/58
         qvUFjl99HbE61pTsVPBzSW1Fk/2hy+x/zvVCYH26GcTI7QzUO61ed0raYg8Ea35pM6Gf
         v+0G07oZDqssZSKL4ptJZ3DJTTld/Hr2O3UMyUaBgcmztcxV3sXRA8J06V9DlITHuz+R
         FlWQ==
X-Gm-Message-State: AOJu0YwAQ+K6zksa4gkObk/wwMe1RNxvmUajezhMDAy35aqB5iXSK1HK
	NpkEVj/qIy1TdvlrWD9CJN0N+0UtJIfCblK052Zl
X-Google-Smtp-Source: AGHT+IG2Ctyaf7+tPjnLU31qpHDga5y6EAeSS7g74aovcwiQNTS85vE9NtWDgEl1DtJ8skzrB9XXgJpoZHJP/aQkxIM=
X-Received: by 2002:a2e:a453:0:b0:2cc:8472:c97c with SMTP id
 v19-20020a2ea453000000b002cc8472c97cmr617988ljn.26.1703023052424; Tue, 19 Dec
 2023 13:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-26-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-26-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 19 Dec 2023 13:57:21 -0800
Message-ID: <CAOnJCUKu1069YXRWopFDjRobF4jjskdFJMQH1oD2wPc+9JoBmg@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] RISC-V: KVM: selftests: Add guest_sbi_probe_extension
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
> Add guest_sbi_probe_extension(), allowing guest code to probe for
> SBI extensions. As guest_sbi_probe_extension() needs
> SBI_ERR_NOT_SUPPORTED, take the opportunity to bring in all SBI
> error codes. We don't bring in all current extension IDs or base
> extension function IDs though, even though we need one of each,
> because we'd prefer to bring those in as necessary.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
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

Add SBI_ERR_NO_SHMEM as well ?

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


Apart from that, LGTM.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
