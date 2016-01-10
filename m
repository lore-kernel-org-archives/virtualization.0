From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 32/41] sh: move xchg_cmpxchg to a header by itself
Date: Sun, 10 Jan 2016 16:20:59 +0200
Message-ID: <1452426622-4471-33-git-send-email-mst__2438.10365577719$1452435778$gmane$org@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davem>
List-Id: virtualization@lists.linuxfoundation.org

Looks like future sh variants will support a 4-byte cas which will be
used to implement 1 and 2 byte xchg.

This is exactly what we do for llsc now, move the portable part of the
code into a separate header so it's easy to reuse.

Suggested-by:  Rich Felker <dalias@libc.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/include/asm/cmpxchg-llsc.h | 35 +-------------------------
 arch/sh/include/asm/cmpxchg-xchg.h | 51 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 34 deletions(-)
 create mode 100644 arch/sh/include/asm/cmpxchg-xchg.h

diff --git a/arch/sh/include/asm/cmpxchg-llsc.h b/arch/sh/include/asm/cmpxchg-llsc.h
index e754794..fcfd322 100644
--- a/arch/sh/include/asm/cmpxchg-llsc.h
+++ b/arch/sh/include/asm/cmpxchg-llsc.h
@@ -1,9 +1,6 @@
 #ifndef __ASM_SH_CMPXCHG_LLSC_H
 #define __ASM_SH_CMPXCHG_LLSC_H
 
-#include <linux/bitops.h>
-#include <asm/byteorder.h>
-
 static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 {
 	unsigned long retval;
@@ -50,36 +47,6 @@ __cmpxchg_u32(volatile u32 *m, unsigned long old, unsigned long new)
 	return retval;
 }
 
-static inline u32 __xchg_cmpxchg(volatile void *ptr, u32 x, int size)
-{
-	int off = (unsigned long)ptr % sizeof(u32);
-	volatile u32 *p = ptr - off;
-#ifdef __BIG_ENDIAN
-	int bitoff = (sizeof(u32) - 1 - off) * BITS_PER_BYTE;
-#else
-	int bitoff = off * BITS_PER_BYTE;
-#endif
-	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
-	u32 oldv, newv;
-	u32 ret;
-
-	do {
-		oldv = READ_ONCE(*p);
-		ret = (oldv & bitmask) >> bitoff;
-		newv = (oldv & ~bitmask) | (x << bitoff);
-	} while (__cmpxchg_u32(p, oldv, newv) != oldv);
-
-	return ret;
-}
-
-static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
-{
-	return __xchg_cmpxchg(m, val, sizeof *m);
-}
-
-static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
-{
-	return __xchg_cmpxchg(m, val, sizeof *m);
-}
+#include <asm/cmpxchg-xchg.h>
 
 #endif /* __ASM_SH_CMPXCHG_LLSC_H */
diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/arch/sh/include/asm/cmpxchg-xchg.h
new file mode 100644
index 0000000..7219719
--- /dev/null
+++ b/arch/sh/include/asm/cmpxchg-xchg.h
@@ -0,0 +1,51 @@
+#ifndef __ASM_SH_CMPXCHG_XCHG_H
+#define __ASM_SH_CMPXCHG_XCHG_H
+
+/*
+ * Copyright (C) 2016 Red Hat, Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See the
+ * file "COPYING" in the main directory of this archive for more details.
+ */
+#include <linux/bitops.h>
+#include <asm/byteorder.h>
+
+/*
+ * Portable implementations of 1 and 2 byte xchg using a 4 byte cmpxchg.
+ * Note: this header isn't self-contained: before including it, __cmpxchg_u32
+ * must be defined first.
+ */
+static inline u32 __xchg_cmpxchg(volatile void *ptr, u32 x, int size)
+{
+	int off = (unsigned long)ptr % sizeof(u32);
+	volatile u32 *p = ptr - off;
+#ifdef __BIG_ENDIAN
+	int bitoff = (sizeof(u32) - 1 - off) * BITS_PER_BYTE;
+#else
+	int bitoff = off * BITS_PER_BYTE;
+#endif
+	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
+	u32 oldv, newv;
+	u32 ret;
+
+	do {
+		oldv = READ_ONCE(*p);
+		ret = (oldv & bitmask) >> bitoff;
+		newv = (oldv & ~bitmask) | (x << bitoff);
+	} while (__cmpxchg_u32(p, oldv, newv) != oldv);
+
+	return ret;
+}
+
+static inline unsigned long xchg_u16(volatile u16 *m, unsigned long val)
+{
+	return __xchg_cmpxchg(m, val, sizeof *m);
+}
+
+static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
+{
+	return __xchg_cmpxchg(m, val, sizeof *m);
+}
+
+#endif /* __ASM_SH_CMPXCHG_XCHG_H */
-- 
MST
