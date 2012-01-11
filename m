From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH 3/4 v2] xen kconfig: add dom0 support help text
Date: Wed, 11 Jan 2012 10:45:55 -0500 (EST)
Message-ID: <7aa66b79-0850-458c-981b-6cd998d93e3b@zmail13.collab.prod.int.phx2.redhat.com>
References: <1326132476-10047-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1326132476-10047-1-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: jeremy@goop.org, stefano stabellini <stefano.stabellini@eu.citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>, konrad wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> Describe dom0 support in the config menu and supply help text for it.
> 
> v2 adds 'if EXPERT' to keep it out of the "standard" menu.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  arch/x86/xen/Kconfig |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index 26c731a..31ec975 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -14,9 +14,14 @@ config XEN
>  	  Xen hypervisor.
>  
>  config XEN_DOM0
> -	def_bool y
> +	bool "Xen Initial Domain (Dom0) support" if EXPERT
> +	default y
>  	depends on XEN && PCI_XEN && SWIOTLB_XEN
>  	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
> +	help
> +	  This allows the kernel to be used for the initial Xen domain,
> +	  Domain0. This is a privileged guest that supplies backends
> +	  and is used to manage the other Xen domains.
>  
>  # Dummy symbol since people have come to rely on the
>  PRIVILEGED_GUEST
>  # name in tools.
> --
> 1.7.7.5

There's currently an issue using EXPERT. It doesn't make this
patch wrong, but any users that would want to turn EXPERT on, in
order to turn DOM0 off, would find that their configs have gotten
twisted in other ways as well. I've posted a patch for EXPERT, and
if it gets merged, then I really can't see any good arguments against
this patch.

Drew
