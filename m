From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC V4 3/3] KVM: X86: Adding skeleton for Memory ROE
Date: Wed, 25 Jul 2018 11:36:23 +0200
Message-ID: <61b16167-33cf-f435-6a9b-c20ab299e8d2@redhat.com>
References: <20180720233130.14129-1-ahmedsoliman0x666@gmail.com>
	<20180720233130.14129-4-ahmedsoliman0x666@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180720233130.14129-4-ahmedsoliman0x666@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>, kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, virtualization@lists.linux-foundation.org, linux-doc@vger.kernel.org, x86@kernel.org, xen-devel@lists.xensource.com
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kees Cook <keescook@chromium.org>, nathan Corbet <corbet@lwn.net>, rkrcmar@redhat.com, David Vrabel <david.vrabel@nutanix.com>, Boris Lukashev <blukashev@sempervictus.com>, Ingo Molnar <mingo@redhat.com>, nigel.edwards@hpe.com, hpa@zytor.com, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@surriel.com>
List-Id: virtualization@lists.linuxfoundation.org


>  		if (kvm_x86_ops->slot_disable_log_dirty)
>  			kvm_x86_ops->slot_disable_log_dirty(kvm, new);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4ee7bc548a83..82c5780e11d9 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -297,6 +297,9 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
>  struct kvm_memory_slot {
>  	gfn_t base_gfn;
>  	unsigned long npages;
> +#ifdef CONFIG_KVM_MROE
> +	unsigned long *mroe_bitmap;
> +#endif

Yet another problematic bitmap when it comes to splitting/resizing
memory slots atomically :(


-- 

Thanks,

David / dhildenb
