From: Igor Stoppa <igor.stoppa@gmail.com>
Subject: [PATCH] virtio: add unlikely() to WARN_ON_ONCE()
Date: Fri,  7 Sep 2018 20:48:02 +0300
Message-ID: <20180907174802.31900-1-igor.stoppa__49398.1474348859$1536342379$gmane$org@huawei.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Igor Stoppa <igor.stoppa@huawei.com>, Virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The condition to test is unlikely() to be true. Add the hint.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 tools/virtio/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index fb22bccfbc8a..2b5e417ea2f0 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -123,7 +123,7 @@ static inline void free_page(unsigned long addr)
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
-#define WARN_ON_ONCE(cond) ((cond) ? fprintf (stderr, "WARNING\n") : 0)
+#define WARN_ON_ONCE(cond) (unlikely(cond) ? fprintf (stderr, "WARNING\n") : 0)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
-- 
2.17.1
