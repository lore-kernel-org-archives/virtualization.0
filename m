From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v4 01/12] virtio: pci: switch to new PM API
Date: Wed, 7 Dec 2011 15:22:29 +0530
Message-ID: <20111207095229.GF4651@amit-x200.redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
	<201112062312.36498.rjw@sisk.pl>
	<20111207035703.GA4651@amit-x200.redhat.com>
	<201112071048.24566.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201112071048.24566.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 07 Dec 2011 [10:48:24], Rafael J. Wysocki wrote:
> On Wednesday, December 07, 2011, Amit Shah wrote:
> > Hi Rafael,
> > 
> > On (Tue) 06 Dec 2011 [23:12:36], Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > On Tuesday, December 06, 2011, Amit Shah wrote:
> > > > The older PM API doesn't have a way to get notifications on hibernate
> > > > events.  Switch to the newer one that gives us those notifications.
> > > > 
> > > > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci.c |   16 ++++++++++++----
> > > >  1 files changed, 12 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> > > > index 03d1984..23e1532 100644
> > > > --- a/drivers/virtio/virtio_pci.c
> > > > +++ b/drivers/virtio/virtio_pci.c
> > > > @@ -708,19 +708,28 @@ static void __devexit virtio_pci_remove(struct pci_dev *pci_dev)
> > > >  }
> > > >  
> > > >  #ifdef CONFIG_PM
> > > > -static int virtio_pci_suspend(struct pci_dev *pci_dev, pm_message_t state)
> > > > +static int virtio_pci_suspend(struct device *dev)
> > > >  {
> > > > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > > +
> > > >  	pci_save_state(pci_dev);
> > > >  	pci_set_power_state(pci_dev, PCI_D3hot);
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static int virtio_pci_resume(struct pci_dev *pci_dev)
> > > > +static int virtio_pci_resume(struct device *dev)
> > > >  {
> > > > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > > +
> > > >  	pci_restore_state(pci_dev);
> > > >  	pci_set_power_state(pci_dev, PCI_D0);
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +static const struct dev_pm_ops virtio_pci_pm_ops = {
> > > > +	.suspend = virtio_pci_suspend,
> > > > +	.resume  = virtio_pci_resume,
> > > > +};
> > > >  #endif
> > > 
> > > You seem to have forgotten about hibernation callbacks.
> > 
> > This patch just moves to the new API keeping everything else the same.
> > The hibernation callbacks come in patch 2.
> 
> OK, but then hibernation will be broken between the two patches, so perhaps
> it's better to merge them into one?

The hibernation support doesn't exist now.  It's added in the later
patches of the series (3 onwards).

		Amit
