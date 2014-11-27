From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v4 00/16] qemu: towards virtio-1 host support
Date: Thu, 27 Nov 2014 17:42:11 +0200
Message-ID: <20141127154211.GC26747@redhat.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141127152422.GA26747@redhat.com>
	<20141127163139.7db48144.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141127163139.7db48144.cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 27, 2014 at 04:31:39PM +0100, Cornelia Huck wrote:
> On Thu, 27 Nov 2014 17:24:22 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Nov 27, 2014 at 04:16:33PM +0100, Cornelia Huck wrote:
> > > Yet another version of the virtio-1 support patches.
> > > 
> > > This one has seen some (very) light testing with the virtio-1 guest
> > > support patches currently on vhost-next.
> > > 
> > > Changes from v3:
> > > 
> > > - Add support for FEATURES_OK. We refuse to set features after the
> > >   driver has set this in the status field, and we allow to fail
> > >   setting the status if the features are inconsistent.
> > > - Add missing virtio-1 changes for virtio-net (header size and mac).
> > > - Dropped setting the VERSION_1 bit for virtio-blk: There's still
> > >   some stuff missing.
> > > 
> > > For virtio-blk, we need to validate the feature bits if version 1 is
> > > negotiated: some legacy features are not allowed in that case. I'm not
> > > quite sure how to handle this, though. We could use the new
> > > validate_features callback to verify that the driver negotiated a
> > > sensible feature set, but that would require us to offer a superset
> > > of legacy and version 1 bits, which feels wrong. Any ideas?
> > 
> > No, that's violating the spec.
> > I think the simplest way is to have separate features and
> > legacy_features fields.  Present the correct one depending on which
> > revision was negotiated.
> 
> But revisions are a virtio-ccw only thing - what can other transports
> do here?

Other transports have different ways to deal with this.
For example virtio pci exposes a legacy header and
a modern header. Legacy header will expose old features,
modern one - new features.

mmio simply does not support transitional devices.
So qemu user will have to specify virtio 1.0 or 0.9 for mmio.

Other transports are out of virtio 1.0 spec so
they just use legacy features.

> The basic problem is that we decide via a feature bit that
> needs to be negotiated which feature bits we want to present.

Consider wce as one example.  This is not needed for modern guests, so
we can just mask it from modern feature mask.  Consider virtio blk scsi
commands as another example.  this feature is not supported in virtio
1.0, so we must mask it from modern feature mask.

Seems the same handling works in all cases?


> pci and
> mmio don't have a way to know whether the driver wants to use 1.0 or
> legacy prior to feature negotiation, do they?

pci does. mmio doesn't but it does not want to support transitional
devices.
