From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 04/11] virtio_ring: implement endian reversal based
	on VERSION_1 feature.
Date: Wed, 22 Oct 2014 16:28:34 +0200
Message-ID: <20141022162834.17f39f0d.cornelia.huck@de.ibm.com>
References: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
	<1412692792-12325-5-git-send-email-cornelia.huck@de.ibm.com>
	<20141022140226.GA12171@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141022140226.GA12171@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 22 Oct 2014 17:02:26 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 07, 2014 at 04:39:45PM +0200, Cornelia Huck wrote:
> > From: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > [Cornelia Huck: we don't need the vq->vring.num -> vq->ring_mask change]
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  drivers/virtio/virtio_ring.c |  195 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 138 insertions(+), 57 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 1cfb5ba..350c39b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -145,42 +145,54 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
> >  	i = 0;
> >  	for (n = 0; n < out_sgs; n++) {
> >  		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
> > -			desc[i].flags = VRING_DESC_F_NEXT;
> > -			desc[i].addr = sg_phys(sg);
> > -			desc[i].len = sg->length;
> > -			desc[i].next = i+1;
> > +			desc[i].flags = cpu_to_virtio16(vq->vq.vdev,
> > +							  VRING_DESC_F_NEXT);
> > +			desc[i].addr = cpu_to_virtio64(vq->vq.vdev,
> > +							 sg_phys(sg));
> > +			desc[i].len = cpu_to_virtio32(vq->vq.vdev,
> > +							sg->length);
> > +			desc[i].next = cpu_to_virtio16(vq->vq.vdev,
> > +							 i+1);
> >  			i++;
> >  		}
> >  	}
> >  	for (; n < (out_sgs + in_sgs); n++) {
> >  		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
> > -			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
> > -			desc[i].addr = sg_phys(sg);
> > -			desc[i].len = sg->length;
> > -			desc[i].next = i+1;
> > +			desc[i].flags =	cpu_to_virtio16(vq->vq.vdev,
> > +							  VRING_DESC_F_NEXT|
> > +							  VRING_DESC_F_WRITE);
> > +			desc[i].addr = cpu_to_virtio64(vq->vq.vdev,
> > +							 sg_phys(sg));
> > +			desc[i].len = cpu_to_virtio32(vq->vq.vdev,
> > +							sg->length);
> > +			desc[i].next = cpu_to_virtio16(vq->vq.vdev, i+1);
> >  			i++;
> >  		}
> >  	}
> > -	BUG_ON(i != total_sg);
> >  
> >  	/* Last one doesn't continue. */
> > -	desc[i-1].flags &= ~VRING_DESC_F_NEXT;
> > +	desc[i-1].flags &= ~cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> >  	desc[i-1].next = 0;
> >  
> > -	/* We're about to use a buffer */
> > -	vq->vq.num_free--;
> > -
> >  	/* Use a single buffer which doesn't continue */
> >  	head = vq->free_head;
> > -	vq->vring.desc[head].flags = VRING_DESC_F_INDIRECT;
> > -	vq->vring.desc[head].addr = virt_to_phys(desc);
> > +	vq->vring.desc[head].flags =
> > +		cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT);
> > +	vq->vring.desc[head].addr =
> > +		cpu_to_virtio64(vq->vq.vdev, virt_to_phys(desc));
> >  	/* kmemleak gives a false positive, as it's hidden by virt_to_phys */
> >  	kmemleak_ignore(desc);
> > -	vq->vring.desc[head].len = i * sizeof(struct vring_desc);
> > +	vq->vring.desc[head].len =
> > +		cpu_to_virtio32(vq->vq.vdev, i * sizeof(struct vring_desc));
> >  
> > -	/* Update free pointer */
> > +	BUG_ON(i != total_sg);
> > +
> 
> Why move the BUG_ON here?
> I think I'll move it back ...

IIRC this was in the original patch I applied - but you're right, the
statement can stay in the old place.

> 
> > +	/* Update free pointer (we store this in native endian) */
> >  	vq->free_head = vq->vring.desc[head].next;
> >  
> > +	/* We've just used a buffer */
> > +	vq->vq.num_free--;
> > +
> >  	return head;
> >  }
> >  
