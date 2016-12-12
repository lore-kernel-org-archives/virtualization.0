From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH v4 4/4] vsock: cancel packets when failing to connect
Date: Mon, 12 Dec 2016 20:21:09 +0800
Message-ID: <1481545269-18104-5-git-send-email-bergwolf__32737.914278596$1481545336$gmane$org@gmail.com>
References: <1481545269-18104-1-git-send-email-bergwolf@gmail.com>
	<1481545269-18104-2-git-send-email-bergwolf@gmail.com>
	<1481545269-18104-3-git-send-email-bergwolf@gmail.com>
	<1481545269-18104-4-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481545269-18104-4-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, David Miller <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Otherwise we'll leave the packets queued until releasing vsock device.
E.g., if guest is slow to start up, resulting ETIMEDOUT on connect, guest
will get the connect requests from failed host sockets.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 8a398b3..c73b03a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1101,10 +1101,19 @@ static const struct proto_ops vsock_dgram_ops = {
 	.sendpage = sock_no_sendpage,
 };
 
+static int vsock_transport_cancel_pkt(struct vsock_sock *vsk)
+{
+	if (!transport->cancel_pkt)
+		return -EOPNOTSUPP;
+
+	return transport->cancel_pkt(vsk);
+}
+
 static void vsock_connect_timeout(struct work_struct *work)
 {
 	struct sock *sk;
 	struct vsock_sock *vsk;
+	int cancel = 0;
 
 	vsk = container_of(work, struct vsock_sock, dwork.work);
 	sk = sk_vsock(vsk);
@@ -1115,8 +1124,11 @@ static void vsock_connect_timeout(struct work_struct *work)
 		sk->sk_state = SS_UNCONNECTED;
 		sk->sk_err = ETIMEDOUT;
 		sk->sk_error_report(sk);
+		cancel = 1;
 	}
 	release_sock(sk);
+	if (cancel)
+		vsock_transport_cancel_pkt(vsk);
 
 	sock_put(sk);
 }
@@ -1223,11 +1235,13 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 			err = sock_intr_errno(timeout);
 			sk->sk_state = SS_UNCONNECTED;
 			sock->state = SS_UNCONNECTED;
+			vsock_transport_cancel_pkt(vsk);
 			goto out_wait;
 		} else if (timeout == 0) {
 			err = -ETIMEDOUT;
 			sk->sk_state = SS_UNCONNECTED;
 			sock->state = SS_UNCONNECTED;
+			vsock_transport_cancel_pkt(vsk);
 			goto out_wait;
 		}
 
-- 
2.7.4
