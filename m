From: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH] vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request definition
Date: Mon, 3 Sep 2018 20:59:13 +0300
Message-ID: <20180903175906.GA11529__16221.5339871638$1535997919$gmane$org@glebfm.cloud.tilaa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The _IOC_READ flag fits this ioctl request more because this request
actually only writes to, but doesn't read from userspace.
See NOTEs in include/uapi/asm-generic/ioctl.h for more information.

Fixes: 429711aec282 ("vhost: switch to use new message format")
Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
---
 include/uapi/linux/vhost.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b1e22c40c4b6..84c3de89696a 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -176,7 +176,7 @@ struct vhost_memory {
 #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
 
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
-#define VHOST_GET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x26, __u64)
+#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
 
 /* VHOST_NET specific defines */
 

-- 
glebfm
