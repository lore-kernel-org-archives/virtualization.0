From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V5 3/6] kvm : Add unhalt msr to aid (live) migration
Date: Tue, 17 Apr 2012 12:47:17 +0530
Message-ID: <4F8D18FD.2040801__3614.35796735368$1334647083$gmane$org@linux.vnet.ibm.com>
References: <20120323080503.14568.43092.sendpatchset@codeblue>
	<20120323080723.14568.23068.sendpatchset@codeblue>
	<20120412001517.GB32051@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120412001517.GB32051@amt.cnet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>, Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, X86 <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization <virtualization@lists.linux-foundation.org>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/12/2012 05:45 AM, Marcelo Tosatti wrote:
> On Fri, Mar 23, 2012 at 01:37:26PM +0530, Raghavendra K T wrote:
>> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>>

[...]
>
> Unless there is a reason to use an MSR, should use a normal ioctl
> such as KVM_{GET,SET}_MP_STATE.
>
>

I agree with you. In the current implementation, since we are not doing
any communication between host/guest (on this flag), I too felt MSR is
an overkill for this.

IMO, patch like below should do the job, which I am planning to include
in next version of patch.
Let me know if you foresee any side-effects.

---
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aa44292..5c81a66 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5691,7 +5691,9 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu 
*vcpu,
  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
  				    struct kvm_mp_state *mp_state)
  {
-	mp_state->mp_state = vcpu->arch.mp_state;
+	mp_state->mp_state = (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
+				vcpu->pv_unhalted)?
+				KVM_MP_STATE_RUNNABLE : vcpu->arch.mp_state;
  	return 0;
  }
