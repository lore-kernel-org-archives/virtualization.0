From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
Date: Thu, 12 Mar 2015 17:21:11 +0100
Message-ID: <5501BCF7.9080004@redhat.com>
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1426137682-12287-1-git-send-email-famz@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



On 12/03/2015 06:21, Fam Zheng wrote:
> If the device doesn't support shutdown, disabling interrupts may cause
> trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
> after we disable MSI-X, futher notifications from device will be
> delivered to IRQ, which is unexpected. This IRQ will not be cleared, and
> may prevent us from making progress, by keep triggering interrupts.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210..fb29c96 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -448,10 +448,11 @@ static void pci_device_shutdown(struct device *dev)
>  
>  	pm_runtime_resume(dev);
>  
> -	if (drv && drv->shutdown)
> +	if (drv && drv->shutdown) {
>  		drv->shutdown(pci_dev);
> -	pci_msi_shutdown(pci_dev);
> -	pci_msix_shutdown(pci_dev);
> +		pci_msi_shutdown(pci_dev);
> +		pci_msix_shutdown(pci_dev);
> +	}
>  
>  #ifdef CONFIG_KEXEC
>  	/*
> 

The patch may be okay, but I think the bug here is also that virtio-pci
is not defining a .shutdown callback.  It should define one and call
free_irq (for INTX) and pci_disable_msix.

How is this related to the virtio-scsi patch that you posted?  Do you
need both to fix the problem you reported?

Paolo
