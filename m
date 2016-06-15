From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v6v3 02/12] mm: migrate: support non-lru movable page
	migration
Date: Wed, 15 Jun 2016 12:15:04 +0530
Message-ID: <5760F970.7060805@linux.vnet.ibm.com>
References: <1463754225-31311-1-git-send-email-minchan@kernel.org>
	<1463754225-31311-3-git-send-email-minchan@kernel.org>
	<20160530013926.GB8683@bbox> <20160531000117.GB18314@bbox>
	<575E7F0B.8010201@linux.vnet.ibm.com> <20160615023249.GG17127@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160615023249.GG17127@bbox>
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
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Rafael Aquini <aquini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On 06/15/2016 08:02 AM, Minchan Kim wrote:
> Hi,
> 
> On Mon, Jun 13, 2016 at 03:08:19PM +0530, Anshuman Khandual wrote:
>> > On 05/31/2016 05:31 AM, Minchan Kim wrote:
>>> > > @@ -791,6 +921,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>> > >  	int rc = -EAGAIN;
>>> > >  	int page_was_mapped = 0;
>>> > >  	struct anon_vma *anon_vma = NULL;
>>> > > +	bool is_lru = !__PageMovable(page);
>>> > >  
>>> > >  	if (!trylock_page(page)) {
>>> > >  		if (!force || mode == MIGRATE_ASYNC)
>>> > > @@ -871,6 +1002,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>> > >  		goto out_unlock_both;
>>> > >  	}
>>> > >  
>>> > > +	if (unlikely(!is_lru)) {
>>> > > +		rc = move_to_new_page(newpage, page, mode);
>>> > > +		goto out_unlock_both;
>>> > > +	}
>>> > > +
>> > 
>> > Hello Minchan,
>> > 
>> > I might be missing something here but does this implementation support the
>> > scenario where these non LRU pages owned by the driver mapped as PTE into
>> > process page table ? Because the "goto out_unlock_both" statement above
>> > skips all the PTE unmap, putting a migration PTE and removing the migration
>> > PTE steps.
> You're right. Unfortunately, it doesn't support right now but surely,
> it's my TODO after landing this work.
> 
> Could you share your usecase?

Sure.

My driver has privately managed non LRU pages which gets mapped into user space
process page table through f_ops->mmap() and vmops->fault() which then updates
the file RMAP (page->mapping->i_mmap) through page_add_file_rmap(page). One thing
to note here is that the page->mapping eventually points to struct address_space
(file->f_mapping) which belongs to the character device file (created using mknod)
which we are using for establishing the mmap() regions in the user space.

Now as per this new framework, all the page's are to be made __SetPageMovable before
passing the list down to migrate_pages(). Now __SetPageMovable() takes *new* struct
address_space as an argument and replaces the existing page->mapping. Now thats the
problem, we have lost all our connection to the existing file RMAP information. This
stands as a problem when we try to migrate these non LRU pages which are PTE mapped.
The rmap_walk_file() never finds them in the VMA, skips all the migrate PTE steps and
then the migration eventually fails.

Seems like assigning a new struct address_space to the page through __SetPageMovable()
is the source of the problem. Can it take the existing (file->f_mapping) as an argument
in there ? Sure, but then can we override file system generic ->isolate(), ->putback(),
->migratepages() functions ? I dont think so. I am sure, there must be some work around
to fix this problem for the driver. But we need to rethink this framework from supporting
these mapped non LRU pages point of view.

I might be missing something here, feel free to point out.

- Anshuman
