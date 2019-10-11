From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 1/2] vsock: add half-closed socket details in the
	implementation notes
Date: Fri, 11 Oct 2019 15:07:57 +0200
Message-ID: <20191011130758.22134-2-sgarzare__44459.8469812021$1570799985$gmane$org@redhat.com>
References: <20191011130758.22134-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011130758.22134-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Adit Ranadive <aditr@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

vmci_transport never allowed half-closed socket on the host side.
Since we want to have the same behaviour across all transports, we
add a section in the "Implementation notes".

Cc: Jorgen Hansen <jhansen@vmware.com>
Cc: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2ab43b2bba31..27df57c2024b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -83,6 +83,10 @@
  *   TCP_ESTABLISHED - connected
  *   TCP_CLOSING - disconnecting
  *   TCP_LISTEN - listening
+ *
+ * - Half-closed socket is supported only on the guest side. recv() on the host
+ * side should return EOF when the guest closes a connection, also if some
+ * data is still in the receive queue.
  */
 
 #include <linux/types.h>
-- 
2.21.0
