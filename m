From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost: missing __user tags
Date: Fri, 15 May 2020 11:33:50 -0400
Message-ID: <20200515153347.1092235-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kbuild test robot <lkp@intel.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

sparse warns about converting void * to void __user *. This is not new
but only got noticed now that vhost is built on more systems.
This is just a question of __user tags missing in a couple of places,
so fix it up.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d450e16c5c25..21a59b598ed8 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -730,7 +730,7 @@ static inline void __user *vhost_vq_meta_fetch(struct vhost_virtqueue *vq,
 	if (!map)
 		return NULL;
 
-	return (void *)(uintptr_t)(map->addr + addr - map->start);
+	return (void __user *)(uintptr_t)(map->addr + addr - map->start);
 }
 
 /* Can we switch to this memory table? */
@@ -869,7 +869,7 @@ static void __user *__vhost_get_user_slow(struct vhost_virtqueue *vq,
  * not happen in this case.
  */
 static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
-					    void *addr, unsigned int size,
+					    void __user *addr, unsigned int size,
 					    int type)
 {
 	void __user *uaddr = vhost_vq_meta_fetch(vq,
-- 
MST
