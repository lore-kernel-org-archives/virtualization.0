Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F219DCDB484
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 01:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88DA1831A7;
	Thu, 19 Oct 2023 01:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88DA1831A7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=OzA36oun
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yvFiH0ubr_z; Thu, 19 Oct 2023 01:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89B41831F2;
	Thu, 19 Oct 2023 01:20:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89B41831F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF700C0DD2;
	Thu, 19 Oct 2023 01:20:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48394C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2434D6F7B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:20:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2434D6F7B0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=OzA36oun
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PajnK0xmLCIW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:20:37 +0000 (UTC)
X-Greylist: delayed 644 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 19 Oct 2023 01:20:36 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D01666F521
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D01666F521
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1697677783;
 bh=sP/cRV4QUGjTkFLtwW0tXTJRApQEfvV0GlECJSheTZ0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OzA36ounnOpYrxRilcLyJmhKG74vt5b0xbblSnpZ38SXwXoRD+pqu81YjaU92OqiS
 K12o3y54lx6qpe39yAAqNZhbD2Z3NftbZ3odfdwqgqNJ5pR9T+1d1SWyxv5ED4xLsP
 8I7wuTWDCuUgDsuuejG9J4zE5bmBSREmXITfJ3eXHU8WKIgnmZAfrtpEVwlb5yQZV9
 WNCMgxPvXT0laLMYP1cAF0XEPYLg5zqjCDWUsTrngP8pkzVgbM4HKfbkvRfDCowcFK
 4C9L3k65lqlVMLkdmGCI0ViV1t4nAyuFMJNGHHeRywl+mYpfXEyyQkSWfovcLLvz3i
 nY7Es8JiD1N/w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9qPf4HMkz4wcN;
 Thu, 19 Oct 2023 12:09:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/paravirt: Improve vcpu_is_preempted
In-Reply-To: <20231018155838.2332822-1-srikar@linux.vnet.ibm.com>
References: <20231018155838.2332822-1-srikar@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2023 12:09:38 +1100
Message-ID: <877cnj76zx.fsf@mail.lhotse>
MIME-Version: 1.0
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 virtualization@lists.linux-foundation.org, Ajay Kaher <akaher@vmware.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

Hi Srikar,

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> PowerVM Hypervisor dispatches on a whole core basis. In a shared LPAR, a
> CPU from a core that is CEDED or preempted may have a larger latency. In
> such a scenario, its preferable to choose a different CPU to run.
>
> If one of the CPUs in the core is active, i.e neither CEDED nor
> preempted, then consider this CPU as not preempted.
>
> Also if any of the CPUs in the core has yielded but OS has not requested
> CEDE or CONFER, then consider this CPU to be preempted.

I think the change is OK, but the change log and comments are slightly
confusing IMHO.

In several places you use "this CPU", but that usually means "the CPU
the code is currently executing on".

I think it would be clearer if you used eg. "target CPU" or something to
make it clear that you're not talking about the currently executing CPU.

cheers

> Correct detection of preempted CPUs is important for detecting idle
> CPUs/cores in task scheduler.
>
> Changelog:
> v1 -> v2: Handle lppaca_of(cpu) in !PPC_SPLPAR case.
> v1: https://lore.kernel.org/r/20231009051740.17683-1-srikar%40linux.vnet.ibm.com
> 1. Fixed some compilation issues reported by kernelbot
> a. https://lore.kernel.org/oe-kbuild-all/202310102341.K0sgoqQL-lkp@intel.com/
> b.  https://lore.kernel.org/oe-kbuild-all/202310091636.lElmJkYV-lkp@intel.com/
> 2. Resolved comments from Shrikanth

That change log should appear below the break "---".

> Tested-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/paravirt.h | 42 ++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
> index e08513d73119..0372b0093f72 100644
> --- a/arch/powerpc/include/asm/paravirt.h
> +++ b/arch/powerpc/include/asm/paravirt.h
> @@ -71,6 +71,11 @@ static inline void yield_to_any(void)
>  {
>  	plpar_hcall_norets_notrace(H_CONFER, -1, 0);
>  }
> +
> +static inline bool is_vcpu_idle(int vcpu)
> +{
> +	return lppaca_of(vcpu).idle;
> +}
>  #else
>  static inline bool is_shared_processor(void)
>  {
> @@ -100,6 +105,10 @@ static inline void prod_cpu(int cpu)
>  	___bad_prod_cpu(); /* This would be a bug */
>  }
>  
> +static inline bool is_vcpu_idle(int vcpu)
> +{
> +	return false;
> +}
>  #endif
>  
>  #define vcpu_is_preempted vcpu_is_preempted
> @@ -121,9 +130,19 @@ static inline bool vcpu_is_preempted(int cpu)
>  	if (!is_shared_processor())
>  		return false;
>  
> +	if (!(yield_count_of(cpu) & 1))
> +		return false;

Would be nice for that to have a short comment too.

> +
> +	/*
> +	 * If CPU has yielded to Hypervisor but OS has not requested idle
> +	 * then this CPU is definitely preempted.

eg. If the target CPU has yielded to the Hypervisor, but the OS has not
requested idle then the target CPU has definitely been preempted.

> +	 */
> +	if (!is_vcpu_idle(cpu))
> +		return true;
> +
>  #ifdef CONFIG_PPC_SPLPAR
>  	if (!is_kvm_guest()) {
> -		int first_cpu;
> +		int first_cpu, i;
>  
>  		/*
>  		 * The result of vcpu_is_preempted() is used in a
> @@ -149,11 +168,28 @@ static inline bool vcpu_is_preempted(int cpu)
>  		 */
>  		if (cpu_first_thread_sibling(cpu) == first_cpu)
>  			return false;
> +
> +		/*
> +		 * If any of the threads of this core is not preempted or
> +		 * ceded, then consider this CPU to be non-preempted
> +		 */

eg. If any of the threads of the target CPU's core are not preempted or
ceded, then consider that the target CPU is also not preempted.

> +		first_cpu = cpu_first_thread_sibling(cpu);
> +		for (i = first_cpu; i < first_cpu + threads_per_core; i++) {
> +			if (i == cpu)
> +				continue;
> +			if (!(yield_count_of(i) & 1))
> +				return false;
> +			if (!is_vcpu_idle(i))
> +				return true;
> +		}
>  	}
>  #endif
>  
> -	if (yield_count_of(cpu) & 1)
> -		return true;
> +	/*
> +	 * None of the threads in this core are running but none of
> +	 * them were preempted too. Hence assume the thread to be
> +	 * non-preempted.
> +	 */
>  	return false;
>  }
>  
>
> base-commit: eddc90ea2af5933249ea1a78119f2c8ef8d07156
> -- 
> 2.31.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
