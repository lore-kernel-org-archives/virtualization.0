From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 6/9] remove unused macro
Date: Wed,  5 Dec 2007 13:08:30 -0200
Message-ID: <1196867342420-git-send-email-gcosta@redhat.com>
References: 20071204204931.GC32018@elte.hu
	<1196867313972-git-send-email-gcosta@redhat.com>
	<1196867319253-git-send-email-gcosta@redhat.com>
	<11968673241599-git-send-email-gcosta@redhat.com>
	<11968673291072-git-send-email-gcosta@redhat.com>
	<1196867333728-git-send-email-gcosta@redhat.com>
	<11968673383347-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11968673383347-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Mr. Grep says warn_if_not_ulong() is not used anymore anywhere
in the code. So, we remove it.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/system_64.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/asm-x86/system_64.h b/include/asm-x86/system_64.h
index 2757258..621e0b8 100644
--- a/include/asm-x86/system_64.h
+++ b/include/asm-x86/system_64.h
@@ -66,8 +66,6 @@
 #define read_barrier_depends()	do {} while(0)
 #define set_mb(var, value) do { (void) xchg(&var, value); } while (0)
 
-#define warn_if_not_ulong(x) do { unsigned long foo; (void) (&(x) == &foo); } while (0)
-
 #include <linux/irqflags.h>
 
 #endif
-- 
1.4.4.2
