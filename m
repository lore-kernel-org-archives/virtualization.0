From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH-RESEND] vhost-vsock: fix orphan connection reset
Date: Fri,  9 Dec 2016 01:10:46 +0800
Message-ID: <1481217046-7058-1-git-send-email-bergwolf__21173.0781397366$1481217077$gmane$org@gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

local_addr.svm_cid is host cid. We should check guest cid instead,
which is remote_addr.svm_cid. Otherwise we end up resetting all
connections to all guests.

Cc: stable@vger.kernel.org [4.8+]
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
resending because the last attempt looks to be dropped by vger.
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index e3b30ea..a504e2e0 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -506,7 +506,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 * executing.
 	 */
 
-	if (!vhost_vsock_get(vsk->local_addr.svm_cid)) {
+	if (!vhost_vsock_get(vsk->remote_addr.svm_cid)) {
 		sock_set_flag(sk, SOCK_DONE);
 		vsk->peer_shutdown = SHUTDOWN_MASK;
 		sk->sk_state = SS_UNCONNECTED;
-- 
2.7.4
