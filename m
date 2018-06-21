From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost_net: validate sock before trying to put its fd
Date: Thu, 21 Jun 2018 13:11:31 +0800
Message-ID: <1529557891-4828-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Sock will be NULL if we pass -1 to vhost_net_set_backend(), but when
we meet errors during ubuf allocation, the code does not check for
NULL before calling sockfd_put(), this will lead NULL
dereferencing. Fixing by checking sock pointer before.

Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 986058a..b97a994 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1208,7 +1208,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	if (ubufs)
 		vhost_net_ubuf_put_wait_and_free(ubufs);
 err_ubufs:
-	sockfd_put(sock);
+	if (sock)
+		sockfd_put(sock);
 err_vq:
 	mutex_unlock(&vq->mutex);
 err:
-- 
2.7.4
