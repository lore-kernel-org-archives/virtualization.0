From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 01/16] mm: use put_page to free page instead of
	putback_lru_page
Date: Mon, 4 Apr 2016 15:53:59 +1000
Message-ID: <57020177.60006__24174.5540559807$1459749271$gmane$org@gmail.com>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-2-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459321935-3655-2-git-send-email-minchan@kernel.org>
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
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, jlayton@poochiereds.net, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



On 30/03/16 18:12, Minchan Kim wrote:
> Procedure of page migration is as follows:
>
> First of all, it should isolate a page from LRU and try to
> migrate the page. If it is successful, it releases the page
> for freeing. Otherwise, it should put the page back to LRU
> list.
>
> For LRU pages, we have used putback_lru_page for both freeing
> and putback to LRU list. It's okay because put_page is aware of
> LRU list so if it releases last refcount of the page, it removes
> the page from LRU list. However, It makes unnecessary operations
> (e.g., lru_cache_add, pagevec and flags operations. It would be
> not significant but no worth to do) and harder to support new
> non-lru page migration because put_page isn't aware of non-lru
> page's data structure.
>
> To solve the problem, we can add new hook in put_page with
> PageMovable flags check but it can increase overhead in
> hot path and needs new locking scheme to stabilize the flag check
> with put_page.
>
> So, this patch cleans it up to divide two semantic(ie, put and putback).
> If migration is successful, use put_page instead of putback_lru_page and
> use putback_lru_page only on failure. That makes code more readable
> and doesn't add overhead in put_page.
So effectively when we return from unmap_and_move() the page is either
put_page or putback_lru_page() and the page is gone from under us.
