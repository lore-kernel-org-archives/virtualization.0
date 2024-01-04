Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFE1BDD6
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgSfnwNY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FCDB60C0F
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 04:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FCDB60C0F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FgSfnwNY
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UI-SaIoNqSMg
	for <virtualization@lists.linux-foundation.org>;
	Thu,  4 Jan 2024 04:00:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5273060BD8
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 04:00:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5273060BD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704340830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBYuqGL01aH65sRzp3Rsp7NBWvcHS/OIZjseRKkmKSE=;
	b=FgSfnwNYM4uAumaH7Hqx1fwdG24BmHrjDEsmRLuRf1Rgo7ZRdVfjrRe6e5CXE7RDu66E8v
	BJGG1D/ZgaQc4dMNIGg/wrnIxkYj/+kUb5qfXD1PwBfPng5xaw2GMW1gev+TNZ0LeVaWTj
	IemmrhBkphtl1RIILTATKS6Vy66T4+A=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-WIeJss0qPlS2w1D2aVeLtg-1; Wed, 03 Jan 2024 23:00:26 -0500
X-MC-Unique: WIeJss0qPlS2w1D2aVeLtg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dc3178ae1bso152275a34.3
        for <virtualization@lists.linux-foundation.org>; Wed, 03 Jan 2024 20:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704340826; x=1704945626;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBYuqGL01aH65sRzp3Rsp7NBWvcHS/OIZjseRKkmKSE=;
        b=izn2B9bGpQe7yT2yjyosIi8PXUh6ZPQEuKvWZY7V8qSXiyUAlqLQvgZqlVgavFPgEo
         xhk8t/n1i3nXLdd4y0McqxeJYECLSbHYaaKFE0glx5uL9mrzrc47gff2hvKN7RNwlSsf
         HF0ePFXNk/F60dK7my0C0Iv91kIuzn/zva6Frv1efXe7X0ZsEalIUJ4o8StgZMpznzby
         TJqg/6MCutRNzse37so/GPaEThHTcRTWxbRj+2WoWiG4U6cl/tTsvdHTMtKhJkvMmLWu
         4yo1mQQdNJNkihacTRvDrlj/vN52fLxd6eZMlRdXwkZwxnjsEnRIjlcOJ/ziyANtcUZx
         DQMg==
X-Gm-Message-State: AOJu0YwkXw1xxeih4qG0YM6G5jJK8AMEKtshl9zj4sVpuiDk6eSfEHB8
	+gf+0d6XgjsOcVY7+3JALIUusCNUclNKhnVNobjANYirxwKcwUAHOd3dFIC3y6UUj8gTcXuhj4F
	JTFJV3/WDuV/bYAWna9xKfFP+NLOD/q3/f89wbLyI4o5sbaTcuQ==
X-Received: by 2002:a9d:6195:0:b0:6dc:386:a236 with SMTP id g21-20020a9d6195000000b006dc0386a236mr82611otk.47.1704340826179;
        Wed, 03 Jan 2024 20:00:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYCFaNNcVbXHq19hlObccAYpVr3fPXzM+NW7eJa+gC+TOtT2xTCMbEvFLXeyLlWyifJIETXg==
X-Received: by 2002:a9d:6195:0:b0:6dc:386:a236 with SMTP id g21-20020a9d6195000000b006dc0386a236mr82593otk.47.1704340825954;
        Wed, 03 Jan 2024 20:00:25 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id x9-20020a63db49000000b005ccf10e73b8sm23041671pgi.91.2024.01.03.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 20:00:25 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: guoren@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	peterz@infradead.org,
	anup@brainfault.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V12 03/14] riscv: errata: Move errata vendor func-id into vendorid_list.h
Date: Thu,  4 Jan 2024 01:00:14 -0300
Message-ID: <ZZYtTryGpoMk7Gt8@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225125847.2778638-4-guoren@kernel.org>
References: <20231225125847.2778638-1-guoren@kernel.org> <20231225125847.2778638-4-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 25, 2023 at 07:58:36AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Move errata vendor func-id definitions from errata_list into
> vendorid_list.h. Unifying these definitions is also for following
> rwonce errata implementation.
> 
> Suggested-by: Leonardo Bras <leobras@redhat.com>
> Link: https://lore.kernel.org/linux-riscv/ZQLFJ1cmQ8PAoMHm@redhat.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/errata_list.h   | 18 ------------------
>  arch/riscv/include/asm/vendorid_list.h | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 83ed25e43553..31bbd9840e97 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -11,24 +11,6 @@
>  #include <asm/hwcap.h>
>  #include <asm/vendorid_list.h>
>  
> -#ifdef CONFIG_ERRATA_ANDES
> -#define ERRATA_ANDESTECH_NO_IOCP	0
> -#define ERRATA_ANDESTECH_NUMBER		1
> -#endif
> -
> -#ifdef CONFIG_ERRATA_SIFIVE
> -#define	ERRATA_SIFIVE_CIP_453 0
> -#define	ERRATA_SIFIVE_CIP_1200 1
> -#define	ERRATA_SIFIVE_NUMBER 2
> -#endif
> -
> -#ifdef CONFIG_ERRATA_THEAD
> -#define	ERRATA_THEAD_PBMT 0
> -#define	ERRATA_THEAD_CMO 1
> -#define	ERRATA_THEAD_PMU 2
> -#define	ERRATA_THEAD_NUMBER 3
> -#endif
> -
>  #ifdef __ASSEMBLY__
>  
>  #define ALT_INSN_FAULT(x)						\
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
> index e55407ace0c3..c503373193d2 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -9,4 +9,22 @@
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
>  
> +#ifdef CONFIG_ERRATA_ANDES
> +#define ERRATA_ANDESTECH_NO_IOCP	0
> +#define ERRATA_ANDESTECH_NUMBER		1
> +#endif
> +
> +#ifdef CONFIG_ERRATA_SIFIVE
> +#define	ERRATA_SIFIVE_CIP_453 0
> +#define	ERRATA_SIFIVE_CIP_1200 1
> +#define	ERRATA_SIFIVE_NUMBER 2
> +#endif
> +
> +#ifdef CONFIG_ERRATA_THEAD
> +#define	ERRATA_THEAD_PBMT 0
> +#define	ERRATA_THEAD_CMO 1
> +#define	ERRATA_THEAD_PMU 2
> +#define	ERRATA_THEAD_NUMBER 3
> +#endif
> +
>  #endif
> -- 
> 2.40.1
> 

LGTM:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

