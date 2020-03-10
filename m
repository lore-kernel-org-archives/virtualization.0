From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] MAINTAINERS: Add myself as virtio-balloon co-maintainer
Date: Tue, 10 Mar 2020 12:54:11 +0100
Message-ID: <20200310115411.12760-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: virtualization@lists.linuxfoundation.org

As suggested by Michael, let's add me as co-maintainer of virtio-balloon.
While at it, also add "include/linux/balloon_compaction.h" to the file
list.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c555f4be8c4e..da9f53a05d0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17800,6 +17800,15 @@ F:	drivers/block/virtio_blk.c
 F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 F:	drivers/crypto/virtio/
+
+VIRTIO BALLOON
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	David Hildenbrand <david@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/virtio_balloon.c
+F:	include/uapi/linux/virtio_balloon.h
+F:	include/linux/balloon_compaction.h
 F:	mm/balloon_compaction.c
=20
 VIRTIO BLOCK AND SCSI DRIVERS
--=20
2.24.1
