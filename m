From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 4/4] qemu-kvm: add compat eventfd
Date: Mon, 17 Aug 2009 15:37:30 +0300
Message-ID: <20090817123730.GE10700__6770.76073266125$1250513284$gmane$org@redhat.com>
References: <cover.1250512448.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1250512448.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Support build on rhel 5.3 where we have syscall for eventfd but not
userspace wrapper.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 compat/sys/eventfd.h |   13 +++++++++++++
 configure            |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 compat/sys/eventfd.h

diff --git a/compat/sys/eventfd.h b/compat/sys/eventfd.h
new file mode 100644
index 0000000..f55d96a
--- /dev/null
+++ b/compat/sys/eventfd.h
@@ -0,0 +1,13 @@
+#ifndef _COMPAT_SYS_EVENTFD
+#define _COMPAT_SYS_EVENTFD
+
+#include <unistd.h>
+#include <syscall.h>
+
+
+static inline int eventfd (int count, int flags)
+{
+    return syscall(SYS_eventfd, count, flags);
+}
+
+#endif
diff --git a/configure b/configure
index 84af8bd..2dd0ce8 100755
--- a/configure
+++ b/configure
@@ -866,6 +866,7 @@ if test "$kvm" = "yes" ; then
 
 kvm_cflags="-I$source_path/kvm/include"
 kvm_cflags="$kvm_cflags -I$source_path/kvm/include/$kvm_arch"
+kvm_cflags="$kvm_cflags -idirafter $source_path/compat"
 
 # test for KVM_CAP_PIT
 
-- 
1.6.2.5
