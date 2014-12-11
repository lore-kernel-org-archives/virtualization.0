From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/3] virtio_config: fix virtio_cread_bytes
Date: Thu, 11 Dec 2014 19:01:34 +0200
Message-ID: <1418317279-13915-3-git-send-email-mst@redhat.com>
References: <1418317279-13915-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20141211170251.GC13991@redhat.com>
Resent-To: virtualization@lists.linux-foundation.org
Content-Disposition: inline
In-Reply-To: <1418317279-13915-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.or, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_cread_bytes is implemented incorrectly in case length happens to
be 2,4 or 8 bytes: transports and devices will assume it's an integer
value that has to be converted to LE format.

Let's just do multiple 1-byte reads: this also makes life easier
for transports who only need to implement 1,2,4 and 8 byte reads.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7979f85..a61cd37 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -305,7 +305,10 @@ static inline void virtio_cread_bytes(struct virtio_device *vdev,
 				      unsigned int offset,
 				      void *buf, size_t len)
 {
-	vdev->config->get(vdev, offset, buf, len);
+	int i;
+
+	for (i = 0; i < len; i++)
+		vdev->config->get(vdev, offset + i, buf + i, 1);
 }
 
 static inline void virtio_cwrite8(struct virtio_device *vdev,
-- 
MST
