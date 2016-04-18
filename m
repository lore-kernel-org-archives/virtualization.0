From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 11/16] zsmalloc: separate free_zspage from
	putback_zspage
Date: Mon, 18 Apr 2016 10:04:08 +0900
Message-ID: <20160418010408.GB5882__40112.5324926854$1460941383$gmane$org@swordfish>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-12-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1459321935-3655-12-git-send-email-minchan@kernel.org>
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

Hello Minchan,

On (03/30/16 16:12), Minchan Kim wrote:
[..]
> @@ -1835,23 +1827,31 @@ static void __zs_compact(struct zs_pool *pool, struct size_class *class)
>  			if (!migrate_zspage(pool, class, &cc))
>  				break;
>  
> -			putback_zspage(pool, class, dst_page);
> +			VM_BUG_ON_PAGE(putback_zspage(pool, class,
> +				dst_page) == ZS_EMPTY, dst_page);

can this VM_BUG_ON_PAGE() condition ever be true?

>  		}
>  		/* Stop if we couldn't find slot */
>  		if (dst_page == NULL)
>  			break;
> -		putback_zspage(pool, class, dst_page);
> -		if (putback_zspage(pool, class, src_page) == ZS_EMPTY)
> +		VM_BUG_ON_PAGE(putback_zspage(pool, class,
> +				dst_page) == ZS_EMPTY, dst_page);

hm... this VM_BUG_ON_PAGE(dst_page) is sort of confusing. under what
circumstances it can be true?

a minor nit, it took me some time (need some coffee I guess) to
correctly parse this macro wrapper

		VM_BUG_ON_PAGE(putback_zspage(pool, class,
			dst_page) == ZS_EMPTY, dst_page);

may be do it like:
		fullness = putback_zspage(pool, class, dst_page);
		VM_BUG_ON_PAGE(fullness == ZS_EMPTY, dst_page);


well, if we want to VM_BUG_ON_PAGE() at all. there haven't been any
problems with compaction, is there any specific reason these macros
were added?



> +		if (putback_zspage(pool, class, src_page) == ZS_EMPTY) {
>  			pool->stats.pages_compacted += class->pages_per_zspage;
> -		spin_unlock(&class->lock);
> +			spin_unlock(&class->lock);
> +			free_zspage(pool, class, src_page);

do we really need to free_zspage() out of class->lock?
wouldn't something like this

		if (putback_zspage(pool, class, src_page) == ZS_EMPTY) {
			pool->stats.pages_compacted += class->pages_per_zspage;
			free_zspage(pool, class, src_page);
		}
		spin_unlock(&class->lock);

be simpler?

besides, free_zspage() now updates class stats out of class lock,
not critical but still.

	-ss

> +		} else {
> +			spin_unlock(&class->lock);
> +		}
> +
>  		cond_resched();
>  		spin_lock(&class->lock);
>  	}
>  
>  	if (src_page)
> -		putback_zspage(pool, class, src_page);
> +		VM_BUG_ON_PAGE(putback_zspage(pool, class,
> +				src_page) == ZS_EMPTY, src_page);
>  
>  	spin_unlock(&class->lock);
>  }
