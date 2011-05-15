From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 08/18] virtio_ring: support for used_event idx feature
Date: Sun, 15 May 2011 15:47:46 +0300
Message-ID: <20110515124746.GB24932__37645.1871045448$1305463731$gmane$org@redhat.com>
References: <cover.1304541918.git.mst@redhat.com>
	<dd16b9f3bad847b0eadc7f94368e27982c1a7560.1304541919.git.mst@redhat.com>
	<878vugh5ib.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <878vugh5ib.fsf@rustcorp.com.au>
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

On Mon, May 09, 2011 at 01:47:32PM +0930, Rusty Russell wrote:
> On Wed, 4 May 2011 23:51:38 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > Add support for the used_event idx feature: when enabling
> > interrupts, publish the current avail index value to
> > the host so that we get interrupts on the next update.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 507d6eb..3a3ed75 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -320,6 +320,14 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
> >  	ret = vq->data[i];
> >  	detach_buf(vq, i);
> >  	vq->last_used_idx++;
> > +	/* If we expect an interrupt for the next entry, tell host
> > +	 * by writing event index and flush out the write before
> > +	 * the read in the next get_buf call. */
> > +	if (!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
> > +		vring_used_event(&vq->vring) = vq->last_used_idx;
> > +		virtio_mb();
> > +	}
> > +
> 
> Hmm, so you're still using the avail->flags; it's just if thresholding
> is enabled the host will ignore it?
> 
> It's a little subtle, but it keeps this patch small.

Right, that's exactly why I do it this way.

> Perhaps we'll want to make it more explicit later.
> 
> Thanks,
> Rusty.

Yes, e.g. it might be better to avoid touching that cache line,
and track the current status in a private field in the guest.
But I was unable to measure any effect from doing it either way.

-- 
MST
