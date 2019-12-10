From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 1/6] vsock/virtio_transport_common: remove unused
 virtio header includes
Date: Tue, 10 Dec 2019 11:43:02 +0100
Message-ID: <20191210104307.89346-2-sgarzare__44839.825229586$1575974616$gmane$org@redhat.com>
References: <20191210104307.89346-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191210104307.89346-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: netdev@vger.kernel.org, davem@davemloft.net
Cc: kvm@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

We can remove virtio header includes, because virtio_transport_common
doesn't use virtio API, but provides common functions to interface
virtio/vhost transports with the af_vsock core, and to handle
the protocol.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e5ea29c6bca7..0e20b0f6eb65 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -11,9 +11,6 @@
 #include <linux/sched/signal.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
-#include <linux/virtio.h>
-#include <linux/virtio_ids.h>
-#include <linux/virtio_config.h>
 #include <linux/virtio_vsock.h>
 #include <uapi/linux/vsockmon.h>
 
-- 
2.23.0
