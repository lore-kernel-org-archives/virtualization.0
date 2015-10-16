From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 9/9] kvm/x86: Hyper-V kvm exit
Date: Fri, 16 Oct 2015 09:51:58 +0200
Message-ID: <5620AC9E.4050905__44769.8536132977$1444981947$gmane$org@redhat.com>
References: <1444979273-6587-1-git-send-email-den@openvz.org>
	<1444979273-6587-10-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444979273-6587-10-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Denis V. Lunev" <den@openvz.org>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 16/10/2015 09:07, Denis V. Lunev wrote:
>  
> +		/* KVM_EXIT_HYPERV */
> +                struct kvm_hyperv_exit hyperv;
> +Indicates that the VCPU exits into userspace to process some tasks
> +related with Hyper-V emulation. Currently used to synchronize modified
> +Hyper-V SynIC state with userspace.
> +

The documentation should include the definition of the struct and the
definition of the subtypes (currently KVM_EXIT_HYPERV_SYNIC only).

Documentation for KVM_CAP_HYPERV_SINIC and KVM_IRQ_ROUTING_HV_SINT is
missing, too.

Finally, it would be better to have unit tests in kvm-unit-tests.
Either this or QEMU support is a requirement for merging, and the unit
tests are probably easier.

But apart from this, the series looks great and I'm already applying it
to kvm/queue so that it gets some more testing.

Paolo
