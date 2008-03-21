From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 14/15] guest: detect when running on kvm
Date: Fri, 21 Mar 2008 15:33:29 +0100
Message-ID: <1206110009.8363.3.camel__49850.1430186026$1206110684$gmane$org@cotte.boeblingen.de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
	<20080320175357.GA30959@infradead.org> <47E2CAFF.3070203@de.ibm.com>
	<20080320194137.GA9975@infradead.org> <47E2D034.4090600@de.ibm.com>
	<20080320212255.GA4225@osiris.boeblingen.de.ibm.com>
	<47E39804.4030605@de.ibm.com>
	<20080321140603.GC4128@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080321140603.GC4128@osiris.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: carsteno@linux.vnet.ibm.com, Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, carsteno@de.ibm.com, heicars2@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, kvm-devel@lists.sourceforge.net, borntrae@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag, den 21.03.2008, 15:06 +0100 schrieb Heiko Carstens:
> Just introduce something like MACHINE_FLAG_KVM. The rest can be converted
> later. Unless you're bored and feel like fiddling around with assembly code :)
I've done that patch this morning already, see below. I agree with HCH
that we should do that, but after the kvm merge. I don't want kvm-s390
conflict with Martin's patches. This is just a beautification, and can
safely wait a release cycle.
---
 arch/s390/kernel/early.c |    6 +++---
 include/asm-s390/setup.h |   32 ++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

Index: linux-host/arch/s390/kernel/early.c
===================================================================
--- linux-host.orig/arch/s390/kernel/early.c
+++ linux-host/arch/s390/kernel/early.c
@@ -138,15 +138,15 @@ static noinline __init void detect_machi
 
 	/* Running under z/VM ? */
 	if (cpuinfo->cpu_id.version == 0xff)
-		machine_flags |= 1;
+		machine_flags |= MACHINE_FLAG_VM;
 
 	/* Running on a P/390 ? */
 	if (cpuinfo->cpu_id.machine == 0x7490)
-		machine_flags |= 4;
+		machine_flags |= MACHINE_FLAG_P390;
 
 	/* Running under KVM ? */
 	if (cpuinfo->cpu_id.version == 0xfe)
-		machine_flags |= 64;
+		machine_flags |= MACHINE_FLAG_KVM;
 }
 
 #ifdef CONFIG_64BIT
Index: linux-host/include/asm-s390/setup.h
===================================================================
--- linux-host.orig/include/asm-s390/setup.h
+++ linux-host/include/asm-s390/setup.h
@@ -59,23 +59,35 @@ extern unsigned int s390_noexec;
  */
 extern unsigned long machine_flags;
 
-#define MACHINE_IS_VM		(machine_flags & 1)
-#define MACHINE_IS_P390		(machine_flags & 4)
-#define MACHINE_HAS_MVPG	(machine_flags & 16)
-#define MACHINE_IS_KVM		(machine_flags & 64)
-#define MACHINE_HAS_IDTE	(machine_flags & 128)
-#define MACHINE_HAS_DIAG9C	(machine_flags & 256)
+#define MACHINE_FLAG_VM		1
+#define MACHINE_FLAG_IEEE	2
+#define MACHINE_FLAG_P390	4
+#define MACHINE_FLAG_CSP	8
+#define MACHINE_FLAG_MVPG	16
+#define MACHINE_FLAG_DIAG44	32
+#define MACHINE_FLAG_KVM	64
+#define MACHINE_FLAG_IDTE	128
+#define MACHINE_FLAG_DIAG9C	256
+#define MACHINE_FLAG_MVCOS	512
+
+
+#define MACHINE_IS_VM		(machine_flags & MACHINE_FLAG_VM)
+#define MACHINE_IS_KVM		(machine_flags & MACHINE_FLAG_KVM)
+#define MACHINE_IS_P390		(machine_flags & MACHINE_FLAG_P390)
+#define MACHINE_HAS_MVPG	(machine_flags & MACHINE_FLAG_MVPG)
+#define MACHINE_HAS_IDTE	(machine_flags & MACHINE_FLAG_IDTE)
+#define MACHINE_HAS_DIAG9C	(machine_flags & MACHINE_FLAG_DIAG9C)
 
 #ifndef __s390x__
-#define MACHINE_HAS_IEEE	(machine_flags & 2)
-#define MACHINE_HAS_CSP		(machine_flags & 8)
+#define MACHINE_HAS_IEEE	(machine_flags & MACHINE_FLAG_IEEE)
+#define MACHINE_HAS_CSP		(machine_flags & MACHINE_FLAG_CSP)
 #define MACHINE_HAS_DIAG44	(1)
 #define MACHINE_HAS_MVCOS	(0)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
-#define MACHINE_HAS_DIAG44	(machine_flags & 32)
-#define MACHINE_HAS_MVCOS	(machine_flags & 512)
+#define MACHINE_HAS_DIAG44	(machine_flags & MACHINE_FLAG_DIAG44)
+#define MACHINE_HAS_MVCOS	(machine_flags & MACHINE_FLAG_MVCOS)
 #endif /* __s390x__ */
 
 #define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
