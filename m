From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v4 09/12] virtio: net: Add freeze, restore handlers to
	support S4
Date: Wed, 7 Dec 2011 16:05:29 +0530
Message-ID: <20111207103529.GG4651@amit-x200.redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
	<712d8d78cf730161181562ed44d4fe08a370b85e.1323199985.git.amit.shah@redhat.com>
	<20111207102824.GC8326@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111207102824.GC8326@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 07 Dec 2011 [12:28:24], Michael S. Tsirkin wrote:
> On Wed, Dec 07, 2011 at 01:18:47AM +0530, Amit Shah wrote:
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 697a0fc..1378f3c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1151,6 +1151,38 @@ static void __devexit virtnet_remove(struct virtio_device *vdev)
> >  	free_netdev(vi->dev);
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int virtnet_freeze(struct virtio_device *vdev)
> > +{
> > +	struct virtnet_info *vi = vdev->priv;
> > +
> > +	netif_device_detach(vi->dev);
> > +	if (netif_running(vi->dev))
> > +		napi_disable(&vi->napi);
> > +
> 
> Could refill_work still be running at this point?

Yes, it could.  So moving the cancel_delayed_work_sync() before
disabling napi would work fine?  Anything else that might similar treatment?

		Amit
