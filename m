From: Will Deacon <will@kernel.org>
Subject: [PATCH 04/13] vhost: Remove redundant use of read_barrier_depends()
	barrier
Date: Fri,  8 Nov 2019 17:01:11 +0000
Message-ID: <20191108170120.22331-5-will__7212.52360833518$1573232539$gmane$org@kernel.org>
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

Since commit 76ebbe78f739 ("locking/barriers: Add implicit
smp_read_barrier_depends() to READ_ONCE()"), there is no need to use
'smp_read_barrier_depends()' outside of the Alpha architecture code.

Unfortunately, there is precisely >one< user in the vhost code, and
there isn't an obvious 'READ_ONCE()' access making the barrier
redundant. However, on closer inspection (thanks, Jason), it appears
that vring synchronisation between the producer and consumer occurs via
the 'avail_idx' field, which is followed up by an 'rmb()' in
'vhost_get_vq_desc()', making the 'read_barrier_depends()' redundant on
Alpha.

Jason says:

  | I'm also confused about the barrier here, basically in driver side
  | we did:
  |
  | 1) allocate pages
  | 2) store pages in indirect->addr
  | 3) smp_wmb()
  | 4) increase the avail idx (somehow a tail pointer of vring)
  |
  | in vhost we did:
  |
  | 1) read avail idx
  | 2) smp_rmb()
  | 3) read indirect->addr
  | 4) read from indirect->addr
  |
  | It looks to me even the data dependency barrier is not necessary
  | since we have rmb() which is sufficient for us to the correct
  | indirect->addr and driver are not expected to do any writing to
  | indirect->addr after avail idx is increased

Remove the redundant barrier invocation.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vhost.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 36ca2cf419bf..865bc91b783c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2128,11 +2128,6 @@ static int get_indirect(struct vhost_virtqueue *vq,
 		return ret;
 	}
 	iov_iter_init(&from, READ, vq->indirect, ret, len);
-
-	/* We will use the result as an address to read from, so most
-	 * architectures only need a compiler barrier here. */
-	read_barrier_depends();
-
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
