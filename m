Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF5ECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 01:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62FE1605C9;
	Fri, 23 Sep 2022 01:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62FE1605C9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oHkdqT2W-j02; Fri, 23 Sep 2022 01:58:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB181605D8;
	Fri, 23 Sep 2022 01:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB181605D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86E88C0033;
	Fri, 23 Sep 2022 01:58:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E425C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 01:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D19E40202
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 01:58:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D19E40202
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVwXXrRat6Mg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 01:58:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AE39401FB
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AE39401FB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 01:58:34 +0000 (UTC)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140]
 helo=srivatsab-a02.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1obXwy-006TNS-9J;
 Thu, 22 Sep 2022 21:57:56 -0400
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] smp/hotplug, x86/vmware: Put offline vCPUs in halt
 instead of mwait
Message-ID: <1d53fca8-5c6b-2130-2645-95330bbcf899@csail.mit.edu>
Date: Thu, 22 Sep 2022 18:57:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
Content-Language: en-US
Cc: Juergen Gross <jgross@suse.com>, namit@vmware.com, x86@kernel.org,
 Alexey Makhalov <amakhalov@vmware.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, sturlapati@vmware.com,
 keerthanak@vmware.com, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 ganb@vmware.com, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, ankitja@vmware.com,
 "H. Peter Anvin" <hpa@zytor.com>, bordoloih@vmware.com,
 Thomas Gleixner <tglx@linutronix.de>
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


Hi Boris, Thomas, Peter,

On 7/21/22 1:44 PM, Srivatsa S. Bhat wrote:
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
> statically defined by the user). [ Note that such a vCPU is not
> actually busy spinning though; it remains in mwait idle state in the
> guest ].
> 
> Fix this by overriding the CPU offline play_dead() callback for VMware
> hypervisor, by putting the CPU in halt state (which actually yields to
> the hypervisor), even if mwait support is available.
> 
> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Alexey Makhalov <amakhalov@vmware.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> ---

Could you share your thoughts on this patch when you get a chance,
please? I verified that this patch still applies cleanly on current
mainline (6.0-rc6). I'm happy to resend the patch though, if it helps.

Thank you!

Regards,
Srivatsa

> 
>  arch/x86/kernel/cpu/vmware.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..420e359ed9bb 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -27,6 +27,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/cpu.h>
>  #include <linux/reboot.h>
> +#include <linux/tboot.h>
>  #include <linux/static_call.h>
>  #include <asm/div64.h>
>  #include <asm/x86_init.h>
> @@ -312,6 +313,21 @@ static int vmware_cpu_down_prepare(unsigned int cpu)
>  	local_irq_enable();
>  	return 0;
>  }
> +
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
> 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
