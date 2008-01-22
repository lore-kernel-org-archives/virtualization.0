From: Eduardo Pereira Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/2] Allow enabling PARAVIRT without any guest implementation
Date: Tue, 22 Jan 2008 16:50:18 -0200
Message-ID: <20080122185018.GY7338__18729.6271244579$1201028256$gmane$org@blackpad>
References: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
	<20080122120207.GA30271@elte.hu>
	<20080122123450.GU7338@blackpad> <47962E1D.2090308@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47962E1D.2090308@goop.org>
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
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


On Tue, Jan 22, 2008 at 09:55:41AM -0800, Jeremy Fitzhardinge wrote:
> Eduardo Pereira Habkost wrote:
> >If this is desirable for broader testing, we can make config PARAVIRT
> >visible and selectable on menuconfig, even when there is no guest
> >implementation being enabled. Should I do it?
> >  
> 
> Yes please.
> 

This will allow people to enable the paravirt_ops code even when no
guest support is enabled, for broader testing of the paravirt_ops code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/Kconfig |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e910d8..715bbcd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -325,15 +325,6 @@ config SCHED_NO_NO_OMIT_FRAME_POINTER
 
 	  If in doubt, say "Y".
 
-config PARAVIRT
-	bool
-	depends on X86_32 && !(X86_VISWS || X86_VOYAGER)
-	help
-	  This changes the kernel so it can modify itself when it is run
-	  under a hypervisor, potentially improving performance significantly
-	  over full virtualization.  However, when run without a hypervisor
-	  the kernel is theoretically slower and slightly larger.
-
 menuconfig PARAVIRT_GUEST
 	bool "Paravirtualized guest support"
 	depends on X86_32
@@ -359,6 +350,15 @@ config VMI
 
 source "arch/x86/lguest/Kconfig"
 
+config PARAVIRT
+	bool "Enable paravirtualization code"
+	depends on X86_32 && !(X86_VISWS || X86_VOYAGER)
+	help
+	  This changes the kernel so it can modify itself when it is run
+	  under a hypervisor, potentially improving performance significantly
+	  over full virtualization.  However, when run without a hypervisor
+	  the kernel is theoretically slower and slightly larger.
+
 endif
 
 config ACPI_SRAT
-- 
1.5.3.4

-- 
Eduardo
