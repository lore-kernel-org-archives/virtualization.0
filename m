From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] x86/paravirt: hide unused patch_default label
Date: Fri, 16 Dec 2016 10:16:35 +0100
Message-ID: <20161216091700.2499520-1-arnd@arndb.de>
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
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

A bugfix introduced a harmless warning:

arch/x86/kernel/paravirt_patch_32.c: In function 'native_patch':
arch/x86/kernel/paravirt_patch_32.c:71:1: error: label 'patch_default' defined but not used [-Werror=unused-label]

This puts it in the same #ifdef as its caller.

Fixes: 45dbea5f55c0 ("x86/paravirt: Fix native_patch()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/paravirt_patch_32.c | 2 ++
 arch/x86/kernel/paravirt_patch_64.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index d33ef165b1f8..2b729b1df391 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -68,7 +68,9 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 #endif
 
 	default:
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
 patch_default:
+#endif
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
 
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index f4fcf26c9fce..b5bff128949a 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -80,7 +80,9 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 #endif
 
 	default:
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
 patch_default:
+#endif
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
 
-- 
2.9.0
