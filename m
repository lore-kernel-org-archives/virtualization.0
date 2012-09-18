From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v10 3/5] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Tue, 18 Sep 2012 11:07:12 -0300
Message-ID: <20120918140711.GA1645__16518.9072410159$1347977312$gmane$org@optiplex.redhat.com>
References: <cover.1347897793.git.aquini@redhat.com>
	<39738cbd4b596714210e453440833db7cca73172.1347897793.git.aquini@redhat.com>
	<20120917151552.ffbb9293.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120917151552.ffbb9293.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 17, 2012 at 03:15:52PM -0700, Andrew Morton wrote:
> > +	/* Number of balloon pages isolated from 'pages' list for compaction */
> > +	unsigned int num_isolated_pages;
> 
> Is it utterly inconceivable that this counter could exceed 4G, ever?
> 
> >  	/* Number of balloon pages we've told the Host we're not using. */
> >  	unsigned int num_pages;

I've just followed the same unit the driver writers had used to keep track of
how many pages are 'enlisted' to a given balloon device (num_pages). As
compaction can not isolate more pages than what a balloon device possess, yes,
num_isolated_pages won't get bigger than 4G pages.



> > +	mutex_lock(&vb->balloon_lock);
> >  	for (vb->num_pfns = 0; vb->num_pfns < num;
> >  	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> > -		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY |
> > -					__GFP_NOMEMALLOC | __GFP_NOWARN);
> > +		struct page *page = alloc_page(vb_gfp_mask | __GFP_NORETRY |
> > +					       __GFP_NOWARN | __GFP_NOMEMALLOC);
> 
> That looks like an allocation which could easily fail.
>

That's not a big problem. If we fail that allocation and miss the desired 
balloon 'inflation' target at this round, the driver will take care of it
later, as it keeps chasing its targets.


 
> >  		if (!page) {
> >  			if (printk_ratelimit())
> >  				dev_printk(KERN_INFO, &vb->vdev->dev,
> 
> Strangely, we suppressed the core page allocator's warning and
> substituted this less useful one.
> 
> Also, it would be nice if someone could get that printk_ratelimit() out
> of there, for reasons described at the printk_ratelimit() definition
> site.
> 

Despite I agree 100% with you here, (IMHO) that was a change out of the scope 
for this patchseries original purposes and so I didn't propose it.

OTOH, I don't mind in introducing the aforementioned surgery by this patch, 
if the balloon driver folks are OK with it.
