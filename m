From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 3/4 v2] PCI: support SR-IOV capability
Date: Mon, 1 Sep 2008 09:30:20 -0600
Message-ID: <20080901153020.GD16796__12959.646099671$1220365221$gmane$org@ldl.fc.hp.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB6F@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7A25B56E4BE99C4283EB931CD1A40E110177EB6F@pdsmsx414.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

* Zhao, Yu <yu.zhao@intel.com>:
> Support SR-IOV capability. By default, this feature is not enabled and the SR-IOV device behaves as traditional PCI device. After it's enabled, each Virtual Function's PCI configuration space can be accessed using its own Bus, Device and Function Number (Routing ID). Each Virtual Function also has PCI Memory Space, which is used to map its own register set.
> 
> Signed-off-by: Yu Zhao <yu.zhao@intel.com>
> Signed-off-by: Eddie Dong <eddie.dong@intel.com>
> 
> ---
>  drivers/pci/Kconfig      |   10 +
>  drivers/pci/Makefile     |    2 +
>  drivers/pci/iov.c        |  555 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c        |   14 +-
>  drivers/pci/pci.h        |   44 ++++
>  drivers/pci/probe.c      |    5 +
>  include/linux/pci.h      |   28 +++
>  include/linux/pci_regs.h |   20 ++
>  8 files changed, 677 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/pci/iov.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index f43cc46..0a1fe01 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -57,3 +57,13 @@ config PCI_ARI
>  	default n
>  	help
>  	  This enables PCI Alternative Routing-ID Interpretation.
> +
> +config PCI_IOV
> +	bool "PCI SR-IOV support"
> +	depends on PCI && HOTPLUG
> +	select PCI_MSI
> +	select PCI_ARI
> +	select HOTPLUG_PCI
> +	default n
> +	help
> +	  This allows device drivers to enable Single Root I/O Virtualization.

I'd like to see this Kconfig help text enhanced too. Telling a
user that PCI_IOV enables Single Root I/O Virtualization isn't
that helpful, but explaining what SR-IOV actually gets you _is_
helpful.

	This option allows device drivers to enable Single Root I/O
	Virtualization.  Each Virtual Function's PCI configuration
	space can be accessed using its own Bus, Device and Function
	Number (Routing ID). Each Virtual Function also has PCI Memory
	Space, which is used to map its own register set.

Thanks.

/ac
