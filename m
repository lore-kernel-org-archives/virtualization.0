From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 05/11] virtio: introduce legacy virtio
	devices
Date: Thu, 30 Oct 2014 19:02:01 +0100
Message-ID: <20141030190201.41e8940d.cornelia.huck@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<1412692807-12398-6-git-send-email-cornelia.huck@de.ibm.com>
	<20141028164018.29d73d9f@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141028164018.29d73d9f@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 28 Oct 2014 16:40:18 +0100
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> On Tue,  7 Oct 2014 16:40:01 +0200
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > Introduce a helper function to indicate  whether a virtio device is
> > operating in legacy or virtio standard mode.
> > 
> > It may be used to make decisions about the endianess of virtio accesses
> > and other virtio-1 specific changes, enabling us to support transitional
> > devices.
> > 
> > Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/virtio/virtio.c                |    6 +++++-
> >  include/hw/virtio/virtio-access.h |    4 ++++
> >  include/hw/virtio/virtio.h        |   13 +++++++++++--
> >  3 files changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 7aaa953..e6ae3a0 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -883,7 +883,11 @@ static bool virtio_device_endian_needed(void *opaque)
> >      VirtIODevice *vdev = opaque;
> > 
> >      assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> > -    return vdev->device_endian != virtio_default_endian();
> > +    if (virtio_device_is_legacy(vdev)) {
> > +        return vdev->device_endian != virtio_default_endian();
> > +    }
> > +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> > +    return vdev->device_endian != VIRTIO_DEVICE_ENDIAN_LITTLE;
> >  }
> > 
> 
> Shouldn't we have some code doing the following somewhere ?
> 
> if (!virtio_device_is_legacy(vdev)) {
>     vdev->device_endian = VIRTIO_DEVICE_ENDIAN_LITTLE;
> }
> 
> also, since virtio-1 is LE only, do we expect device_endian to
> be different from VIRTIO_DEVICE_ENDIAN_LITTLE ?

device_endian should not depend on whether the device is legacy or not.
virtio_is_big_endian always returns false for virtio-1 devices, though.
