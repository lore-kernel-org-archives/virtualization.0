Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447559;
	b=AVdSu/iLdtY0cJ/bPl80x7d9xCjmVCnUQBqD0w39WNEyqJHE8djSwy1J0jimtLooyrCf
	 nS3obgLroGHyiZf4gYQ8tHMNLil5H7/FMcs4Lo9OQRI1znCGujPsGXhnvpdiIn0JElo3r
	 dDkO77OhNZOpwkXK/0dADULFdW5joy7PRK3Ltuk1E9N27rKEEGwLuXfXouL5V9how8GNw
	 RMwyp/g1kLHpBx2KsUT3QJ2gyAFcjqIbF2EaAO1/qOh0Buxcnm8aP9BJzKsfURO/tCd1p
	 7IKQ5ZqSL6hdhBHw3FtAtMc5VMkbcMujVPbejBNLtbHQsMS88MAy9BpuyOwZb75mytA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447559;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2vIHfmH9PqQoENTr1ZAdbd1GcxgaoRPWjUm3ZBNsSks=;
	b=yoh7X5VAO/xmqVyP3oFbFaTdBfHo+lu+S5tUZOApuDDDgGd+YP2SQXES0nXWVsmSxOq4
	 jK7p/0BTvlQNQGj4mgehRzu7CNaDvCn/ZaV3qvKeYT5imFrc9sm4dIc2RpDyNt1xyLLYr
	 XQ3wqL5JAETN0sQ1CzZpHz/UwgFP4T6BuDYJEKqSF8hAuzHAyyBQ542PG9qpjFu1ycEQk
	 kNIQHjR6/FSajQ5XxdSNirEXAJKaiSVmZepYh77PYH+e6rSoqr+yQbL7Gp7pQdPVXKMJR
	 xwleo/I7W7jVy59oI0Z83m85DXtzdAFCHVdbG+Sqa7nMp3VTf3ZoqB/kcrKQDlnjAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=iLZ16PHK;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05F606A31B;
	Mon, 19 Oct 2026 22:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B05F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=iLZ16PHK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=2vIHfmH9PqQoENTr1ZAdbd1GcxgaoRPWjUm3ZBNsSks=; b=iLZ16PHKq46ADjPnJnMN7mnQJ4
	vDXohIpLz+a/oL8cF7KTuk3vIrqpDsP/wGnIAJ6tCgdjqD2SVzdTAWUWunGWrZrSZfv8AXAQA0kJ4
	Etn5AI0etjT+EC9ExguKQeG0AN6B7ZUc1J3YR8ga9qSauv9eWWCMT5tWrPP4LnnSVInl3ixjlk6la
	1nAJt7oY3mS477Y5TxrWzCfC4sk93Dxu/hAIvQvmkyUpMbzk+wKZO1GrUSCjr1JuqtIfw1qWYgWhE
	O176mNY/VZP8xGLibFuEMKAYXi7CF7Dad0Ln8E7/M2HvJGHX6DFJvz+a8EyeFWsA+BNHt33DcX864
	9/dB1Hzw==;
Received: from [177.189.74.83] (helo=[192.168.15.93])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xIvU4-003vDb-OM; Tue, 20 Oct 2026 00:05:32 +0200
Message-ID: <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
Date: Mon, 19 Oct 2026 19:05:21 -0300
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
 Dave Young <ruirui.yang@linux.dev>, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Pratyush Yadav <pratyush@kernel.org>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Stephen Brennan <stephen.s.brennan@oracle.com>,
 Michael Kelley <mhklinux@outlook.com>, Ian Forbes <ian.forbes@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2026 14:55, Zack Rusin wrote:
> Selected crash callbacks should not require running every panic notifier
> before kdump. Add a separate atomic chain with an at-most-once dispatch
> helper, and invoke it before panic reaches the kmsg dumpers.
> 
> The helper permits another call from the crash path without repeating
> callbacks or recursing into them. Document that callbacks may run in NMI
> context, with other CPUs running and the kexec lock held.
> 
> Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: separate pre-kdump chain, with a set-once dispatch guard.
> 
>  include/linux/panic_notifier.h |  3 +++
>  kernel/panic.c                 | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> index 41e32483d7a7..3ad390764a41 100644
> --- a/include/linux/panic_notifier.h
> +++ b/include/linux/panic_notifier.h
> @@ -6,6 +6,9 @@
>  #include <linux/types.h>
>  
>  extern struct atomic_notifier_head panic_notifier_list;
> +extern struct atomic_notifier_head panic_pre_kdump_list;
> +
> +void panic_notify_pre_kdump(char *msg);
>  
>  extern bool crash_kexec_post_notifiers;
>  
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa..d78e90abb192 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
>  
>  EXPORT_SYMBOL(panic_notifier_list);
>  
> +struct atomic_notifier_head panic_pre_kdump_list =
> +	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
> +EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
> +
>  static void panic_print_deprecated(void)
>  {
>  	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> @@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>  		crash_smp_send_stop();
>  }
>  
> +/**
> + * panic_notify_pre_kdump - invoke selected callbacks before kdump
> + * @msg: Panic message, or NULL for direct crash-kexec entry
> + *
> + * Dispatch at most once per boot, including recursive entry. Callbacks run
> + * with interrupts disabled, possibly in NMI context, before other CPUs have
> + * necessarily stopped. The kexec lock may be held. They must not sleep,
> + * allocate, wait for other CPUs, or call into kexec management operations.
> + * The message is read-only and may only be used during the callback.
> + */
> +void panic_notify_pre_kdump(char *msg)
> +{
> +	static atomic_t started = ATOMIC_INIT(0);
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	if (!atomic_xchg(&started, 1))
> +		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
> +	local_irq_restore(flags);
> +}
> +
>  /**
>   * vpanic - halt the system
>   * @fmt: The text string to print
> @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
>  
>  	sys_info(panic_print);
>  
> +	panic_notify_pre_kdump(buf);
>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>  
>  	/*

Hi Zack, thanks for trying to improve this conundrum called panic
notifiers heh

I confess at first sight I got a bit confused, and only after reading
patch 1 and 2 twice, things made sense to me: you're hooking
__crash_kexec() directly!

So, in my head, 2 things that would make sense upfront: merge patches #1
and #2, and comment a bit about it in the code.


But more than this, IIUC (and please correct me if I'm wrong): in case
__crash_kexec() is called earlier, THAT call invokes
panic_notify_pre_kdump(). Now, if that call doesn't happen (for example,
'cause crash_kexec_post_notifiers=Y), then panic_notify_pre_kdump() is
called from vpanic(), *after* the regular panic notifiers!!? Is it
intentional?

If it is, why even call it here, if __crash_exec() will be called again,
in next line, in such case of crash_kexec_post_notifiers=Y? It could be
easily done outside of `if(kexec_crash_image)` [at __crash_kexec()].

Is it really correct/expected that such "early" notifiers will end-up
being the latest notifiers if crash_kexec_post_notifiers=Y? Maybe this
is aimed at collecting also the potential extra info dumped in some
regular panic notifier?
Thanks,


Guilherme
