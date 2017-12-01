From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Fri,  1 Dec 2017 11:51:16 -0800
Message-ID: <1512157876-24665-21-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171201195053.GA23494@linux.vnet.ibm.com>
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
Cc: tglx@linutronix.de, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, peterz@infradead.org, fweisbec@gmail.com, jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, oleg@redhat.com, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, dipankar@in.ibm.com, akpm@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Because READ_ONCE() now implies read_barrier_depends(), the
read_barrier_depends() in next_desc() is now redundant.  This commit
therefore removes it and the related comments.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: <kvm@vger.kernel.org>
Cc: <virtualization@lists.linux-foundation.org>
Cc: <netdev@vger.kernel.org>
---
 drivers/vhost/vhost.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 33ac2b186b85..78b5940a415a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1877,12 +1877,7 @@ static unsigned next_desc(struct vhost_virtqueue *vq, struct vring_desc *desc)
 		return -1U;
 
 	/* Check they're not leading us off end of descriptors. */
-	next = vhost16_to_cpu(vq, desc->next);
-	/* Make sure compiler knows to grab that: we don't want it changing! */
-	/* We will use the result as an index in an array, so most
-	 * architectures only need a compiler barrier here. */
-	read_barrier_depends();
-
+	next = vhost16_to_cpu(vq, READ_ONCE(desc->next));
 	return next;
 }
 
-- 
2.5.2
