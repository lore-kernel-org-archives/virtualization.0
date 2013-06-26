From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Wed, 26 Jun 2013 23:24:33 +0530
Message-ID: <51CB2AD9.5060508__17614.6273421638$1372269067$gmane$org@linux.vnet.ibm.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<1372171802.3804.30.camel@oc2024037011.ibm.com>
	<51CAAA26.4090204@linux.vnet.ibm.com>
	<20130626113744.GA6300@hawk.usersys.redhat.com>
	<20130626125240.GY18508@redhat.com>
	<51CAEF45.3010203@linux.vnet.ibm.com>
	<20130626161130.GB18152@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130626161130.GB18152@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, Andrew Jones <drjones@redhat.com>, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/26/2013 09:41 PM, Gleb Natapov wrote:
> On Wed, Jun 26, 2013 at 07:10:21PM +0530, Raghavendra K T wrote:
>> On 06/26/2013 06:22 PM, Gleb Natapov wrote:
>>> On Wed, Jun 26, 2013 at 01:37:45PM +0200, Andrew Jones wrote:
>>>> On Wed, Jun 26, 2013 at 02:15:26PM +0530, Raghavendra K T wrote:
>>>>> On 06/25/2013 08:20 PM, Andrew Theurer wrote:
>>>>>> On Sun, 2013-06-02 at 00:51 +0530, Raghavendra K T wrote:
>>>>>>> This series replaces the existing paravirtualized spinlock mechanism
>>>>>>> with a paravirtualized ticketlock mechanism. The series provides
>>>>>>> implementation for both Xen and KVM.
>>>>>>>
>>>>>>> Changes in V9:
>>>>>>> - Changed spin_threshold to 32k to avoid excess halt exits that are
>>>>>>>     causing undercommit degradation (after PLE handler improvement).
>>>>>>> - Added  kvm_irq_delivery_to_apic (suggested by Gleb)
>>>>>>> - Optimized halt exit path to use PLE handler
>>>>>>>
>>>>>>> V8 of PVspinlock was posted last year. After Avi's suggestions to look
>>>>>>> at PLE handler's improvements, various optimizations in PLE handling
>>>>>>> have been tried.
>>>>>>
>>>>>> Sorry for not posting this sooner.  I have tested the v9 pv-ticketlock
>>>>>> patches in 1x and 2x over-commit with 10-vcpu and 20-vcpu VMs.  I have
>>>>>> tested these patches with and without PLE, as PLE is still not scalable
>>>>>> with large VMs.
>>>>>>
>>>>>
>>>>> Hi Andrew,
>>>>>
>>>>> Thanks for testing.
>>>>>
>>>>>> System: x3850X5, 40 cores, 80 threads
>>>>>>
>>>>>>
>>>>>> 1x over-commit with 10-vCPU VMs (8 VMs) all running dbench:
>>>>>> ----------------------------------------------------------
>>>>>> 						Total
>>>>>> Configuration				Throughput(MB/s)	Notes
>>>>>>
>>>>>> 3.10-default-ple_on			22945			5% CPU in host kernel, 2% spin_lock in guests
>>>>>> 3.10-default-ple_off			23184			5% CPU in host kernel, 2% spin_lock in guests
>>>>>> 3.10-pvticket-ple_on			22895			5% CPU in host kernel, 2% spin_lock in guests
>>>>>> 3.10-pvticket-ple_off			23051			5% CPU in host kernel, 2% spin_lock in guests
>>>>>> [all 1x results look good here]
>>>>>
>>>>> Yes. The 1x results look too close
>>>>>
>>>>>>
>>>>>>
>>>>>> 2x over-commit with 10-vCPU VMs (16 VMs) all running dbench:
>>>>>> -----------------------------------------------------------
>>>>>> 						Total
>>>>>> Configuration				Throughput		Notes
>>>>>>
>>>>>> 3.10-default-ple_on			 6287			55% CPU  host kernel, 17% spin_lock in guests
>>>>>> 3.10-default-ple_off			 1849			2% CPU in host kernel, 95% spin_lock in guests
>>>>>> 3.10-pvticket-ple_on			 6691			50% CPU in host kernel, 15% spin_lock in guests
>>>>>> 3.10-pvticket-ple_off			16464			8% CPU in host kernel, 33% spin_lock in guests
>>>>>
>>>>> I see 6.426% improvement with ple_on
>>>>> and 161.87% improvement with ple_off. I think this is a very good sign
>>>>>   for the patches
>>>>>
>>>>>> [PLE hinders pv-ticket improvements, but even with PLE off,
>>>>>>   we still off from ideal throughput (somewhere >20000)]
>>>>>>
>>>>>
>>>>> Okay, The ideal throughput you are referring is getting around atleast
>>>>> 80% of 1x throughput for over-commit. Yes we are still far away from
>>>>> there.
>>>>>
>>>>>>
>>>>>> 1x over-commit with 20-vCPU VMs (4 VMs) all running dbench:
>>>>>> ----------------------------------------------------------
>>>>>> 						Total
>>>>>> Configuration				Throughput		Notes
>>>>>>
>>>>>> 3.10-default-ple_on			22736			6% CPU in host kernel, 3% spin_lock in guests
>>>>>> 3.10-default-ple_off			23377			5% CPU in host kernel, 3% spin_lock in guests
>>>>>> 3.10-pvticket-ple_on			22471			6% CPU in host kernel, 3% spin_lock in guests
>>>>>> 3.10-pvticket-ple_off			23445			5% CPU in host kernel, 3% spin_lock in guests
>>>>>> [1x looking fine here]
>>>>>>
>>>>>
>>>>> I see ple_off is little better here.
>>>>>
>>>>>>
>>>>>> 2x over-commit with 20-vCPU VMs (8 VMs) all running dbench:
>>>>>> ----------------------------------------------------------
>>>>>> 						Total
>>>>>> Configuration				Throughput		Notes
>>>>>>
>>>>>> 3.10-default-ple_on			 1965			70% CPU in host kernel, 34% spin_lock in guests		
>>>>>> 3.10-default-ple_off			  226			2% CPU in host kernel, 94% spin_lock in guests
>>>>>> 3.10-pvticket-ple_on			 1942			70% CPU in host kernel, 35% spin_lock in guests
>>>>>> 3.10-pvticket-ple_off			 8003			11% CPU in host kernel, 70% spin_lock in guests
>>>>>> [quite bad all around, but pv-tickets with PLE off the best so far.
>>>>>>   Still quite a bit off from ideal throughput]
>>>>>
>>>>> This is again a remarkable improvement (307%).
>>>>> This motivates me to add a patch to disable ple when pvspinlock is on.
>>>>> probably we can add a hypercall that disables ple in kvm init patch.
>>>>> but only problem I see is what if the guests are mixed.
>>>>>
>>>>>   (i.e one guest has pvspinlock support but other does not. Host
>>>>> supports pv)
>>>>
>>>> How about reintroducing the idea to create per-kvm ple_gap,ple_window
>>>> state. We were headed down that road when considering a dynamic window at
>>>> one point. Then you can just set a single guest's ple_gap to zero, which
>>>> would lead to PLE being disabled for that guest. We could also revisit
>>>> the dynamic window then.
>>>>
>>> Can be done, but lets understand why ple on is such a big problem. Is it
>>> possible that ple gap and SPIN_THRESHOLD are not tuned properly?
>>>
>>
>> The one obvious reason I see is commit awareness inside the guest. for
>> under-commit there is no necessity to do PLE, but unfortunately we do.
>>
>> atleast we return back immediately in case of potential undercommits,
>> but we still incur vmexit delay.
> But why do we? If SPIN_THRESHOLD will be short enough (or ple windows
> long enough) to not generate PLE exit we will not go into PLE handler
> at all, no?
>

Yes. you are right. dynamic ple window was an attempt to solve it.

Probelm is, reducing the SPIN_THRESHOLD is resulting in excess halt
exits in under-commits and increasing ple_window may be sometimes
counter productive as it affects other busy-wait constructs such as
flush_tlb AFAIK.
So if we could have had a dynamically changing SPIN_THRESHOLD too, that
would be nice.
