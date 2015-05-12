From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/7] virtio: relax feature check
Date: Tue, 12 May 2015 18:27:59 +0200
Message-ID: <20150512182759.4df29129.cornelia.huck@de.ibm.com>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
	<20150506120737.8607.30158.stgit@bahia.huguette.org>
	<20150512151453.42880d6c.cornelia.huck@de.ibm.com>
	<20150512153150-mutt-send-email-mst@redhat.com>
	<20150512154446.50c68fc4.cornelia.huck@de.ibm.com>
	<20150512164611.46d3e70a.cornelia.huck@de.ibm.com>
	<20150512171701-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150512171701-mutt-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 May 2015 17:30:21 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 12, 2015 at 04:46:11PM +0200, Cornelia Huck wrote:
> > On Tue, 12 May 2015 15:44:46 +0200
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > 
> > > On Tue, 12 May 2015 15:34:47 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > On Tue, May 12, 2015 at 03:14:53PM +0200, Cornelia Huck wrote:
> > > > > On Wed, 06 May 2015 14:07:37 +0200
> > > > > Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> > > > > 
> > > > > > Unlike with add and clear, there is no valid reason to abort when checking
> > > > > > for a feature. It makes more sense to return false (i.e. the feature bit
> > > > > > isn't set). This is exactly what __virtio_has_feature() does if fbit >= 32.
> > > > > > 
> > > > > > This allows to introduce code that is aware about new 64-bit features like
> > > > > > VIRTIO_F_VERSION_1, even if they are still not implemented.
> > > > > > 
> > > > > > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > > > > > ---
> > > > > >  include/hw/virtio/virtio.h |    1 -
> > > > > >  1 file changed, 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > > > index d95f8b6..6ef70f1 100644
> > > > > > --- a/include/hw/virtio/virtio.h
> > > > > > +++ b/include/hw/virtio/virtio.h
> > > > > > @@ -233,7 +233,6 @@ static inline void virtio_clear_feature(uint32_t *features, unsigned int fbit)
> > > > > > 
> > > > > >  static inline bool __virtio_has_feature(uint32_t features, unsigned int fbit)
> > > > > >  {
> > > > > > -    assert(fbit < 32);
> > > > > >      return !!(features & (1 << fbit));
> > > > > >  }
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > > I must say I'm not very comfortable with knowingly passing out-of-rage
> > > > > values to this function.
> > > > > 
> > > > > Can we perhaps apply at least the feature-bit-size extending patches
> > > > > prior to your patchset, if the remainder of the virtio-1 patchset still
> > > > > takes some time?
> > > > 
> > > > So the feature-bit-size extending patches currently don't support
> > > > migration correctly, that's why they are not merged.
> > > > 
> > > > What I think we need to do for this is move host_features out
> > > > from transports into core virtio device.
> > > > 
> > > > Then we can simply check host features >31 and skip
> > > > migrating low guest features is none set.
> > > > 
> > > > Thoughts? Any takers?
> > > > 
> > > 
> > > After we move host_features, put them into an optional vmstate
> > > subsection?
> > > 
> > > I think with the recent patchsets, most of the interesting stuff is
> > > already not handled by the transport anymore. There's only
> > > VIRTIO_F_NOTIFY_ON_EMPTY and VIRTIO_F_BAD_FEATURE left (set by pci and
> > > ccw).
> 
> notify on empty is likely safe to set for everyone.
> 
> bad feature should be pci specific, it's a mistake that
> we have it in ccw. it's there to detect very old buggy guests.
> in fact ccw ignores this bit completely.
> 
> For PCI, I think VIRTIO_F_BAD_FEATURE is never
> actually set in guest features. If guest attempts to set it,
> it is immediately cleared.
> 
> So it can be handled in pci specific code, and won't
> affect migration.
> 
> 
> > Thinking a bit more, we probably don't need this move of host_features
> > to get migration right (although it might be a nice cleanup later).
> > 
> > Could we
> > - keep migration of bits 0..31 as-is
> > - add a vmstate subsection for bits 32..63 only included if one of
> >   those bits is set
> > - have a post handler that performs a validation of the full set of
> >   bits 0..63
> > ?
> > 
> > We could do a similar exercise with a subsection containing the
> > addresses for avail and used with a post handler overwriting any
> > addresses set by the old style migration code.
> > 
> > Does that make sense?
> 
> I don't see how it does: on the receive side you don't know
> whether guest acked bits 32..63 so you can't decide whether
> to parse bits 32..63.

But if it wasn't set, it obviously wasn't acked, I'd think?

> 
> The right thing to do IMHO is to migrate the high guest bits if and only
> if the *host* bits 32..63 are set.  And that needs the host features in
> core, or at least is easier if they are there.

Aren't the host bits a prereq? Confused. I'll think about that tomorrow
when it's hopefully a bit cooler around here :)
