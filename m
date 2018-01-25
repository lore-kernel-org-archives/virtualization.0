From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next 11/12] tools/virtio: copy READ/WRITE_ONCE
Date: Fri, 26 Jan 2018 01:36:42 +0200
Message-ID: <1516923320-16959-15-git-send-email-mst__32461.2911128954$1516923327$gmane$org@redhat.com>
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

This is to make ptr_ring test build again.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/main.h | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 5706e07..593a328 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -134,4 +134,61 @@ static inline void busy_wait(void)
     barrier(); \
 } while (0)
 
+#if defined(__i386__) || defined(__x86_64__) || defined(__s390x__)
+#define smp_wmb() barrier()
+#else
+#define smp_wmb() smp_release()
+#endif
+
+#ifdef __alpha__
+#define smp_read_barrier_depends() smp_acquire()
+#else
+#define smp_read_barrier_depends() do {} while(0)
+#endif
+
+static __always_inline
+void __read_once_size(const volatile void *p, void *res, int size)
+{
+        switch (size) {                                                 \
+        case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;              \
+        case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;            \
+        case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;            \
+        case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;            \
+        default:                                                        \
+                barrier();                                              \
+                __builtin_memcpy((void *)res, (const void *)p, size);   \
+                barrier();                                              \
+        }                                                               \
+}
+
+static __always_inline void __write_once_size(volatile void *p, void *res, int size)
+{
+	switch (size) {
+	case 1: *(volatile unsigned char *)p = *(unsigned char *)res; break;
+	case 2: *(volatile unsigned short *)p = *(unsigned short *)res; break;
+	case 4: *(volatile unsigned int *)p = *(unsigned int *)res; break;
+	case 8: *(volatile unsigned long long *)p = *(unsigned long long *)res; break;
+	default:
+		barrier();
+		__builtin_memcpy((void *)p, (const void *)res, size);
+		barrier();
+	}
+}
+
+#define READ_ONCE(x) \
+({									\
+	union { typeof(x) __val; char __c[1]; } __u;			\
+	__read_once_size(&(x), __u.__c, sizeof(x));		\
+	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
+	__u.__val;							\
+})
+
+#define WRITE_ONCE(x, val) \
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__val = (typeof(x)) (val) }; \
+	__write_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
+
 #endif
-- 
MST
