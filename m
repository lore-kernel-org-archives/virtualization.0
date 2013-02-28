From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] arch/x86/xen: remove depends on CONFIG_EXPERIMENTAL
Date: Thu, 28 Feb 2013 13:56:40 -0800
Message-ID: <20130228215640.GA3136@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Mukesh Rathor <mukesh.rathor@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

The CONFIG_EXPERIMENTAL config item has not carried much meaning for a
while now and is almost always enabled by default. As agreed during the
Linux kernel summit, remove it from any "depends on" lines in Kconfigs.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Mukesh Rathor <mukesh.rathor@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---

v2:
 - drop EXPERIMENTAL from bool and help text too.

---
 arch/x86/xen/Kconfig |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 93ff4e1..6c5802f 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -52,12 +52,10 @@ config XEN_DEBUG_FS
 	  Enabling this option may incur a significant performance overhead.
 
 config XEN_X86_PVH
-	bool "Support for running as a PVH guest (EXPERIMENTAL)"
-	depends on X86_64 && XEN && EXPERIMENTAL
+	bool "Support for running as a PVH guest"
+	depends on X86_64 && XEN
 	default n
 	help
 	   This option enables support for running as a PVH guest (PV guest
 	   using hardware extensions) under a suitably capable hypervisor.
-	   This option is EXPERIMENTAL because the hypervisor interfaces
-	   which it uses is not yet considered stable therefore backwards and
-	   forwards compatibility is not yet guaranteed.  If unsure, say N.
+	   If unsure, say N.
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
