From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v6v3 02/12] mm: migrate: support non-lru movable page
	migration
Date: Thu, 16 Jun 2016 09:26:17 +0900
Message-ID: <20160616002617.GM17127__30687.9116957591$1466036792$gmane$org@bbox>
References: <1463754225-31311-1-git-send-email-minchan@kernel.org>
	<1463754225-31311-3-git-send-email-minchan@kernel.org>
	<20160530013926.GB8683@bbox> <20160531000117.GB18314@bbox>
	<575E7F0B.8010201@linux.vnet.ibm.com> <20160615023249.GG17127@bbox>
	<5760F970.7060805@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5760F970.7060805@linux.vnet.ibm.com>
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
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Rafael Aquini <aquini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 15, 2016 at 12:15:04PM +0530, Anshuman Khandual wrote:
> On 06/15/2016 08:02 AM, Minchan Kim wrote:
> > Hi,
> > 
> > On Mon, Jun 13, 2016 at 03:08:19PM +0530, Anshuman Khandual wrote:
> >> > On 05/31/2016 05:31 AM, Minchan Kim wrote:
> >>> > > @@ -791,6 +921,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>> > >  	int rc = -EAGAIN;
> >>> > >  	int page_was_mapped = 0;
> >>> > >  	struct anon_vma *anon_vma = NULL;
> >>> > > +	bool is_lru = !__PageMovable(page);
> >>> > >  
> >>> > >  	if (!trylock_page(page)) {
> >>> > >  		if (!force || mode == MIGRATE_ASYNC)
> >>> > > @@ -871,6 +1002,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>> > >  		goto out_unlock_both;
> >>> > >  	}
> >>> > >  
> >>> > > +	if (unlikely(!is_lru)) {
> >>> > > +		rc = move_to_new_page(newpage, page, mode);
> >>> > > +		goto out_unlock_both;
> >>> > > +	}
> >>> > > +
> >> > 
> >> > Hello Minchan,
> >> > 
> >> > I might be missing something here but does this implementation support the
> >> > scenario where these non LRU pages owned by the driver mapped as PTE into
> >> > process page table ? Because the "goto out_unlock_both" statement above
> >> > skips all the PTE unmap, putting a migration PTE and removing the migration
> >> > PTE steps.
> > You're right. Unfortunately, it doesn't support right now but surely,
> > it's my TODO after landing this work.
> > 
> > Could you share your usecase?
> 
> Sure.

Thanks a lot!

> 
> My driver has privately managed non LRU pages which gets mapped into user space
> process page table through f_ops->mmap() and vmops->fault() which then updates
> the file RMAP (page->mapping->i_mmap) through page_add_file_rmap(page). One thing

Hmm, page_add_file_rmap is not exported function. How does your driver can use it?
Do you use vm_insert_pfn?
What type your vma is? VM_PFNMMAP or VM_MIXEDMAP?

I want to make dummy driver to simulate your case.
It would be very helpful to implement/test pte-mapped non-lru page
migration feature. That's why I ask now.

> to note here is that the page->mapping eventually points to struct address_space
> (file->f_mapping) which belongs to the character device file (created using mknod)
> which we are using for establishing the mmap() regions in the user space.
> 
> Now as per this new framework, all the page's are to be made __SetPageMovable before
> passing the list down to migrate_pages(). Now __SetPageMovable() takes *new* struct
> address_space as an argument and replaces the existing page->mapping. Now thats the
> problem, we have lost all our connection to the existing file RMAP information. This

We could change __SetPageMovable doesn't need mapping argument.
Instead, it just marks PAGE_MAPPING_MOVABLE into page->mapping.
For that, user should take care of setting page->mapping earlier than
marking the flag.

> stands as a problem when we try to migrate these non LRU pages which are PTE mapped.
> The rmap_walk_file() never finds them in the VMA, skips all the migrate PTE steps and
> then the migration eventually fails.
> 
> Seems like assigning a new struct address_space to the page through __SetPageMovable()
> is the source of the problem. Can it take the existing (file->f_mapping) as an argument
We can set existing file->f_mapping under the page_lock.

> in there ? Sure, but then can we override file system generic ->isolate(), ->putback(),

I don't get it. Why does it override file system generic functions?

> ->migratepages() functions ? I dont think so. I am sure, there must be some work around
> to fix this problem for the driver. But we need to rethink this framework from supporting
> these mapped non LRU pages point of view.
> 
> I might be missing something here, feel free to point out.
> 
> - Anshuman
> 
