From: Yoshimi Ichiyanagi <ichiyanagi.yoshimi@lab.ntt.co.jp>
Subject: [PATCH] i386: modified CONFIG_PHYSICAL_ALIGN
Date: Tue, 14 Aug 2007 09:55:50 +0900
Message-ID: <5AC7DE0DDBA7B1ichiyanagi.yoshimi@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: moriai.satoshi@lab.ntt.co.jp, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CONFIG_PHYSICAL_ALIGN gives the physical address's alignment where the 
kernel is loaded.

CONFIG_PHYSICAL_ALIGN's default value is different from i386 kernel with the 
x86_84 kernel. The i386's default CONFIG_PHYSICAL_ALIGN value is 1MB, but 
the x86_64's is 2MB.

The problem is, if you compile x86_64 kernel, the value of 
CONFIG_PHYSICAL_ALIGN will be fixed, and the next time you compile i386 
kernel, previous CONFIG_PHYSICAL_ALIGN value of x86_64(default: 2MB) will 
be used by default.

The follwing patch will fix this problem. With this patch, either 
CONFIG_RELOCATABLE's option or CONFIG_EMNBEDDED's option is set "Y", 
you can configure the value of CONFIG_PHYSICAL_ALIGN.


Signed-off-by: Yoshimi Ichiyanagi <ichiyanagi.yoshimi@lab.ntt.co.jp>

---
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index f952493..05c3316 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -880,7 +880,7 @@ config RELOCATABLE
           kernel.
 
 config PHYSICAL_ALIGN
-	hex "Alignment value to which kernel should be aligned"
+	hex "Alignment value to which kernel should be aligned" if (EMBEDDED || RELOCATABLE)
 	default "0x100000"
 	range 0x2000 0x400000
 	help


--
Yoshimi Ichiyanagi
Open source software computing project, NTT Cyber Space Laboratories
E-mail : ichiyanagi.yoshimi@lab.ntt.co.jp
