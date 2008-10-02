From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 3/6 v3] PCI: support ARI capability
Date: Thu, 2 Oct 2008 09:03:15 -0700
Message-ID: <200810020903.16385.jbarnes__33766.824034001$1222963591$gmane$org@virtuousgeek.org>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F3@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F3@pdsmsx502.ccr.corp.intel.com>
Content-Disposition: inline
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday, September 27, 2008 1:28 am Zhao, Yu wrote:
> Add Alternative Routing-ID Interpretation (ARI) support.
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
>  drivers/pci/pci.c        |   31 +++++++++++++++++++++++++++++++
>  drivers/pci/pci.h        |   12 ++++++++++++
>  drivers/pci/probe.c      |    3 +++
>  include/linux/pci.h      |    1 +
>  include/linux/pci_regs.h |   14 ++++++++++++++
>  5 files changed, 61 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 400d3b3..fe9efc4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1260,6 +1260,37 @@ void pci_pm_init(struct pci_dev *dev)
>         }
>  }
>
> +/**
> + * pci_ari_init - turn on ARI forwarding if it's supported
> + * @dev: the PCI device
> + */
> +void pci_ari_init(struct pci_dev *dev)
> +{
> +       int pos;
> +       u32 cap;
> +       u16 ctrl;
> +
> +       if (!dev->is_pcie || (dev->pcie_type != PCI_EXP_TYPE_ROOT_PORT &&
> +                               dev->pcie_type != PCI_EXP_TYPE_DOWNSTREAM))
> +               return;
> +
> +       pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
> +       if (!pos)
> +               return;
> +
> +       pci_read_config_dword(dev, pos + PCI_EXP_DEVCAP2, &cap);
> +
> +       if (!(cap & PCI_EXP_DEVCAP2_ARI))
> +               return;
> +
> +       pci_read_config_word(dev, pos + PCI_EXP_DEVCTL2, &ctrl);
> +       ctrl |= PCI_EXP_DEVCTL2_ARI;
> +       pci_write_config_word(dev, pos + PCI_EXP_DEVCTL2, ctrl);
> +
> +       dev->ari_enabled = 1;
> +       dev_info(&dev->dev, "ARI forwarding enabled.\n");
> +}
> +

Maybe we should be consistent with the other APIs and call it pci_enable_ari 
(like we do for wake & msi).  Looks pretty good otherwise.

Jesse
