From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 11/15] cleanup CLI_STRING, STI_STRING and friends
Date: Thu, 20 Dec 2007 18:04:06 -0200
Message-ID: <11981813384090-git-send-email-gcosta__39009.7222909846$1198182029$gmane$org@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
	<1198181224677-git-send-email-gcosta@redhat.com>
	<11981812412879-git-send-email-gcosta@redhat.com>
	<11981812771615-git-send-email-gcosta@redhat.com>
	<1198181309285-git-send-email-gcosta@redhat.com>
	<11981813192341-git-send-email-gcosta@redhat.com>
	<11981813292926-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981813292926-git-send-email-gcosta@redhat.com>
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

Since the advent of ticket locking, CLI_STRING, STI_STRING, and friends
are not used anymore. They can now be safely deleted.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/spinlock.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

Index: linux-2.6-x86/include/asm-x86/spinlock.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/spinlock.h	2007-12-20 19:06:59.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/spinlock.h	2007-12-20 19:08:09.000000000 -0800
@@ -19,15 +19,6 @@
  * (the type definitions are in asm/spinlock_types.h)
  */
 
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#else
-#define CLI_STRING	"cli"
-#define STI_STRING	"sti"
-#define CLI_STI_CLOBBERS
-#define CLI_STI_INPUT_ARGS
-#endif /* CONFIG_PARAVIRT */
-
 #ifdef CONFIG_X86_32
 typedef char _slock_t;
 # define LOCK_INS_DEC "decb"
