From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v1 11/19] zsmalloc: squeeze freelist into page->mapping
Date: Fri, 18 Mar 2016 07:17:31 +0900
Message-ID: <20160317221731.GA2154@bbox>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
	<1457681423-26664-12-git-send-email-minchan@kernel.org>
	<20160315064053.GF1464@swordfish> <20160315065126.GA3039@bbox>
	<56EA9E8E.5040206@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56EA9E8E.5040206@hisilicon.com>
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
To: YiPing Xu <xuyiping@hisilicon.com>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, Mel Gorman <mgorman@suse.de>, koct9i@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, aquini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 17, 2016 at 08:09:50PM +0800, YiPing Xu wrote:
> 
> 
> On 2016/3/15 14:51, Minchan Kim wrote:
> >On Tue, Mar 15, 2016 at 03:40:53PM +0900, Sergey Senozhatsky wrote:
> >>On (03/11/16 16:30), Minchan Kim wrote:
> >>>-static void *location_to_obj(struct page *page, unsigned long obj_idx)
> >>>+static void objidx_to_page_and_ofs(struct size_class *class,
> >>>+				struct page *first_page,
> >>>+				unsigned long obj_idx,
> >>>+				struct page **obj_page,
> >>>+				unsigned long *ofs_in_page)
> >>
> >>this looks big; 5 params, function "returning" both page and offset...
> >>any chance to split it in two steps, perhaps?
> >
> >Yes, it's rather ugly but I don't have a good idea.
> >Feel free to suggest if you have a better idea.
> >
> >>
> >>besides, it is more intuitive (at least to me) when 'offset'
> >>shortened to 'offt', not 'ofs'.
> 
> 	the purpose to get 'obj_page' and 'ofs_in_page' is to map the page
> and get the meta-data pointer in the page, so, we can finish this in
> a single function.
> 
> 	just like this, and maybe we could have a better function name
> 
> static unsigned long *map_handle(struct size_class *class,
> 	struct page *first_page, unsigned long obj_idx)
> {
> 	struct page *cursor = first_page;
> 	unsigned long offset = obj_idx * class->size;
> 	int nr_page = offset >> PAGE_SHIFT;
> 	unsigned long offset_in_page = offset & ~PAGE_MASK;
> 	void *addr;
> 	int i;
> 
> 	if (class->huge) {
> 		VM_BUG_ON_PAGE(!is_first_page(page), page);
> 		return &page_private(page);
> 	}
> 
> 	for (i = 0; i < nr_page; i++)
> 		cursor = get_next_page(cursor);
> 
> 	addr = kmap_atomic(cursor);
> 	
> 	return addr + offset_in_page;
> }
> 
> static void unmap_handle(unsigned long *addr)
> {
> 	if (class->huge) {
> 		return;
> 	}
> 
> 	kunmap_atomic(addr & ~PAGE_MASK);
> }
> 
> 	all functions called "objidx_to_page_and_ofs" could use it like
> this, for example:
> 
> static unsigned long handle_from_obj(struct size_class *class,
> 				struct page *first_page, int obj_idx)
> {
> 	unsigned long *head = map_handle(class, first_page, obj_idx);
> 
> 	if (*head & OBJ_ALLOCATED_TAG)
> 		handle = *head & ~OBJ_ALLOCATED_TAG;
> 
> 	unmap_handle(*head);
> 
> 	return handle;
> }
> 
> 	'freeze_zspage', u'nfreeze_zspage' use it in the same way.
> 
> 	but in 'obj_malloc', we still have to get the page to get obj.
> 
> 	obj = location_to_obj(m_page, obj);

Yes, That's why I didn't use such pattern. I didn't want to
add unnecessary overhead in that hot path.
