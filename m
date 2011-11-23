From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5 of 5] virtio: expose added descriptors immediately
Date: Wed, 23 Nov 2011 10:30:06 +0200
Message-ID: <20111123083005.GD22734@redhat.com>
References: <f3831c1617c86a51d875.1320306173@localhost6.localdomain6>
	<20111113210256.GA31621@redhat.com>
	<20111114065606.GA3779@redhat.com> <871ut8q5mh.fsf@rustcorp.com.au>
	<20111116071838.GE5433@redhat.com> <8739dib5z6.fsf@rustcorp.com.au>
	<20111121115702.GA27580@redhat.com>
	<87lir9xagv.fsf@rustcorp.com.au>
	<20111122062907.GB11012@redhat.com>
	<87ty5v1vqy.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ty5v1vqy.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 23, 2011 at 11:49:01AM +1030, Rusty Russell wrote:
> On Tue, 22 Nov 2011 08:29:08 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Nov 22, 2011 at 11:03:04AM +1030, Rusty Russell wrote:
> > > -	/* If you haven't kicked in this long, you're probably doing something
> > > -	 * wrong. */
> > > -	WARN_ON(vq->num_added > vq->vring.num);
> > > +	/* This is very unlikely, but theoretically possible.  Kick
> > > +	 * just in case. */
> > > +	if (unlikely(vq->num_added == 65535))
> > 
> > This is 0xffff but why use the decimal notation?
> 
> Interesting.  Why use hex?  Feels more like binary?

Just easier to see it's the largest 16 bit number.

> But I've changed it to "(1 << 16) - 1" to be clear.

That's even better.

> > > +		virtqueue_kick(_vq);
> > >  
> > >  	pr_debug("Added buffer head %i to %p\n", head, vq);
> > >  	END_USE(vq);
> > 
> > We also still need to reset vq->num_added, right?
> 
> virtqueue_kick does that for us.
> 
> Cheers,
> Rusty.

Right.
