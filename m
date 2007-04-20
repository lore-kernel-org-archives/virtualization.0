From: Zachary Amsden <zach@vmware.com>
Subject: [RFC, PATCH 4/5] Paravirt_ops drop internal patches.patch
Date: Thu, 19 Apr 2007 18:52:54 -0700 (PDT)
Message-ID: <20070420015254.6C451BFC@zach-dev2.vmware.com>
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
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <petr@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chaz Masden <zamsden@gmail.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Some of these boot hooks do not need to be patched, in fact, it is better not
to patch them at all and thus keep them totally private.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r dba7b8b8e43d include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Apr 19 16:12:02 2007 -0700
+++ b/include/asm-i386/paravirt.h	Thu Apr 19 16:16:19 2007 -0700
@@ -686,12 +686,12 @@ static inline unsigned long apic_read(un
 
 static inline void setup_boot_clock(void)
 {
-	PVOP_VCALL0(setup_boot_clock);
+	paravirt_ops.setup_boot_clock();
 }
 
 static inline void setup_secondary_clock(void)
 {
-	PVOP_VCALL0(setup_secondary_clock);
+	paravirt_ops.setup_secondary_clock();
 }
 #endif
 
@@ -711,7 +711,7 @@ static inline void startup_ipi_hook(int 
 static inline void startup_ipi_hook(int phys_apicid, unsigned long start_eip,
 				    unsigned long start_esp)
 {
-	PVOP_VCALL3(startup_ipi_hook, phys_apicid, start_eip, start_esp);
+	paravirt_ops.startup_ipi_hook(phys_apicid, start_eip, start_esp);
 }
 #endif
