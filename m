From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v1 13/19] zsmalloc: factor page chain functionality out
Date: Mon, 14 Mar 2016 13:58:05 +0900
Message-ID: <20160314045805.GB6159@bbox>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
	<1457681423-26664-14-git-send-email-minchan@kernel.org>
	<56E38870.5090408@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56E38870.5090408@hisilicon.com>
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
To: xuyiping <xuyiping@hisilicon.com>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 12, 2016 at 11:09:36AM +0800, xuyiping wrote:
> 
> 
> On 2016/3/11 15:30, Minchan Kim wrote:
> >For migration, we need to create sub-page chain of zspage
> >dynamically so this patch factors it out from alloc_zspage.
> >
> >As a minor refactoring, it makes OBJ_ALLOCATED_TAG assign
> >more clear in obj_malloc(it could be another patch but it's
> >trivial so I want to put together in this patch).
> >
> >Signed-off-by: Minchan Kim <minchan@kernel.org>
> >---
> >  mm/zsmalloc.c | 78 ++++++++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 45 insertions(+), 33 deletions(-)
> >
> >diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> >index bfc6a048afac..f86f8aaeb902 100644
> >--- a/mm/zsmalloc.c
> >+++ b/mm/zsmalloc.c
> >@@ -977,7 +977,9 @@ static void init_zspage(struct size_class *class, struct page *first_page)
> >  	unsigned long off = 0;
> >  	struct page *page = first_page;
> >
> >-	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
> >+	first_page->freelist = NULL;
> >+	INIT_LIST_HEAD(&first_page->lru);
> >+	set_zspage_inuse(first_page, 0);
> >
> >  	while (page) {
> >  		struct page *next_page;
> >@@ -1022,13 +1024,44 @@ static void init_zspage(struct size_class *class, struct page *first_page)
> >  	set_freeobj(first_page, 0);
> >  }
> >
> >+static void create_page_chain(struct page *pages[], int nr_pages)
> >+{
> >+	int i;
> >+	struct page *page;
> >+	struct page *prev_page = NULL;
> >+	struct page *first_page = NULL;
> >+
> >+	for (i = 0; i < nr_pages; i++) {
> >+		page = pages[i];
> >+
> >+		INIT_LIST_HEAD(&page->lru);
> >+		if (i == 0) {
> >+			SetPagePrivate(page);
> >+			set_page_private(page, 0);
> >+			first_page = page;
> >+		}
> >+
> >+		if (i == 1)
> >+			set_page_private(first_page, (unsigned long)page);
> >+		if (i >= 1)
> >+			set_page_private(page, (unsigned long)first_page);
> >+		if (i >= 2)
> >+			list_add(&page->lru, &prev_page->lru);
> >+		if (i == nr_pages - 1)
> >+			SetPagePrivate2(page);
> >+
> >+		prev_page = page;
> >+	}
> >+}
> >+
> >  /*
> >   * Allocate a zspage for the given size class
> >   */
> >  static struct page *alloc_zspage(struct size_class *class, gfp_t flags)
> >  {
> >-	int i, error;
> >+	int i;
> >  	struct page *first_page = NULL, *uninitialized_var(prev_page);
> >+	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
> >
> >  	/*
> >  	 * Allocate individual pages and link them together as:
> >@@ -1041,43 +1074,23 @@ static struct page *alloc_zspage(struct size_class *class, gfp_t flags)
> 
> 	*uninitialized_var(prev_page) in alloc_zspage is not in use more.

True.
It says why we should avoid uninitialized_var if possible.
If we didn't use uninitialized_var, compiler could warn about it
when I did build test.

Thanks.
