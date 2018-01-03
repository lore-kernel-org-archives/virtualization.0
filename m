From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Subject: [tip:core/rcu] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Wed, 3 Jan 2018 08:08:47 -0800
Message-ID: <tip-3a5db0b108e0a40f08c2bcff6a675dbf632b91e0__33513.5190784515$1514995712$gmane$org@git.kernel.org>
Reply-To: virtualization@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com,
	tglx@linutronix.de, linux-kernel@vger.kernel.org, mst@redhat.com,
	hpa@zytor.com, netdev@vger.kernel.org, mingo@kernel.org,
	kvm@vger.kernel.org, jasowang@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: linux-tip-commits@vger.kernel.org
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, hpa@zytor.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  3a5db0b108e0a40f08c2bcff6a675dbf632b91e0
Gitweb:     https://git.kernel.org/tip/3a5db0b108e0a40f08c2bcff6a675dbf632b91e0
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 27 Nov 2017 09:45:10 -0800
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Tue, 5 Dec 2017 11:57:55 -0800

drivers/vhost: Remove now-redundant read_barrier_depends()

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
index 33ac2b1..78b5940 100644
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
