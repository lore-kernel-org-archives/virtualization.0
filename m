From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] virtio_pci: use put_device instead of kfree
Date: Fri, 15 Dec 2017 03:48:09 +0200
Message-ID: <20171215034700-mutt-send-email-mst@kernel.org>
References: <cover.1513083885.git.zhangweiping@didichuxing.com>
	<e397f504c0a796481d8aaf0e558cc8425286012c.1513083885.git.zhangweiping@didichuxing.com>
	<20171214205538-mutt-send-email-mst@kernel.org>
	<CAA70yB4jyroEGd+rKHMA_AJ93JGTC8Q4qADBs87q3z7x9XwEMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAA70yB4jyroEGd+rKHMA_AJ93JGTC8Q4qADBs87q3z7x9XwEMQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiping zhang <zwp10758@gmail.com>
Cc: Cornelia Huck <cohuck@redhat.com>, weiping zhang <zhangweiping@didichuxing.com>, Greg Kroah-Hartman <gregkh@suse.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 15, 2017 at 09:38:42AM +0800, weiping zhang wrote:
> 2017-12-15 3:13 GMT+08:00 Michael S. Tsirkin <mst@redhat.com>:
> > On Tue, Dec 12, 2017 at 09:24:02PM +0800, weiping zhang wrote:
> >> As mentioned at drivers/base/core.c:
> >> /*
> >>  * NOTE: _Never_ directly free @dev after calling this function, even
> >>  * if it returned an error! Always use put_device() to give up the
> >>  * reference initialized in this function instead.
> >>  */
> >> so we don't free vp_dev until vp_dev->vdev.dev.release be called.
> >
> > seeing as 5739411acbaa63a6c22c91e340fdcdbcc7d82a51 adding these
> > annotations went to stable, should this go there too?
> >
> just let people know the detail reason of using put_device.
> >> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> >> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >
> > OK but this relies on users knowing that register_virtio_device
> > calls device_register. I think we want to add a comment
> > to register_virtio_device.
> >
> > Also the cleanup is uglified.
> >
> > I really think the right thing would be to change device_register making
> > it safe to kfree. People have the right to expect register on failure to
> > have no effect.
> >
> > That just might be too hard to implement though.
> >
> > For now, my suggestion - add a variable.
> >
> >> ---
> >>  drivers/virtio/virtio_pci_common.c | 17 +++++++++--------
> >>  1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index 1c4797e..91d20f7 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -551,16 +551,17 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
> >>       pci_set_master(pci_dev);
> >>
> >>       rc = register_virtio_device(&vp_dev->vdev);
> >> -     if (rc)
> >> -             goto err_register;
> >> +     if (rc) {
> >> +             if (vp_dev->ioaddr)
> >> +                  virtio_pci_legacy_remove(vp_dev);
> >> +             else
> >> +                  virtio_pci_modern_remove(vp_dev);
> >> +             pci_disable_device(pci_dev);
> >> +             put_device(&vp_dev->vdev.dev);
> >> +     }
> >>
> >> -     return 0;
> >> +     return rc;
> >>
> >> -err_register:
> >> -     if (vp_dev->ioaddr)
> >> -          virtio_pci_legacy_remove(vp_dev);
> >> -     else
> >> -          virtio_pci_modern_remove(vp_dev);
> >>  err_probe:
> >>       pci_disable_device(pci_dev);
> >>  err_enable_device:
> >> --
> >> 2.9.4
> >
> > I'd prefer something like the below.
> >
> > --->
> >
> > virtio_pci: don't kfree device on register failure
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ---
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 1c4797e..995ab03 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -513,7 +513,7 @@ static void virtio_pci_release_dev(struct device *_d)
> >  static int virtio_pci_probe(struct pci_dev *pci_dev,
> >                             const struct pci_device_id *id)
> >  {
> > -       struct virtio_pci_device *vp_dev;
> > +       struct virtio_pci_device *vp_dev, *reg_dev = NULL;
> >         int rc;
> >
> >         /* allocate our structure and fill it out */
> > @@ -551,6 +551,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
> >         pci_set_master(pci_dev);
> >
> >         rc = register_virtio_device(&vp_dev->vdev);
> > +       /* NOTE: device is considered registered even if register failed. */
> > +       reg_dev = vp_dev;
> >         if (rc)
> >                 goto err_register;
> >
> > @@ -564,7 +566,10 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
> >  err_probe:
> >         pci_disable_device(pci_dev);
> >  err_enable_device:
> > -       kfree(vp_dev);
> > +       if (reg_dev)
> > +               put_device(dev);
> > +       else
> > +               kfree(vp_dev);
> >         return rc;
> >  }
> looks more cleaner and same coding style.
> Need I send V3 or apply your patch directly ?

Pls post v3 updating all patches to this style.

Also just to make sure, none of this is a regression and none
of this causes actual known issues right?

I think it's preferrable to defer to next merge cycle unless this
is a regression.

> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
