From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Tue, 17 Jan 2012 18:43:33 +0530
Message-ID: <4F1573FD.3030604@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
	<4F13E739.7040300@redhat.com>
	<20120116094020.GA6019@linux.vnet.ibm.com>
	<4F13F883.5090002@redhat.com>
	<20120116141117.GB6019@linux.vnet.ibm.com>
	<20120117091413.GM2167@redhat.com>
	<20120117122650.GC30757@linux.vnet.ibm.com>
	<20120117125126.GQ2167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120117125126.GQ2167@redhat.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org

On 01/17/2012 06:21 PM, Gleb Natapov wrote:
> On Tue, Jan 17, 2012 at 05:56:50PM +0530, Srivatsa Vaddagiri wrote:
>> * Gleb Natapov<gleb@redhat.com>  [2012-01-17 11:14:13]:
>>
>>>> The problem case I was thinking of was when guest VCPU would have issued
>>>> HLT with interrupts disabled. I guess one option is to inject an NMI,
>>>> and have the guest kernel NMI handler recognize this and make
>>>> adjustments such that the vcpu avoids going back to HLT instruction.
>>>>
>>> Just kick vcpu out of a guest mode and adjust rip to point after HLT on
>>> next re-entry. Don't forget to call vmx_clear_hlt().
>>
>> Looks bit hackish to me compared to having another hypercall to yield!
>>
> Do not see anything hackish about it. But what you described above (the
> part I replied to) is not another hypercall, but yet another NMI source
> and special handling in a guest. So what hypercall do you mean?
>

Earlier version had a hypercall to sleep instead of current halt()
approach. This was taken out to avoid extra hypercall.

So here is the hypercall hunk referred :

+/*
+ * kvm_pv_wait_for_kick_op : Block until kicked by either a KVM_HC_KICK_CPU
+ * hypercall or a event like interrupt.
+ *
+ * @vcpu : vcpu which is blocking.
+ */
+static void kvm_pv_wait_for_kick_op(struct kvm_vcpu *vcpu)
+{
+       DEFINE_WAIT(wait);
+
+       /*
+        * Blocking on vcpu->wq allows us to wake up sooner if required to
+        * service pending events (like interrupts).
+        *
+        * Also set state to TASK_INTERRUPTIBLE before checking 
vcpu->kicked to
+        * avoid racing with kvm_pv_kick_cpu_op().
+        */
+       prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
+
+       /*
+        * Somebody has already tried kicking us. Acknowledge that
+        * and terminate the wait.
+        */
+       if (vcpu->kicked) {
+               vcpu->kicked = 0;
+               goto end_wait;
+       }
+
+       /* Let's wait for either KVM_HC_KICK_CPU or someother event
+        * to wake us up.
+        */
+
+       srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
+       schedule();
+       vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+end_wait:
+       finish_wait(&vcpu->wq, &wait);
+}

>>>> Having another hypercall to do yield/sleep (rather than effecting that
>>>> via HLT) seems like an alternate clean solution here ..
