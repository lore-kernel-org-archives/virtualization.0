From: Will Deacon <will@kernel.org>
Subject: [PATCH 09/13] Documentation/barriers: Remove references to
	[smp_]read_barrier_depends()
Date: Fri,  8 Nov 2019 17:01:16 +0000
Message-ID: <20191108170120.22331-10-will__10164.762898215$1573232598$gmane$org@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Josh Triplett <josh@joshtriplett.org>, Yunjae Lee <lyj7694@gmail.com>, SeongJae Park <sj38.park@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Joe Perches <joe@perches.com>, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

The '[smp_]read_barrier_depends()' barrier macros no longer exist as
part of the Linux memory model, so remove all references to them from
the Documentation/ directory.

Although this is fairly mechanical on the whole, we drop the "CACHE
COHERENCY" section entirely from 'memory-barriers.txt' as it doesn't
make any sense now that the dependency barriers have been removed.

Signed-off-by: Will Deacon <will@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.html |  11 +-
 Documentation/memory-barriers.txt             | 156 +-----------------
 2 files changed, 13 insertions(+), 154 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 467251f7fef6..4b8357def8ff 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -577,12 +577,11 @@ guarantee to also allow data elements to be removed from RCU-protected
 linked data structures, again without disrupting RCU readers.
 
 <p>
-This guarantee was only partially premeditated.
-DYNIX/ptx used an explicit memory barrier for publication, but had nothing
-resembling <tt>rcu_dereference()</tt> for subscription, nor did it
-have anything resembling the <tt>smp_read_barrier_depends()</tt>
-that was later subsumed into <tt>rcu_dereference()</tt> and later
-still into <tt>READ_ONCE()</tt>.
+This guarantee was only partially premeditated. DYNIX/ptx used an explicit
+memory barrier for publication, but had nothing resembling
+<tt>rcu_dereference()</tt> for subscription, nor did it have anything
+resembling the dependency-ordering barrier that was later subsumed into
+<tt>rcu_dereference()</tt> and later still into <tt>READ_ONCE()</tt>.
 The need for these operations made itself known quite suddenly at a
 late-1990s meeting with the DEC Alpha architects, back in the days when
 DEC was still a free-standing company.
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..16b6aa7c5fe4 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -556,12 +556,12 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 DATA DEPENDENCY BARRIERS (HISTORICAL)
 -------------------------------------
 
-As of v4.15 of the Linux kernel, an smp_read_barrier_depends() was
-added to READ_ONCE(), which means that about the only people who
-need to pay attention to this section are those working on DEC Alpha
-architecture-specific code and those working on READ_ONCE() itself.
-For those who need it, and for those who are interested in the history,
-here is the story of data-dependency barriers.
+As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
+DEC Alpha, which means that about the only people who need to pay attention
+to this section are those working on DEC Alpha architecture-specific code
+and those working on READ_ONCE() itself.  For those who need it, and for
+those who are interested in the history, here is the story of
+data-dependency barriers.
 
 The usage requirements of data dependency barriers are a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
@@ -2709,144 +2709,6 @@ the properties of the memory window through which devices are accessed and/or
 the use of any special device communication instructions the CPU may have.
 
 
-CACHE COHERENCY
----------------
-
-Life isn't quite as simple as it may appear above, however: for while the
-caches are expected to be coherent, there's no guarantee that that coherency
-will be ordered.  This means that while changes made on one CPU will
-eventually become visible on all CPUs, there's no guarantee that they will
-become apparent in the same order on those other CPUs.
-
-
-Consider dealing with a system that has a pair of CPUs (1 & 2), each of which
-has a pair of parallel data caches (CPU 1 has A/B, and CPU 2 has C/D):
-
-	            :
-	            :                          +--------+
-	            :      +---------+         |        |
-	+--------+  : +--->| Cache A |<------->|        |
-	|        |  : |    +---------+         |        |
-	|  CPU 1 |<---+                        |        |
-	|        |  : |    +---------+         |        |
-	+--------+  : +--->| Cache B |<------->|        |
-	            :      +---------+         |        |
-	            :                          | Memory |
-	            :      +---------+         | System |
-	+--------+  : +--->| Cache C |<------->|        |
-	|        |  : |    +---------+         |        |
-	|  CPU 2 |<---+                        |        |
-	|        |  : |    +---------+         |        |
-	+--------+  : +--->| Cache D |<------->|        |
-	            :      +---------+         |        |
-	            :                          +--------+
-	            :
-
-Imagine the system has the following properties:
-
- (*) an odd-numbered cache line may be in cache A, cache C or it may still be
-     resident in memory;
-
- (*) an even-numbered cache line may be in cache B, cache D or it may still be
-     resident in memory;
-
- (*) while the CPU core is interrogating one cache, the other cache may be
-     making use of the bus to access the rest of the system - perhaps to
-     displace a dirty cacheline or to do a speculative load;
-
- (*) each cache has a queue of operations that need to be applied to that cache
-     to maintain coherency with the rest of the system;
-
- (*) the coherency queue is not flushed by normal loads to lines already
-     present in the cache, even though the contents of the queue may
-     potentially affect those loads.
-
-Imagine, then, that two writes are made on the first CPU, with a write barrier
-between them to guarantee that they will appear to reach that CPU's caches in
-the requisite order:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-					u == 0, v == 1 and p == &u, q == &u
-	v = 2;
-	smp_wmb();			Make sure change to v is visible before
-					 change to p
-	<A:modify v=2>			v is now in cache A exclusively
-	p = &v;
-	<B:modify p=&v>			p is now in cache B exclusively
-
-The write memory barrier forces the other CPUs in the system to perceive that
-the local CPU's caches have apparently been updated in the correct order.  But
-now imagine that the second CPU wants to read those values:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-	...
-			q = p;
-			x = *q;
-
-The above pair of reads may then fail to happen in the expected order, as the
-cacheline holding p may get updated in one of the second CPU's caches while
-the update to the cacheline holding v is delayed in the other of the second
-CPU's caches by some other cache event:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-					u == 0, v == 1 and p == &u, q == &u
-	v = 2;
-	smp_wmb();
-	<A:modify v=2>	<C:busy>
-			<C:queue v=2>
-	p = &v;		q = p;
-			<D:request p>
-	<B:modify p=&v>	<D:commit p=&v>
-			<D:read p>
-			x = *q;
-			<C:read *q>	Reads from v before v updated in cache
-			<C:unbusy>
-			<C:commit v=2>
-
-Basically, while both cachelines will be updated on CPU 2 eventually, there's
-no guarantee that, without intervention, the order of update will be the same
-as that committed on CPU 1.
-
-
-To intervene, we need to interpolate a data dependency barrier or a read
-barrier between the loads (which as of v4.15 is supplied unconditionally
-by the READ_ONCE() macro).  This will force the cache to commit its
-coherency queue before processing any further requests:
-
-	CPU 1		CPU 2		COMMENT
-	===============	===============	=======================================
-					u == 0, v == 1 and p == &u, q == &u
-	v = 2;
-	smp_wmb();
-	<A:modify v=2>	<C:busy>
-			<C:queue v=2>
-	p = &v;		q = p;
-			<D:request p>
-	<B:modify p=&v>	<D:commit p=&v>
-			<D:read p>
-			smp_read_barrier_depends()
-			<C:unbusy>
-			<C:commit v=2>
-			x = *q;
-			<C:read *q>	Reads from v after v updated in cache
-
-
-This sort of problem can be encountered on DEC Alpha processors as they have a
-split cache that improves performance by making better use of the data bus.
-While most CPUs do imply a data dependency barrier on the read when a memory
-access depends on a read, not all do, so it may not be relied on.
-
-Other CPUs may also have split caches, but must coordinate between the various
-cachelets for normal memory accesses.  The semantics of the Alpha removes the
-need for hardware coordination in the absence of memory barriers, which
-permitted Alpha to sport higher CPU clock rates back in the day.  However,
-please note that (again, as of v4.15) smp_read_barrier_depends() should not
-be used except in Alpha arch-specific code and within the READ_ONCE() macro.
-
-
 CACHE COHERENCY VS DMA
 ----------------------
 
@@ -3010,10 +2872,8 @@ caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 
 The Alpha defines the Linux kernel's memory model, although as of v4.15
-the Linux kernel's addition of smp_read_barrier_depends() to READ_ONCE()
-greatly reduced Alpha's impact on the memory model.
-
-See the subsection on "Cache Coherency" above.
+the Linux kernel's addition of smp_mb() to READ_ONCE() on Alpha greatly
+reduced its impact on the memory model.
 
 
 VIRTUAL MACHINE GUESTS
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
