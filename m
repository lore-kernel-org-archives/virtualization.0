From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v3 08/16] zsmalloc: squeeze freelist into page->mapping
Date: Tue, 19 Apr 2016 16:42:39 +0900
Message-ID: <20160419074239.GB18448@bbox>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-9-git-send-email-minchan@kernel.org>
	<20160417155621.GE575@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160417155621.GE575@swordfish>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 18, 2016 at 12:56:21AM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> On (03/30/16 16:12), Minchan Kim wrote:
> [..]
> > +static void objidx_to_page_and_offset(struct size_class *class,
> > +				struct page *first_page,
> > +				unsigned long obj_idx,
> > +				struct page **obj_page,
> > +				unsigned long *offset_in_page)
> >  {
> > -	unsigned long obj;
> > +	int i;
> > +	unsigned long offset;
> > +	struct page *cursor;
> > +	int nr_page;
> >  
> > -	if (!page) {
> > -		VM_BUG_ON(obj_idx);
> > -		return NULL;
> > -	}
> > +	offset = obj_idx * class->size;
> 
> so we already know the `offset' before we call objidx_to_page_and_offset(),
> thus we can drop `struct size_class *class' and `obj_idx', and pass
> `long obj_offset'  (which is `obj_idx * class->size') instead, right?
> 
> we also _may be_ can return `cursor' from the function.
> 
> static struct page *objidx_to_page_and_offset(struct page *first_page,
> 					unsigned long obj_offset,
> 					unsigned long *offset_in_page);
> 
> this can save ~20 instructions, which is not so terrible for a hot path
> like obj_malloc(). what do you think?
> 
> well, seems that `unsigned long *offset_in_page' can be calculated
> outside of this function too, it's basically
> 
> 	*offset_in_page = (obj_idx * class->size) & ~PAGE_MASK;
> 
> so we don't need to supply it to this function, nor modify it there.
> which can save ~40 instructions on my system. does this sound silly?

Sound smart. :)
At least, we will use it in hot path.

Thanks!
