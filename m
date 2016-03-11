From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v1 02/19] mm/compaction: support non-lru movable page
	migration
Date: Fri, 11 Mar 2016 17:35:20 +0900
Message-ID: <20160311083520.GA27206__3828.99145265601$1457685396$gmane$org@bbox>
References: <1457681423-26664-3-git-send-email-minchan@kernel.org>
	<201603111650.Suc95X5j%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201603111650.Suc95X5j%fengguang.wu@intel.com>
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
To: kbuild test robot <lkp@intel.com>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, kbuild-all@01.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, koct9i@gmail.com, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi kbuild,

On Fri, Mar 11, 2016 at 04:11:19PM +0800, kbuild test robot wrote:
> Hi Minchan,
> 
> [auto build test ERROR on v4.5-rc7]
> [cannot apply to next-20160310]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/Support-non-lru-page-migration/20160311-153649
> config: x86_64-nfsroot (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from mm/compaction.c:12:0:
> >> include/linux/compaction.h:87:20: error: static declaration of 'isolate_movable_page' follows non-static declaration
>     static inline bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>                        ^
>    In file included from mm/compaction.c:11:0:
>    include/linux/migrate.h:36:13: note: previous declaration of 'isolate_movable_page' was here
>     extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
>                 ^
>    In file included from mm/compaction.c:12:0:
> >> include/linux/compaction.h:92:20: error: static declaration of 'putback_movable_page' follows non-static declaration
>     static inline void putback_movable_page(struct page *page)
>                        ^
>    In file included from mm/compaction.c:11:0:
>    include/linux/migrate.h:37:13: note: previous declaration of 'putback_movable_page' was here
>     extern void putback_movable_page(struct page *page);
>                 ^
> 
> vim +/isolate_movable_page +87 include/linux/compaction.h
> 
>     81	
>     82	static inline bool compaction_deferred(struct zone *zone, int order)
>     83	{
>     84		return true;
>     85	}
>     86	
>   > 87	static inline bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>     88	{
>     89		return false;
>     90	}
>     91	
>   > 92	static inline void putback_movable_page(struct page *page)
>     93	{
>     94	}
>     95	#endif /* CONFIG_COMPACTION */
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Actually, I made patchset based on v4.5-rc6 but the problem you found is
still problem in v4.5-rc6, too. Thanks for catching it fast.

I should apply following patch to fix the problem.

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 6f040ad379ce..4cd4ddf64cc7 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -84,14 +84,6 @@ static inline bool compaction_deferred(struct zone *zone, int order)
 	return true;
 }
 
-static inline bool isolate_movable_page(struct page *page, isolate_mode_t mode)
-{
-	return false;
-}
-
-static inline void putback_movable_page(struct page *page)
-{
-}
 #endif /* CONFIG_COMPACTION */
 
 #if defined(CONFIG_COMPACTION) && defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)

Thanks.
