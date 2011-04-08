From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Subject: Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Fri, 8 Apr 2011 07:46:17 +0100
Message-ID: <1302245177.31620.47.camel__7205.98406992412$1302245220$gmane$org@localhost.localdomain>
References: <1301828839.2837.143.camel@edumazet-laptop>
	<20110403.172407.91341067.davem@davemloft.net>
	<1301910955.23887.75.camel@zakaz.uk.xensource.com>
	<20110406.144515.235693855.davem@davemloft.net>
	<1302159483.31620.36.camel@localhost.localdomain>
	<4D9DEDA5.6020706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D9DEDA5.6020706@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "mingo@redhat.com" <mingo@redhat.com>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pazke@donpac.ru" <pazke@donpac.ru>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

(dropping netdev and visws list)
On Thu, 2011-04-07 at 18:00 +0100, H. Peter Anvin wrote:
> On 04/06/2011 11:58 PM, Ian Campbell wrote:
> > 
> > I'm not sure why ELAN belongs in the EXTENDED_PLATFORM option space
> > rather than in the CPU choice option, since its only impact seems to be
> > on -march, MODULE_PROC_FAMILY and some cpufreq drivers which doesn't
> > sound like an extended platform to me but does it appear to be
> > deliberate (see 9e111f3e167a "x86: move ELAN to the
> > NON_STANDARD_PLATFORM section", that was the old name for
> > EXTENDED_PLATFORM).
> > 
> 
> Historic... we used to have nonstandard A20M# handling on Elan, until it
> was discovered that we could make it work without it.

Any reason not switch it over at this point then?

8<--------------------------

From b1942fa168aee77537bf467e4c68c6f181b8fdee Mon Sep 17 00:00:00 2001
From: Ian Campbell <ijc@hellion.org.uk>
Date: Fri, 8 Apr 2011 07:42:29 +0100
Subject: [PATCH] x86: move AMD Elan Kconfig under "Processor family"

Currently the option resides under X86_EXTENDED_PLATFORM due to historical
nonstandard A20M# handling. However that is no longer the case and so Elan can
be treated as part of the standard processor choice Kconfig option.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/Kconfig                    |   11 -----------
 arch/x86/Kconfig.cpu                |   16 ++++++++++------
 arch/x86/Makefile_32.cpu            |    2 +-
 arch/x86/include/asm/module.h       |    2 +-
 arch/x86/kernel/cpu/cpufreq/Kconfig |    4 ++--
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cc6c53a..f00a3f3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -365,17 +365,6 @@ config X86_UV
 # Following is an alphabetically sorted list of 32 bit extended platforms
 # Please maintain the alphabetic order if and when there are additions
 
-config X86_ELAN
-	bool "AMD Elan"
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	---help---
-	  Select this for an AMD Elan processor.
-
-	  Do not use this option for K6/Athlon/Opteron processors!
-
-	  If unsure, choose "PC-compatible" instead.
-
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
 	depends on PCI
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index d161e93..6a7cfdf 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -1,6 +1,4 @@
 # Put here option for CPU selection and depending optimization
-if !X86_ELAN
-
 choice
 	prompt "Processor family"
 	default M686 if X86_32
@@ -203,6 +201,14 @@ config MWINCHIP3D
 	  stores for this CPU, which can increase performance of some
 	  operations.
 
+config MELAN
+	bool "AMD Elan"
+	depends on X86_32
+	---help---
+	  Select this for an AMD Elan processor.
+
+	  Do not use this option for K6/Athlon/Opteron processors!
+
 config MGEODEGX1
 	bool "GeodeGX1"
 	depends on X86_32
@@ -292,8 +298,6 @@ config X86_GENERIC
 	  This is really intended for distributors who need more
 	  generic optimizations.
 
-endif
-
 #
 # Define implied options from the CPU selection here
 config X86_INTERNODE_CACHE_SHIFT
@@ -312,7 +316,7 @@ config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || MPSC
 	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
-	default "4" if X86_ELAN || M486 || M386 || MGEODEGX1
+	default "4" if MELAN || M486 || M386 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
 config X86_XADD
@@ -358,7 +362,7 @@ config X86_POPAD_OK
 
 config X86_ALIGNMENT_16
 	def_bool y
-	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODEGX1
+	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODEGX1
 
 config X86_INTEL_USERCOPY
 	def_bool y
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index f2ee1ab..86cee7b 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -37,7 +37,7 @@ cflags-$(CONFIG_MATOM)		+= $(call cc-option,-march=atom,$(call cc-option,-march=
 	$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
 
 # AMD Elan support
-cflags-$(CONFIG_X86_ELAN)	+= -march=i486
+cflags-$(CONFIG_MELAN)		+= -march=i486
 
 # Geode GX1 support
 cflags-$(CONFIG_MGEODEGX1)	+= -march=pentium-mmx
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 67763c5..9eae775 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -35,7 +35,7 @@
 #define MODULE_PROC_FAMILY "K7 "
 #elif defined CONFIG_MK8
 #define MODULE_PROC_FAMILY "K8 "
-#elif defined CONFIG_X86_ELAN
+#elif defined CONFIG_MELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
 #define MODULE_PROC_FAMILY "CRUSOE "
diff --git a/arch/x86/kernel/cpu/cpufreq/Kconfig b/arch/x86/kernel/cpu/cpufreq/Kconfig
index 870e6cc..0ab9b22 100644
--- a/arch/x86/kernel/cpu/cpufreq/Kconfig
+++ b/arch/x86/kernel/cpu/cpufreq/Kconfig
@@ -43,7 +43,7 @@ config X86_ACPI_CPUFREQ
 config ELAN_CPUFREQ
 	tristate "AMD Elan SC400 and SC410"
 	select CPU_FREQ_TABLE
-	depends on X86_ELAN
+	depends on MELAN
 	---help---
 	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
 	  processors.
@@ -59,7 +59,7 @@ config ELAN_CPUFREQ
 config SC520_CPUFREQ
 	tristate "AMD Elan SC520"
 	select CPU_FREQ_TABLE
-	depends on X86_ELAN
+	depends on MELAN
 	---help---
 	  This adds the CPUFreq driver for AMD Elan SC520 processor.
 
-- 
1.7.4.1
