Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0390CC6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 07:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A399405A5;
	Fri, 23 Sep 2022 07:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A399405A5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=X36Z/ZtD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phBsJC2sF7G1; Fri, 23 Sep 2022 07:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC7A4400FB;
	Fri, 23 Sep 2022 07:05:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC7A4400FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B0F2C0033;
	Fri, 23 Sep 2022 07:05:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7325C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1BAF83E1A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1BAF83E1A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=X36Z/ZtD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWi3VxHmI07a
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:05:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5C0E83224
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5C0E83224
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fQbe8Qt2OMSbhVmXxMJpTQEENy8N/rtwxDABlBmr4k8=; b=X36Z/ZtDiwDwkEjDB+qxcAOJoT
 eiHFgnPY3GMMUQCiNiVKslJaWjzlZic9Yhtq9vqdwi6zCnhta16P+1TRke+E85V6cMDwLB4WT8jge
 0Np3N/gxq7eeLtzIQ3u6ylXccRBAwGYDJDxG7kkUB6QzpkCSYKhWN9d+YAbF/xf0Lois+QoJ/c919
 RVv5KLjPfvTvjuGyKr6Jg5Ny188keAKDhHkkUva1odzSIp1HxDpMpNOlmxGBReS2NiP97d4vCkpn6
 KiXqzp+dqFjB0NLyC7ZeLmwOJ41ktT699EzB6rORGycet+/Lmc6sdKcs2JBfcIEF95IYwN8koWc9A
 5VMCUGcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1obckY-00F9ug-VC; Fri, 23 Sep 2022 07:05:27 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 497B7300074;
 Fri, 23 Sep 2022 09:05:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 2B8ED2BC39437; Fri, 23 Sep 2022 09:05:26 +0200 (CEST)
Date: Fri, 23 Sep 2022 09:05:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] smp/hotplug, x86/vmware: Put offline vCPUs in halt
 instead of mwait
Message-ID: <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net>
References: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
Cc: Juergen Gross <jgross@suse.com>, namit@vmware.com, x86@kernel.org,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 ganb@vmware.com, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, ankitja@vmware.com,
 "H. Peter Anvin" <hpa@zytor.com>, bordoloih@vmware.com,
 Thomas Gleixner <tglx@linutronix.de>, sturlapati@vmware.com
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

On Thu, Jul 21, 2022 at 01:44:33PM -0700, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> 
> VMware ESXi allows enabling a passthru mwait CPU-idle state in the
> guest using the following VMX option:
> 
> monitor_control.mwait_in_guest = "TRUE"
> 
> This lets a vCPU in mwait to remain in guest context (instead of
> yielding to the hypervisor via a VMEXIT), which helps speed up
> wakeups from idle.
> 
> However, this runs into problems with CPU hotplug, because the Linux
> CPU offline path prefers to put the vCPU-to-be-offlined in mwait
> state, whenever mwait is available. As a result, since a vCPU in mwait
> remains in guest context and does not yield to the hypervisor, an
> offline vCPU *appears* to be 100% busy as viewed from ESXi, which
> prevents the hypervisor from running other vCPUs or workloads on the
> corresponding pCPU (particularly when vCPU - pCPU mappings are
> statically defined by the user).

I would hope vCPU pinning is a mandatory thing when MWAIT passthrough it
set?

> [ Note that such a vCPU is not
> actually busy spinning though; it remains in mwait idle state in the
> guest ].
> 
> Fix this by overriding the CPU offline play_dead() callback for VMware
> hypervisor, by putting the CPU in halt state (which actually yields to
> the hypervisor), even if mwait support is available.
> 
> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> ---

> +static void vmware_play_dead(void)
> +{
> +	play_dead_common();
> +	tboot_shutdown(TB_SHUTDOWN_WFS);
> +
> +	/*
> +	 * Put the vCPU going offline in halt instead of mwait (even
> +	 * if mwait support is available), to make sure that the
> +	 * offline vCPU yields to the hypervisor (which may not happen
> +	 * with mwait, for example, if the guest's VMX is configured
> +	 * to retain the vCPU in guest context upon mwait).
> +	 */
> +	hlt_play_dead();
> +}
>  #endif
>  
>  static __init int activate_jump_labels(void)
> @@ -349,6 +365,7 @@ static void __init vmware_paravirt_ops_setup(void)
>  #ifdef CONFIG_SMP
>  		smp_ops.smp_prepare_boot_cpu =
>  			vmware_smp_prepare_boot_cpu;
> +		smp_ops.play_dead = vmware_play_dead;
>  		if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>  					      "x86/vmware:online",
>  					      vmware_cpu_online,

No real objection here; but would not something like the below fix the
problem more generally? I'm thinking MWAIT passthrough for *any*
hypervisor doesn't want play_dead to use it.

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f24227bc3220..166cb3aaca8a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1759,6 +1759,8 @@ static inline void mwait_play_dead(void)
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
+	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
 	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
 		return;
 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
