From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v6v3 02/12] mm: migrate: support non-lru movable page
	migration
Date: Thu, 16 Jun 2016 14:37:54 +0900
Message-ID: <20160616053754.GQ17127__48751.8548070968$1466055484$gmane$org@bbox>
References: <1463754225-31311-1-git-send-email-minchan@kernel.org>
	<1463754225-31311-3-git-send-email-minchan@kernel.org>
	<20160530013926.GB8683@bbox> <20160531000117.GB18314@bbox>
	<575E7F0B.8010201@linux.vnet.ibm.com> <20160615023249.GG17127@bbox>
	<5760F970.7060805@linux.vnet.ibm.com> <20160616002617.GM17127@bbox>
	<5762200F.5040908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5762200F.5040908@linux.vnet.ibm.com>
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

On Thu, Jun 16, 2016 at 09:12:07AM +0530, Anshuman Khandual wrote:
> On 06/16/2016 05:56 AM, Minchan Kim wrote:
> > On Wed, Jun 15, 2016 at 12:15:04PM +0530, Anshuman Khandual wrote:
> >> On 06/15/2016 08:02 AM, Minchan Kim wrote:
> >>> Hi,
> >>>
> >>> On Mon, Jun 13, 2016 at 03:08:19PM +0530, Anshuman Khandual wrote:
> >>>>> On 05/31/2016 05:31 AM, Minchan Kim wrote:
> >>>>>>> @@ -791,6 +921,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>>>>>>  	int rc = -EAGAIN;
> >>>>>>>  	int page_was_mapped = 0;
> >>>>>>>  	struct anon_vma *anon_vma = NULL;
> >>>>>>> +	bool is_lru = !__PageMovable(page);
> >>>>>>>  
> >>>>>>>  	if (!trylock_page(page)) {
> >>>>>>>  		if (!force || mode == MIGRATE_ASYNC)
> >>>>>>> @@ -871,6 +1002,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>>>>>>  		goto out_unlock_both;
> >>>>>>>  	}
> >>>>>>>  
> >>>>>>> +	if (unlikely(!is_lru)) {
> >>>>>>> +		rc = move_to_new_page(newpage, page, mode);
> >>>>>>> +		goto out_unlock_both;
> >>>>>>> +	}
> >>>>>>> +
> >>>>>
> >>>>> Hello Minchan,
> >>>>>
> >>>>> I might be missing something here but does this implementation support the
> >>>>> scenario where these non LRU pages owned by the driver mapped as PTE into
> >>>>> process page table ? Because the "goto out_unlock_both" statement above
> >>>>> skips all the PTE unmap, putting a migration PTE and removing the migration
> >>>>> PTE steps.
> >>> You're right. Unfortunately, it doesn't support right now but surely,
> >>> it's my TODO after landing this work.
> >>>
> >>> Could you share your usecase?
> >>
> >> Sure.
> > 
> > Thanks a lot!
> > 
> >>
> >> My driver has privately managed non LRU pages which gets mapped into user space
> >> process page table through f_ops->mmap() and vmops->fault() which then updates
> >> the file RMAP (page->mapping->i_mmap) through page_add_file_rmap(page). One thing
> > 
> > Hmm, page_add_file_rmap is not exported function. How does your driver can use it?
> 
> Its not using the function directly, I just re-iterated the sequence of functions
> above. (do_set_pte -> page_add_file_rmap) gets called after we grab the page from
> driver through (__do_fault->vma->vm_ops->fault()).
> 
> > Do you use vm_insert_pfn?
> > What type your vma is? VM_PFNMMAP or VM_MIXEDMAP?
> 
> I dont use vm_insert_pfn(). Here is the sequence of events how the user space
> VMA gets the non LRU pages from the driver.
> 
> - Driver registers a character device with 'struct file_operations' binding
> - Then the 'fops->mmap()' just binds the incoming 'struct vma' with a 'struct
>   vm_operations_struct' which provides the 'vmops->fault()' routine which
>   basically traps all page faults on the VMA and provides one page at a time
>   through a driver specific allocation routine which hands over non LRU pages
> 
> The VMA is not anything special as such. Its what we get when we try to do a
> simple mmap() on a file descriptor pointing to a character device. I can
> figure out all the VM_* flags it holds after creation.
> 
> > 
> > I want to make dummy driver to simulate your case.
> 
> Sure. I hope the above mentioned steps will help you but in case you need more
> information, please do let me know.

I got understood now. :)
I will test it with dummy driver and will Cc'ed when I send a patch.

Thanks.
