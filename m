From: Eric Northup <digitaleric@google.com>
Subject: Re: [PATCH V12 3/5] kvm : Fold pv_unhalt flag into GET_MP_STATE ioctl
	to aid migration
Date: Tue, 6 Aug 2013 11:32:01 -0700
Message-ID: <CAG7+5M3_4D+hQn3xWefniKRWzkdraLCJKHG2PrLGPZLJQQUZVA__34652.4976230741$1375813940$gmane$org@mail.gmail.com>
References: <20130806182150.2386.95104.sendpatchset@codeblue.in.ibm.com>
	<20130806182309.2386.35697.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130806182309.2386.35697.sendpatchset@codeblue.in.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, drjones@redhat.com, lf-virt <virtualization@lists.linux-foundation.org>, srivatsa.vaddagiri@gmail.com, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, habanero@linux.vnet.ibm.com, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, Thomas Gleixner <tglx@linutronix.de>, chegu_vinod@hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Paolo Bonzini <pbonzini@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 6, 2013 at 11:23 AM, Raghavendra K T
<raghavendra.kt@linux.vnet.ibm.com> wrote:
> kvm : Fold pv_unhalt flag into GET_MP_STATE ioctl to aid migration
>
> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>
> During migration, any vcpu that got kicked but did not become runnable
> (still in halted state) should be runnable after migration.

If this is about migration correctness, could it get folded into the
previous patch 2/5, so that there's not a broken commit which could
hurt bisection?

>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> Acked-by: Gleb Natapov <gleb@redhat.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kvm/x86.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index dae4575..1e73dab 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6284,7 +6284,12 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>                                     struct kvm_mp_state *mp_state)
>  {
>         kvm_apic_accept_events(vcpu);
> -       mp_state->mp_state = vcpu->arch.mp_state;
> +       if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
> +                                       vcpu->arch.pv.pv_unhalted)
> +               mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
> +       else
> +               mp_state->mp_state = vcpu->arch.mp_state;
> +
>         return 0;
>  }
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
