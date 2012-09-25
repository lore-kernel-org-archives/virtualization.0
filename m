From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Tue, 25 Sep 2012 03:05:49 +0200
Message-ID: <20120925010549.GA22893__22911.9172589437$1348535086$gmane$org@redhat.com>
References: <cover.1347897793.git.aquini@redhat.com>
	<89c9f4096bbad072e155445fcdf1805d47ddf48e.1347897793.git.aquini@redhat.com>
	<20120917151543.fd523040.akpm@linux-foundation.org>
	<20120918162420.GB1645@optiplex.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120918162420.GB1645@optiplex.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 18, 2012 at 01:24:21PM -0300, Rafael Aquini wrote:
> > > +static inline void assign_balloon_mapping(struct page *page,
> > > +					  struct address_space *mapping)
> > > +{
> > > +	page->mapping = mapping;
> > > +	smp_wmb();
> > > +}
> > > +
> > > +static inline void clear_balloon_mapping(struct page *page)
> > > +{
> > > +	page->mapping = NULL;
> > > +	smp_wmb();
> > > +}
> > > +
> > > +static inline gfp_t balloon_mapping_gfp_mask(void)
> > > +{
> > > +	return GFP_HIGHUSER_MOVABLE;
> > > +}
> > > +
> > > +static inline bool __is_movable_balloon_page(struct page *page)
> > > +{
> > > +	struct address_space *mapping = ACCESS_ONCE(page->mapping);
> > > +	smp_read_barrier_depends();
> > > +	return mapping_balloon(mapping);
> > > +}
> > 
> > hm.  Are these barrier tricks copied from somewhere else, or home-made?
> >
> 
> They were introduced by a reviewer request to assure the proper ordering when
> inserting or deleting pages to/from a balloon device, so a given page won't get
> elected as being a balloon page before it gets inserted into the balloon's page
> list, just as it will only be deleted from the balloon's page list after it is
> decomissioned of its balloon page status (page->mapping wipe-out). 
> 
> Despite the mentioned operations only take place under proper locking, I thought
> it wouldn't hurt enforcing such order, thus I kept the barrier stuff. Btw,
> considering the aforementioned usage case, I just realized the
> assign_balloon_mapping() barrier is misplaced. I'll fix that and introduce
> comments on those function's usage.

If these are all under page lock these barriers just confuse things,
because they are almost never enough by themselves.
So in that case it would be better to drop them and document
usage as you are going to.

Even better would be lockdep check but unfortunately it
does not seem to be possible for page lock.

-- 
MST
