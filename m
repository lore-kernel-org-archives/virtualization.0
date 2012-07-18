From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/3] mm: introduce compaction and migration for
	virtio ballooned pages
Date: Wed, 18 Jul 2012 15:46:05 -0700
Message-ID: <20120718154605.cb0591bc.akpm@linux-foundation.org>
References: <cover.1342485774.git.aquini@redhat.com>
	<49f828a9331c9b729fcf77226006921ec5bc52fa.1342485774.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49f828a9331c9b729fcf77226006921ec5bc52fa.1342485774.git.aquini@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Rafael Aquini <aquini@linux.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 17 Jul 2012 13:50:41 -0300
Rafael Aquini <aquini@redhat.com> wrote:

> This patch introduces the helper functions as well as the necessary changes
> to teach compaction and migration bits how to cope with pages which are
> part of a guest memory balloon, in order to make them movable by memory
> compaction procedures.
> 
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1629,5 +1629,20 @@ static inline unsigned int debug_guardpage_minorder(void) { return 0; }
>  static inline bool page_is_guard(struct page *page) { return false; }
>  #endif /* CONFIG_DEBUG_PAGEALLOC */
>  
> +#if (defined(CONFIG_VIRTIO_BALLOON) || \
> +	defined(CONFIG_VIRTIO_BALLOON_MODULE)) && defined(CONFIG_COMPACTION)
> +extern bool putback_balloon_page(struct page *);
> +extern struct address_space *balloon_mapping;
> +
> +static inline bool is_balloon_page(struct page *page)
> +{
> +	return (page->mapping == balloon_mapping) ? true : false;

You can simply do

	return page->mapping == balloon_mapping;

> +}
> +#else
> +static inline bool is_balloon_page(struct page *page)       { return false; }
> +static inline bool isolate_balloon_page(struct page *page)  { return false; }
> +static inline bool putback_balloon_page(struct page *page)  { return false; }
> +#endif /* (VIRTIO_BALLOON || VIRTIO_BALLOON_MODULE) && COMPACTION */

This means that if CONFIG_VIRTIO_BALLOON=y and CONFIG_COMPACTION=n,
is_balloon_page() will always return NULL.  IOW, no pages are balloon
pages!  This is wrong.

I'm not sure what to do about this, apart from renaming the function to
is_compactible_balloon_page() or something similarly aawkward.
