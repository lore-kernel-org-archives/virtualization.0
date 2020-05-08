From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v2 resubmit] virtio-balloon: Disable free page reporting if
 page poison reporting is not enabled
Date: Fri, 08 May 2020 10:40:06 -0700
Message-ID: <20200508173732.17877.85060.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtio-dev-return-7295-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
To: jasowang@redhat.com, david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

We should disable free page reporting if page poisoning is enabled but we
cannot report it via the balloon interface. This way we can avoid the
possibility of corrupting guest memory. Normally the page poisoning feature
should always be present when free page reporting is enabled on the
hypervisor, however this allows us to correctly handle a case of the
virtio-balloon device being possibly misconfigured.

Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page reports to host")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

Changes since v1:
Originally this patch also modified free page hinting, that has been removed.
Updated patch title and description.
Added a comment explaining reasoning for disabling free page reporting.

Resbumitting v2 w/ Ack from David Hildebrand.

 drivers/virtio/virtio_balloon.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 51086a5afdd4..1f157d2f4952 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1107,11 +1107,18 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 static int virtballoon_validate(struct virtio_device *vdev)
 {
-	/* Tell the host whether we care about poisoned pages. */
+	/*
+	 * Inform the hypervisor that our pages are poisoned or
+	 * initialized. If we cannot do that then we should disable
+	 * page reporting as it could potentially change the contents
+	 * of our free pages.
+	 */
 	if (!want_init_on_free() &&
 	    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
 	     !page_poisoning_enabled()))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
 	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
 	return 0;
