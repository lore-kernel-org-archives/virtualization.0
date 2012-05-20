From: Chen Baozi <baozich@gmail.com>
Subject: [PATCH] virtio: fix typo in comment
Date: Sun, 20 May 2012 10:44:34 +0800
Message-ID: <1337481874-3472-1-git-send-email-baozich__48694.0263923772$1337708064$gmane$org@gmail.com>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Chen Baozi <chenbaozi@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Chen Baozi <chenbaozi@gmail.com>

- Delete "@request_vqs" and "@free_vqs" comments, since
  they are no longer in struct virtio_config_ops.
- According to the macro below, "@val" should be "@v".

Signed-off-by: Chen Baozi <chenbaozi@gmail.com>
---
 include/linux/virtio_config.h |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7323a33..fc457f4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -74,15 +74,6 @@
  * @set_status: write the status byte
  *	vdev: the virtio_device
  *	status: the new status byte
- * @request_vqs: request the specified number of virtqueues
- *	vdev: the virtio_device
- *	max_vqs: the max number of virtqueues we want
- *      If supplied, must call before any virtqueues are instantiated.
- *      To modify the max number of virtqueues after request_vqs has been
- *      called, call free_vqs and then request_vqs with a new value.
- * @free_vqs: cleanup resources allocated by request_vqs
- *	vdev: the virtio_device
- *      If supplied, must call after all virtqueues have been deleted.
  * @reset: reset the device
  *	vdev: the virtio device
  *	After this, status and feature negotiation must be done again
@@ -156,7 +147,7 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
  * @vdev: the virtio device
  * @fbit: the feature bit
  * @offset: the type to search for.
- * @val: a pointer to the value to fill in.
+ * @v: a pointer to the value to fill in.
  *
  * The return value is -ENOENT if the feature doesn't exist.  Otherwise
  * the config value is copied into whatever is pointed to by v. */
-- 
1.7.1
