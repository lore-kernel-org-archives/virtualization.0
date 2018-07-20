From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] [RFC V3] KVM: X86: Adding skeleton for Memory ROE
Date: Thu, 19 Jul 2018 18:07:59 -0700
Message-ID: <26f2e29b-c016-7140-4fea-853fbbd01459@infradead.org>
References: <20180719213802.17161-1-ahmedsoliman0x666@gmail.com>
	<20180719213802.17161-4-ahmedsoliman0x666@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180719213802.17161-4-ahmedsoliman0x666@gmail.com>
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
To: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>, kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, virtualization@lists.linux-foundation.org, linux-doc@vger.kernel.org, x86@kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kees Cook <keescook@chromium.org>, nathan Corbet <corbet@lwn.net>, David Vrabel <david.vrabel@nutanix.com>, rkrcmar@redhat.com, Boris Lukashev <blukashev@sempervictus.com>, Ingo Molnar <mingo@redhat.com>, nigel.edwards@hpe.com, hpa@zytor.com, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@surriel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 07/19/2018 02:38 PM, Ahmed Abd El Mawgood wrote:
> This patch introduces a hypercall implemented for X86 that can assist
> against subset of kernel rootkits, it works by place readonly protection in
> shadow PTE. The end result protection is also kept in a bitmap for each
> kvm_memory_slot and is used as reference when updating SPTEs. The whole
> goal is to protect the guest kernel static data from modification if
> attacker is running from guest ring 0, for this reason there is no
> hypercall to revert effect of Memory ROE hypercall. This patch doesn't
> implement integrity check on guest TLB so obvious attack on the current
> implementation will involve guest virtual address -> guest physical
> address remapping, but there are plans to fix that.
> 
> Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
> ---

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 92fd433c50b9..8ae822a8dc7a 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -96,6 +96,13 @@ config KVM_MMU_AUDIT
>  	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
>  	 auditing of KVM MMU events at runtime.
>  
> +config KVM_MROE
> +	bool "Hypercall Memory Read-Only Enforcement"
> +	depends on KVM && X86
> +	help
> +	This option add KVM_HC_HMROE hypercall to kvm which as hardening

	            adds                       to kvm as a hardening   (???)


> +	mechanism to protect memory pages from being edited.
> +
>  # OK, it's a little counter-intuitive to do this, but it puts it neatly under
>  # the virtualization menu.
>  source drivers/vhost/Kconfig


-- 
~Randy
