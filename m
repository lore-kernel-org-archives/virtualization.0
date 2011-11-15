From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2 09/11] virtio: net: Add freeze, restore handlers to
	support S4
Date: Tue, 15 Nov 2011 17:59:36 +0530
Message-ID: <20111115122902.GA26378@amit-x200.redhat.com>
References: <cover.1317311033.git.amit.shah@redhat.com>
	<5b7834c9a30254220f9c079ba54d29abaf63db8f.1317311033.git.amit.shah@redhat.com>
	<20111002093324.GD29706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111002093324.GD29706@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Sun) 02 Oct 2011 [11:33:26], Michael S. Tsirkin wrote:
> On Thu, Sep 29, 2011 at 09:19:40PM +0530, Amit Shah wrote:
> > Remove all the vqs on hibernation and re-create them after restoring
> > from a hibernated image.  This keeps networking working across
> > hibernation.
> > 
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/net/virtio_net.c |   28 ++++++++++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index dcd4b01..8b9ed43 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1131,6 +1131,30 @@ static void __devexit virtnet_remove(struct virtio_device *vdev)
> >  	free_netdev(vi->dev);
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int virtnet_freeze(struct virtio_device *vdev)
> > +{
> > +	struct virtnet_info *vi = vdev->priv;
> 
> I'm guessing we need to do something like netif_device_detach here,
> otherwise guest might be in the process of using the vq for transmit at
> this point.

Done.

> I think we also must make sure NAPI RX handler is not in progress.

How to do that?  napi_disable() / napi_enable() doesn't seem right
(and it doesn't work, too).  pci_disable_device() in the suspend
routine may work?

> We also might need to mask interrupts from the device
> to prevent TX or RX from getting rescheduled?

pci_disable_device() will help this too, right?

		Amit
