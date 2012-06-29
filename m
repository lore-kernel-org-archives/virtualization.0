From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH v2 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Fri, 29 Jun 2012 16:31:57 +0100
Message-ID: <20120629153157.GB13141__19281.7738083706$1340983929$gmane$org@csn.ul.ie>
References: <cover.1340916058.git.aquini@redhat.com>
	<d0f33a6492501a0d420abbf184f9b956cff3e3fc.1340916058.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d0f33a6492501a0d420abbf184f9b956cff3e3fc.1340916058.git.aquini@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 28, 2012 at 06:49:39PM -0300, Rafael Aquini wrote:
> This patch introduces the helper functions as well as the necessary changes
> to teach compaction and migration bits how to cope with pages which are
> part of a guest memory balloon, in order to make them movable by memory
> compaction procedures.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

I have two minor comments but it is not critical they be addressed. If you
doa V3 then fix it but if it is picked up as it is, I'm ok with that.
From a compaction point of view;

Acked-by: Mel Gorman <mel@csn.ul.ie>

> ---
>  include/linux/mm.h |   16 ++++++++
>  mm/compaction.c    |  110 +++++++++++++++++++++++++++++++++++++++++++---------
>  mm/migrate.c       |   30 +++++++++++++-
>  3 files changed, 136 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b36d08c..35568fc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1629,5 +1629,21 @@ static inline unsigned int debug_guardpage_minorder(void) { return 0; }
>  static inline bool page_is_guard(struct page *page) { return false; }
>  #endif /* CONFIG_DEBUG_PAGEALLOC */
>  
> +#if (defined(CONFIG_VIRTIO_BALLOON) || \
> +	defined(CONFIG_VIRTIO_BALLOON_MODULE)) && defined(CONFIG_COMPACTION)
> +extern bool isolate_balloon_page(struct page *);
> +extern bool putback_balloon_page(struct page *);
> +extern struct address_space *balloon_mapping;
> +
> +static inline bool is_balloon_page(struct page *page)
> +{
> +        return (page->mapping == balloon_mapping) ? true : false;
> +}
> +#else
> +static inline bool is_balloon_page(struct page *page)       { return false; }
> +static inline bool isolate_balloon_page(struct page *page)  { return false; }
> +static inline bool putback_balloon_page(struct page *page)  { return false; }
> +#endif /* (VIRTIO_BALLOON || VIRTIO_BALLOON_MODULE) && COMPACTION */
> +
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */

isolate_balloon_page is only used in compaction.c and could declared static
to compaction.c. You could move them all between struct compact_control
and release_pages to avoid forward declarations.

> <SNIP>
> +/* putback_lru_page() counterpart for a ballooned page */
> +bool putback_balloon_page(struct page *page)
> +{
> +	if (WARN_ON(!is_balloon_page(page)))
> +		return false;
> +
> +	if (likely(trylock_page(page))) {
> +		if(is_balloon_page(page)) {

Stick a space in there. Run checkpatch.pl if you haven't already. I suspect
it would have caught this.

As I said, not worth spinning a V3 for :)

-- 
Mel Gorman
SUSE Labs
