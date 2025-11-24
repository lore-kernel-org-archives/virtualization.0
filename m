Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4862FBDE9;
	Mon, 24 Nov 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978087; cv=none; b=aqTvGuxrBE9Cmo69HDMyexnpaj7iBGZPwIA2DR6gjqXTMcslGQ00KxHhio8r9BD31nfB4r84vgUDg3p06h6LXZlaA6iJ64NddHDnpiA3MM/2qpkGLHY795B0B+R0TvjSh3Dgodv29OlXkU04Q026NbN2erVLC3pwt7FsxG8FiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978087; c=relaxed/simple;
	bh=a0nRGIDci22MCD2D8c5xMsYYHrIdVNziTzBaqLsw6hI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UsnY2HGT+rsFq7aw4AFNEkoxpPMA+Txlmpfa/1Tb9VQ0+vFTzFNapIZCpGiDc+psf4cqgoZxGvaa4PHJZ/TodK/kBM+xR9Rw0nVkQwmiBajPprdtEbmT2c0cbj6Al8Z3giyESyTlZU/i7B1j/40zO+v+s9b9pAB7TAxkBao+8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dx_9NeKyRpt3YnAA--.14223S3;
	Mon, 24 Nov 2025 17:54:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxpeRbKyRps409AQ--.34932S3;
	Mon, 24 Nov 2025 17:54:37 +0800 (CST)
Subject: Re: [PATCH v3 09/21] loongarch/paravirt: Use common code for
 paravirt_steal_clock()
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, virtualization@lists.linux.dev, x86@kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-10-jgross@suse.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e43e9885-68f1-8558-08cd-9d0ef48861f7@loongson.cn>
Date: Mon, 24 Nov 2025 17:52:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251006074606.1266-10-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpeRbKyRps409AQ--.34932S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryfAFy5tw1kCFW8Ar4rCrX_yoW8KF43p3
	srAr1kWw4UGFn5uFZrK398Wry5Cwn7G3W2vF1aga4rAFZrXr1qgr18J34DXFyqqa97Ja1F
	qFyrCwn0ga1UJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
	SoJUUUUU=

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2025/10/6 下午3:45, Juergen Gross wrote:
> Remove the arch specific variant of paravirt_steal_clock() and use
> the common one instead.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/loongarch/Kconfig                |  1 +
>   arch/loongarch/include/asm/paravirt.h | 10 ----------
>   arch/loongarch/kernel/paravirt.c      |  7 -------
>   3 files changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ea683bcea14c..7a9d1d0edc92 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -671,6 +671,7 @@ source "kernel/livepatch/Kconfig"
>   config PARAVIRT
>   	bool "Enable paravirtualization code"
>   	depends on AS_HAS_LVZ_EXTENSION
> +	select HAVE_PV_STEAL_CLOCK_GEN
>   	help
>   	  This changes the kernel so it can modify itself when it is run
>   	  under a hypervisor, potentially improving performance significantly
> diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
> index d219ea0d98ac..0111f0ad5f73 100644
> --- a/arch/loongarch/include/asm/paravirt.h
> +++ b/arch/loongarch/include/asm/paravirt.h
> @@ -4,16 +4,6 @@
>   
>   #ifdef CONFIG_PARAVIRT
>   
> -#include <linux/static_call_types.h>
> -
> -u64 dummy_steal_clock(int cpu);
> -DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
> -
> -static inline u64 paravirt_steal_clock(int cpu)
> -{
> -	return static_call(pv_steal_clock)(cpu);
> -}
> -
>   int __init pv_ipi_init(void);
>   int __init pv_time_init(void);
>   int __init pv_spinlock_init(void);
> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
> index 8caaa94fed1a..c5e526098c0b 100644
> --- a/arch/loongarch/kernel/paravirt.c
> +++ b/arch/loongarch/kernel/paravirt.c
> @@ -13,13 +13,6 @@ static int has_steal_clock;
>   static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
>   DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>   
> -static u64 native_steal_clock(int cpu)
> -{
> -	return 0;
> -}
> -
> -DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
> -
>   static bool steal_acc = true;
>   
>   static int __init parse_no_stealacc(char *arg)
> 

