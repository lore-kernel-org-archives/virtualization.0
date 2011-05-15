From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 06/18] virtio_ring: avail event index interface
Date: Sun, 15 May 2011 15:47:27 +0300
Message-ID: <20110515124727.GA24932__47424.6743288406$1305463706$gmane$org@redhat.com>
References: <cover.1304541918.git.mst@redhat.com>
	<b00ef5d572ec9bc3b884c496025512abc1f14349.1304541919.git.mst@redhat.com>
	<87aaewh5pg.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87aaewh5pg.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 09, 2011 at 01:43:15PM +0930, Rusty Russell wrote:
> On Wed, 4 May 2011 23:51:19 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > Define a new feature bit for the host to
> > declare that it uses an avail_event index
> > (like Xen) instead of a feature bit
> > to enable/disable interrupts.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_ring.h |   11 ++++++++---
> >  1 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > index f5c1b75..f791772 100644
> > --- a/include/linux/virtio_ring.h
> > +++ b/include/linux/virtio_ring.h
> > @@ -32,6 +32,9 @@
> >  /* The Guest publishes the used index for which it expects an interrupt
> >   * at the end of the avail ring. Host should ignore the avail->flags field. */
> >  #define VIRTIO_RING_F_USED_EVENT_IDX	29
> > +/* The Host publishes the avail index for which it expects a kick
> > + * at the end of the used ring. Guest should ignore the used->flags field. */
> > +#define VIRTIO_RING_F_AVAIL_EVENT_IDX	32
> 
> Are you really sure we want to separate the two?  Seems a little simpler
> to have one bit to mean "we're publishing our threshold".  For someone
> implementing this from scratch, it's a little simpler.
> 
> Or are there cases where the old style makes more sense?
> 
> Thanks,
> Rusty.

Hmm, it makes debugging easier as each side can disable
publishing separately - I used it all the time when I saw
e.g. networking stuck to guess whether I need to investigate the
interrupt or the exit handling.

But I'm not hung up on this.

Let me know pls.

-- 
MST
