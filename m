From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/16] Support non-lru page migration
Date: Wed, 30 Mar 2016 16:11:41 -0700
Message-ID: <20160330161141.4332b189e7a4930e117d765b@linux-foundation.org>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459321935-3655-1-git-send-email-minchan@kernel.org>
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
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, jlayton@poochiereds.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 30 Mar 2016 16:11:59 +0900 Minchan Kim <minchan@kernel.org> wrote:

> Recently, I got many reports about perfermance degradation
> in embedded system(Android mobile phone, webOS TV and so on)
> and failed to fork easily.
> 
> The problem was fragmentation caused by zram and GPU driver
> pages. Their pages cannot be migrated so compaction cannot
> work well, either so reclaimer ends up shrinking all of working
> set pages. It made system very slow and even to fail to fork
> easily.
> 
> Other pain point is that they cannot work with CMA.
> Most of CMA memory space could be idle(ie, it could be used
> for movable pages unless driver is using) but if driver(i.e.,
> zram) cannot migrate his page, that memory space could be
> wasted. In our product which has big CMA memory, it reclaims
> zones too exccessively although there are lots of free space
> in CMA so system was very slow easily.
> 
> To solve these problem, this patch try to add facility to
> migrate non-lru pages via introducing new friend functions
> of migratepage in address_space_operation and new page flags.
> 
> 	(isolate_page, putback_page)
> 	(PG_movable, PG_isolated)
> 
> For details, please read description in
> "mm/compaction: support non-lru movable page migration".

OK, I grabbed all these.

I wonder about testing coverage during the -next period.  How many
people are likely to exercise these code paths in a serious way before
it all hits mainline?
