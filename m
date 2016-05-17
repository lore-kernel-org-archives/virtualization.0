From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v5 02/12] mm: migrate: support non-lru movable page
	migration
Date: Tue, 17 May 2016 10:30:09 +0900
Message-ID: <20160517013009.GB497__11754.7669135549$1463448658$gmane$org@swordfish>
References: <1462760433-32357-1-git-send-email-minchan@kernel.org>
	<1462760433-32357-3-git-send-email-minchan@kernel.org>
	<20160516071751.GA32079@swordfish> <20160517011850.GD31335@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160517011850.GD31335@bbox>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Rafael Aquini <aquini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (05/17/16 10:18), Minchan Kim wrote:
[..]
> > >  #ifdef CONFIG_MIGRATION
> > >  
> > > +extern int PageMovable(struct page *page);
> > > +extern void __SetPageMovable(struct page *page, struct address_space *mapping);
> > > +extern void __ClearPageMovable(struct page *page);
> > >  extern void putback_movable_pages(struct list_head *l);
> > >  extern int migrate_page(struct address_space *,
> > >  			struct page *, struct page *, enum migrate_mode);
> > >  extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
> > >  		unsigned long private, enum migrate_mode mode, int reason);
> > > +extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
> > > +extern void putback_movable_page(struct page *page);
> > >  
> > >  extern int migrate_prep(void);
> > >  extern int migrate_prep_local(void);
> > 
> > given that some of Movable users can be built as modules, shouldn't
> > at least some of those symbols be exported via EXPORT_SYMBOL?
> 
> Those functions aim for VM compaction so driver shouldn't use it.
> Only driver should be aware of are __SetPageMovable and __CleraPageMovable.
> I will export them.
> 

and PageMovable(), probably?

zsmalloc():

	VM_BUG_ON_PAGE(!PageMovable(page), page);


> Thanks for the review, Sergey!

no prob! sorry, I'm a bit slow and late here.

	-ss
