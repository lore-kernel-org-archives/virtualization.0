From: Will Deacon <will@kernel.org>
Subject: [PATCH 11/18] tools/memory-model: Remove smp_read_barrier_depends() from informal doc
Date: Tue, 30 Jun 2020 18:37:27 +0100
Message-ID: <20200630173734.14057-12-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

smp_read_barrier_depends() has gone the way of mmiowb() and so many
esoteric memory barriers before it. Drop the two mentions of this
deceased barrier from the LKMM informal explanation document.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 .../Documentation/explanation.txt             | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index e91a2eb19592..01adf9e0ebac 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1122,12 +1122,10 @@ maintain at least the appearance of FIFO order.
 In practice, this difficulty is solved by inserting a special fence
 between P1's two loads when the kernel is compiled for the Alpha
 architecture.  In fact, as of version 4.15, the kernel automatically
-adds this fence (called smp_read_barrier_depends() and defined as
-nothing at all on non-Alpha builds) after every READ_ONCE() and atomic
-load.  The effect of the fence is to cause the CPU not to execute any
-po-later instructions until after the local cache has finished
-processing all the stores it has already received.  Thus, if the code
-was changed to:
+adds this fence after every READ_ONCE() and atomic load on Alpha.  The
+effect of the fence is to cause the CPU not to execute any po-later
+instructions until after the local cache has finished processing all
+the stores it has already received.  Thus, if the code was changed to:
 
 	P1()
 	{
@@ -1146,14 +1144,14 @@ READ_ONCE() or another synchronization primitive rather than accessed
 directly.
 
 The LKMM requires that smp_rmb(), acquire fences, and strong fences
-share this property with smp_read_barrier_depends(): They do not allow
-the CPU to execute any po-later instructions (or po-later loads in the
-case of smp_rmb()) until all outstanding stores have been processed by
-the local cache.  In the case of a strong fence, the CPU first has to
-wait for all of its po-earlier stores to propagate to every other CPU
-in the system; then it has to wait for the local cache to process all
-the stores received as of that time -- not just the stores received
-when the strong fence began.
+share this property: They do not allow the CPU to execute any po-later
+instructions (or po-later loads in the case of smp_rmb()) until all
+outstanding stores have been processed by the local cache.  In the
+case of a strong fence, the CPU first has to wait for all of its
+po-earlier stores to propagate to every other CPU in the system; then
+it has to wait for the local cache to process all the stores received
+as of that time -- not just the stores received when the strong fence
+began.
 
 And of course, none of this matters for any architecture other than
 Alpha.
-- 
2.27.0.212.ge8ba1cc988-goog
