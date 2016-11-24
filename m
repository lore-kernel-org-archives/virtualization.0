From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] tools/virtio: use {READ,WRITE}_ONCE() in uaccess.h
Date: Thu, 24 Nov 2016 10:25:14 +0000
Message-ID: <1479983114-17190-4-git-send-email-mark.rutland__29158.1367644996$1480112042$gmane$org@arm.com>
References: <1479983114-17190-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1479983114-17190-1-git-send-email-mark.rutland@arm.com>
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
Cc: mark.rutland@arm.com, dave@stgolabs.net, kvm@vger.kernel.org, dbueso@suse.de, netdev@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, dvyukov@google.com
List-Id: virtualization@lists.linuxfoundation.org

As a step towards killing off ACCESS_ONCE, use {READ,WRITE}_ONCE() for the
virtio tools uaccess primitives, pulling these in from <linux/compiler.h>.

With this done, we can kill off the now-unused ACCESS_ONCE() definition.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
---
 tools/virtio/linux/uaccess.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
index 0a578fe..fa05d01 100644
--- a/tools/virtio/linux/uaccess.h
+++ b/tools/virtio/linux/uaccess.h
@@ -1,8 +1,9 @@
 #ifndef UACCESS_H
 #define UACCESS_H
-extern void *__user_addr_min, *__user_addr_max;
 
-#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+#include <linux/compiler.h>
+
+extern void *__user_addr_min, *__user_addr_max;
 
 static inline void __chk_user_ptr(const volatile void *p, size_t size)
 {
@@ -13,7 +14,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
 	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
-	ACCESS_ONCE(*(__pu_ptr)) = x;				\
+	WRITE_ONCE(*(__pu_ptr), x);				\
 	0;							\
 })
 
@@ -21,7 +22,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
 	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
-	x = ACCESS_ONCE(*(__pu_ptr));				\
+	x = READ_ONCE(*(__pu_ptr));				\
 	0;							\
 })
 
-- 
2.7.4
