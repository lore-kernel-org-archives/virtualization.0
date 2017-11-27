From: Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VSOCK: Don't set sk_state to TCP_CLOSE before testing it
Date: Mon, 27 Nov 2017 05:29:32 -0800
Message-ID: <1511789372-12672-1-git-send-email-jhansen__29074.5939979844$1511789386$gmane$org@vmware.com>
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
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Jorgen Hansen <jhansen@vmware.com>, davem@davemloft.net, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

A recent commit (3b4477d2dcf2) converted the sk_state to use
TCP constants. In that change, vmci_transport_handle_detach
was changed such that sk->sk_state was set to TCP_CLOSE before
we test whether it is TCP_SYN_SENT. This change moves the
sk_state change back to the original locations in that function.

Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 net/vmw_vsock/vmci_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 56573dc..a7a73ff 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -804,8 +804,6 @@ static void vmci_transport_handle_detach(struct sock *sk)
 		 */
 		if (vsk->local_addr.svm_cid == VMADDR_CID_HOST ||
 		    vsock_stream_has_data(vsk) <= 0) {
-			sk->sk_state = TCP_CLOSE;
-
 			if (sk->sk_state == TCP_SYN_SENT) {
 				/* The peer may detach from a queue pair while
 				 * we are still in the connecting state, i.e.,
@@ -815,10 +813,12 @@ static void vmci_transport_handle_detach(struct sock *sk)
 				 * event like a reset.
 				 */
 
+				sk->sk_state = TCP_CLOSE;
 				sk->sk_err = ECONNRESET;
 				sk->sk_error_report(sk);
 				return;
 			}
+			sk->sk_state = TCP_CLOSE;
 		}
 		sk->sk_state_change(sk);
 	}
-- 
2.6.2
