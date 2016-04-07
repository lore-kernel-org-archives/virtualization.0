From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v3 03/16] mm: add non-lru movable page support document
Date: Thu, 7 Apr 2016 11:27:14 +0900
Message-ID: <20160407022714.GC15178__23658.3106955097$1459996040$gmane$org@bbox>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-4-git-send-email-minchan@kernel.org>
	<56FE87EA.60806@suse.cz> <20160404022552.GD6543@bbox>
	<57026782.3020201@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <57026782.3020201@suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: jlayton@poochiereds.net, Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Sangseok Lee <sangseok.lee@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, koct9i@gmail.com, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 04, 2016 at 03:09:22PM +0200, Vlastimil Babka wrote:
> On 04/04/2016 04:25 AM, Minchan Kim wrote:
> >>
> >>Ah, I see, so it's designed with page lock to handle the concurrent isolations etc.
> >>
> >>In http://marc.info/?l=linux-mm&m=143816716511904&w=2 Mel has warned
> >>about doing this in general under page_lock and suggested that each
> >>user handles concurrent calls to isolate_page() internally. Might be
> >>more generic that way, even if all current implementers will
> >>actually use the page lock.
> >
> >We need PG_lock for two reasons.
> >
> >Firstly, it guarantees page's flags operation(i.e., PG_movable, PG_isolated)
> >atomicity. Another thing is for stability for page->mapping->a_ops.
> >
> >For example,
> >
> >isolate_migratepages_block
> >         if (PageMovable(page))
> >                 isolate_movable_page
> >                         get_page_unless_zero <--- 1
> >                         trylock_page
> >                         page->mapping->a_ops->isolate_page <--- 2
> >
> >Between 1 and 2, driver can nullify page->mapping so we need PG_lock
> 
> Hmm I see, that really doesn't seem easily solvable without page_lock.
> My idea is that compaction code would just check PageMovable() and
> PageIsolated() to find a candidate.
> page->mapping->a_ops->isolate_page would do the driver-specific
> necessary locking, revalidate if the page state and succeed
> isolation, or fail. It would need to handle the possibility that the

So you mean that VM can try to isolate false-positive page of the driver?
I don't think it's a good idea. For handling that, every driver should
keep some logics to handle such false-positive which needs each own
data structure or something to remember the page passed from VM
is valid or not. It makes driver's logic more complicated and need
more codes to handle it. It's not a good deal.

> page already doesn't belong to the mapping, which is probably not a
> problem. But what if the driver is a module that was already
> unloaded, and even though we did NULL-check each part from page to
> isolate_page, it points to a function that's already gone? That
> would need some extra handling to prevent that, hm...

Yes, driver should clean up pages is is using. For it, we need some lock.
I think page_lock is good for it because we are migrating *page* and page_lock
have been used it for a long time in migration path.
