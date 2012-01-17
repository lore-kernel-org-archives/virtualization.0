From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Tue, 17 Jan 2012 18:39:13 +0100
Message-ID: <1485A122-9D48-46E3-A01E-E37B5C9EC54A@suse.de>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<20120116142014.GA10155@linux.vnet.ibm.com>
	<B6E21B69-17D1-48E0-AFD4-B52075094005@suse.de>
	<4F146EA5.3010106@linux.vnet.ibm.com>
	<E9F33AFD-F051-4D68-84FF-D259FD6AD19D@suse.de>
	<4F15AF9E.9000907@linux.vnet.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F15AF9E.9000907@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org


On 17.01.2012, at 18:27, Raghavendra K T wrote:

> On 01/17/2012 12:12 AM, Alexander Graf wrote:
>> 
>> On 16.01.2012, at 19:38, Raghavendra K T wrote:
>> 
>>> On 01/16/2012 07:53 PM, Alexander Graf wrote:
>>>> 
>>>> On 16.01.2012, at 15:20, Srivatsa Vaddagiri wrote:
>>>> 
>>>>> * Alexander Graf<agraf@suse.de>   [2012-01-16 04:57:45]:
>>>>> 
>>>>>> Speaking of which - have you benchmarked performance degradation of pv ticket locks on bare metal?
>>>>> 
>>>>> You mean, run kernel on bare metal with CONFIG_PARAVIRT_SPINLOCKS
>>>>> enabled and compare how it performs with CONFIG_PARAVIRT_SPINLOCKS disabled for
>>>>> some workload(s)?
>>>> 
>>>> Yup
>>>> 
>>>>> 
>>>>> In some sense, the 1x overcommitcase results posted does measure the overhead
>>>>> of (pv-)spinlocks no? We don't see any overhead in that case for atleast
>>>>> kernbench ..
>>>>> 
>>>>>> Result for Non PLE machine :
>>>>>> ============================
>>>>> 
>>>>> [snip]
>>>>> 
>>>>>> Kernbench:
>>>>>>               BASE                    BASE+patch
>>>> 
>>>> What is BASE really? Is BASE already with the PV spinlocks enabled? I'm having a hard time understanding which tree you're working against, since the prerequisites aren't upstream yet.
>>>> 
>>>> 
>>>> Alex
>>> 
>>> Sorry for confusion, I think I was little imprecise on the BASE.
>>> 
>>> The BASE is pre 3.2.0 + Jeremy's following patches:
>>> xadd (https://lkml.org/lkml/2011/10/4/328)
>>> x86/ticketlocklock  (https://lkml.org/lkml/2011/10/12/496).
>>> So this would have ticketlock cleanups from Jeremy and
>>> CONFIG_PARAVIRT_SPINLOCKS=y
>>> 
>>> BASE+patch = pre 3.2.0 + Jeremy's above patches + above V5 PV spinlock
>>> series and CONFIG_PARAVIRT_SPINLOCKS=y
>>> 
>>> In both the cases  CONFIG_PARAVIRT_SPINLOCKS=y.
>>> 
>>> So let,
>>> A. pre-3.2.0 with CONFIG_PARAVIRT_SPINLOCKS = n
>>> B. pre-3.2.0 + Jeremy's above patches with CONFIG_PARAVIRT_SPINLOCKS = n
>>> C. pre-3.2.0 + Jeremy's above patches with CONFIG_PARAVIRT_SPINLOCKS = y
>>> D. pre-3.2.0 + Jeremy's above patches + V5 patches with CONFIG_PARAVIRT_SPINLOCKS = n
>>> E. pre-3.2.0 + Jeremy's above patches + V5 patches with CONFIG_PARAVIRT_SPINLOCKS = y
>>> 
>>> is it performance of A vs E ? (currently C vs E)
>> 
>> Since D and E only matter with KVM in use, yes, I'm mostly interested in A, B and C :).
>> 
>> 
>> Alex
>> 
>> 
> setup :
> Native: IBM xSeries with Intel(R) Xeon(R) x5570 2.93GHz CPU with 8 core , 64GB RAM, (16 cpu online)
> 
> Guest : Single guest with 8 VCPU 4GB Ram.
> benchmark : kernbench -f -H -M -o 20
> 
> Here is the result :
> Native Run
> ============
> case A               case B             %improvement   case C  %improvement
> 56.1917 (2.57125)    56.035 (2.02439)   0.278867       56.27 (2.40401)   -0.139344	

This looks a lot like statistical derivation. How often did you execute the test case? Did you make sure to have a clean base state every time?

Maybe it'd be a good idea to create a small in-kernel microbenchmark with a couple threads that take spinlocks, then do work for a specified number of cycles, then release them again and start anew. At the end of it, we can check how long the whole thing took for n runs. That would enable us to measure the worst case scenario.

> 
> Guest Run
> ============
> case A               case B             %improvement   case C  %improvement
> 166.999 (15.7613)    161.876 (14.4874) 	3.06768        161.24 (12.6497)  3.44852

Is this the same machine? Why is the guest 3x slower?


Alex

> 
> We do not see much overhead in native run with CONFIG_PARAVIRT_SPINLOCKS = y
> 
