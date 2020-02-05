From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 1/3] virtio-balloon: Fix memory leak when unloading while hinting is in progress
Date: Wed,  5 Feb 2020 17:34:00 +0100
Message-ID: <20200205163402.42627-2-david@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205163402.42627-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Liang Li <liang.z.li@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

When unloading the driver while hinting is in progress, we will not
release the free page blocks back to MM, resulting in a memory leak.

Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Liang Li <liang.z.li@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
index 8e400ece9273..abef2306c899 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -968,6 +968,10 @@ static void remove_common(struct virtio_balloon *vb)
 		leak_balloon(vb, vb->num_pages);
 	update_balloon_size(vb);
=20
+	/* There might be free pages that are being reported: release them. */
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		return_free_pages_to_mm(vb, ULONG_MAX);
+
 	/* Now we reset the device so we can clean up the queues. */
 	vb->vdev->config->reset(vb->vdev);
=20
--=20
2.24.1
