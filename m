From: Asias He <asias.hejun@gmail.com>
Subject: [RFC V2 2/7] VSOCK: Add dgram_skb to vsock_sock
Date: Sat,  5 Jul 2014 11:23:11 +0800
Message-ID: <294e5a9eaad00941ae3125c0d1c6b25bd3368881.1404529115.git.asias.hejun__46960.904429625$1404530662$gmane$org@gmail.com>
References: <cover.1404529115.git.asias.hejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1404529115.git.asias.hejun@gmail.com>
In-Reply-To: <cover.1404529115.git.asias.hejun@gmail.com>
References: <cover.1404529115.git.asias.hejun@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Asias He <asias@redhat.com>

Signed-off-by: Asias He <asias@redhat.com>
---
 include/net/af_vsock.h   | 1 +
 net/vmw_vsock/af_vsock.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 88f559a..ef668a0 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -58,6 +58,7 @@ struct vsock_sock {
 	 */
 	struct list_head pending_links;
 	struct list_head accept_queue;
+	struct list_head dgram_skb;
 	bool rejected;
 	struct delayed_work dwork;
 	u32 peer_shutdown;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9b48d4e..df8781c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -684,6 +684,7 @@ struct sock *__vsock_create(struct net *net,
 	vsk->listener = NULL;
 	INIT_LIST_HEAD(&vsk->pending_links);
 	INIT_LIST_HEAD(&vsk->accept_queue);
+	INIT_LIST_HEAD(&vsk->dgram_skb);
 	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
-- 
1.9.3
