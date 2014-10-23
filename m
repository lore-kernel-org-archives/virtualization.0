From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] fixup! virtio: add legacy feature table support
Date: Thu, 23 Oct 2014 20:34:27 +0300
Message-ID: <1414085648-22537-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

the following is needed on top of v4 virtio 1.0 support
that I sent.  Will squash it in for v5.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 85a164e..e9018b4 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -113,6 +113,13 @@ void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
 	for (i = 0; i < drv->feature_table_size; i++)
 		if (drv->feature_table[i] == fbit)
 			return;
+
+	if (drv->feature_table_legacy) {
+		for (i = 0; i < drv->feature_table_size_legacy; i++)
+			if (drv->feature_table_legacy[i] == fbit)
+				return;
+	}
+
 	BUG();
 }
 EXPORT_SYMBOL_GPL(virtio_check_driver_offered_feature);
-- 
MST
