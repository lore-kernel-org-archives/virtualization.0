From: wexu@redhat.com
Subject: [PATCH 3/3] tap: free skb if flags error
Date: Fri,  1 Dec 2017 05:10:38 -0500
Message-ID: <1512123038-15773-4-git-send-email-wexu__15621.6414332905$1512195642$gmane$org@redhat.com>
References: <1512123038-15773-1-git-send-email-wexu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1512123038-15773-1-git-send-email-wexu@redhat.com>
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
 drivers/net/tap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index e9489b8..0a886fda 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -829,8 +829,11 @@ static ssize_t tap_do_read(struct tap_queue *q,
 	DEFINE_WAIT(wait);
 	ssize_t ret = 0;
 
-	if (!iov_iter_count(to))
+	if (!iov_iter_count(to)) {
+		if (skb)
+			kfree_skb(skb);
 		return 0;
+	}
 
 	if (skb)
 		goto put;
@@ -1154,11 +1157,14 @@ static int tap_recvmsg(struct socket *sock, struct msghdr *m,
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
-	ret = tap_do_read(q, &m->msg_iter, flags & MSG_DONTWAIT,
-			  m->msg_control);
+	}
+	ret = tap_do_read(q, &m->msg_iter, flags & MSG_DONTWAIT, skb);
 	if (ret > total_len) {
 		m->msg_flags |= MSG_TRUNC;
 		ret = flags & MSG_TRUNC ? ret : total_len;
-- 
1.8.3.1
