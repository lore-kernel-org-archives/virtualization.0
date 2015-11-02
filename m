From: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [kvm-unit-tests PATCH] x86: hyperv_synic: Hyper-V SynIC test
Date: Mon, 2 Nov 2015 15:18:12 +0300
Message-ID: <56375484.1000206@openvz.org>
References: <1445853369-24435-1-git-send-email-asmetanin@virtuozzo.com>
	<56375402.7060406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56375402.7060406@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, kvm@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/02/2015 03:16 PM, Paolo Bonzini wrote:
> On 26/10/2015 10:56, Andrey Smetanin wrote:
>> Hyper-V SynIC is a Hyper-V synthetic interrupt controller.
>>
>> The test runs on every vCPU and performs the following steps:
>> * read from all Hyper-V SynIC MSR's
>> * setup Hyper-V SynIC evt/msg pages
>> * setup SINT's routing
>> * inject SINT's into destination vCPU by 'hyperv-synic-test-device'
>> * wait for SINT's isr's completion
>> * clear Hyper-V SynIC evt/msg pages and destroy SINT's routing
>>
>> Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
>> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>> CC: "K. Y. Srinivasan" <kys@microsoft.com>
>> CC: Gleb Natapov <gleb@kernel.org>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Roman Kagan <rkagan@virtuozzo.com>
>> CC: Denis V. Lunev <den@openvz.org>
>> CC: qemu-devel@nongnu.org
>> CC: virtualization@lists.linux-foundation.org
> Bad news.
>
> The test breaks with APICv, because of the following sequence of events:
>
> 1) non-auto-EOI interrupt 176 is injected into IRR and ISR
>
> 2) The PPR register is now 176
>
> 3) auto-EOI interrupt 179 is injected into IRR only, because (179 &
> 0xf0) <= (PPR & 0xf0)
>
> 4) interrupt 176 ISR performs an EOI
>
> 5) at this point, because virtual interrupt delivery is enabled, the
> processor does not perform TPR virtualization (SDM 29.1.2).
>
> In addition (and even worse) because virtual interrupt delivery is
> enabled, an auto-EOI interrupt that was stashed in IRR can be injected
> by the processor, and the auto-EOI behavior will be skipped.
>
> The solution is to have userspace enable KVM_CAP_HYPERV_SYNIC through
> KVM_ENABLE_CAP, and modify vmx.c to not use apicv on VMs that have it
> enabled.  This requires some changes to the callbacks that only work if
> enable_apicv or !enable_apicv:
>
>         if (enable_apicv)
>                 kvm_x86_ops->update_cr8_intercept = NULL;
>         else {
>                 kvm_x86_ops->hwapic_irr_update = NULL;
>                 kvm_x86_ops->hwapic_isr_update = NULL;
>                 kvm_x86_ops->deliver_posted_interrupt = NULL;
>                 kvm_x86_ops->sync_pir_to_irr = vmx_sync_pir_to_irr_dummy;
>         }
>
> The question then is... does Hyper-V actually use auto-EOI interrupts?
> If it doesn't, we might as well not implement them... :/
>
> I'm keeping the kernel patches queued for my own testing, but this of
> course has to be fixed before including them---which will delay this
> feature to 4.5, unfortunately.
>
> Paolo

well, the problem is that it actually uses auto EOI....

Den
