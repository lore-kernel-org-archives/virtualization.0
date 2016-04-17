From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v3 06/16] zsmalloc: squeeze inuse into page->mapping
Date: Mon, 18 Apr 2016 00:08:04 +0900
Message-ID: <20160417150804.GA575__11987.6720746563$1460993740$gmane$org@swordfish>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-7-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1459321935-3655-7-git-send-email-minchan@kernel.org>
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
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On (03/30/16 16:12), Minchan Kim wrote:
[..]
> +static int get_zspage_inuse(struct page *first_page)
> +{
> +	struct zs_meta *m;
> +
> +	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
> +
> +	m = (struct zs_meta *)&first_page->mapping;
..
> +static void set_zspage_inuse(struct page *first_page, int val)
> +{
> +	struct zs_meta *m;
> +
> +	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
> +
> +	m = (struct zs_meta *)&first_page->mapping;
..
> +static void mod_zspage_inuse(struct page *first_page, int val)
> +{
> +	struct zs_meta *m;
> +
> +	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
> +
> +	m = (struct zs_meta *)&first_page->mapping;
..
>  static void get_zspage_mapping(struct page *first_page,
>  				unsigned int *class_idx,
>  				enum fullness_group *fullness)
>  {
> -	unsigned long m;
> +	struct zs_meta *m;
> +
>  	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
> +	m = (struct zs_meta *)&first_page->mapping;
..
>  static void set_zspage_mapping(struct page *first_page,
>  				unsigned int class_idx,
>  				enum fullness_group fullness)
>  {
> +	struct zs_meta *m;
> +
>  	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
>  
> +	m = (struct zs_meta *)&first_page->mapping;
> +	m->fullness = fullness;
> +	m->class = class_idx;
>  }


a nitpick: this

	struct zs_meta *m;
	VM_BUG_ON_PAGE(!is_first_page(first_page), first_page);
	m = (struct zs_meta *)&first_page->mapping;


seems to be common in several places, may be it makes sense to
factor it out and turn into a macro or a static inline helper?

other than that, looks good to me

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
