From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v11 3/7] mm: introduce a common interface for balloon
	pages mobility
Date: Wed, 7 Nov 2012 19:34:28 -0200
Message-ID: <20121107213427.GA10444__48149.488590616$1352324122$gmane$org@optiplex.redhat.com>
References: <cover.1352256081.git.aquini@redhat.com>
	<4ea10ef1eb1544e12524c8ca7df20cf621395463.1352256087.git.aquini@redhat.com>
	<20121107130207.214f16ea.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121107130207.214f16ea.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 07, 2012 at 01:02:07PM -0800, Andrew Morton wrote:
> On Wed,  7 Nov 2012 01:05:50 -0200
> Rafael Aquini <aquini@redhat.com> wrote:
> 
> > Memory fragmentation introduced by ballooning might reduce significantly
> > the number of 2MB contiguous memory blocks that can be used within a guest,
> > thus imposing performance penalties associated with the reduced number of
> > transparent huge pages that could be used by the guest workload.
> > 
> > This patch introduces a common interface to help a balloon driver on
> > making its page set movable to compaction, and thus allowing the system
> > to better leverage the compation efforts on memory defragmentation.
> 
> 
> mm/migrate.c: In function 'unmap_and_move':
> mm/migrate.c:899: error: 'COMPACTBALLOONRELEASED' undeclared (first use in this function)
> mm/migrate.c:899: error: (Each undeclared identifier is reported only once
> mm/migrate.c:899: error: for each function it appears in.)
> 
> You've been bad - you didn't test with your feature disabled. 
> Please do that.  And not just compilation testing.
>

Gasp... Shame on me, indeed. balloon_event_count() was a macro and I had it
tested a couple of review rounds earlier. You requested me to get rid of
preprocessor pirotech, and I did but I miserably failed on re-testing it.
 
I'm pretty sure Santa is not going to visit me this year.

Do you want me to resubmit this?

> 
> We can fix this one with a sucky macro.  I think that's better than
> unconditionally defining the enums.
> 
> --- a/include/linux/balloon_compaction.h~mm-introduce-a-common-interface-for-balloon-pages-mobility-fix
> +++ a/include/linux/balloon_compaction.h
> @@ -207,10 +207,8 @@ static inline gfp_t balloon_mapping_gfp_
>  	return GFP_HIGHUSER;
>  }
>  
> -static inline void balloon_event_count(enum vm_event_item item)
> -{
> -	return;
> -}
> +/* A macro, to avoid generating references to the undefined COMPACTBALLOON* */
> +#define balloon_event_count(item) do { } while (0)
>  
>  static inline bool balloon_compaction_check(void)
>  {
> 
