From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 06/10] vhost: add missing __user annotations
Date: Tue, 6 Dec 2016 17:40:54 +0200
Message-ID: <1481038106-24899-7-git-send-email-mst__15581.2793913812$1481038913$gmane$org@redhat.com>
References: <1481038106-24899-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1481038106-24899-1-git-send-email-mst@redhat.com>
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

Several vhost functions were missing __user annotations
on pointers, causing sparse warnings. Fix this up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7331ef3..ba7db68 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -719,7 +719,7 @@ static int memory_access_ok(struct vhost_dev *d, struct vhost_umem *umem,
 static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 			  struct iovec iov[], int iov_size, int access);
 
-static int vhost_copy_to_user(struct vhost_virtqueue *vq, void *to,
+static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 			      const void *from, unsigned size)
 {
 	int ret;
@@ -749,7 +749,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void *to,
 }
 
 static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
-				void *from, unsigned size)
+				void __user *from, unsigned size)
 {
 	int ret;
 
@@ -783,7 +783,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 }
 
 static void __user *__vhost_get_user(struct vhost_virtqueue *vq,
-				     void *addr, unsigned size)
+				     void __user *addr, unsigned size)
 {
 	int ret;
 
@@ -934,8 +934,8 @@ static int umem_access_ok(u64 uaddr, u64 size, int access)
 	return 0;
 }
 
-int vhost_process_iotlb_msg(struct vhost_dev *dev,
-			    struct vhost_iotlb_msg *msg)
+static int vhost_process_iotlb_msg(struct vhost_dev *dev,
+				   struct vhost_iotlb_msg *msg)
 {
 	int ret = 0;
 
-- 
MST
