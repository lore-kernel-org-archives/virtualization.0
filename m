From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] [RFC] virtio: Limit the retries on a virtio device reset
Date: Fri, 25 Aug 2017 00:23:00 +0300
Message-ID: <20170825001922-mutt-send-email-mst@kernel.org>
References: <1503505982-29568-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20170824171253-mutt-send-email-mst@kernel.org>
	<05de15a6-9c4f-f44f-b8bd-ca04e7e91499@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <05de15a6-9c4f-f44f-b8bd-ca04e7e91499@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: cohuck@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 24, 2017 at 07:42:07PM +0200, Pierre Morel wrote:
> On 24/08/2017 16:19, Michael S. Tsirkin wrote:
> > On Wed, Aug 23, 2017 at 06:33:02PM +0200, Pierre Morel wrote:
> > > Reseting a device can sometime fail, even a virtual device.
> > > If the device is not reseted after a while the driver should
> > > abandon the retries.
> > > This is the change proposed for the modern virtio_pci.
> > > =

> > > More generally, when this happens,the virtio driver can set the
> > > VIRTIO_CONFIG_S_FAILED status flag to advertise the caller.
> > > =

> > > The virtio core can test if the reset was succesful by testing
> > > this flag after a reset.
> > > =

> > > This behavior is backward compatible with existing drivers.
> > > This behavior seems to me compatible with Virtio-1.0 specifications,
> > > Chapters 2.1 Device Status Field.
> > > There I definitively need your opinion: Is it right?
> > > =

> > > This patch also lead to another question:
> > > do we care if a device provided by the hypervisor is buggy?
> > > =

> > > Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > =

> > So I think this is not the best place to start to add error recovery.
> =

> I agree, there can not be any error recovery there.
> If reset does not work we can let fall the device until next reset of the
> hypervisor.

On probe, yes. But failures are more likely to trigger at other times.

> > It should be much more common to have a situation where device gets
> > broken while it's being used.  Spec has a NEEDS_RESET flag for this.
> =

> Yes the device side can set this flag, but it is another problem, it is
> supposing that:
> - the transport, device side, still works.
> - it is able to detect that the device need a reset
> - a reset is effective

Right. OTOH in this case there's more we can do.


> > =

> > I think we should start by coding up that support in all virtio drivers.
> > =

> > As a next step, we can add more code to detect unexpected behaviour by
> > the host and mark device as broken. Then we can do more things by
> > looking at the broken flag.
> =

> It seems difficult to me.
> But may be I went too fast to the conclusion that there is nothing to do.
> I still think about it.
> =

> Best regards
> =

> Pierre
> =

> > =

> > =

> > > ---
> > >   drivers/virtio/virtio.c            |  4 ++++
> > >   drivers/virtio/virtio_pci_modern.c | 11 ++++++++++-
> > >   2 files changed, 14 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 48230a5..6255dc4 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -324,6 +324,8 @@ int register_virtio_device(struct virtio_device *=
dev)
> > >   	/* We always start by resetting the device, in case a previous
> > >   	 * driver messed it up.  This also tests that code path a little. =
*/
> > >   	dev->config->reset(dev);
> > > +	if (dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED)
> > > +		return -EIO;
> > >   	/* Acknowledge that we've seen the device. */
> > >   	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > > @@ -373,6 +375,8 @@ int virtio_device_restore(struct virtio_device *d=
ev)
> > >   	/* We always start by resetting the device, in case a previous
> > >   	 * driver messed it up. */
> > >   	dev->config->reset(dev);
> > > +	if (dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED)
> > > +		return -EIO;
> > >   	/* Acknowledge that we've seen the device. */
> > >   	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virt=
io_pci_modern.c
> > > index 2555d80..bfc5fc1 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -270,6 +270,7 @@ static void vp_set_status(struct virtio_device *v=
dev, u8 status)
> > >   static void vp_reset(struct virtio_device *vdev)
> > >   {
> > >   	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> > > +	int retry_count =3D 10;
> > >   	/* 0 status means a reset. */
> > >   	vp_iowrite8(0, &vp_dev->common->device_status);
> > >   	/* After writing 0 to device_status, the driver MUST wait for a re=
ad of
> > > @@ -277,8 +278,16 @@ static void vp_reset(struct virtio_device *vdev)
> > >   	 * This will flush out the status write, and flush in device write=
s,
> > >   	 * including MSI-X interrupts, if any.
> > >   	 */
> > > -	while (vp_ioread8(&vp_dev->common->device_status))
> > > +	while (vp_ioread8(&vp_dev->common->device_status) && retry_count--)
> > >   		msleep(1);
> > > +	/* If the read did not return 0 before the timeout consider that
> > > +	 * the device failed.
> > > +	 */
> > > +	if (retry_count <=3D 0) {
> > > +		virtio_add_status(vdev, VIRTIO_CONFIG_S_FAILED);
> > > +		return;
> > > +	}
> > > +	virtio_add_status(vdev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > >   	/* Flush pending VQ/configuration callbacks. */
> > >   	vp_synchronize_vectors(vdev);
> > >   }
> > > -- =

> > > 2.3.0
> > =

> =

> =

> -- =

> Pierre Morel
> Linux/KVM/QEMU in B=F6blingen - Germany
