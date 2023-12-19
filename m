Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24C137C
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="sv/gd3Lb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8688C400AF
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 00:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8688C400AF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.a=rsa-sha256 header.s=google header.b=sv/gd3Lb
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kkMVmXW1KRu
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 00:49:26 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 733F74004A
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 00:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 733F74004A
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2cc55698c81so40887321fa.0
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 16:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702946964; x=1703551764; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ez3c6gLJQTM1xEl9vrsUm/CRp88KyDpLDlUqP6UiLU=;
        b=sv/gd3Lbe/J45sZ4cVAdlxdITVChy9GsmCIBZTizVeJy3nIeIXQsljv+ej9qjMLbY6
         YhThMVJZavqbzdImaITqN5gJ+1JZfbnkOkEytZ2QgaKDc+UHjMzMz/c4wbzzmosHACEg
         KONnc/rIJkk8RmnmVxuTiDTpGo6kgcr7ntKIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946964; x=1703551764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ez3c6gLJQTM1xEl9vrsUm/CRp88KyDpLDlUqP6UiLU=;
        b=O5pUGt7OjixVcC4mhSDtidIHh7oeW5Hqn/lZWsOlIbJrpwZHHzAr/H3VAIBnXLCh1w
         9F4VmIOycQt1IG2KiJypF/an/ctB/g3GeuQI1ldslMdPcDuY6BSOhC1JwxTgAOKm+hyW
         Ojcg0eliaLQ0EQcroqdUFN202PMLrPAmilq9cbHNI7DhAcZ60vqa+TN6L2a5jdoPFK2M
         xZ/sBgvs/a9NyVQZl0kpIxuBJtaYjBaJFgfVaIEvkMaZDdjEgGpxuHTm9pKVO/DDoUrn
         43e96IRfjBRnBC/vL9QRrUJe0OpEbxyDOiqlhMB+ZCnDE5yFcUYSvsClt1bebua9kZvt
         k3Pw==
X-Gm-Message-State: AOJu0Yyisn9SoTSMuyK4H0CBERdoknCfGQ5u+OoDTf/IWHfQuKEeJSi+
	hvVwG1BpPXgFHlOAJVKqkLZJGaqiZBdD1zEbgo0B
X-Google-Smtp-Source: AGHT+IFSnv+UBG26wPKYz6so6qFuZwW7T8Q4zNpPNVBVsjUhYX6zMiZmS3kJpFdhaJxJK09EWWJMQPQYG8ealNdm2Ls=
X-Received: by 2002:a05:6512:3045:b0:50e:3776:2e16 with SMTP id
 b5-20020a056512304500b0050e37762e16mr1994822lfb.73.1702946964384; Mon, 18 Dec
 2023 16:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231217204019.36492-15-ajones@ventanamicro.com> <20231217204019.36492-17-ajones@ventanamicro.com>
In-Reply-To: <20231217204019.36492-17-ajones@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 18 Dec 2023 16:49:13 -0800
Message-ID: <CAOnJCUJ4pghg270dC54GUcLobtt6-E6sW4_kSWiLMVUACvEYug@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] RISC-V: Add SBI STA extension definitions
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
> The SBI STA extension enables steal-time accounting. Add the
> definitions it specifies.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0892f4421bc4..b6f898c56940 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -31,6 +31,7 @@ enum sbi_ext_id {
>         SBI_EXT_SRST =3D 0x53525354,
>         SBI_EXT_PMU =3D 0x504D55,
>         SBI_EXT_DBCN =3D 0x4442434E,
> +       SBI_EXT_STA =3D 0x535441,
>
>         /* Experimentals extensions must lie within this range */
>         SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
> @@ -243,6 +244,22 @@ enum sbi_ext_dbcn_fid {
>         SBI_EXT_DBCN_CONSOLE_WRITE_BYTE =3D 2,
>  };
>
> +/* SBI STA (steal-time accounting) extension */
> +enum sbi_ext_sta_fid {
> +       SBI_EXT_STA_STEAL_TIME_SET_SHMEM =3D 0,
> +};
> +
> +struct sbi_sta_struct {
> +       __le32 sequence;
> +       __le32 flags;
> +       __le64 steal;
> +       u8 preempted;
> +       u8 pad[47];
> +} __packed;
> +
> +#define SBI_STA_SHMEM_DISABLE          -1
> +
> +/* SBI spec version fields */
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> --
> 2.43.0
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
