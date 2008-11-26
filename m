From: Greg KH <greg@kroah.com>
Subject: Re: [SR-IOV driver example 2/3] PF driver: integrate with SR-IOV core
Date: Wed, 26 Nov 2008 08:58:59 -0800
Message-ID: <20081126165859.GA28251__21623.8120374785$1227719036$gmane$org@kroah.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081126140303.GA13641@yzhao12-linux.sh.intel.com>
	<20081126142156.GB13668@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081126142156.GB13668@yzhao12-linux.sh.intel.com>
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
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 26, 2008 at 10:21:56PM +0800, Yu Zhao wrote:
> This patch integrates the IGB driver with the SR-IOV core. It shows how
> the SR-IOV API is used to support the capability. Obviously people does
> not need to put much effort to integrate the PF driver with SR-IOV core.
> All SR-IOV standard stuff are handled by SR-IOV core and PF driver only
> concerns the device specific resource allocation and deallocation once it
> gets the necessary information (i.e. number of Virtual Functions) from
> the callback function.
> 
> ---
>  drivers/net/igb/igb_main.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/igb/igb_main.c b/drivers/net/igb/igb_main.c
> index bc063d4..b8c7dc6 100644
> --- a/drivers/net/igb/igb_main.c
> +++ b/drivers/net/igb/igb_main.c
> @@ -139,6 +139,7 @@ void igb_set_mc_list_pools(struct igb_adapter *, struct e1000_hw *, int, u16);
>  static int igb_vmm_control(struct igb_adapter *, bool);
>  static int igb_set_vf_mac(struct net_device *, int, u8*);
>  static void igb_mbox_handler(struct igb_adapter *);
> +static int igb_virtual(struct pci_dev *, int);
>  #endif
>  
>  static int igb_suspend(struct pci_dev *, pm_message_t);
> @@ -184,6 +185,9 @@ static struct pci_driver igb_driver = {
>  #endif
>  	.shutdown = igb_shutdown,
>  	.err_handler = &igb_err_handler,
> +#ifdef CONFIG_PCI_IOV
> +	.virtual = igb_virtual
> +#endif

#ifdef should not be needed, right?

>  };
>  
>  static int global_quad_port_a; /* global quad port a indication */
> @@ -5107,6 +5111,32 @@ void igb_set_mc_list_pools(struct igb_adapter *adapter,
>  	reg_data |= (1 << 25);
>  	wr32(E1000_VMOLR(pool), reg_data);
>  }
> +
> +static	int
> +igb_virtual(struct pci_dev *pdev, int nr_virtfn)
> +{
> +	unsigned char my_mac_addr[6] = {0x00, 0xDE, 0xAD, 0xBE, 0xEF, 0xFF};
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct igb_adapter *adapter = netdev_priv(netdev);
> +	int i;
> +
> +	if (nr_virtfn > 7)
> +		return -EINVAL;

Why the check for 7?  Is that the max virtual functions for this card?
Shouldn't that be a define somewhere so it's easier to fix in future
versions of this hardware?  :)

> +
> +	if (nr_virtfn) {
> +		for (i = 0; i < nr_virtfn; i++) {
> +			printk(KERN_INFO "SR-IOV: VF %d is enabled\n", i);

Use dev_info() please, that shows the exact pci device and driver that
emitted the message.

> +			my_mac_addr[5] = (unsigned char)i;
> +			igb_set_vf_mac(netdev, i, my_mac_addr);
> +			igb_set_vf_vmolr(adapter, i);
> +		}
> +	} else
> +		printk(KERN_INFO "SR-IOV is disabled\n");

Is that really true?  (oh, use dev_info as well.)  What happens if you
had called this with "5" and then later with "0", you never destroyed
those existing virtual functions, yet the code does:

> +	adapter->vfs_allocated_count = nr_virtfn;

Which makes the driver think they are not present.  What happens when
the driver later goes to shut down?  Are those resources freed up
properly?

thanks,

greg k-h
