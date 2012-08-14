From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 14 Aug 2012 22:52:27 +0300
Message-ID: <20120814195227.GB28870@redhat.com>
References: <cover.1344619987.git.aquini@redhat.com>
	<292b1b52e863a05b299f94bda69a61371011ac19.1344619987.git.aquini@redhat.com>
	<20120813082619.GE14081@redhat.com>
	<20120814174404.GA13338@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120814174404.GA13338@t510.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2012 at 02:44:05PM -0300, Rafael Aquini wrote:
> On Mon, Aug 13, 2012 at 11:26:19AM +0300, Michael S. Tsirkin wrote:
> > > +static inline bool movable_balloon_page(struct page *page)
> > > +{
> > > +	return (page->mapping && page->mapping == balloon_mapping);
> > 
> > I am guessing this needs smp_read_barrier_depends, and maybe
> > ACCESS_ONCE ...
> > 
> 
> I'm curious about your guessing here. Could you ellaborate it further, please?

well balloon_mapping can change dynamically.


I think actually rcu is a good fit here.

> 
> > > +#else
> > > +static inline bool isolate_balloon_page(struct page *page) { return false; }
> > > +static inline void putback_balloon_page(struct page *page) { return false; }
> > > +static inline bool movable_balloon_page(struct page *page) { return false; }
> > > +#endif /* (VIRTIO_BALLOON || VIRTIO_BALLOON_MODULE) && CONFIG_COMPACTION */
> > > +
> > 
> > This does mean that only one type of balloon is useable at a time.
> > I wonder whether using a flag in address_space structure instead
> > is possible ...
> 
> This means we are only introducing this feature for virtio_balloon by now.
> Despite the flagging address_space stuff is something we surely can look in the
> future, I quite didn't get how we could be using two different types of balloon
> devices at the same time for the same system. Could you ellaborate it a little
> more, please?
> 
> 
> > > +/* __isolate_lru_page() counterpart for a ballooned page */
> > > +bool isolate_balloon_page(struct page *page)
> > > +{
> > > +	if (WARN_ON(!movable_balloon_page(page)))
> > 
> > Looks like this actually can happen if the page is leaked
> > between previous movable_balloon_page and here.
> > 
> > > +		return false;
> 
> Yes, it surely can happen, and it does not harm to catch it here, print a warn and
> return. While testing it, I wasn't lucky to see this small window opening, though.
