From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v5 02/12] mm: migrate: support non-lru movable page
	migration
Date: Mon, 16 May 2016 16:17:51 +0900
Message-ID: <20160516071751.GA32079@swordfish>
References: <1462760433-32357-1-git-send-email-minchan@kernel.org>
	<1462760433-32357-3-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1462760433-32357-3-git-send-email-minchan@kernel.org>
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

On (05/09/16 11:20), Minchan Kim wrote:
[..]
> +++ b/include/linux/migrate.h
> @@ -32,11 +32,16 @@ extern char *migrate_reason_names[MR_TYPES];
>  
>  #ifdef CONFIG_MIGRATION
>  
> +extern int PageMovable(struct page *page);
> +extern void __SetPageMovable(struct page *page, struct address_space *mapping);
> +extern void __ClearPageMovable(struct page *page);
>  extern void putback_movable_pages(struct list_head *l);
>  extern int migrate_page(struct address_space *,
>  			struct page *, struct page *, enum migrate_mode);
>  extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>  		unsigned long private, enum migrate_mode mode, int reason);
> +extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
> +extern void putback_movable_page(struct page *page);
>  
>  extern int migrate_prep(void);
>  extern int migrate_prep_local(void);

given that some of Movable users can be built as modules, shouldn't
at least some of those symbols be exported via EXPORT_SYMBOL?

	-ss
