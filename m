From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] ptr_ring: support testing different batching sizes
Date: Fri, 7 Apr 2017 08:50:02 +0300
Message-ID: <1491544049-19108-3-git-send-email-mst@redhat.com>
References: <1491544049-19108-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1491544049-19108-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Use the param flag for that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/ptr_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index 635b07b..7b22f1b 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -97,6 +97,9 @@ void alloc_ring(void)
 {
 	int ret = ptr_ring_init(&array, ring_size, 0);
 	assert(!ret);
+	/* Hacky way to poke at ring internals. Useful for testing though. */
+	if (param)
+		array.batch = param;
 }
 
 /* guest side */
-- 
MST
