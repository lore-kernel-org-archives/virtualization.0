From: Will Deacon <will@kernel.org>
Subject: [PATCH 06/13] READ_ONCE: Remove smp_read_barrier_depends() invocation
Date: Fri,  8 Nov 2019 17:01:13 +0000
Message-ID: <20191108170120.22331-7-will__13957.3869457067$1573232560$gmane$org@kernel.org>
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

Alpha overrides '__read_once_size_n()' directly, so there's no need to
use 'smp_read_barrier_depends()' in the core code.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 2c2ac0948c94..2e3289268a89 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -102,7 +102,6 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 		__read_once_size(&(x), __u.__c, sizeof(x));		\
 	else								\
 		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
 	__u.__val;							\
 })
 #define READ_ONCE(x) __READ_ONCE(x, 1)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
