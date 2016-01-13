From: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH] uapi: use __u8 from linux/types.h
Date: Wed, 13 Jan 2016 19:10:15 +0300
Message-ID: <20160113160958.GA29108__47436.5443144508$1452711999$gmane$org@glebfm.cloud.tilaa.com>
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
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Kernel headers should use linux/types.h based definitions.

Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
---
 include/uapi/linux/virtio_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 7a63faa..4b04ead 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -287,7 +287,7 @@ struct virtio_gpu_get_capset {
 /* VIRTIO_GPU_RESP_OK_CAPSET */
 struct virtio_gpu_resp_capset {
 	struct virtio_gpu_ctrl_hdr hdr;
-	uint8_t capset_data[];
+	__u8 capset_data[];
 };
 
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
-- 
glebfm
