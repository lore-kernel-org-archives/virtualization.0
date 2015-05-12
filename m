From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/7] vhost: set vring endianness for
	legacy virtio
Date: Tue, 12 May 2015 17:15:53 +0200
Message-ID: <20150512154127-mutt-send-email-mst@redhat.com>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
	<20150506120801.8607.64278.stgit@bahia.huguette.org>
	<20150512152530.4ab0c56f.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150512152530.4ab0c56f.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 12, 2015 at 03:25:30PM +0200, Cornelia Huck wrote:
> On Wed, 06 May 2015 14:08:02 +0200
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> 
> > Legacy virtio is native endian: if the guest and host endianness differ,
> > we have to tell vhost so it can swap bytes where appropriate. This is
> > done through a vhost ring ioctl.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> >  hw/virtio/vhost.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 54851b7..1d7b939 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> (...)
> > @@ -677,6 +700,16 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
> >          return -errno;
> >      }
> > 
> > +    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> 
> I think this should either go in after the virtio-1 base support (more
> feature bits etc.) or get a big fat comment and be touched up later.
> I'd prefer the first solution so it does not get forgotten, but I'm not
> sure when Michael plans to proceed with the virtio-1 patches (I think
> they're mostly fine already).

There are three main issues with virtio 1 patches that I am aware of.

One issue with virtio 1 patches as they are is with how features are
handled ATM.  There are 3 types of features

	a. virtio 1 only features
	b. virtio 0 only features
	c. shared features

and 3 types of devices
	a. legacy device: has b+c features
	b. modern device: has a+c features
	c. transitional device: has a+c features but exposes
	   only c through the legacy interface


So I think a callback that gets features depending on guest
version isn't a good way to model it because fundamentally device
has one set of features.
A better way to model this is really just a single
host_features bitmask, and for transitional devices, a mask
hiding a features - which are so far all bits > 31, so maybe
for now we can just have a global mask.

We need to validate features at initialization time and make
sure they make sense, fail if not (sometimes we need to mask
features if they don't make sense - this is unfortunate
but might be needed for compatibility).

Moving host_features to virtio core would make all of the above
easier.


Second issue is migration, some of it is with migrating the new
features, so that's tied to the first one.


Third issue is fixing devices so they don't try to
access guest memory until DRIVER_OK is set.
This is surprisingly hard to do generally given need to support old
drivers which don't set DRIVER_OK or set it very late, and the fact that
we tied work-arounds for even older drivers which dont' set pci bus
master to the DRIVER_OK bit. I tried, and I'm close to giving up and
just checking guest ack for virtio 1, and ignoring DRIVER_OK requirement
if not there.



> > +        virtio_legacy_is_cross_endian(vdev)) {
> > +        r = vhost_virtqueue_set_vring_endian_legacy(dev,
> > +                                                    virtio_is_big_endian(vdev),
> > +                                                    vhost_vq_index);
> > +        if (r) {
> > +            return -errno;
> > +        }
> > +    }
> > +
> >      s = l = virtio_queue_get_desc_size(vdev, idx);
> >      a = virtio_queue_get_desc_addr(vdev, idx);
> >      vq->desc = cpu_physical_memory_map(a, &l, 0);
