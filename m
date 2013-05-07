From: Asias He <asias@redhat.com>
Subject: [PATCH 1/4] vhost-net: Always access vq->private_data under vq mutex
Date: Tue,  7 May 2013 14:54:33 +0800
Message-ID: <1367909676-11788-2-git-send-email-asias@redhat.com>
References: <1367909676-11788-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367909676-11788-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 2b51e23..b616d9a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -349,12 +349,11 @@ static void handle_tx(struct vhost_net *net)
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy, zcopy_used;
 
-	/* TODO: check that we are running from vhost_worker? */
-	sock = rcu_dereference_check(vq->private_data, 1);
+	mutex_lock(&vq->mutex);
+	sock = vq->private_data;
 	if (!sock)
-		return;
+		goto out;
 
-	mutex_lock(&vq->mutex);
 	vhost_disable_notify(&net->dev, vq);
 
 	hdr_size = nvq->vhost_hlen;
@@ -463,7 +462,7 @@ static void handle_tx(struct vhost_net *net)
 			break;
 		}
 	}
-
+out:
 	mutex_unlock(&vq->mutex);
 }
 
@@ -572,14 +571,14 @@ static void handle_rx(struct vhost_net *net)
 	s16 headcount;
 	size_t vhost_hlen, sock_hlen;
 	size_t vhost_len, sock_len;
-	/* TODO: check that we are running from vhost_worker? */
-	struct socket *sock = rcu_dereference_check(vq->private_data, 1);
-
-	if (!sock)
-		return;
+	struct socket *sock;
 
 	mutex_lock(&vq->mutex);
+	sock = vq->private_data;
+	if (!sock)
+		goto out;
 	vhost_disable_notify(&net->dev, vq);
+
 	vhost_hlen = nvq->vhost_hlen;
 	sock_hlen = nvq->sock_hlen;
 
@@ -654,7 +653,7 @@ static void handle_rx(struct vhost_net *net)
 			break;
 		}
 	}
-
+out:
 	mutex_unlock(&vq->mutex);
 }
 
-- 
1.8.1.4
