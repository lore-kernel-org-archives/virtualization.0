From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [Xen-ia64-devel] [PATCH 7/8] ia64/xen: paravirtualize minstate.h,
	DO_SAVE_MIN.
Date: Wed, 27 Feb 2008 10:32:00 +0900
Message-ID: <5C878E08C9E9Btakebe_akio__43983.0302064822$1204076001$gmane$org@jp.fujitsu.com>
References: <1204034339752-git-send-email-yamahata@valinux.co.jp>
	<12040343392692-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12040343392692-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, linux-ia64@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Hi, Isaku

>---
> arch/ia64/xen/xenminstate.h |  148 ++++++++++++++++++++++++++++++++++++++++
>+++
> 1 files changed, 148 insertions(+), 0 deletions(-)
> create mode 100644 arch/ia64/xen/xenminstate.h
>
>diff --git a/arch/ia64/xen/xenminstate.h b/arch/ia64/xen/xenminstate.h
>new file mode 100644
>index 0000000..cdaf910
>--- /dev/null
>+++ b/arch/ia64/xen/xenminstate.h
>@@ -0,0 +1,148 @@
>+#include <asm/cache.h>
>+
>+#ifdef CONFIG_XEN
>+#include "../kernel/entry.h"
>+#else
>+#include "entry.h"
>+#endif
>+
>
we don't have arch/ia64/xen/entry.h,
so the above ifdef is not necessary.

Best Regards,

Akio Takebe
