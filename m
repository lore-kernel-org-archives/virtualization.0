From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] vmci_driver.patch: VMCI device driver.
Date: Thu, 30 Aug 2012 14:04:00 -0700
Message-ID: <20120830210400.GB3276@kroah.com>
References: <20120824171042.4775.36871.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20120824171607.4775.41134.stgit@promb-2n-dhcp175.eng.vmware.com>
	<15333E71B3DDCB48A90165AD57993F285685DB43DA@exch-mbx-114.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <15333E71B3DDCB48A90165AD57993F285685DB43DA@exch-mbx-114.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: George Zhang <georgezhang@vmware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 30, 2012 at 09:40:34AM -0700, George Zhang wrote:
> +struct vmci_device {
> +       struct mutex lock; /* Device access mutex */
> +
> +       unsigned int ioaddr;
> +       unsigned int ioaddr_size;
> +       unsigned int irq;
> +       unsigned int intr_type;
> +       bool exclusive_vectors;
> +       struct msix_entry msix_entries[VMCI_MAX_INTRS];
> +
> +       bool enabled;
> +       spinlock_t dev_spinlock; /* Lock for datagram access synchronization */
> +       atomic_t datagrams_allowed;
> +};

Why are you ignoring the driver model with this code, and the rest of
your infractructure?  Please don't, that's just rude.  Hint, you should
have a "struct device dev" in this structure if you are doing things
right.

> +static long drv_driver_unlocked_ioctl(struct file *filp,
> +                                     u_int iocmd,
> +                                     unsigned long ioarg)
> +{

Ah, a new syscall.  Why not just create a real syscall instead of
multiplexing here?  Are you _sure_ all of these ioctls really are needed
(hint, I know they aren't...)

> +static int __devinit drv_probe_device(struct pci_dev *pdev,
> +                                     const struct pci_device_id *id)
> +{
> +       unsigned int ioaddr;
> +       unsigned int ioaddr_size;
> +       unsigned int capabilities;
> +       int result;
> +
> +       pr_info("Probing for vmci/PCI.");

This is pointless, why are you being noisy?

> +       result = pci_enable_device(pdev);
> +       if (result) {
> +               pr_err("Cannot enable VMCI device %s: error %d",
> +                      pci_name(pdev), result);

Ick, please use dev_err() here, and other dev_* printk functions where
you can (hint, it's quite often in this file.)

> +               return result;
> +       }
> +       pci_set_master(pdev);   /* To enable QueuePair functionality. */
> +       ioaddr = pci_resource_start(pdev, 0);
> +       ioaddr_size = pci_resource_len(pdev, 0);
> +
> +       /*
> +        * Request I/O region with adjusted base address and size. The
> +        * adjusted values are needed and used if we release the
> +        * region in case of failure.
> +        */
> +       if (!request_region(ioaddr, ioaddr_size, MODULE_NAME)) {
> +               pr_info(MODULE_NAME ": Another driver already loaded " \
> +                       "for device in slot %s.", pci_name(pdev));
> +               goto pci_disable;
> +       }
> +
> +       pr_info("Found VMCI PCI device at %#x, irq %u.", ioaddr, pdev->irq);

Ick, noisy, you should NEVER print anything out if all goes well, that's
pointless.

greg k-h
