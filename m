From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] Revert "vhost: make msg padding explicit"
Date: Wed, 2 May 2018 17:19:05 +0300
Message-ID: <1525270740-460646-1-git-send-email-mst__3084.55682029507$1525270649$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit 93c0d549c4c5a7382ad70de6b86610b7aae57406.

Unfortunately the padding will break 32 bit userspace.
Ouch. Need to add some compat code, revert for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/vhost.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 5a8ad06..c51f8e5 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -68,7 +68,6 @@ struct vhost_iotlb_msg {
 
 struct vhost_msg {
 	int type;
-	int padding0;
 	union {
 		struct vhost_iotlb_msg iotlb;
 		__u8 padding[64];
-- 
MST
