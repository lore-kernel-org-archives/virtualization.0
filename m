From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 13/41] x86: reuse asm-generic/barrier.h
Date: Sun, 10 Jan 2016 16:18:19 +0200
Message-ID: <1452426622-4471-14-git-send-email-mst__31694.6400482722$1452435548$gmane$org@redhat.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Borislav Petkov <bp@suse.de>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, Joe Perches <joe@perch>
List-Id: virtualization@lists.linuxfoundation.org

As on most architectures, on x86 read_barrier_depends and
smp_read_barrier_depends are empty.  Drop the local definitions and pull
the generic ones from asm-generic/barrier.h instead: they are identical.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/barrier.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 0681d25..cc4c2a7 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -43,9 +43,6 @@
 #define smp_store_mb(var, value) do { WRITE_ONCE(var, value); barrier(); } while (0)
 #endif /* SMP */
 
-#define read_barrier_depends()		do { } while (0)
-#define smp_read_barrier_depends()	do { } while (0)
-
 #if defined(CONFIG_X86_PPRO_FENCE)
 
 /*
@@ -91,4 +88,6 @@ do {									\
 #define smp_mb__before_atomic()	barrier()
 #define smp_mb__after_atomic()	barrier()
 
+#include <asm-generic/barrier.h>
+
 #endif /* _ASM_X86_BARRIER_H */
-- 
MST
