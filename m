From: wexu@redhat.com
Subject: [PATCH 3/3] tap: free skb if flags error
Date: Fri,  1 Dec 2017 00:54:29 -0500
Message-ID: <1512107669-27572-4-git-send-email-wexu__31333.5087536418$1512195569$gmane$org@redhat.com>
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

tap_recvmsg() supports accepting skb by msg_control after
commit 3b4ba04acca8 ("tap: support receiving skb from msg_control"),
the skb if presented should be freed within the function, otherwise
it would be leaked.

Signed-off-by: Wei Xu <wexu@redhat.com>
Reported-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
---
 drivers/net/tap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index e9489b8..1c66b75 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1154,9 +1154,13 @@ static int tap_recvmsg(struct socket *sock, struct msghdr *m,
 		       size_t total_len, int flags)
 {
 	struct tap_queue *q = container_of(sock, struct tap_queue, sock);
+	struct sk_buff *skb = m->msg_control;
 	int ret;
-	if (flags & ~(MSG_DONTWAIT|MSG_TRUNC))
+	if (flags & ~(MSG_DONTWAIT|MSG_TRUNC)) {
+		if (skb)
+			kfree_skb(skb);
 		return -EINVAL;
+	}
 	ret = tap_do_read(q, &m->msg_iter, flags & MSG_DONTWAIT,
 			  m->msg_control);
 	if (ret > total_len) {
-- 
1.8.3.1
