From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 3/21] [PATCH] move desc_empty to where they belong
Date: Mon, 17 Dec 2007 20:52:26 -0200
Message-ID: <11979319811234-git-send-email-gcosta@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979319763641-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch moves the (duplicated) desc_empty implementation to desc.h,
where the descriptor things belong.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc.h         |    6 ++++++
 include/asm-x86/processor_32.h |    6 ------
 include/asm-x86/processor_64.h |    6 ------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/asm-x86/desc.h b/include/asm-x86/desc.h
index 161a6d6..6c781bf 100644
--- a/include/asm-x86/desc.h
+++ b/include/asm-x86/desc.h
@@ -71,6 +71,12 @@ static inline void pack_gate(gate_desc *gate, unsigned char type,
 
 #endif
 
+static inline int desc_empty(const void *ptr)
+{
+	const u32 *desc = ptr;
+	return !(desc[0] | desc[1]);
+}
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
diff --git a/include/asm-x86/processor_32.h b/include/asm-x86/processor_32.h
index b9dbe46..cadeffb 100644
--- a/include/asm-x86/processor_32.h
+++ b/include/asm-x86/processor_32.h
@@ -21,12 +21,6 @@
 #include <linux/init.h>
 #include <asm/desc_defs.h>
 
-static inline int desc_empty(const void *ptr)
-{
-	const u32 *desc = ptr;
-	return !(desc[0] | desc[1]);
-}
-
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
diff --git a/include/asm-x86/processor_64.h b/include/asm-x86/processor_64.h
index a5d06d7..6207292 100644
--- a/include/asm-x86/processor_64.h
+++ b/include/asm-x86/processor_64.h
@@ -20,12 +20,6 @@
 #include <linux/cpumask.h>
 #include <asm/desc_defs.h>
 
-static inline int desc_empty(const void *ptr)
-{
-	const u32 *desc = ptr;
-	return !(desc[0] | desc[1]);
-}
-
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
-- 
1.4.4.2
