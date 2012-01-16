From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Tue, 17 Jan 2012 00:08:29 +0530
Message-ID: <4F146EA5.3010106@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<20120116142014.GA10155@linux.vnet.ibm.com>
	<B6E21B69-17D1-48E0-AFD4-B52075094005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <B6E21B69-17D1-48E0-AFD4-B52075094005@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki>
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 07:53 PM, Alexander Graf wrote:
>
> On 16.01.2012, at 15:20, Srivatsa Vaddagiri wrote:
>
>> * Alexander Graf<agraf@suse.de>  [2012-01-16 04:57:45]:
>>
>>> Speaking of which - have you benchmarked performance degradation of pv ticket locks on bare metal?
>>
>> You mean, run kernel on bare metal with CONFIG_PARAVIRT_SPINLOCKS
>> enabled and compare how it performs with CONFIG_PARAVIRT_SPINLOCKS disabled for
>> some workload(s)?
>
> Yup
>
>>
>> In some sense, the 1x overcommitcase results posted does measure the overhead
>> of (pv-)spinlocks no? We don't see any overhead in that case for atleast
>> kernbench ..
>>
>>> Result for Non PLE machine :
>>> ============================
>>
>> [snip]
>>
>>> Kernbench:
>>>                BASE                    BASE+patch
>
> What is BASE really? Is BASE already with the PV spinlocks enabled? I'm having a hard time understanding which tree you're working against, since the prerequisites aren't upstream yet.
>
>
> Alex

Sorry for confusion, I think I was little imprecise on the BASE.

The BASE is pre 3.2.0 + Jeremy's following patches:
xadd (https://lkml.org/lkml/2011/10/4/328)
x86/ticketlocklock  (https://lkml.org/lkml/2011/10/12/496).
So this would have ticketlock cleanups from Jeremy and
CONFIG_PARAVIRT_SPINLOCKS=y

BASE+patch = pre 3.2.0 + Jeremy's above patches + above V5 PV spinlock
series and CONFIG_PARAVIRT_SPINLOCKS=y

In both the cases  CONFIG_PARAVIRT_SPINLOCKS=y.

So let,
A. pre-3.2.0 with CONFIG_PARAVIRT_SPINLOCKS = n
B. pre-3.2.0 + Jeremy's above patches with CONFIG_PARAVIRT_SPINLOCKS = n
C. pre-3.2.0 + Jeremy's above patches with CONFIG_PARAVIRT_SPINLOCKS = y
D. pre-3.2.0 + Jeremy's above patches + V5 patches with 
CONFIG_PARAVIRT_SPINLOCKS = n
E. pre-3.2.0 + Jeremy's above patches + V5 patches with 
CONFIG_PARAVIRT_SPINLOCKS = y

is it performance of A vs E ? (currently C vs E)

Please let me know the configuration expected for testing.

Jeremy,
I would be happy to test A vs B vs C vs E, for some workload of interest 
if you wish, for your upcoming patches.

Thanks and Regards
Raghu

>
>>>                %improvement
>>>                mean (sd)               mean (sd)
>>> Scenario A:
>>> case 1x:	 164.233 (16.5506)	 163.584 (15.4598	0.39517
>>
>> [snip]
>>
>>> Result for PLE machine:
>>> ======================
>>
>> [snip]
>>> Kernbench:
>>>                BASE                    BASE+patch
>>>                %improvement
>>>                mean (sd)               mean (sd)
>>> Scenario A:
>>> case 1x:	 161.263 (56.518)        159.635 (40.5621)	1.00953
>>
>> - vatsa
>>
>
>
