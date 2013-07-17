From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V10 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Wed, 17 Jul 2013 19:43:01 +0530
Message-ID: <51E6A66D.7090407@linux.vnet.ibm.com>
References: <20130714131241.GA11772@redhat.com>
	<51E3C5CE.7000009@linux.vnet.ibm.com>
	<20130715103648.GN11772@redhat.com>
	<51E4C011.4060803@linux.vnet.ibm.com>
	<20130716060215.GE11772@redhat.com>
	<51E5941B.3090300@linux.vnet.ibm.com>
	<20130717093420.GU11772@redhat.com>
	<51E66C71.6020605@linux.vnet.ibm.com>
	<20130717124511.GW11772@redhat.com>
	<51E69429.7040309@linux.vnet.ibm.com>
	<20130717132503.GA13732@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130717132503.GA13732@redhat.com>
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
Cc: jeremy@goop.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/17/2013 06:55 PM, Gleb Natapov wrote:
> On Wed, Jul 17, 2013 at 06:25:05PM +0530, Raghavendra K T wrote:
>> On 07/17/2013 06:15 PM, Gleb Natapov wrote:
>>> On Wed, Jul 17, 2013 at 03:35:37PM +0530, Raghavendra K T wrote:
>>>>>> Instead of halt we started with a sleep hypercall in those
>>>>>>   versions. Changed to halt() once Avi suggested to reuse existing sleep.
>>>>>>
>>>>>> If we use older hypercall with few changes like below:
>>>>>>
>>>>>> kvm_pv_wait_for_kick_op(flags, vcpu, w->lock )
>>>>>> {
>>>>>>   // a0 reserved for flags
>>>>>> if (!w->lock)
>>>>>> return;
>>>>>> DEFINE_WAIT
>>>>>> ...
>>>>>> end_wait
>>>>>> }
>>>>>>
>>>>> How would this help if NMI takes lock in critical section. The thing
>>>>> that may happen is that lock_waiting->want may have NMI lock value, but
>>>>> lock_waiting->lock will point to non NMI lock. Setting of want and lock
>>>>> have to be atomic.
>>>>
>>>> True. so we are here
>>>>
>>>>          non NMI lock(a)
>>>>          w->lock = NULL;
>>>>          smp_wmb();
>>>>          w->want = want;
>>>>                                 NMI
>>>>                           <---------------------
>>>>                            NMI lock(b)
>>>>                            w->lock = NULL;
>>>>                            smp_wmb();
>>>>                            w->want = want;
>>>>                            smp_wmb();
>>>>                            w->lock = lock;
>>>>                           ---------------------->
>>>>          smp_wmb();
>>>>          w->lock = lock;
>>>>
>>>> so how about fixing like this?
>>>>
>>>> again:
>>>>          w->lock = NULL;
>>>>          smp_wmb();
>>>>          w->want = want;
>>>>          smp_wmb();
>>>>          w->lock = lock;
>>>>
>>>> if (!lock || w->want != want) goto again;
>>>>
>>> NMI can happen after the if() but before halt and the same situation
>>> we are trying to prevent with IRQs will occur.
>>
>> True, we can not fix that. I thought to fix the inconsistency of
>> lock,want pair.
>> But NMI could happen after the first OR condition also.
>> /me thinks again
>>
> lock_spinning() can check that it is called in nmi context and bail out.

Good point.
I think we can check for even irq context and bailout so that in irq 
context we continue spinning instead of slowpath. no ?

> How often this will happens anyway.
>

I know NMIs occur frequently with watchdogs. or used by sysrq-trigger
etc.. But I am not an expert how frequent it is otherwise. But even
then if they do not use spinlock, we have no problem as already pointed.

I can measure with debugfs counter how often it happens.
