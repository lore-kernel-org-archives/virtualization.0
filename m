From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next 10/12] tools/virtio: more stubs to fix tools build
Date: Fri, 26 Jan 2018 01:36:40 +0200
Message-ID: <1516923320-16959-13-git-send-email-mst@redhat.com>
References: <1516923320-16959-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1516923320-16959-1-git-send-email-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/kernel.h      | 2 +-
 tools/virtio/linux/thread_info.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 tools/virtio/linux/thread_info.h

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 395521a..fca8381 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -118,7 +118,7 @@ static inline void free_page(unsigned long addr)
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
-#define WARN_ON_ONCE(cond) ((cond) && fprintf (stderr, "WARNING\n"))
+#define WARN_ON_ONCE(cond) ((cond) ? fprintf (stderr, "WARNING\n") : 0)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
diff --git a/tools/virtio/linux/thread_info.h b/tools/virtio/linux/thread_info.h
new file mode 100644
index 0000000..e0f610d
--- /dev/null
+++ b/tools/virtio/linux/thread_info.h
@@ -0,0 +1 @@
+#define check_copy_size(A, B, C) (1)
-- 
MST
