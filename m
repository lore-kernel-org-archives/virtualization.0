Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD927D266
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="xu5x7FBc"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2680C60E7E
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:39:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2680C60E7E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xu5x7FBc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hmE_Wd5JVr1k
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 05:39:01 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72BC560BB2
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 05:39:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72BC560BB2
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso296449a12.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 21:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702618740; x=1703223540; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV6k6Fkf1zGeYnG+LwbzgUEhP05ecy2yUGe65fxGGFc=;
        b=xu5x7FBcBIoxHCwTM0l3mk0tftVRO0vGRUMyBfGcHWU02aIF+FguTeSzCvctllkLWf
         2g741eRIY7R7Qg20ati1gDpKBaD9xGyBLVKbkgxrDdGS+GAjws1OVGzJIG7rUHnhRfCt
         UTAyR7maV6WY+OBJIBevoHIQQ7wT1wenHAUa4H1Vibd64Vgtsx5QhJzK5vuWYsjiwcNw
         BwR8mLvPr1duBqgjLFvmG6gHjnDZJ8Oyx2ye7022iByoepLiMCkl5SxmJLKbPwm8VTck
         Q3U8MMfml9XKj4r1iTa02e/DBQmY668ndBFtc62H5swzOyBtzAiNDpxRx9zAvGHBMuZ/
         KL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702618740; x=1703223540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV6k6Fkf1zGeYnG+LwbzgUEhP05ecy2yUGe65fxGGFc=;
        b=YJTSpaVrJKWFZHaIuHtBee4dX4Iq8e9AhfBF851f+N2ZE4+Igrn+kczAfyOsfAQ7ai
         ngPemdu3Sd6DIsN06dllJ+/3WdzHKHxQgiyeXADbZNMG2lJKKE4Sljjg010Pam4LmJwR
         VSiKBAv9es44SHoOVnaNrLsS2V6kD5r/7rP46YMegoa3EQvzewpVGc80Ck6iHf6vKwEZ
         cmcsJpBOBsE94rZvEsshbzW5w6qRuv6jn35LrSh6Tu3s6XWCPc9hOlGqUQdDg8fwfkBG
         4Bf9OCgDljWvl8gAelmJ7krABRk2InAFbWDsOS2SZw5ZQd0QaCXjBGsVic/qck3bIjy9
         AVlA==
X-Gm-Message-State: AOJu0Yyp84PB9VzdXVPyFouYQ8/A0kZYMsFQ9M7CcAasXxwxuzPmswnN
	YZ5MDQQ08oQPXe9LoojFwhMrUty/hE8+Kha2AUcyRg==
X-Google-Smtp-Source: AGHT+IG+Fb3ZYO0u7bbyiooMvcQHR8wrEQ7/sQGQ+UlaI2KFAdSrc8MnMOG61PoyxvLBI/rlO4ZmrauaySWJxDXAoVk=
X-Received: by 2002:a05:6a20:d386:b0:190:1e0c:d29 with SMTP id
 iq6-20020a056a20d38600b001901e0c0d29mr18276788pzb.4.1702618740539; Thu, 14
 Dec 2023 21:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-17-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-17-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 11:08:47 +0530
Message-ID: <CAAhSdy3UxqriE+9E+To8ioDEpzzCp-GQ4ZfMpCxHYHJ=+u9p6Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] RISC-V: Add SBI STA extension definitions
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:45=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> The SBI STA extension enables steal-time accounting. Add the
> definitions it specifies.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
