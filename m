From: "Denis V. Lunev" <den@parallels.com>
Subject: [PATCH 1/2] virtio_balloon: return the amount of freed memory from
	leak_balloon()
Date: Wed,  8 Oct 2014 14:21:08 +0400
Message-ID: <1412763669-2980-2-git-send-email-den@parallels.com>
References: <1412763669-2980-1-git-send-email-den@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412763669-2980-1-git-send-email-den@parallels.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: den@openvz.org, virtualization@lists.linux-foundation.org, Raushaniya Maksudova <rmaksudova@parallels.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Raushaniya Maksudova <rmaksudova@parallels.com>

This value would be useful in the next patch to provide the amount of
the freed memory for OOM killer.

Accessing to vb->num_pfns outside of vb->balloon_lock is wrong and unsafe.

Signed-off-by: Raushaniya Maksudova <rmaksudova@parallels.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Rusty Russell <rusty@rustcorp.com.au>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: virtualization@lists.linux-foundation.org
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 25ebe8e..213da41 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -168,8 +168,9 @@ static void release_pages_by_pfn(const u32 pfns[], unsigned int num)
 	}
 }
 
-static void leak_balloon(struct virtio_balloon *vb, size_t num)
+static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 {
+	unsigned num_freed_pages;
 	struct page *page;
 	struct balloon_dev_info *vb_dev_info = vb->vb_dev_info;
 
@@ -186,6 +187,7 @@ static void leak_balloon(struct virtio_balloon *vb, size_t num)
 		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
+	num_freed_pages = vb->num_pfns;
 	/*
 	 * Note that if
 	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
@@ -195,6 +197,7 @@ static void leak_balloon(struct virtio_balloon *vb, size_t num)
 		tell_host(vb, vb->deflate_vq);
 	mutex_unlock(&vb->balloon_lock);
 	release_pages_by_pfn(vb->pfns, vb->num_pfns);
+	return num_freed_pages;
 }
 
 static inline void update_stat(struct virtio_balloon *vb, int idx,
-- 
1.9.1
