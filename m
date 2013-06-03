From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC V9 2/19]  x86/ticketlock: Don't inline _spin_unlock
	when using paravirt spinlocks
Date: Mon, 3 Jun 2013 11:28:00 -0400
Message-ID: <20130603152800.GA4224@phenom.dumpdata.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130601192209.5966.46834.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130601192209.5966.46834.sendpatchset@codeblue>
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
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 02, 2013 at 12:52:09AM +0530, Raghavendra K T wrote:
> x86/ticketlock: Don't inline _spin_unlock when using paravirt spinlocks
> 
> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> 
> The code size expands somewhat, and its better to just call
> a function rather than inline it.
> 
> Thanks Jeremy for original version of ARCH_NOINLINE_SPIN_UNLOCK config patch,
> which is simplified.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 685692c..80fcc4b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -621,6 +621,7 @@ config PARAVIRT_DEBUG
>  config PARAVIRT_SPINLOCKS
>  	bool "Paravirtualization layer for spinlocks"
>  	depends on PARAVIRT && SMP
> +	select UNINLINE_SPIN_UNLOCK
>  	---help---
>  	  Paravirtualized spinlocks allow a pvops backend to replace the
>  	  spinlock implementation with something virtualization-friendly
> 
