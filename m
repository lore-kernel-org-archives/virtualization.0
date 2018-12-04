From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Subject: [tip:core/rcu] drivers/vhost: Replace synchronize_rcu_bh() with
	synchronize_rcu()
Date: Tue, 4 Dec 2018 14:39:33 -0800
Message-ID: <tip-d05faa5f1ac50beef77b4ceba0e8e157d41146e2@git.kernel.org>
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	netdev@vger.kernel.org, mingo@kernel.org, paulmck@linux.ibm.com,
	hpa@zytor.com, kvm@vger.kernel.org
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, hpa@zytor.com, tglx@linutronix.de, paulmck@linux.ibm.com, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  d05faa5f1ac50beef77b4ceba0e8e157d41146e2
Gitweb:     https://git.kernel.org/tip/d05faa5f1ac50beef77b4ceba0e8e157d41146e2
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Mon, 5 Nov 2018 17:14:53 -0800
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Tue, 27 Nov 2018 09:21:37 -0800

drivers/vhost: Replace synchronize_rcu_bh() with synchronize_rcu()

Now that synchronize_rcu() waits for bh-disable regions of code as well
as RCU read-side critical sections, synchronize_rcu_bh() can be replaced
by synchronize_rcu().  This commit therefore makes this change.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: <kvm@vger.kernel.org>
Cc: <virtualization@lists.linux-foundation.org>
Cc: <netdev@vger.kernel.org>
---
 drivers/vhost/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ab11b2bee273..564ead864028 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1359,7 +1359,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	if (rx_sock)
 		sockfd_put(rx_sock);
 	/* Make sure no callbacks are outstanding */
-	synchronize_rcu_bh();
+	synchronize_rcu();
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
 	vhost_net_flush(n);
