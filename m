From: Fam Zheng <famz@redhat.com>
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
Date: Fri, 13 Mar 2015 07:21:04 +0800
Message-ID: <20150312232104.GA32054__42742.2947054312$1426202487$gmane$org@ad.nay.redhat.com>
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
	<5501BCF7.9080004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5501BCF7.9080004@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 03/12 17:21, Paolo Bonzini wrote:
> On 12/03/2015 06:21, Fam Zheng wrote:
> > If the device doesn't support shutdown, disabling interrupts may cause
> > trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
> > after we disable MSI-X, futher notifications from device will be
> > delivered to IRQ, which is unexpected. This IRQ will not be cleared, and
> > may prevent us from making progress, by keep triggering interrupts.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  drivers/pci/pci-driver.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 3cb2210..fb29c96 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -448,10 +448,11 @@ static void pci_device_shutdown(struct device *dev)
> >  
> >  	pm_runtime_resume(dev);
> >  
> > -	if (drv && drv->shutdown)
> > +	if (drv && drv->shutdown) {
> >  		drv->shutdown(pci_dev);
> > -	pci_msi_shutdown(pci_dev);
> > -	pci_msix_shutdown(pci_dev);
> > +		pci_msi_shutdown(pci_dev);
> > +		pci_msix_shutdown(pci_dev);
> > +	}
> >  
> >  #ifdef CONFIG_KEXEC
> >  	/*
> > 
> 
> The patch may be okay, but I think the bug here is also that virtio-pci
> is not defining a .shutdown callback.  It should define one and call
> free_irq (for INTX) and pci_disable_msix.

It's not enough. The device has to know we disabled msix, otherwise it will
send us IRQ, which is wrong.

> 
> How is this related to the virtio-scsi patch that you posted?  Do you
> need both to fix the problem you reported?
> 

This one should be enough. I was wrong in saying virtio-scsi hanging the
shutdown is because requests not being completed, it's more because of the
unexpected IRQ as explained in [1].

[1]: https://bugzilla.redhat.com/attachment.cgi?id=998391

Fam
