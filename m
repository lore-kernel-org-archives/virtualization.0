From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 12/15 v5] PCI: support the SR-IOV capability
Date: Tue, 21 Oct 2008 09:50:54 -0700
Message-ID: <20081021165054.GA24795__44261.4213018262$1224609201$gmane$org@kroah.com>
References: <20081021114056.GA3185@yzhao12-linux.sh.intel.com>
	<20081021115308.GM3185@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081021115308.GM3185@yzhao12-linux.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 21, 2008 at 07:53:08PM +0800, Yu Zhao wrote:
> Support Single Root I/O Virtualization (SR-IOV) capability.
> 
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Grant Grundler <grundler@parisc-linux.org>
> Cc: Alex Chiang <achiang@hp.com>
> Cc: Matthew Wilcox <matthew@wil.cx>
> Cc: Roland Dreier <rdreier@cisco.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Yu Zhao <yu.zhao@intel.com>
> 
> ---
>  drivers/pci/Kconfig      |   12 +
>  drivers/pci/Makefile     |    2 +
>  drivers/pci/iov.c        |  616 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c  |    4 +
>  drivers/pci/pci.c        |   14 +
>  drivers/pci/pci.h        |   48 ++++
>  drivers/pci/probe.c      |    4 +
>  include/linux/pci.h      |   40 +++
>  include/linux/pci_regs.h |   21 ++
>  9 files changed, 761 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/pci/iov.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e1ca425..e7c0836 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -50,3 +50,15 @@ config HT_IRQ
>  	   This allows native hypertransport devices to use interrupts.
>  
>  	   If unsure say Y.
> +
> +config PCI_IOV
> +	bool "PCI SR-IOV support"
> +	depends on PCI
> +	select PCI_MSI
> +	default n
> +	help
> +	  This option allows device drivers to enable Single Root I/O
> +	  Virtualization. Each Virtual Function's PCI configuration
> +	  space can be accessed using its own Bus, Device and Function
> +	  Number (Routing ID). Each Virtual Function also has PCI Memory
> +	  Space, which is used to map its own register set.
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 4b47f4e..abbfcfa 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -55,3 +55,5 @@ obj-$(CONFIG_PCI_SYSCALL) += syscall.o
>  ifeq ($(CONFIG_PCI_DEBUG),y)
>  EXTRA_CFLAGS += -DDEBUG
>  endif
> +
> +obj-$(CONFIG_PCI_IOV) += iov.o
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> new file mode 100644
> index 0000000..571a46c
> --- /dev/null
> +++ b/drivers/pci/iov.c
> @@ -0,0 +1,616 @@
> +/*
> + * drivers/pci/iov.c
> + *
> + * Copyright (C) 2008 Intel Corporation
> + *
> + * PCI Express Single Root I/O Virtualization capability support.
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/string.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <asm/page.h>
> +#include "pci.h"
> +
> +
> +#define iov_config_attr(field)						\
> +static ssize_t field##_show(struct device *dev,				\
> +		struct device_attribute *attr, char *buf)		\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	return sprintf(buf, "%d\n", pdev->iov->field);			\
> +}
> +
> +iov_config_attr(status);
> +iov_config_attr(totalvfs);
> +iov_config_attr(initialvfs);
> +iov_config_attr(numvfs);

As you are adding new sysfs entries, can you also create the proper
documentation in Documentation/ABI/ so that people can understand how to
use them?  Yes, I see you added a stand-alone document, but putting it
in the "standard" format is also necessary.

thanks,

greg k-h
