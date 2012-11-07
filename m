From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 3/7] mm: introduce a common interface for balloon
	pages mobility
Date: Wed, 7 Nov 2012 13:02:07 -0800
Message-ID: <20121107130207.214f16ea.akpm@linux-foundation.org>
References: <cover.1352256081.git.aquini@redhat.com>
	<4ea10ef1eb1544e12524c8ca7df20cf621395463.1352256087.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ea10ef1eb1544e12524c8ca7df20cf621395463.1352256087.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  7 Nov 2012 01:05:50 -0200
Rafael Aquini <aquini@redhat.com> wrote:

> Memory fragmentation introduced by ballooning might reduce significantly
> the number of 2MB contiguous memory blocks that can be used within a guest,
> thus imposing performance penalties associated with the reduced number of
> transparent huge pages that could be used by the guest workload.
> 
> This patch introduces a common interface to help a balloon driver on
> making its page set movable to compaction, and thus allowing the system
> to better leverage the compation efforts on memory defragmentation.


mm/migrate.c: In function 'unmap_and_move':
mm/migrate.c:899: error: 'COMPACTBALLOONRELEASED' undeclared (first use in this function)
mm/migrate.c:899: error: (Each undeclared identifier is reported only once
mm/migrate.c:899: error: for each function it appears in.)

You've been bad - you didn't test with your feature disabled. 
Please do that.  And not just compilation testing.


We can fix this one with a sucky macro.  I think that's better than
unconditionally defining the enums.

--- a/include/linux/balloon_compaction.h~mm-introduce-a-common-interface-for-balloon-pages-mobility-fix
+++ a/include/linux/balloon_compaction.h
@@ -207,10 +207,8 @@ static inline gfp_t balloon_mapping_gfp_
 	return GFP_HIGHUSER;
 }
 
-static inline void balloon_event_count(enum vm_event_item item)
-{
-	return;
-}
+/* A macro, to avoid generating references to the undefined COMPACTBALLOON* */
+#define balloon_event_count(item) do { } while (0)
 
 static inline bool balloon_compaction_check(void)
 {
