From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 2/2] mm: reduce atomic use on use_mm fast path
Date: Thu, 17 Sep 2009 10:22:39 +0300
Message-ID: <20090917072239.GC18115__2015.89644789255$1253172315$gmane$org@redhat.com>
References: <cover.1253171695.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1253171695.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-mm@kvack.org, akpm@linux-founda
List-Id: virtualization@lists.linuxfoundation.org

When mm switched to matches that of active mm, we don't need to
increment and then drop the mm count.  In a simple benchmark this
happens in about 50% of time.  Making that conditional reduces
contention on that cache line on SMP systems.

Acked-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/mmu_context.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/mmu_context.c b/mm/mmu_context.c
index fd473b5..ded9081 100644
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -26,13 +26,16 @@ void use_mm(struct mm_struct *mm)
 
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
-	atomic_inc(&mm->mm_count);
+	if (active_mm != mm) {
+		atomic_inc(&mm->mm_count);
+		tsk->active_mm = mm;
+	}
 	tsk->mm = mm;
-	tsk->active_mm = mm;
 	switch_mm(active_mm, mm, tsk);
 	task_unlock(tsk);
 
-	mmdrop(active_mm);
+	if (active_mm != mm)
+		mmdrop(active_mm);
 }
 
 /*
-- 
1.6.2.5
