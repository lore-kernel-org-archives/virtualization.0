From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] tools/virtio/ringtest: tweaks for s390
Date: Mon, 19 Sep 2016 17:06:56 +0200
Message-ID: <20160919150656.6194-3-cornelia.huck@de.ibm.com>
References: <20160919150656.6194-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160919150656.6194-1-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: pasic@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Make ringtest work on s390 too.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Sascha Silbe <silbe@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 tools/virtio/ringtest/main.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 16917ac..7806b7b 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -26,6 +26,16 @@ static inline void wait_cycles(unsigned long long cycles)
 #define VMEXIT_CYCLES 500
 #define VMENTRY_CYCLES 500
 
+#elif defined(__s390x__)
+static inline void wait_cycles(unsigned long long cycles)
+{
+	asm volatile("0: brctg %0,0b" : : "d" (cycles));
+}
+
+/* tweak me */
+#define VMEXIT_CYCLES 200
+#define VMENTRY_CYCLES 200
+
 #else
 static inline void wait_cycles(unsigned long long cycles)
 {
@@ -81,6 +91,8 @@ extern unsigned ring_size;
 /* Is there a portable way to do this? */
 #if defined(__x86_64__) || defined(__i386__)
 #define cpu_relax() asm ("rep; nop" ::: "memory")
+#elif defined(__s390x__)
+#define cpu_relax() barrier()
 #else
 #define cpu_relax() assert(0)
 #endif
-- 
2.8.4
