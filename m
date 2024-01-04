Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21BC18AF1
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgCPoPf0"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BA3060E32
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 05:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BA3060E32
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgCPoPf0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNe72c8ZJ6lA
	for <virtualization@lists.linux-foundation.org>;
	Thu,  4 Jan 2024 05:11:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55FE260AA7
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 05:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55FE260AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704345079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1vihmddHtSZ99/zq0fZBdm+zeXPC115N0eCs1YPKg8=;
	b=WgCPoPf0DHOTInW2th0z9/Eyfddgc6CAnHIgIYJ2tKdFStqtmF5x9UxXwIhCDSJBeySusM
	02KOkagv9W8K+2qKVynDnZfEqx8vuqpLTXiZuz8ViLjd16NOZfMSU8sPSjpbWe3eVSC4Xa
	ut93RR8DOONmywNDY7VjrafI9zVjTwg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-o8UMvJCsMGqRNdEUTy10EQ-1; Thu, 04 Jan 2024 00:11:17 -0500
X-MC-Unique: o8UMvJCsMGqRNdEUTy10EQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so99908a12.0
        for <virtualization@lists.linux-foundation.org>; Wed, 03 Jan 2024 21:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704345076; x=1704949876;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1vihmddHtSZ99/zq0fZBdm+zeXPC115N0eCs1YPKg8=;
        b=R9CB1M1/4FuPc13Negm/LRE4aG9E4nuI6mOOKJY7gGtdjUdMkEaXtS1dnCjZVZWGrl
         Nq9z1RWNYRrSDbb9FPvN3S1u5Cj5xw+0QUsO+qB1tI29kQGrdfL3bV/J4VQlx8gqTtqc
         tX5rwUwMpdwo6IiMNQjD7B/HVstxSuNdwl5CNoEhf/HCh2J7yvkzqdUv+iIyOosAOF13
         92VH2HMbxkxWeXZxVD4w7DG1T9Ii4TbzkKRzZIMXtMSS8yFqB5U9/clYlql8JKLnOuvZ
         cidic9tyuosO6tMgNL0AXoaDOOzwDMSjVEfbrj/x+2m7KjsbIN57jT1bpFne9meid8RM
         GHUA==
X-Gm-Message-State: AOJu0Yyd6BvcyHx8JYzsRLsKiYNy3XBnkZvXPbH9tHCh2k0xYW9ZYomM
	9VPSFH3PtlJykE8QH8+k3yKsSzaEDb/5cSuzmG8oFu0k2+RT3Z47t0BeJ+QKt42B1WVXhw53qGH
	bdho3awAQm86USRQmob9cmnPbOy9FCA5txqbfwLRRbKGYCn02KA==
X-Received: by 2002:a17:902:da86:b0:1d4:d140:8171 with SMTP id j6-20020a170902da8600b001d4d1408171mr52089plx.41.1704345076615;
        Wed, 03 Jan 2024 21:11:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpSlvwWfbHMFG7wHdD03jmH2na3W8ssbNhKgAkQNbMSxmoAlh0aAjbmolGPOik5IenAoMbcg==
X-Received: by 2002:a17:902:da86:b0:1d4:d140:8171 with SMTP id j6-20020a170902da8600b001d4d1408171mr52085plx.41.1704345076326;
        Wed, 03 Jan 2024 21:11:16 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001d3ecbccb52sm24427284ple.213.2024.01.03.21.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 21:11:15 -0800 (PST)
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
Subject: Re: [PATCH V12 08/14] riscv: qspinlock: Force virt_spin_lock for KVM guests
Date: Thu,  4 Jan 2024 02:11:05 -0300
Message-ID: <ZZY96U3CzvDhu3BL@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225125847.2778638-9-guoren@kernel.org>
References: <20231225125847.2778638-1-guoren@kernel.org> <20231225125847.2778638-9-guoren@kernel.org>
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

On Mon, Dec 25, 2023 at 07:58:41AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Force to enable virt_spin_lock when KVM guest, because fair locks
> have horrible lock 'holder' preemption issues.
> 
> Suggested-by: Leonardo Bras <leobras@redhat.com>
> Link: https://lkml.kernel.org/kvm/ZQK9-tn2MepXlY1u@redhat.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/sbi.h | 8 ++++++++
>  arch/riscv/kernel/sbi.c      | 2 +-
>  arch/riscv/kernel/setup.c    | 6 +++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0892f4421bc4..8f748d9e1b85 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -51,6 +51,13 @@ enum sbi_ext_base_fid {
>  	SBI_EXT_BASE_GET_MIMPID,
>  };
>  
> +enum sbi_ext_base_impl_id {
> +	SBI_EXT_BASE_IMPL_ID_BBL = 0,
> +	SBI_EXT_BASE_IMPL_ID_OPENSBI,
> +	SBI_EXT_BASE_IMPL_ID_XVISOR,
> +	SBI_EXT_BASE_IMPL_ID_KVM,
> +};
> +
>  enum sbi_ext_time_fid {
>  	SBI_EXT_TIME_SET_TIMER = 0,
>  };
> @@ -276,6 +283,7 @@ int sbi_console_getchar(void);
>  long sbi_get_mvendorid(void);
>  long sbi_get_marchid(void);
>  long sbi_get_mimpid(void);
> +long sbi_get_firmware_id(void);
>  void sbi_set_timer(uint64_t stime_value);
>  void sbi_shutdown(void);
>  void sbi_send_ipi(unsigned int cpu);
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 5a62ed1da453..4330aedf65fd 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -543,7 +543,7 @@ static inline long sbi_get_spec_version(void)
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
>  }
>  
> -static inline long sbi_get_firmware_id(void)
> +long sbi_get_firmware_id(void)
>  {
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
>  }
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 0bafb9fd6ea3..e33430e9d97e 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -281,6 +281,9 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>  
>  static void __init virt_spin_lock_init(void)
>  {
> +	if (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
> +		no_virt_spin = true;
> +
>  	if (no_virt_spin)
>  		static_branch_disable(&virt_spin_lock_key);
>  	else
> @@ -290,7 +293,8 @@ static void __init virt_spin_lock_init(void)
>  
>  static void __init riscv_spinlock_init(void)
>  {
> -	if (!enable_qspinlock) {
> +	if ((!enable_qspinlock) &&
> +	    (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)) {
>  		static_branch_disable(&combo_qspinlock_key);
>  		pr_info("Ticket spinlock: enabled\n");
>  	} else {
> -- 
> 2.40.1
> 

LGTM:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

