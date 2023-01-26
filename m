Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27362C54E94
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 02:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 812FD40A5C;
	Thu, 26 Jan 2023 02:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 812FD40A5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOaRCW9XPSHh; Thu, 26 Jan 2023 02:14:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C3BC240119;
	Thu, 26 Jan 2023 02:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3BC240119
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D5FDC0032;
	Thu, 26 Jan 2023 02:14:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78404C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 02:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CBD04046A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 02:14:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CBD04046A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5VieT9-3p7A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 02:14:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2484F40119
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2484F40119
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 02:14:11 +0000 (UTC)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140]
 helo=srivatsab3MD6R.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1pKrm9-00HW0d-KX;
 Wed, 25 Jan 2023 21:14:05 -0500
To: Sean Christopherson <seanjc@google.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20230116060134.80259-1-srivatsa@csail.mit.edu>
 <20230116155526.05d37ff9@imammedo.users.ipa.redhat.com> <87bkmui5z4.ffs@tglx>
 <ecb9a22e-fd6e-67f0-d916-ad16033fc13c@csail.mit.edu>
 <20230120163734.63e62444@imammedo.users.ipa.redhat.com>
 <Y8rfBBBicRMk+Hut@google.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v2] x86/hotplug: Do not put offline vCPUs in mwait idle
 state
Message-ID: <c3304b18-533b-4845-0ca8-b2680bfd715d@csail.mit.edu>
Date: Wed, 25 Jan 2023 18:14:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y8rfBBBicRMk+Hut@google.com>
Content-Language: en-US
Cc: x86@kernel.org, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, ganb@vmware.com, ankitja@vmware.com,
 namit@vmware.com, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, bordoloih@vmware.com,
 xen-devel@lists.xenproject.org, Wyes Karny <wyes.karny@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, keerthanak@vmware.com,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>, amakhalov@vmware.com,
 linux-kernel@vger.kernel.org, Lewis Caroll <lewis.carroll@amd.com>,
 blamoreaux@vmware.com
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


Hi Igor and Sean,

On 1/20/23 10:35 AM, Sean Christopherson wrote:
> On Fri, Jan 20, 2023, Igor Mammedov wrote:
>> On Fri, 20 Jan 2023 05:55:11 -0800
>> "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
>>
>>> Hi Igor and Thomas,
>>>
>>> Thank you for your review!
>>>
>>> On 1/19/23 1:12 PM, Thomas Gleixner wrote:
>>>> On Mon, Jan 16 2023 at 15:55, Igor Mammedov wrote:  
>>>>> "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:  
>>>>>> Fix this by preventing the use of mwait idle state in the vCPU offline
>>>>>> play_dead() path for any hypervisor, even if mwait support is
>>>>>> available.  
>>>>>
>>>>> if mwait is enabled, it's very likely guest to have cpuidle
>>>>> enabled and using the same mwait as well. So exiting early from
>>>>>  mwait_play_dead(), might just punt workflow down:
>>>>>   native_play_dead()
>>>>>         ...
>>>>>         mwait_play_dead();
>>>>>         if (cpuidle_play_dead())   <- possible mwait here                                              
>>>>>                 hlt_play_dead(); 
>>>>>
>>>>> and it will end up in mwait again and only if that fails
>>>>> it will go HLT route and maybe transition to VMM.  
>>>>
>>>> Good point.
>>>>   
>>>>> Instead of workaround on guest side,
>>>>> shouldn't hypervisor force VMEXIT on being uplugged vCPU when it's
>>>>> actually hot-unplugging vCPU? (ex: QEMU kicks vCPU out from guest
>>>>> context when it is removing vCPU, among other things)  
>>>>
>>>> For a pure guest side CPU unplug operation:
>>>>
>>>>     guest$ echo 0 >/sys/devices/system/cpu/cpu$N/online
>>>>
>>>> the hypervisor is not involved at all. The vCPU is not removed in that
>>>> case.
>>>>   
>>>
>>> Agreed, and this is indeed the scenario I was targeting with this patch,
>>> as opposed to vCPU removal from the host side. I'll add this clarification
>>> to the commit message.
> 
> Forcing HLT doesn't solve anything, it's perfectly legal to passthrough HLT.  I
> guarantee there are use cases that passthrough HLT but _not_ MONITOR/MWAIT, and
> that passthrough all of them.
> 
>> commit message explicitly said:
>> "which prevents the hypervisor from running other vCPUs or workloads on the
>> corresponding pCPU."
>>
>> and that implies unplug on hypervisor side as well.
>> Why? That's because when hypervisor exposes mwait to guest, it has to reserve/pin
>> a pCPU for each of present vCPUs. And you can safely run other VMs/workloads
>> on that pCPU only after it's not possible for it to be reused by VM where
>> it was used originally.
> 
> Pinning isn't strictly required from a safety perspective.  The latency of context
> switching may suffer due to wake times, but preempting a vCPU that it's C1 (or
> deeper) won't cause functional problems.   Passing through an entire socket
> (or whatever scope triggers extra fun) might be a different story, but pinning
> isn't strictly required.
> 
> That said, I 100% agree that this is expected behavior and not a bug.  Letting the
> guest execute MWAIT or HLT means the host won't have perfect visibility into guest
> activity state.
> 
> Oversubscribing a pCPU and exposing MWAIT and/or HLT to vCPUs is generally not done
> precisely because the guest will always appear busy without extra effort on the
> host.  E.g. KVM requires an explicit opt-in from userspace to expose MWAIT and/or
> HLT.
> 
> If someone really wants to effeciently oversubscribe pCPUs and passthrough MWAIT,
> then their best option is probably to have a paravirt interface so that the guest
> can tell the host its offlining a vCPU.  Barring that the host could inspect the
> guest when preempting a vCPU to try and guesstimate how much work the vCPU is
> actually doing in order to make better scheduling decisions.
> 
>> Now consider following worst (and most likely) case without unplug
>> on hypervisor side:
>>
>>  1. vm1mwait: pin pCPU2 to vCPU2
>>  2. vm1mwait: guest$ echo 0 >/sys/devices/system/cpu/cpu2/online
>>         -> HLT -> VMEXIT
>>  --
>>  3. vm2mwait: pin pCPU2 to vCPUx and start VM
>>  4. vm2mwait: guest OS onlines Vcpu and starts using it incl.
>>        going into idle=>mwait state
>>  --
>>  5. vm1mwait: it still thinks that vCPU is present it can rightfully do:
>>        guest$ echo 1 >/sys/devices/system/cpu/cpu2/online
>>  --              
>>  6.1 best case vm1mwait online fails after timeout
>>  6.2 worse case: vm2mwait does VMEXIT on vCPUx around time-frame when
>>      vm1mwait onlines vCPU2, the online may succeed and then vm2mwait's
>>      vCPUx will be stuck (possibly indefinitely) until for some reason
>>      VMEXIT happens on vm1mwait's vCPU2 _and_ host decides to schedule
>>      vCPUx on pCPU2 which would make vm1mwait stuck on vCPU2.
>> So either way it's expected behavior.
>>
>> And if there is no intention to unplug vCPU on hypervisor side,
>> then VMEXIT on play_dead is not really necessary (mwait is better
>> then HLT), since hypervisor can't safely reuse pCPU elsewhere and
>> VCPU goes into deep sleep within guest context.
>>
>> PS:
>> The only case where making HLT/VMEXIT on play_dead might work out,
>> would be if new workload weren't pinned to the same pCPU nor
>> used mwait (i.e. host can migrate it elsewhere and schedule
>> vCPU2 back on pCPU2).


That makes sense. Thank you both for the detailed explanation!
Let's drop this patch.

Regards,
Srivatsa
VMware Photon OS
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
