From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] MAINTAINERS: add URL for virtio-mem
Date: Wed, 17 Jun 2020 12:47:56 +0200
Message-ID: <20200617104756.6312-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Let's add the status/info page, which is still under construction, however,
already contains valuable documentation/information.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 301330e02bca7..3470c5bfbdc7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18234,6 +18234,7 @@ VIRTIO MEM DRIVER
 M:	David Hildenbrand <david@redhat.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
+W:	https://virtio-mem.gitlab.io/
 F:	drivers/virtio/virtio_mem.c
 F:	include/uapi/linux/virtio_mem.h
 
-- 
2.26.2
