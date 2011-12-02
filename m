From: Raghavendra K T <raghukt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V3 2/4] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Fri, 02 Dec 2011 17:59:16 +0530
Message-ID: <4ED8C49C.8070306@linux.vnet.ibm.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130085959.23386.69166.sendpatchset@oc5400248562.ibm.com>
	<4ED760F1.6080804@redhat.com> <4ED7DA85.5080504@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED7DA85.5080504@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki
List-Id: virtualization@lists.linuxfoundation.org

On 12/02/2011 01:20 AM, Raghavendra K T wrote:
>>> + struct kvm_mp_state mp_state;
>>> +
>>> + mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
>>> + if (vcpu) {
>>> + vcpu->kicked = 1;
>>> + /* Ensure kicked is always set before wakeup */
>>> + barrier();
>>> + }
>>> + kvm_arch_vcpu_ioctl_set_mpstate(vcpu,&mp_state);
>>
>> This must only be called from the vcpu thread.
>
> Hmm. Okay. 'll check this.
>

Yes true. kvm_arch_vcpu_ioctl_set_mpstate itself is redundant, and will 
remove this.
