From: wexu@redhat.com
Subject: [PATCH 2/3] tun: free skb in early errors
Date: Fri,  1 Dec 2017 00:54:28 -0500
Message-ID: <1512107669-27572-3-git-send-email-wexu__36230.428753379$1512195564$gmane$org@redhat.com>
References: <1512107669-27572-1-git-send-email-wexu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1512107669-27572-1-git-send-email-wexu@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.vnet.ibm.com, wexu@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Xu <wexu@redhat.com>

tun_recvmsg() supports accepting skb by msg_control after
commit ac77cfd4258f ("tun: support receiving skb through msg_control"),
the skb if presented should be freed within the function, otherwise it
would be leaked.

Signed-off-by: Wei Xu <wexu@redhat.com>
Reported-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
---
 drivers/net/tun.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 6a7bde9..5563430 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2067,14 +2067,17 @@ static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
 {
 	struct tun_file *tfile = container_of(sock, struct tun_file, socket);
 	struct tun_struct *tun = tun_get(tfile);
+	struct sk_buff *skb = m->msg_control;
 	int ret;
 
-	if (!tun)
-		return -EBADFD;
+	if (!tun) {
+		ret = -EBADFD;
+		goto out_free_skb;
+	}
 
 	if (flags & ~(MSG_DONTWAIT|MSG_TRUNC|MSG_ERRQUEUE)) {
 		ret = -EINVAL;
-		goto out;
+		goto out_free_skb;
 	}
 	if (flags & MSG_ERRQUEUE) {
 		ret = sock_recv_errqueue(sock->sk, m, total_len,
@@ -2087,6 +2090,11 @@ static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
 		m->msg_flags |= MSG_TRUNC;
 		ret = flags & MSG_TRUNC ? ret : total_len;
 	}
+	goto out;
+
+out_free_skb:
+	if (skb)
+		kfree_skb(skb);
 out:
 	tun_put(tun);
 	return ret;
-- 
1.8.3.1
