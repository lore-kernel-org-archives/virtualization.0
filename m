From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH] virtio_console: link vq to port with a private
	pointer in struct virtqueue
Date: Thu, 10 May 2012 10:56:09 +0930
Message-ID: <877gwkddxq.fsf@rustcorp.com.au>
References: <87397be80k.fsf@rustcorp.com.au>
	<1336470355-19257-1-git-send-email-pbonzini@redhat.com>
	<20120508101839.GA15598@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120508101839.GA15598@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 8 May 2012 13:18:39 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, May 08, 2012 at 11:45:55AM +0200, Paolo Bonzini wrote:
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -76,8 +76,6 @@
> >  
> >  struct vring_virtqueue
> >  {
> > -	struct virtqueue vq;
> > -
> >  	/* Actual memory layout for this queue */
> >  	struct vring vring;
> >  
> > @@ -106,6 +104,9 @@ struct vring_virtqueue
> >  	/* How to notify other side. FIXME: commonalize hcalls! */
> >  	void (*notify)(struct virtqueue *vq);
> >  
> > +	/* Tokens for callbacks. */
> > +	void **data;
> > +
> >  #ifdef DEBUG
> >  	/* They're supposed to lock for us. */
> >  	unsigned int in_use;
> > @@ -115,8 +116,9 @@ struct vring_virtqueue
> >  	ktime_t last_add_time;
> >  #endif
> >  
> > -	/* Tokens for callbacks. */
> > -	void *data[];
> > +	struct virtqueue vq;
> > +
> > +	/* Bus-specific virtqueue data goes here.  */
> >  };
> >  
> >  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
> 
> 
> This moves the data out of line and the bus specific stuff inline.
> But bus accesses only happen on io and interrupt which are already
> slow, while data accesses happen on fast path.
> 
> >From that POV this looks like a wrong thing to do.

(Resend to all)

Most of it was on a different cacheline anyway though, so it's probably
not measurable.  We avoid the pci_vq->vq indirection, but add the
vq->data indirection.

I share your discomfort with the offset arg method, too.

So unless benchmarks show otherwise, let's do it the vanilla way?

I think that making vring_virtqueue public looks like the way to go,
too.

Of course, a nice series would be great as well :)

Thanks!
Rusty.
