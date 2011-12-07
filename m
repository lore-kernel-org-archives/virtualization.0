From: Raghavendra K T <raghukt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V3 2/4] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Wed, 07 Dec 2011 22:01:44 +0530
Message-ID: <4EDF94F0.2080201@linux.vnet.ibm.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130085959.23386.69166.sendpatchset@oc5400248562.ibm.com>
	<20111207104849.GA24849@amt.cnet>
	<4EDF5413.1030107@linux.vnet.ibm.com>
	<20111207123330.GA32212@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111207123330.GA32212@amt.cnet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org

On 12/07/2011 06:03 PM, Marcelo Tosatti wrote:
> On Wed, Dec 07, 2011 at 05:24:59PM +0530, Raghavendra K T wrote:
>> On 12/07/2011 04:18 PM, Marcelo Tosatti wrote:
>> Yes you are right. It was potentially racy and it was harmful too!.
>> I had observed that it was stalling the CPU before I introduced
>> kicked flag.
>>
>> But now,
>>
>> vcpu->kicked = 1  ==>  kvm_make_request(KVM_REQ_UNHALT, vcpu); ==>
>
> Ok, please use a more descriptive name, such as "pvlock_kicked" or
> something.
>

Yes, pvlock_kicked seems good. 'll use same unless something else
flashes.

>>
>> __vcpu_run() ==>  kvm_check_request(KVM_REQ_UNHALT, vcpu) ==>
>>
>> vcpuN->mp_state = KVM_MP_STATE_RUNNABLE; so eventually we will end up
>> in RUNNABLE.
>>
>> Also Avi pointed that, logically kvm_arch_vcpu_ioctl_set_mpstate should
>> be called only in vcpu thread, so after further debugging, I noticed
>> that,  setting vcpuN->mp_state = KVM_MP_STATE_RUNNABLE; is not
>> necessary.
>> I 'll remove that in the next patch. Thanks for pointing.
>
> In fact you don't need kvm_arch_vcpu_ioctl_set_mpstate either, only the
> new "kicked" flag.
>

True indeed, I meant the same.
