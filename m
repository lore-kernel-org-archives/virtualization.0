From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/6] Revert "VSOCK: fix returnvar.cocci warnings"
Date: Tue,  8 Dec 2015 19:57:31 +0800
Message-ID: <1449575856-28507-2-git-send-email-stefanha__4592.31085046685$1449575887$gmane$org@redhat.com>
References: <1449575856-28507-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449575856-28507-1-git-send-email-stefanha@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Matt Benjamin <mbenjamin@redhat.com>, "David S. Miller" <davem@davemloft.net>, Christoffer Dall <christoffer.dall@linaro.org>, matt.ma@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit 0d76d6e8b2507983a2cae4c09880798079007421.

Keep virtio-vsock out-of-tree until the virtio-vsock device
specification is finalized.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 64bcb10..65b1cf8 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -56,7 +56,8 @@ struct vhost_vsock {
 
 static u32 vhost_transport_get_local_cid(void)
 {
-	return VHOST_VSOCK_DEFAULT_HOST_CID;
+	u32 cid = VHOST_VSOCK_DEFAULT_HOST_CID;
+	return cid;
 }
 
 static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
-- 
2.5.0
