From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Subject: Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Fri, 8 Apr 2011 07:38:14 +0100
Message-ID: <1302244694.31620.44.camel__18635.7414735996$1302244749$gmane$org@localhost.localdomain>
References: <1301828839.2837.143.camel@edumazet-laptop>
	<20110403.172407.91341067.davem@davemloft.net>
	<1301910955.23887.75.camel@zakaz.uk.xensource.com>
	<20110406.144515.235693855.davem@davemloft.net>
	<1302159483.31620.36.camel@localhost.localdomain>
	<4D9DFD6A.1060200@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D9DFD6A.1060200@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, David Miller <davem@davemloft.net>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pazke@donpac.ru" <pazke@donpac.ru>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

(dropping netdev and the visws list)

On Thu, 2011-04-07 at 11:07 -0700, Jeremy Fitzhardinge wrote:
> On 04/06/2011 11:58 PM, Ian Campbell wrote:
> > On Wed, 2011-04-06 at 22:45 +0100, David Miller wrote:
> >> From: Ian Campbell <Ian.Campbell@eu.citrix.com>
> >> Date: Mon, 4 Apr 2011 10:55:55 +0100
> >>
> >>> You mean the "!X86_VISWS" I presume? It doesn't make sense to me either.
> >> No, I think 32-bit x86 allmodconfig elides XEN because of it's X86_TSC dependency.
> > TSC is a real dependency of the Xen interfaces.
> 
> Not really.  The TSC register is a requirement, but that's going to be
> present on any CPU which can boot Xen.  We don't need any of the
> kernel's TSC machinery though.

So why the Kconfig dependency then? In principal a kernel compiled for a
non-TSC processor (which meets the other requirements for Xen, such as
PAE support) will run just fine under Xen on a newer piece of hardware.

Is there any downside to this patch (is X86_CMPXCHG in the same sort of
boat?)

8<----------------------------------

From 7204945696a927d281366f2a57baee37e2b43ca3 Mon Sep 17 00:00:00 2001
From: Ian Campbell <ijc@hellion.org.uk>
Date: Fri, 8 Apr 2011 07:33:21 +0100
Subject: [PATCH] xen: remove Kconfig dependency on X86_TSC

The TSC register is a requirement when running under Xen, but that's going to
be present on any CPU which can boot Xen. We don't need any of the kernel's TSC
machinery, since the usage is contained within the Xen interfaces, and therefore
XEN does not need to depend on CONFIG_X86_TSC.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
---
 arch/x86/xen/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 1c7121b..ac69c5b 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -7,7 +7,7 @@ config XEN
 	select PARAVIRT
 	select PARAVIRT_CLOCK
 	depends on X86_64 || (X86_32 && X86_PAE && !X86_VISWS)
-	depends on X86_CMPXCHG && X86_TSC
+	depends on X86_CMPXCHG
 	help
 	  This is the Linux Xen port.  Enabling this will allow the
 	  kernel to boot in a paravirtualized environment under the
-- 
1.7.4.1
