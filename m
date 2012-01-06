From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Fri, 6 Jan 2012 17:16:31 +0000
Message-ID: <1325870192.25206.514.camel@zakaz.uk.xensource.com>
References: <1325867990-15018-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1325867990-15018-1-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2012-01-06 at 16:39 +0000, Andrew Jones wrote:
> remove XEN_PRIVILEGED_GUEST as it's just an alias for XEN_DOM0.

Hmm, this one is used by tools like update-grub to know when it is ok to
create xen+kernel entries so I think it needs to stay, or we at least
need to give lengthly warning to distros etc that it is going away.

Perhaps you can just patch it out locally?

Ian.

> 
> I compile tested this on a latest pull using an F16 config. The compile
> succeeded and 'make oldconfig' only removed these two options as
> expected.
> 
> CONFIG_XEN_DOM0=y
> CONFIG_XEN_PRIVILEGED_GUEST=y
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  arch/x86/include/asm/xen/pci.h |   21 +--------------------
>  arch/x86/pci/xen.c             |    6 ------
>  arch/x86/xen/Kconfig           |   10 ----------
>  arch/x86/xen/Makefile          |    3 +--
>  arch/x86/xen/xen-ops.h         |    7 -------
>  drivers/xen/Kconfig            |    3 ++-
>  drivers/xen/Makefile           |    3 +--
>  drivers/xen/xenfs/Makefile     |    3 +--
>  include/xen/xen.h              |   11 +++--------
>  9 files changed, 9 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/x86/include/asm/xen/pci.h b/arch/x86/include/asm/xen/pci.h
> index 968d57d..b423889 100644
> --- a/arch/x86/include/asm/xen/pci.h
> +++ b/arch/x86/include/asm/xen/pci.h
> @@ -13,30 +13,11 @@ static inline int pci_xen_hvm_init(void)
>  	return -1;
>  }
>  #endif
> -#if defined(CONFIG_XEN_DOM0)
> +
>  int __init pci_xen_initial_domain(void);
>  int xen_find_device_domain_owner(struct pci_dev *dev);
>  int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
>  int xen_unregister_device_domain_owner(struct pci_dev *dev);
> -#else
> -static inline int __init pci_xen_initial_domain(void)
> -{
> -	return -1;
> -}
> -static inline int xen_find_device_domain_owner(struct pci_dev *dev)
> -{
> -	return -1;
> -}
> -static inline int xen_register_device_domain_owner(struct pci_dev *dev,
> -						   uint16_t domain)
> -{
> -	return -1;
> -}
> -static inline int xen_unregister_device_domain_owner(struct pci_dev *dev)
> -{
> -	return -1;
> -}
> -#endif
>  
>  #if defined(CONFIG_PCI_MSI)
>  #if defined(CONFIG_PCI_XEN)
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 492ade8..e298726 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -108,7 +108,6 @@ static int acpi_register_gsi_xen_hvm(struct device *dev, u32 gsi,
>  				 false /* no mapping of GSI to PIRQ */);
>  }
>  
> -#ifdef CONFIG_XEN_DOM0
>  static int xen_register_gsi(u32 gsi, int gsi_override, int triggering, int polarity)
>  {
>  	int rc, irq;
> @@ -143,7 +142,6 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
>  	return xen_register_gsi(gsi, -1 /* no GSI override */, trigger, polarity);
>  }
>  #endif
> -#endif
>  
>  #if defined(CONFIG_PCI_MSI)
>  #include <linux/msi.h>
> @@ -251,7 +249,6 @@ error:
>  	return irq;
>  }
>  
> -#ifdef CONFIG_XEN_DOM0
>  static bool __read_mostly pci_seg_supported = true;
>  
>  static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> @@ -324,7 +321,6 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  out:
>  	return ret;
>  }
> -#endif
>  
>  static void xen_teardown_msi_irqs(struct pci_dev *dev)
>  {
> @@ -392,7 +388,6 @@ int __init pci_xen_hvm_init(void)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_XEN_DOM0
>  static __init void xen_setup_acpi_sci(void)
>  {
>  	int rc;
> @@ -539,4 +534,3 @@ int xen_unregister_device_domain_owner(struct pci_dev *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(xen_unregister_device_domain_owner);
> -#endif
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index 26c731a..3c7e89a 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -13,16 +13,6 @@ config XEN
>  	  kernel to boot in a paravirtualized environment under the
>  	  Xen hypervisor.
>  
> -config XEN_DOM0
> -	def_bool y
> -	depends on XEN && PCI_XEN && SWIOTLB_XEN
> -	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
> -
> -# Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
> -# name in tools.
> -config XEN_PRIVILEGED_GUEST
> -	def_bool XEN_DOM0
> -
>  config XEN_PVHVM
>  	def_bool y
>  	depends on XEN && PCI && X86_LOCAL_APIC
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index add2c2d..b2d4c4b 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -13,12 +13,11 @@ CFLAGS_mmu.o			:= $(nostackp)
>  obj-y		:= enlighten.o setup.o multicalls.o mmu.o irq.o \
>  			time.o xen-asm.o xen-asm_$(BITS).o \
>  			grant-table.o suspend.o platform-pci-unplug.o \
> -			p2m.o
> +			p2m.o vga.o
>  
>  obj-$(CONFIG_EVENT_TRACING) += trace.o
>  
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= spinlock.o
>  obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
> -obj-$(CONFIG_XEN_DOM0)		+= vga.o
>  obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
> diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
> index b095739..d9dbbca 100644
> --- a/arch/x86/xen/xen-ops.h
> +++ b/arch/x86/xen/xen-ops.h
> @@ -90,14 +90,7 @@ static inline void xen_uninit_lock_cpu(int cpu)
>  
>  struct dom0_vga_console_info;
>  
> -#ifdef CONFIG_XEN_DOM0
>  void __init xen_init_vga(const struct dom0_vga_console_info *, size_t size);
> -#else
> -static inline void __init xen_init_vga(const struct dom0_vga_console_info *info,
> -				       size_t size)
> -{
> -}
> -#endif
>  
>  /* Declare an asm function, along with symbols needed to make it
>     inlineable */
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 8795480..0725228 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -78,8 +78,9 @@ config XEN_DEV_EVTCHN
>  
>  config XEN_BACKEND
>  	bool "Backend driver support"
> -	depends on XEN_DOM0
>  	default y
> +	depends on XEN && PCI_XEN && SWIOTLB_XEN
> +	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
>  	help
>  	  Support for backend device drivers that provide I/O services
>  	  to other virtual machines.
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 974fffd..7e61662 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -1,4 +1,4 @@
> -obj-y	+= grant-table.o features.o events.o manage.o balloon.o
> +obj-y	+= grant-table.o features.o events.o manage.o balloon.o pci.o
>  obj-y	+= xenbus/
>  
>  nostackp := $(call cc-option, -fno-stack-protector)
> @@ -17,7 +17,6 @@ obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+= sys-hypervisor.o
>  obj-$(CONFIG_XEN_PVHVM)			+= platform-pci.o
>  obj-$(CONFIG_XEN_TMEM)			+= tmem.o
>  obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
> -obj-$(CONFIG_XEN_DOM0)			+= pci.o
>  obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= xen-pciback/
>  
>  xen-evtchn-y				:= evtchn.o
> diff --git a/drivers/xen/xenfs/Makefile b/drivers/xen/xenfs/Makefile
> index 4fde944..d20c060 100644
> --- a/drivers/xen/xenfs/Makefile
> +++ b/drivers/xen/xenfs/Makefile
> @@ -1,4 +1,3 @@
>  obj-$(CONFIG_XENFS) += xenfs.o
>  
> -xenfs-y			  = super.o xenbus.o privcmd.o
> -xenfs-$(CONFIG_XEN_DOM0) += xenstored.o
> +xenfs-y			  = super.o xenbus.o privcmd.o xenstored.o
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index a164024..d814ef7 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -1,6 +1,9 @@
>  #ifndef _XEN_XEN_H
>  #define _XEN_XEN_H
>  
> +#include <xen/interface/xen.h>
> +#include <asm/xen/hypervisor.h>
> +
>  enum xen_domain_type {
>  	XEN_NATIVE,		/* running on bare hardware    */
>  	XEN_PV_DOMAIN,		/* running in a PV domain      */
> @@ -18,15 +21,7 @@ extern enum xen_domain_type xen_domain_type;
>  				 xen_domain_type == XEN_PV_DOMAIN)
>  #define xen_hvm_domain()	(xen_domain() &&			\
>  				 xen_domain_type == XEN_HVM_DOMAIN)
> -
> -#ifdef CONFIG_XEN_DOM0
> -#include <xen/interface/xen.h>
> -#include <asm/xen/hypervisor.h>
> -
>  #define xen_initial_domain()	(xen_pv_domain() && \
>  				 xen_start_info->flags & SIF_INITDOMAIN)
> -#else  /* !CONFIG_XEN_DOM0 */
> -#define xen_initial_domain()	(0)
> -#endif	/* CONFIG_XEN_DOM0 */
>  
>  #endif	/* _XEN_XEN_H */
