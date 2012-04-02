From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Mon, 02 Apr 2012 17:45:27 +0530
Message-ID: <4F79985F.5030600__14667.4652387903$1333369086$gmane$org@linux.vnet.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F707C5F.1000905@redhat.com>	<4F716E31.3000803@linux.vnet.ibm.com>
	<CAMy5W3foop40+R1RLv_JPhnO5ZmV90uMmNERYY-e3QCeaJfqLw@mail.gmail.com>
	<4F73568D.7000703@linux.vnet.ibm.com> <4F743247.5080407@redhat.com>
	<4F74A405.2040609@linux.vnet.ibm.com>
	<4F7585EE.7060203@linux.vnet.ibm.com> <4F7855A1.80107@redhat.com>
	<4F785CC9.7070204@linux.vnet.ibm.com> <4F785DCF.7020809@redhat.com>
	<4F7976B6.5050000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F7976B6.5050000@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: KVM <kvm@vger.kernel.org>, Alan Meadows <alan.meadows@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <andi@firstfloor.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/02/2012 03:21 PM, Raghavendra K T wrote:
> On 04/01/2012 07:23 PM, Avi Kivity wrote:
>  > On 04/01/2012 04:48 PM, Raghavendra K T wrote:
>  >>>> I have patch something like below in mind to try:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5127668..3fa912a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1557,12 +1557,17 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
> mark_page_dirty_in_slot(kvm, memslot, gfn);
> }
>
> +#define YIELD_THRESHOLD 2048
> +static void kvm_vcpu_try_yield_to(struct kvm_vcpu *me);
> /*
> * The vCPU has executed a HLT instruction with in-kernel mode enabled.
> */
> void kvm_vcpu_block(struct kvm_vcpu *vcpu)
> {
[...]
> + if (loop_count++ % YIELD_THRESHOLD)
> + schedule();
> + else
> + kvm_vcpu_try_yield_to(vcpu);
> }
>
> +static void kvm_vcpu_try_yield(struct kvm_vcpu *me)

yes, it is kvm_vcpu_try_yield_to. had changed the name just before
sending. sorry.
