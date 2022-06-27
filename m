Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5570C43334
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 07:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00D5A6104C;
	Mon, 27 Jun 2022 07:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00D5A6104C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=cSfth6hd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4QmwBIswQ8P0; Mon, 27 Jun 2022 07:50:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 531756105A;
	Mon, 27 Jun 2022 07:50:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 531756105A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A95BC0039;
	Mon, 27 Jun 2022 07:50:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74257C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38DE2828A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38DE2828A5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=cSfth6hd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z9mjpuIjdoqu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 815EE8291A
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 815EE8291A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=is7Eu+0H7HDxhCl/shZXvpRh5hl4o3ATrtA6ia1L7MM=; b=cSfth6hdEoIZb/zjDZH/w6rGSn
 R76PdgIKZ780DCSfYzkJXp5IBZDMxb52+uXGZiXBQjbKo5KL/rvd9a3nSyGT1rZNPRxLIZMgkjVQp
 rowAaHtUyn4/S/pZYfBZ6y/fHhNtO2Uv9Hac8y7aycjck1LMAU7YqAbvoAN4KeoNY54Hife7bxzjt
 bHkmaLXfjmW8vCSJqvr2DK+vEbtTLzCqOyiom77U+hkUBs/gN27FZ4vbBQcNZrBBXnXP+LPXYqBt1
 HyEpIHQ24fVwDJ1nqwfbt24kSsqwElik2fssi8berbCwF+1T2fHgjvz/Y537eLPmDTe1/6q3usZdq
 ytKmRQDQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o5jVF-00BAP8-KF; Mon, 27 Jun 2022 07:49:49 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED45A300091;
 Mon, 27 Jun 2022 09:49:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id AFAE429BBBBC2; Mon, 27 Jun 2022 09:49:46 +0200 (CEST)
Date: Mon, 27 Jun 2022 09:49:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guo Hui <guohui@uniontech.com>
Subject: Re: [PATCH v2] x86/paravirt: useless assignment instructions cause
 Unixbench full core   performance degradation
Message-ID: <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
References: <f6b68466-968c-4a91-655a-23970280a072@redhat.com>
 <20220627021350.25714-1-guohui@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220627021350.25714-1-guohui@uniontech.com>
Cc: jgross@suse.com, x86@kernel.org, hpa@zytor.com, pv-drivers@vmware.com,
 boqun.feng@gmail.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, amakhalov@vmware.com, longman@redhat.com,
 tglx@linutronix.de, will@kernel.org, wangxiaohua@uniontech.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jun 27, 2022 at 10:13:50AM +0800, Guo Hui wrote:
> The instructions assigned to the vcpu_is_preempted function parameter
> in the X86 architecture physical machine are redundant instructions,
> causing the multi-core performance of Unixbench to drop by about 4% to 5%.
> The C function is as follows:
> static bool vcpu_is_preempted(long vcpu);
> 
> The parameter 'vcpu' in the function osq_lock
> that calls the function vcpu_is_preempted is assigned as follows:
> 
> The C code is in the function node_cpu:
> cpu = node->cpu - 1;
> 
> The instructions corresponding to the C code are:
> mov 0x14(%rax),%edi
> sub $0x1,%edi
> 
> The above instructions are unnecessary
> in the X86 Native operating environment,
> causing high cache-misses and degrading performance.

The above basically says that argument setup is not patched out and
causes significant pain due to a cache-miss.

> Signed-off-by: Guo Hui <guohui@uniontech.com>
> ---
>  arch/x86/kernel/paravirt-spinlocks.c | 4 ++++
>  kernel/locking/osq_lock.c            | 9 ++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
> index 9e1ea99ad..7a55f8407 100644
> --- a/arch/x86/kernel/paravirt-spinlocks.c
> +++ b/arch/x86/kernel/paravirt-spinlocks.c
> @@ -33,6 +33,8 @@ bool pv_is_native_vcpu_is_preempted(void)
>  		__raw_callee_save___native_vcpu_is_preempted;
>  }
>  
> +DECLARE_STATIC_KEY_FALSE(preemted_key);
> +
>  void __init paravirt_set_cap(void)
>  {
>  	if (!pv_is_native_spin_unlock())
> @@ -40,4 +42,6 @@ void __init paravirt_set_cap(void)
>  
>  	if (!pv_is_native_vcpu_is_preempted())
>  		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
> +	else
> +		static_branch_enable(&preemted_key);
>  }

At least for x86 it makes sense to have the static_key default the other
way around. That is, enable it along with vcpu_is_preempted().

> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d5610ad52..a8798e701 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -22,9 +22,16 @@ static inline int encode_cpu(int cpu_nr)
>  	return cpu_nr + 1;
>  }
>  
> +DEFINE_STATIC_KEY_FALSE(preemted_key);
> +
>  static inline int node_cpu(struct optimistic_spin_node *node)
>  {
> -	return node->cpu - 1;
> +	int cpu = 0;
> +
> +	if (!static_branch_unlikely(&preemted_key))
> +		cpu = node->cpu - 1;
> +
> +	return cpu;
>  }

Would not something like:

static inline bool
vcpu_is_preempted_node(struct optimistic_spin_node *node)
{
	if (!static_branch_unlikely(&vcpu_has_preemption))
		return false;

	return vcpu_is_preempted(node_cpu(node->prev));
}

And then use that like:

	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
				  vcpu_is_preempted_node(node)))

Not generate better code still?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
