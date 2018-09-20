From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH net-next] vhost_net: add a missing error return
Date: Thu, 20 Sep 2018 13:01:59 +0300
Message-ID: <20180920100158.GA9551@mwanda>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We accidentally left out this error return so it leads to some use after
free bugs later on.

Fixes: 0a0be13b8fe2 ("vhost_net: batch submitting XDP buffers to underlayer sockets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index dd4e0a301635..1bff6bc8161a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1244,6 +1244,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		kfree(vqs);
 		kvfree(n);
 		kfree(queue);
+		return -ENOMEM;
 	}
 	n->vqs[VHOST_NET_VQ_TX].xdp = xdp;
