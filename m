From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3 2/4] virtio_balloon: handle concurrent accesses to
	virtio_balloon struct elements
Date: Wed, 4 Jul 2012 16:51:23 -0300
Message-ID: <20120704195122.GA1742__4667.89050628922$1341431538$gmane$org@t510.redhat.com>
References: <cover.1341353014.git.aquini@redhat.com>
	<e5f3c6d456f04adeac9fd714a6278424d71a97a0.1341353014.git.aquini@redhat.com>
	<87vci4uj34.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87vci4uj34.fsf@rustcorp.com.au>
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
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Howdy Rusty,

First and foremost, thank you very much for taking the time to go through this
proposal and provide me with such valuable feedback. I really appreciate that.

On Wed, Jul 04, 2012 at 04:08:23PM +0930, Rusty Russell wrote:
> On Tue,  3 Jul 2012 20:48:50 -0300, Rafael Aquini <aquini@redhat.com> wrote:
> > This patch introduces access sychronization to critical elements of struct
> > virtio_balloon, in order to allow the thread concurrency compaction/migration
> > bits might ended up imposing to the balloon driver on several situations.
> > 
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> 
> That's pretty vague, and it's almost impossible to audit this.
> 

I'll definetely attempt to improve this one.
Despite it looks concise to me as it states the "whats" and the "whys", any clue
on how to improve it and turn it into something that would make a lot more sense
is very welcome and appreciated. I'm probably failing miserably to express the
whole idea because I'm a terrible writer, no doubts about it. :)


> > +/* Protection for concurrent accesses to balloon virtqueues and vb->acked */
> > +DEFINE_MUTEX(vb_queue_completion);
> >  
> > +static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq,
> > +		      struct scatterlist *sg)
> > +{
> > +	mutex_lock(&vb_queue_completion);
> >  	init_completion(&vb->acked);
> >  
> >  	/* We should always be able to add one buffer to an empty queue. */
> > -	if (virtqueue_add_buf(vq, &sg, 1, 0, vb, GFP_KERNEL) < 0)
> > +	if (virtqueue_add_buf(vq, sg, 1, 0, vb, GFP_KERNEL) < 0)
> >  		BUG();
> >  	virtqueue_kick(vq);
> >  
> >  	/* When host has read buffer, this completes via balloon_ack */
> >  	wait_for_completion(&vb->acked);
> > +	mutex_unlock(&vb_queue_completion);
> >  }
> 
> OK, this lock is superceded by Michael's patch, and AFAICT is not due to
> any requirement introduced by these patches.
> 

Unfortunately, I'm compelled to disagree with you on this one.

Because tell_host() can be called concurrently, this lock is placed to avoid two
issues, basically:
 a) completion var vb->acked corruption (overriden upon several
    initializations);
 b) virtqueue operations (inflate/deflate) being called simultaneously;

Even though Michael's patch addresses the case (a), as far as this patch series
is concerned, it shows no way to prevent case (b), if two or more threads are
calling tell_host() simultaneously.


> >  static void set_page_pfns(u32 pfns[], struct page *page)
> > @@ -126,9 +132,12 @@ static void set_page_pfns(u32 pfns[], struct page *page)
> >  
> >  static void fill_balloon(struct virtio_balloon *vb, size_t num)
> >  {
> > +	struct scatterlist sg;
> > +	int alloc_failed = 0;
> >  	/* We can only do one array worth at a time. */
> >  	num = min(num, ARRAY_SIZE(vb->pfns));
> >  
> > +	spin_lock(&vb->pfn_list_lock);
> >  	for (vb->num_pfns = 0; vb->num_pfns < num;
> >  	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> >  		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY |
> > @@ -138,8 +147,7 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
> >  				dev_printk(KERN_INFO, &vb->vdev->dev,
> >  					   "Out of puff! Can't get %zu pages\n",
> >  					   num);
> > -			/* Sleep for at least 1/5 of a second before retry. */
> > -			msleep(200);
> > +			alloc_failed = 1;
> >  			break;
> >  		}
> >  		set_page_pfns(vb->pfns + vb->num_pfns, page);
> > @@ -149,10 +157,19 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
> >  	}
> >  
> >  	/* Didn't get any?  Oh well. */
> > -	if (vb->num_pfns == 0)
> > +	if (vb->num_pfns == 0) {
> > +		spin_unlock(&vb->pfn_list_lock);
> >  		return;
> > +	}
> > +
> > +	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> > +	spin_unlock(&vb->pfn_list_lock);
> >  
> > -	tell_host(vb, vb->inflate_vq);
> > +	/* alloc_page failed, sleep for at least 1/5 of a sec before retry. */
> > +	if (alloc_failed)
> > +		msleep(200);
> > +
> > +	tell_host(vb, vb->inflate_vq, &sg);
> 
> So, we drop the lock which procects vp->pfns[] and vb->num_pfns, then
> use it in tell_host?  Surely it could be corrupted between there.
> 

The lock is dropped following these conditions:
 a) virtqueue_add_buf() works based on a scatterlist array (buf);
 b) vp->pfns[] and vb->num_pfns are not anymore being directly accessed/updated
    at tell_host() level;
 c) *vb ptr address is only used as a token to identify the buffer at
    virtqueue_add_buf() and no particular struct's element is updated/accessed;
 d) we are not supposed to block/sleep while holding the spinlock;
 
Changes made to vp->pfns[] and vb->num_pfns after the spinlock is released
doesn't matter for a particular thread anymore since the scatterlist setup is
now moved outside tell_host() and it's being made within the locked session, and
no one else down that codepath directly uses vp->pfns[] or vb->num_pfns to make
its decisions.
Unfortunately, I'm not able to see the same corruption window you've spotted. Am
I missing something here?


Cheers!
Rafael

> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index bfbc15c..d47c5c2 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -51,6 +51,10 @@ struct virtio_balloon
> >  
> >  	/* Number of balloon pages we've told the Host we're not using. */
> >  	unsigned int num_pages;
> > +
> > +	/* Protect 'pages', 'pfns' & 'num_pnfs' against concurrent updates */
> > +	spinlock_t pfn_list_lock;
> > +
> >  	/*
> >  	 * The pages we've told the Host we're not using.
> >  	 * Each page on this list adds VIRTIO_BALLOON_PAGES_PER_PAGE
> 
> You might be better of taking num_pfns and pfns[] out of struct
> virtio_balloon, and putting them on the stack (maybe 64, not 256).
> 
> Cheers,
> Rusty.
