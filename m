Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ED0C07E9D
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 22:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B3EA60B12;
	Mon, 26 Sep 2022 22:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B3EA60B12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v5JqFME5RK6B; Mon, 26 Sep 2022 22:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82BC760A81;
	Mon, 26 Sep 2022 22:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82BC760A81
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 591E6C0032;
	Mon, 26 Sep 2022 22:41:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C08A9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 22:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85F3941733
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 22:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85F3941733
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bXdmgqrYXvjn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 22:41:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 599E541729
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 599E541729
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 22:41:35 +0000 (UTC)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140]
 helo=srivatsab-a02.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1ocwmo-009QTb-AH;
 Mon, 26 Sep 2022 18:41:14 -0400
Subject: Re: [PATCH] smp/hotplug, x86/vmware: Put offline vCPUs in halt
 instead of mwait
To: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
References: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
 <Yy1attxrEMDmCFBa@hirez.programming.kicks-ass.net> <Yy2OPR0b3pG2Ia+v@zn.tnic>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <108b8d67-11e6-d888-437a-4f04d0c04c66@csail.mit.edu>
Date: Mon, 26 Sep 2022 15:41:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Yy2OPR0b3pG2Ia+v@zn.tnic>
Content-Language: en-US
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

On 9/23/22 3:45 AM, Borislav Petkov wrote:
> + kvm ML and leaving the whole mail quoted in for them.
> 
> On Fri, Sep 23, 2022 at 09:05:26AM +0200, Peter Zijlstra wrote:
>> On Thu, Jul 21, 2022 at 01:44:33PM -0700, Srivatsa S. Bhat wrote:
>>> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
>>>
>>> VMware ESXi allows enabling a passthru mwait CPU-idle state in the
>>> guest using the following VMX option:
>>>
>>> monitor_control.mwait_in_guest = "TRUE"
>>>
>>> This lets a vCPU in mwait to remain in guest context (instead of
>>> yielding to the hypervisor via a VMEXIT), which helps speed up
>>> wakeups from idle.
>>>
>>> However, this runs into problems with CPU hotplug, because the Linux
>>> CPU offline path prefers to put the vCPU-to-be-offlined in mwait
>>> state, whenever mwait is available. As a result, since a vCPU in mwait
>>> remains in guest context and does not yield to the hypervisor, an
>>> offline vCPU *appears* to be 100% busy as viewed from ESXi, which
>>> prevents the hypervisor from running other vCPUs or workloads on the
>>> corresponding pCPU (particularly when vCPU - pCPU mappings are
>>> statically defined by the user).
>>
>> I would hope vCPU pinning is a mandatory thing when MWAIT passthrough it
>> set?
>>
>>> [ Note that such a vCPU is not
>>> actually busy spinning though; it remains in mwait idle state in the
>>> guest ].
>>>
>>> Fix this by overriding the CPU offline play_dead() callback for VMware
>>> hypervisor, by putting the CPU in halt state (which actually yields to
>>> the hypervisor), even if mwait support is available.
>>>
>>> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
>>> ---
>>
>>> +static void vmware_play_dead(void)
>>> +{
>>> +	play_dead_common();
>>> +	tboot_shutdown(TB_SHUTDOWN_WFS);
>>> +
>>> +	/*
>>> +	 * Put the vCPU going offline in halt instead of mwait (even
>>> +	 * if mwait support is available), to make sure that the
>>> +	 * offline vCPU yields to the hypervisor (which may not happen
>>> +	 * with mwait, for example, if the guest's VMX is configured
>>> +	 * to retain the vCPU in guest context upon mwait).
>>> +	 */
>>> +	hlt_play_dead();
>>> +}
>>>  #endif
>>>  
>>>  static __init int activate_jump_labels(void)
>>> @@ -349,6 +365,7 @@ static void __init vmware_paravirt_ops_setup(void)
>>>  #ifdef CONFIG_SMP
>>>  		smp_ops.smp_prepare_boot_cpu =
>>>  			vmware_smp_prepare_boot_cpu;
>>> +		smp_ops.play_dead = vmware_play_dead;
>>>  		if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>>>  					      "x86/vmware:online",
>>>  					      vmware_cpu_online,
>>
>> No real objection here; but would not something like the below fix the
>> problem more generally? I'm thinking MWAIT passthrough for *any*
>> hypervisor doesn't want play_dead to use it.
>>

That would be better indeed, thank you!

>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index f24227bc3220..166cb3aaca8a 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1759,6 +1759,8 @@ static inline void mwait_play_dead(void)
>>  		return;
>>  	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
>>  		return;
>> +	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
>> +		return;
>>  	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
>>  		return;
> 
> Yeah, it would be nice if we could get a consensus here from all
> relevant HVs.
> 

I'll send out a v2 after trying out these changes.

Thank you!

Regards,
Srivatsa
VMware Photon OS
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
