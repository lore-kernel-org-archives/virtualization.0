From: Sasha Levin <levinsasha928@gmail.com>
Subject: [PATCH 2/3] virtio_config: Add virtio_config_val_len()
Date: Sun, 14 Aug 2011 17:52:32 +0300
Message-ID: <1313333553-23086-2-git-send-email-levinsasha928__26217.1381073587$1313345721$gmane$org@gmail.com>
References: <1313333553-23086-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313333553-23086-1-git-send-email-levinsasha928@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds virtio_config_val_len() which allows retrieving variable
length data from the virtio config space only if a specific feature is on.

Cc: Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 include/linux/virtio_config.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 39c88c5..add4790 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -155,6 +155,9 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 #define virtio_config_val(vdev, fbit, offset, v) \
 	virtio_config_buf((vdev), (fbit), (offset), (v), sizeof(*v))
 
+#define virtio_config_val_len(vdev, fbit, offset, v, len) \
+	virtio_config_buf((vdev), (fbit), (offset), (v), (len))
+
 static inline int virtio_config_buf(struct virtio_device *vdev,
 				    unsigned int fbit,
 				    unsigned int offset,
-- 
1.7.6
