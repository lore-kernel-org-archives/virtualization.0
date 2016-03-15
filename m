From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v1 11/19] zsmalloc: squeeze freelist into page->mapping
Date: Tue, 15 Mar 2016 15:51:26 +0900
Message-ID: <20160315065126.GA3039__26826.2858190157$1458024666$gmane$org@bbox>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
	<1457681423-26664-12-git-send-email-minchan@kernel.org>
	<20160315064053.GF1464@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160315064053.GF1464@swordfish>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 15, 2016 at 03:40:53PM +0900, Sergey Senozhatsky wrote:
> On (03/11/16 16:30), Minchan Kim wrote:
> > -static void *location_to_obj(struct page *page, unsigned long obj_idx)
> > +static void objidx_to_page_and_ofs(struct size_class *class,
> > +				struct page *first_page,
> > +				unsigned long obj_idx,
> > +				struct page **obj_page,
> > +				unsigned long *ofs_in_page)
> 
> this looks big; 5 params, function "returning" both page and offset...
> any chance to split it in two steps, perhaps?

Yes, it's rather ugly but I don't have a good idea.
Feel free to suggest if you have a better idea.

> 
> besides, it is more intuitive (at least to me) when 'offset'
> shortened to 'offt', not 'ofs'.

Indeed. I will change it to get_page_and_offset instead of
abbreviation if we cannot refactor it more.

> 
> 	-ss
> 
> >  {
> > -	unsigned long obj;
> > +	int i;
> > +	unsigned long ofs;
> > +	struct page *cursor;
> > +	int nr_page;
> >  
> > -	if (!page) {
> > -		VM_BUG_ON(obj_idx);
> > -		return NULL;
> > -	}
> > +	ofs = obj_idx * class->size;
> > +	cursor = first_page;
> > +	nr_page = ofs >> PAGE_SHIFT;
> >  
> > -	obj = page_to_pfn(page) << OBJ_INDEX_BITS;
> > -	obj |= ((obj_idx) & OBJ_INDEX_MASK);
> > -	obj <<= OBJ_TAG_BITS;
> > +	*ofs_in_page = ofs & ~PAGE_MASK;
> > +
> > +	for (i = 0; i < nr_page; i++)
> > +		cursor = get_next_page(cursor);
> >  
> > -	return (void *)obj;
> > +	*obj_page = cursor;
> >  }
