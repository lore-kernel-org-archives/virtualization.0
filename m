From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] arch/x86/xen: remove depends on CONFIG_EXPERIMENTAL
Date: Fri, 22 Feb 2013 23:29:59 -0800
Message-ID: <20130223072959.GA4894__43254.3779294521$1361644782$gmane$org@www.outflux.net>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Mukesh Rathor <mukesh.rathor@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

The CONFIG_EXPERIMENTAL config item has not carried much meaning for a
while now and is almost always enabled by default. As agreed during the
Linux kernel summit, remove it from any "depends on" lines in Kconfigs.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Mukesh Rathor <mukesh.rathor@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/xen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 93ff4e1..8cada4c 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -53,7 +53,7 @@ config XEN_DEBUG_FS
 
 config XEN_X86_PVH
 	bool "Support for running as a PVH guest (EXPERIMENTAL)"
-	depends on X86_64 && XEN && EXPERIMENTAL
+	depends on X86_64 && XEN
 	default n
 	help
 	   This option enables support for running as a PVH guest (PV guest
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
