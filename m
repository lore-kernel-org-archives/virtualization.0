From: Tom Lendacky <tahm@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/18] virtio: use avail_event index
Date: Tue, 17 May 2011 11:23:32 -0500
Message-ID: <201105171123.34706.tahm__10665.2871393182$1305649855$gmane$org@linux.vnet.ibm.com>
References: <cover.1304541918.git.mst@redhat.com>
	<20110515135541.GF24932@redhat.com>
	<87ei3zdsq2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ei3zdsq2.fsf@rustcorp.com.au>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org


On Monday, May 16, 2011 02:12:21 AM Rusty Russell wrote:
> On Sun, 15 May 2011 16:55:41 +0300, "Michael S. Tsirkin" <mst@redhat.com> 
wrote:
> > On Mon, May 09, 2011 at 02:03:26PM +0930, Rusty Russell wrote:
> > > On Wed, 4 May 2011 23:51:47 +0300, "Michael S. Tsirkin" <mst@redhat.com> 
wrote:
> > > > Use the new avail_event feature to reduce the number
> > > > of exits from the guest.
> > > 
> > > Figures here would be nice :)
> > 
> > You mean ASCII art in comments?
> 
> I mean benchmarks of some kind.

I'm working on getting some benchmark results for the patches.  I should 
hopefully have something in the next day or two.

Tom
> 
> > > > @@ -228,6 +237,12 @@ add_head:
> > > >  	 * new available array entries. */
> > > >  	
> > > >  	virtio_wmb();
> > > >  	vq->vring.avail->idx++;
> > > > 
> > > > +	/* If the driver never bothers to kick in a very long while,
> > > > +	 * avail index might wrap around. If that happens, invalidate
> > > > +	 * kicked_avail index we stored. TODO: make sure all drivers
> > > > +	 * kick at least once in 2^16 and remove this. */
> > > > +	if (unlikely(vq->vring.avail->idx == vq->kicked_avail))
> > > > +		vq->kicked_avail_valid = true;
> > > 
> > > If they don't, they're already buggy.  Simply do:
> > >         WARN_ON(vq->vring.avail->idx == vq->kicked_avail);
> > 
> > Hmm, but does it say that somewhere?
> 
> AFAICT it's a corollary of:
> 1) You have a finite ring of size <= 2^16.
> 2) You need to kick the other side once you've done some work.
> 
> > > > @@ -482,6 +517,8 @@ void vring_transport_features(struct
> > > > virtio_device *vdev)
> > > > 
> > > >  			break;
> > > >  		
> > > >  		case VIRTIO_RING_F_USED_EVENT_IDX:
> > > >  			break;
> > > > 
> > > > +		case VIRTIO_RING_F_AVAIL_EVENT_IDX:
> > > > +			break;
> > > > 
> > > >  		default:
> > > >  			/* We don't understand this bit. */
> > > >  			clear_bit(i, vdev->features);
> > > 
> > > Does this belong in a prior patch?
> > > 
> > > Thanks,
> > > Rusty.
> > 
> > Well if we don't support the feature in the ring we should not
> > ack the feature, right?
> 
> Ah, you're right.
> 
> Thanks,
> Rusty.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
