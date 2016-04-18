From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 10/16] zsmalloc: factor page chain functionality out
Date: Mon, 18 Apr 2016 09:33:05 +0900
Message-ID: <20160418003305.GA5882__7898.47759665481$1460939515$gmane$org@swordfish>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-11-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1459321935-3655-11-git-send-email-minchan@kernel.org>
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
> @@ -1421,7 +1434,6 @@ static unsigned long obj_malloc(struct size_class *class,
>  	unsigned long m_offset;
>  	void *vaddr;
>  
> -	handle |= OBJ_ALLOCATED_TAG;

a nitpick, why did you replace this ALLOCATED_TAG assignment
with 2 'handle | OBJ_ALLOCATED_TAG'?

	-ss

>  	obj = get_freeobj(first_page);
>  	objidx_to_page_and_offset(class, first_page, obj,
>  				&m_page, &m_offset);
> @@ -1431,10 +1443,10 @@ static unsigned long obj_malloc(struct size_class *class,
>  	set_freeobj(first_page, link->next >> OBJ_ALLOCATED_TAG);
>  	if (!class->huge)
>  		/* record handle in the header of allocated chunk */
> -		link->handle = handle;
> +		link->handle = handle | OBJ_ALLOCATED_TAG;
>  	else
>  		/* record handle in first_page->private */
> -		set_page_private(first_page, handle);
> +		set_page_private(first_page, handle | OBJ_ALLOCATED_TAG);
>  	kunmap_atomic(vaddr);
>  	mod_zspage_inuse(first_page, 1);
>  	zs_stat_inc(class, OBJ_USED, 1);
