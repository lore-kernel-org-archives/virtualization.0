From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 02/10] drm/virtio: fix endianness in primary_plane_update
Date: Tue, 6 Dec 2016 17:40:40 +0200
Message-ID: <1481038106-24899-3-git-send-email-mst__42988.0457152196$1481038864$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_gpu_cmd_transfer_to_host_2d expects x and y
parameters in LE, but virtio_gpu_primary_plane_update
passes in the CPU format instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index ba28c0f..1fda965 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -88,8 +88,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 				(vgdev, handle, 0,
 				 cpu_to_le32(plane->state->src_w >> 16),
 				 cpu_to_le32(plane->state->src_h >> 16),
-				 plane->state->src_x >> 16,
-				 plane->state->src_y >> 16, NULL);
+				 cpu_to_le32(plane->state->src_x >> 16),
+				 cpu_to_le32(plane->state->src_y >> 16), NULL);
 		}
 	} else {
 		handle = 0;
-- 
MST
