From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 08/27] ia64/xen: define helper functions for xen
	hypercalls.
Date: Thu, 19 Jun 2008 21:10:04 +0900
Message-ID: <20080619121004.GP11378%yamahata__38241.2069979638$1213877704$gmane$org@valinux.co.jp>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840431025-git-send-email-yamahata@valinux.co.jp>
	<57C9024A16AD2D4C97DC78E552063EA3061C5C5D@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA3061C5C5D@orsmsx505.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Dong, Eddie" <eddie.dong@intel.com>, "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 17, 2008 at 04:57:55PM -0700, Luck, Tony wrote:
> 
> +/*
> + * Hypercalls without parameter.
> + */
> +#define __HCALL0(name,hcall)           \
> +       GLOBAL_ENTRY(name);             \
> +       break   hcall;                  \
> 
> Should Linux code be made aware of the "break" numbers that
> are being used for hypercalls (so it doesn't try to re-use
> them for something else?)  include/asm-ia64/break.h should be
> updated with the appropriate stuff (just with a base value
> and a comment for how many you are using ... you can still
> define all the HYPERPRIVOP_* defines in a separate file).
> 
> -Tony

Here is the patch to reserve those numbers.

From 1c9b394c025bb9dcb29dc8240bda68117f577c9d Mon Sep 17 00:00:00 2001
From: Isaku Yamahata <yamahata@valinux.co.jp>
Date: Thu, 19 Jun 2008 19:07:37 +0900
Subject: [PATCH] ia64/xen: reserve "break" numbers used for xen hypercalls.

reserve "break" numbers used for xen hypercalls to avoid
reuse for something else.

Cc: "Luck, Tony" <tony.luck@intel.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/break.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/asm-ia64/break.h b/include/asm-ia64/break.h
index f034020..e90c40e 100644
--- a/include/asm-ia64/break.h
+++ b/include/asm-ia64/break.h
@@ -20,4 +20,13 @@
  */
 #define __IA64_BREAK_SYSCALL		0x100000
 
+/*
+ * Xen specific break numbers:
+ */
+#define __IA64_XEN_HYPERCALL		0x1000
+/* [__IA64_XEN_HYPERPRIVOP_START, __IA64_XEN_HYPERPRIVOP_MAX] is used
+   for xen hyperprivops */
+#define __IA64_XEN_HYPERPRIVOP_START	0x1
+#define __IA64_XEN_HYPERPRIVOP_MAX	0x1a
+
 #endif /* _ASM_IA64_BREAK_H */
-- 
1.5.3

-- 
yamahata
