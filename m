Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8E7E1
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Hr3Wspa6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 603F582188
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 603F582188
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Hr3Wspa6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYHJfRyg9W0H
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 00:16:09 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D7EA8216C
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 00:16:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D7EA8216C
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3bb53e20a43so5271834b6e.1
        for <virtualization@lists.linux-foundation.org>; Thu, 28 Dec 2023 16:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1703808968; x=1704413768; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF8VYnIQOQqAaiJ1Fk4AaOQ/0YJajKW06kr07Kc5Pmw=;
        b=Hr3Wspa6ZtLyYdCvW33QhQQ6bpUjYYiqscxorpxMHFGMlgNDMX62Bz9csAuDfDWdx6
         cT+bJ3wd0Q1GNVRr9fjgyz44ghh+vCPFi+LV3hwEN8Ik5x2cqG+A7qghd336aEYAiYin
         dutGb35c0+HwahWf0EnO4aV8ezMFgCLLPPui3gmeyNeq4ovLfIF4KoHE+/BhBg9LHjsZ
         dG4Z6FgW7N+vohMxKYRloXmXjgCe2tWpxMagr8FjSyt4KqVQDKfzM583KYJ8Q9un/4M2
         wZwYBZP4/J0SlOuOk8T608PEMs3qnW96RH56kmpuMlrFWSBmGU1u872fMGKPI+OG6WoU
         udhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703808968; x=1704413768;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF8VYnIQOQqAaiJ1Fk4AaOQ/0YJajKW06kr07Kc5Pmw=;
        b=F2AZ/1FKo0PKiDiSRTgmCrF3O+GlpfCsVqKcA2/Aub53zvNzRYsVey4Q6ye4EGs9iA
         XgXztMJL7Tn9/9xrLp0jquNcagbX/djVspsumq8Zs6YctaaZZpUdsxUStL/pknQGi68q
         5PnbmqYMDspAXvsxk/jMvDOu2uZ8dpW74UhpazaWMCA/+cwPmNcNbsWjuqUq/lhs3xUL
         DjnkGD5+Ow1DzUfxi4KFBxNra61VNrzdJhqimekHKhWoHJEVSQw1gFaLbmmxufcDxurL
         TnGzi5mpEFehhxD9rWmhA8pjpb+dMcmfP4rPTUDYxQXmO7dLXe+VyM/TzGxJg5vXej99
         PJsQ==
X-Gm-Message-State: AOJu0YynEMyQpqOXmqRUH7ylcXuSfqK2sMBOpyVY5pTkEZBUA0CQmDqg
	X4HDxSvdPTq/vb4UJRKYUdLHANLZPjjw5w==
X-Google-Smtp-Source: AGHT+IHHx4W0B/1pZutO7lzLygxRXci+UxI/fuD6WNdIvohnaJq9dm1XqSdQfH5oJFOgJO3eWZ+/fA==
X-Received: by 2002:a05:6808:1817:b0:3bb:d669:5e26 with SMTP id bh23-20020a056808181700b003bbd6695e26mr1406139oib.33.1703808968499;
        Thu, 28 Dec 2023 16:16:08 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b006d095553f2asm14733674pfb.81.2023.12.28.16.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 16:16:07 -0800 (PST)
Date: Thu, 28 Dec 2023 16:16:07 -0800 (PST)
X-Google-Original-Date: Thu, 28 Dec 2023 16:15:40 PST (-0800)
Subject:     Re: [PATCH v4 02/13] RISC-V: Add SBI STA extension definitions
In-Reply-To: <20231220160012.40184-17-ajones@ventanamicro.com>
CC: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
  virtualization@lists.linux-foundation.org, anup@brainfault.org, atishp@atishpatra.org, pbonzini@redhat.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu,
  guoren@kernel.org, Conor Dooley <conor.dooley@microchip.com>, Atish Patra <atishp@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ajones@ventanamicro.com
Message-ID: <mhng-00bc7d81-742f-49cb-8f3f-c4b0bd83c6c7@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 20 Dec 2023 08:00:15 PST (-0800), ajones@ventanamicro.com wrote:
> The SBI STA extension enables steal-time accounting. Add the
> definitions it specifies.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
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
>  	SBI_EXT_SRST = 0x53525354,
>  	SBI_EXT_PMU = 0x504D55,
>  	SBI_EXT_DBCN = 0x4442434E,
> +	SBI_EXT_STA = 0x535441,
>
>  	/* Experimentals extensions must lie within this range */
>  	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> @@ -243,6 +244,22 @@ enum sbi_ext_dbcn_fid {
>  	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
>  };
>
> +/* SBI STA (steal-time accounting) extension */
> +enum sbi_ext_sta_fid {
> +	SBI_EXT_STA_STEAL_TIME_SET_SHMEM = 0,
> +};
> +
> +struct sbi_sta_struct {
> +	__le32 sequence;
> +	__le32 flags;
> +	__le64 steal;
> +	u8 preempted;
> +	u8 pad[47];
> +} __packed;
> +
> +#define SBI_STA_SHMEM_DISABLE		-1
> +
> +/* SBI spec version fields */
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
