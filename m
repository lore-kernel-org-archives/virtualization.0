From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 00/13] Support non-lru page migration
Date: Wed, 27 Apr 2016 13:20:35 -0700
Message-ID: <20160427132035.e96f99f3420c8fb0020b0fc4@linux-foundation.org>
References: <1461743305-19970-1-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1461743305-19970-1-git-send-email-minchan@kernel.org>
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
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Rafael Aquini <aquini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Chulmin Kim <cmlaika.kim@samsung.com>, Gioh Kim <gi-oh.kim@profitbricks.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kyeongdon Kim <kyeongdon.kim@lge.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 27 Apr 2016 16:48:13 +0900 Minchan Kim <minchan@kernel.org> wrote:

> Recently, I got many reports about perfermance degradation in embedded
> system(Android mobile phone, webOS TV and so on) and easy fork fail.
> 
> The problem was fragmentation caused by zram and GPU driver mainly.
> With memory pressure, their pages were spread out all of pageblock and
> it cannot be migrated with current compaction algorithm which supports
> only LRU pages. In the end, compaction cannot work well so reclaimer
> shrinks all of working set pages. It made system very slow and even to
> fail to fork easily which requires order-[2 or 3] allocations.
> 
> Other pain point is that they cannot use CMA memory space so when OOM
> kill happens, I can see many free pages in CMA area, which is not
> memory efficient. In our product which has big CMA memory, it reclaims
> zones too exccessively to allocate GPU and zram page although there are
> lots of free space in CMA so system becomes very slow easily.
> 
> To solve these problem, this patch tries to add facility to migrate
> non-lru pages via introducing new functions and page flags to help
> migration.

I'm seeing some rejects here against Mel's changes and our patch
bandwidth is getting waaay way ahead of our review bandwidth.  So I
think I'll loadshed this patchset at this time, sorry.
