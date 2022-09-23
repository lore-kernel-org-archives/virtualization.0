Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3817BC6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 10:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0F41402F2;
	Fri, 23 Sep 2022 10:45:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0F41402F2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=WkBB69se
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkonGacsW_E3; Fri, 23 Sep 2022 10:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AD1A408F8;
	Fri, 23 Sep 2022 10:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AD1A408F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 212E3C0033;
	Fri, 23 Sep 2022 10:45:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3368C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9149582437
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9149582437
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de
 header.a=rsa-sha256 header.s=dkim header.b=WkBB69se
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LZr82VQweXUp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:45:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42FEF8145A
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42FEF8145A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:45:29 +0000 (UTC)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 173371EC0646;
 Fri, 23 Sep 2022 12:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1663929922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=YC6QKuFEYpH0XpfhpwGB1CuLNINrgRzZ5ir3xkeSvuM=;
 b=WkBB69seK3LQAmoCcgMvxc4T8LOtOQF+r50Tp3fx9YEEYQAlSVbgszUBjeoYyEGhxR6pW7
 qzpRRDWwvAgaP5PoumZxgODb+d+pIUPwLzU0wxIxtraqbGFSTbX4itR9eh7OAOJlatWm9l
 SrPmUepo8bZacWgektuZAyCYiB1bZQw=
Date: Fri, 23 Sep 2022 12:45:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] smp/hotplug, x86/vmware: Put offline vCPUs in halt
 instead of mwait
Message-ID: <Yy2OPR0b3pG2Ia+v@zn.tnic>
References: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
 <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org,
 Alexey Makhalov <amakhalov@vmware.com>, kvm ML <kvm@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 ganb@vmware.com, Ingo Molnar <mingo@redhat.com>, namit@vmware.com,
 ankitja@vmware.com, "H. Peter Anvin" <hpa@zytor.com>, bordoloih@vmware.com,
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

+ kvm ML and leaving the whole mail quoted in for them.

On Fri, Sep 23, 2022 at 09:05:26AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 21, 2022 at 01:44:33PM -0700, Srivatsa S. Bhat wrote:
> > From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> > 
> > VMware ESXi allows enabling a passthru mwait CPU-idle state in the
> > guest using the following VMX option:
> > 
> > monitor_control.mwait_in_guest = "TRUE"
> > 
> > This lets a vCPU in mwait to remain in guest context (instead of
> > yielding to the hypervisor via a VMEXIT), which helps speed up
> > wakeups from idle.
> > 
> > However, this runs into problems with CPU hotplug, because the Linux
> > CPU offline path prefers to put the vCPU-to-be-offlined in mwait
> > state, whenever mwait is available. As a result, since a vCPU in mwait
> > remains in guest context and does not yield to the hypervisor, an
> > offline vCPU *appears* to be 100% busy as viewed from ESXi, which
> > prevents the hypervisor from running other vCPUs or workloads on the
> > corresponding pCPU (particularly when vCPU - pCPU mappings are
> > statically defined by the user).
> 
> I would hope vCPU pinning is a mandatory thing when MWAIT passthrough it
> set?
> 
> > [ Note that such a vCPU is not
> > actually busy spinning though; it remains in mwait idle state in the
> > guest ].
> > 
> > Fix this by overriding the CPU offline play_dead() callback for VMware
> > hypervisor, by putting the CPU in halt state (which actually yields to
> > the hypervisor), even if mwait support is available.
> > 
> > Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> > ---
> 
> > +static void vmware_play_dead(void)
> > +{
> > +	play_dead_common();
> > +	tboot_shutdown(TB_SHUTDOWN_WFS);
> > +
> > +	/*
> > +	 * Put the vCPU going offline in halt instead of mwait (even
> > +	 * if mwait support is available), to make sure that the
> > +	 * offline vCPU yields to the hypervisor (which may not happen
> > +	 * with mwait, for example, if the guest's VMX is configured
> > +	 * to retain the vCPU in guest context upon mwait).
> > +	 */
> > +	hlt_play_dead();
> > +}
> >  #endif
> >  
> >  static __init int activate_jump_labels(void)
> > @@ -349,6 +365,7 @@ static void __init vmware_paravirt_ops_setup(void)
> >  #ifdef CONFIG_SMP
> >  		smp_ops.smp_prepare_boot_cpu =
> >  			vmware_smp_prepare_boot_cpu;
> > +		smp_ops.play_dead = vmware_play_dead;
> >  		if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> >  					      "x86/vmware:online",
> >  					      vmware_cpu_online,
> 
> No real objection here; but would not something like the below fix the
> problem more generally? I'm thinking MWAIT passthrough for *any*
> hypervisor doesn't want play_dead to use it.
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index f24227bc3220..166cb3aaca8a 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1759,6 +1759,8 @@ static inline void mwait_play_dead(void)
>  		return;
>  	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
>  		return;
> +	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return;
>  	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
>  		return;

Yeah, it would be nice if we could get a consensus here from all
relevant HVs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
