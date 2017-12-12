From: weiping zhang <zhangweiping@didichuxing.com>
Subject: Re: [PATCH 2/3] virtio: use put_device instead of kfree
Date: Tue, 12 Dec 2017 21:13:16 +0800
Message-ID: <20171212131316.GB31104@localhost.didichuxing.com>
References: <cover.1513007310.git.zhangweiping@didichuxing.com>
	<3c3ed58013b0266886e72dc11424e0b93a745e18.1513007310.git.zhangweiping@didichuxing.com>
	<20171212111742.4249c49e.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171212111742.4249c49e.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 12, 2017 at 11:17:42AM +0100, Cornelia Huck wrote:
> On Mon, 11 Dec 2017 23:55:26 +0800
> weiping zhang <zhangweiping@didichuxing.com> wrote:
> 
> > don't free vp_vdev until vp_vdev.dev.release be called.
> 
> Same comment as for the virtio_pci patch.
OK, I'll add it at V2.
> 
> > 
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > ---
> >  drivers/misc/mic/vop/vop_main.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> > index a341938..8c716a0 100644
> > --- a/drivers/misc/mic/vop/vop_main.c
> > +++ b/drivers/misc/mic/vop/vop_main.c
> > @@ -452,10 +452,12 @@ static irqreturn_t vop_virtio_intr_handler(int irq, void *data)
> >  
> >  static void vop_virtio_release_dev(struct device *_d)
> >  {
> > -	/*
> > -	 * No need for a release method similar to virtio PCI.
> > -	 * Provide an empty one to avoid getting a warning from core.
> > -	 */
> > +	struct virtio_device *vdev =
> > +			container_of(_d, struct virtio_device, dev);
> > +	struct _vop_vdev *vop_vdev =
> > +			container_of(vdev, struct _vop_vdev, vdev);
> > +
> > +	kfree(vop_vdev);
> >  }
> >  
> >  /*
> > @@ -501,7 +503,9 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
> >  		dev_err(_vop_dev(vdev),
> >  			"Failed to register vop device %u type %u\n",
> >  			offset, type);
> > -		goto free_irq;
> > +		vpdev->hw_ops->free_irq(vpdev, vdev->virtio_cookie, vdev);
> > +		put_device(&vdev->vdev.dev);
> > +		return ret;
> >  	}
> >  	writeq((u64)vdev, &vdev->dc->vdev);
> >  	dev_dbg(_vop_dev(vdev), "%s: registered vop device %u type %u vdev %p\n",
> > @@ -509,8 +513,6 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
> >  
> >  	return 0;
> >  
> > -free_irq:
> > -	vpdev->hw_ops->free_irq(vpdev, vdev->virtio_cookie, vdev);
> >  kfree:
> >  	kfree(vdev);
> >  	return ret;
> 
> BTW, the kfree(vdev) in _vop_remove_device() is also wrong (needs to be
> a put_device() as well).
thanks for your comments, I'll fix it at v2.
