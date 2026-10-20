Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498234;
	b=Fvs0YmL4TD9AUZGEg40rZk3PMIe2DeU0YRbZgt/wlc1og0Rz8qsHChHgse4b8peJz25v
	 8sGHrY6n0khn+aYP6MPQP/EnGG8NtAPmO/yc4sAyfxpYy3i1UG6AUrmgi5IX3Dh5wFmuJ
	 q5gzdqvSjlgMp0OfPK+ZMTzbUs0TbQrtIqARzb4W0zxbW9lhtoX4ZckgbkxRPuGWpuRKj
	 8DAD9jgdweP0nit3zQBPkxpX4kWKoe25whDHj7ZmgLptPFCcCOg5Jkaa8Z0F5ADDkB6sc
	 Db78WW2BpK0j7SGWdO10BF7ZbwFk/6n1KMbM1kyvHSD16lWtJFpUb7SfpS0kGjMBppQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TP3lHd7ZCrOKSupriqyX6PtdNuECuFfGjiY9AbgLC+E=;
	b=PXEzgLk0JZVJC14yWEv8JoBaTSg+uXAKm56DtNFPRb+emptkLUkr1hrnYBdt3gFs2ZvW
	 QZWwoiS4hIzo+sp/EA0+myRpS0QIwws4wh3x5ivk6jEt6HDtINmx+6D69i6ohYAsx37kz
	 eFnQCRNpmR/sk2HQd9sZHBwTcHTnj7M4CsNf4bY9F7MmjocM6dAzT9yFTGG9vj6s54ZmI
	 89Yq3aZEvmMkPE+1V1k+I/D87KSlLyvdjl03pKVyup6WBunxGF+YZDx0Zg4xFjD9g3tyx
	 ia7XBF9a7lBxMJMGPzRg0SGIFns4MaYQCPV6lZ58qF9HCLY964rfjaCjyvAcWOPE+8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BKofgEhD;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD1606A320
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CD1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BKofgEhD
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dc202a60eso865356f8f.3
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792498233; x=1793103033; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TP3lHd7ZCrOKSupriqyX6PtdNuECuFfGjiY9AbgLC+E=;
        b=BKofgEhD4fBPtC5Lg5sZfijj1VblSsyKRS8fByqQSSfSH7dYJ+nVMSBVw0MvLJxi7m
         WCGuNCnZKQcEA6/SlRrrP/UH46a3X78uoVCbdz4EShVVsomv7mOqdVeUNyPp5X4cm26k
         E6+pISUUNzigU+j8rodLm1wa9T2yemvncpFD0So+FJGgHrIChf7nKZLA/GpYHU6py5q4
         PeYGkAxwsG8mbB/l6cxxscVLBkrLrtJyjg/khWqoJC9XSdi/LWEXFGi+ntDK66sPItE/
         W6ebM7RiJcp3Bs/udnMQ/dEThMJMeODc0wz2zBUrh5zkdWbKRZ2vdoGzAbIXnOm1lBAP
         vzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498233; x=1793103033;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TP3lHd7ZCrOKSupriqyX6PtdNuECuFfGjiY9AbgLC+E=;
        b=A7SENRzrxRdQFhJ3QElwUym6SSqmTjMovpSPdnF1Tlkw0X0A8K/MYlWzSWRe8YhS1T
         wKbammh0qSnw+XG1GFxeZUeUe5yLbDhcMxKZMN74pWwmlQPiojWJlAYhsRzBXEaMVB2+
         tPO6shnma/A1aHzcirqxCTPKMo8GAMFCLWIkM1W/TPJEMtKAHgUNb7KgePf+Gy0QVJvo
         ZO8ACTtOei27OyCFMY9QDD/1tRo7eH5NMekAHnYJbXoR/s/0IB73Xt0JDfEspBo0gqhm
         uG+DHZIzb5NpR8p8ECDNs0st3RDZNcHz0eKCFmUILGSlP+jqxojKKnpT7SGMnWg5PLuz
         +lBQ==
X-Forwarded-Encrypted: i=1; AKwUvByAlYaOofHRaI3ebzLEYxSEWIoG+E2IrzAbBrGvCXNQT6rsONskqDwbdM4pP4yNZ6ugHEWd+s/8wdj/HWmh2w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJGYPBtcGzEbKFTTaD1y7mTki7IGTEwQJ88l7NgwRcenwYw5VUZ
	9wJQFB/hTCl4GaEvdjeU2gW87qktzt6bNRMhPoTRe2bQzIwWgVVAOoWDqYd/pwNsZ3k=
X-Gm-Gg: AYBFou238YIzjBwbtB8cG4i59UZklbNmQKqCsLeswMB/L7tVV22vwwKhJua9Ysi/YpH
	z9344xhnn9rUhzOfMFiDaqxUZ81UyFEgFMK8SZjL2g9+fOiVs8H2Z4Q8E00BfGw3fHU8M7PTtkT
	XOCYG8enj60UrTKQBJQw3xwDWhYBexzzxd1ZvePgDRmUx/SkOf1Z3L7D39Jl8FMABqvk/IobONe
	rBvECmgQUSakhhb21+3jmRpk81yUG2CRdpRm02uC6YjAybqsyC0oUc6fy6BuoBNvuaf3m3gt3eA
	OknM1sdYnAduIjobeEk95XxBMAU5gwKCKAV0PCVjEm3xfajdMPREEsEIjh77HSVXZ8yukhOoeGU
	SK1ujvEb5h6pkSnyk4jLlv0nLGowqQvNV8nQqVQvnIz5TvNZ0aK45CGb8EwKmVsBNn2O7co3iDq
	o6kzmlZOF7oCeQTZvPcfKyqk+/t48ZIE8c3Se5Y01DHtYLSQgdma84z39IK428CZd6WuSHiz9kn
	FwNY1AmToo=
X-Received: by 2002:a5d:5f51:0:b0:48e:412:3813 with SMTP id ffacd0b85a97d-48e07bb2fc7mr21324149f8f.20.1792498232549;
        Tue, 20 Oct 2026 05:10:32 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823cfcsm5747053f8f.39.2026.10.20.05.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:10:32 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:10:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>
Subject: Re: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before
 switching kernels
Message-ID: <atdaNQts1frMB8Kq@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>

On Mon 2026-09-28 13:55:36, Zack Rusin wrote:
> Fatal x86 oopses can call crash_kexec() without reaching panic(). Run the
> pre-kdump chain from __crash_kexec() as well, after finding a loaded image
> under the kexec lock and capturing the original registers.
> 
> This covers direct crash entry without moving all panic notifiers ahead
> of kdump. A missing image or failed trylock leaves callbacks uncalled;
> the shared guard skips callbacks already invoked by panic().
> 
> Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: cover direct crash-kexec entry in a separate core patch.
> 
>  kernel/crash_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2b36aa9fade0..5d9fe9e00f39 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/objtool.h>
>  #include <linux/delay.h>
>  #include <linux/panic.h>
> +#include <linux/panic_notifier.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
>  
>  			crash_setup_regs(&fixed_regs, regs);
> +			panic_notify_pre_kdump(NULL);

I understand why you did this. But it makes the code really hard to
follow: 

  + This code path will be called also by the 1st __crash_kexec() in
    vpanic() when "_crash_kexec_post_notifiers == false". It is the
    default.

  + The panic_notify_pre_kdump(buf) in vpanic(), added by 1st patch,
    is called when "_crash_kexec_post_notifiers == true" or when
    __crash_kexec() returns from some reason.

None of this is obvious.

I am going to think more about it.

Best Regards,
Petr

>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();
