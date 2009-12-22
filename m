From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH] vhost-net: defer f->private_data until setup succeeds
Date: Tue, 22 Dec 2009 11:02:28 -0800
Message-ID: <20091222190228.GB2095__21718.0713698783$1261508597$gmane$org@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Trivial change, just for readability.  The filp is not installed on
failure, so the current code is not incorrect (also vhost_dev_init
currently has no failure case).  This just treats setting f->private_data
as something with global scope (sure, true only after fd_install).

Signed-off-by: Chris Wright <chrisw@redhat.com>
---
 drivers/vhost/net.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 22d5fef..0697ab2 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -326,7 +326,6 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	int r;
 	if (!n)
 		return -ENOMEM;
-	f->private_data = n;
 	n->vqs[VHOST_NET_VQ_TX].handle_kick = handle_tx_kick;
 	n->vqs[VHOST_NET_VQ_RX].handle_kick = handle_rx_kick;
 	r = vhost_dev_init(&n->dev, n->vqs, VHOST_NET_VQ_MAX);
@@ -338,6 +337,9 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, POLLOUT);
 	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, POLLIN);
 	n->tx_poll_state = VHOST_NET_POLL_DISABLED;
+
+	f->private_data = n;
+
 	return 0;
 }
