From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: PATCH v6v2 02/12] mm: migrate: support non-lru movable page
	migration
Date: Mon, 30 May 2016 11:36:07 +0200
Message-ID: <2bc277c4-4257-c6cb-2e37-ee5de985410b__43524.1165840582$1464600989$gmane$org@suse.cz>
References: <1463754225-31311-1-git-send-email-minchan@kernel.org>
	<1463754225-31311-3-git-send-email-minchan@kernel.org>
	<20160530013926.GB8683@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160530013926.GB8683@bbox>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Rafael Aquini <aquini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Gioh Kim <gi-oh.kim@profitbricks.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/30/2016 03:39 AM, Minchan Kim wrote:
> After isolation, VM calls migratepage of driver with isolated page.
> The function of migratepage is to move content of the old page to new page
> and set up fields of struct page newpage. Keep in mind that you should
> clear PG_movable of oldpage via __ClearPageMovable under page_lock if you
> migrated the oldpage successfully and returns 0.

This "clear PG_movable" is one of the reasons I was confused about what 
__ClearPageMovable() really does. There's no actual "PG_movable" page 
flag and the function doesn't clear even the actual mapping flag :) Also 
same thing in the Documentation/ part.

Something like "... you should indicate to the VM that the oldpage is no 
longer movable via __ClearPageMovable() ..."?

> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -81,6 +81,39 @@ static inline bool migrate_async_suitable(int migratetype)
>
>  #ifdef CONFIG_COMPACTION
>
> +int PageMovable(struct page *page)
> +{
> +	struct address_space *mapping;
> +
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	if (!__PageMovable(page))
> +		return 0;
> +
> +	mapping = page_mapping(page);
> +	if (mapping && mapping->a_ops && mapping->a_ops->isolate_page)
> +		return 1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(PageMovable);
> +
> +void __SetPageMovable(struct page *page, struct address_space *mapping)
> +{
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE((unsigned long)mapping & PAGE_MAPPING_MOVABLE, page);
> +	page->mapping = (void *)((unsigned long)mapping | PAGE_MAPPING_MOVABLE);
> +}
> +EXPORT_SYMBOL(__SetPageMovable);
> +
> +void __ClearPageMovable(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(!PageMovable(page), page);
> +	page->mapping = (void *)((unsigned long)page->mapping &
> +				PAGE_MAPPING_MOVABLE);
> +}
> +EXPORT_SYMBOL(__ClearPageMovable);

The second confusing thing is that the function is named 
__ClearPageMovable(), but what it really clears is the mapping pointer,
which is not at all the opposite of what __SetPageMovable() does.

I know it's explained in the documentation, but it also deserves a 
comment here so it doesn't confuse everyone who looks at it.
Even better would be a less confusing name for the function, but I can't 
offer one right now.

> diff --git a/mm/util.c b/mm/util.c
> index 917e0e3d0f8e..b756ee36f7f0 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -399,10 +399,12 @@ struct address_space *page_mapping(struct page *page)
>  	}
>
>  	mapping = page->mapping;

I'd probably use READ_ONCE() here to be safe. Not all callers are under 
page lock?

> -	if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
> +	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
>  		return NULL;
> -	return mapping;
> +
> +	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
>  }
> +EXPORT_SYMBOL(page_mapping);
>
>  /* Slow path of page_mapcount() for compound pages */
>  int __page_mapcount(struct page *page)
>
