From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH RFC V2 4/5] kvm guest : Added configuration support to
	enable debug information for KVM Guests
Date: Mon, 24 Oct 2011 12:01:45 +0200
Message-ID: <1319450505.5660.5.camel__6440.65499441258$1319678751$gmane$org@lappy>
References: <20111023190307.16364.35381.sendpatchset@oc5400248562.ibm.com>
	<20111023190700.16364.7548.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111023190700.16364.7548.sendpatchset@oc5400248562.ibm.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter
	Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Xen <xen-devel@lists.xensource.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Suzuki Poulose <suzuki@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-10-24 at 00:37 +0530, Raghavendra K T wrote:
> Added configuration support to enable debug information
> for KVM Guests in debugfs
>     
> Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
> Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1f03f82..ed34269 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -562,6 +562,15 @@ config KVM_GUEST
>  	  This option enables various optimizations for running under the KVM
>  	  hypervisor.
>  
> +config KVM_DEBUG_FS
> +	bool "Enable debug information for KVM Guests in debugfs"
> +	depends on KVM_GUEST

Shouldn't it depend on DEBUG_FS as well?

> +	default n
> +	---help---
> +	  This option enables collection of various statistics for KVM guest.
> +   	  Statistics are displayed in debugfs filesystem. Enabling this option
> +	  may incur significant overhead.
> +
>  source "arch/x86/lguest/Kconfig"
>  
>  config PARAVIRT

-- 

Sasha.
