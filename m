From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 06/11] x86/paravirt: introduce new config option
	PARAVIRT_XXL
Date: Mon, 13 Aug 2018 09:37:34 +0200
Message-ID: <20180813073739.26108-7-jgross__30889.4681781114$1534146601$gmane$org@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

A large amount of paravirt ops is used by Xen PV guests only. Add a new
config option PARAVIRT_XXL which is selected by XEN_PV. Later we can
put the Xen PV only paravirt ops under the PARACVIRT_XXL umbrella.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig     | 3 +++
 arch/x86/xen/Kconfig | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 887d3a7bb646..3c967b803c21 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -754,6 +754,9 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
+config PARAVIRT_XXL
+	bool
+
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
 	depends on PARAVIRT && DEBUG_KERNEL
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index c1f98f32c45f..dd92d7bd3613 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -18,6 +18,7 @@ config XEN_PV
 	bool "Xen PV guest support"
 	default y
 	depends on XEN
+	select PARAVIRT_XXL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
 	help
-- 
2.13.7
