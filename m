From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 09/32] ia64/xen: add a necessary header file to compile
	include/xen/interface/xen.h
Date: Tue, 14 Oct 2008 14:46:41 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA353274D0A__49609.9109681838$1224021458$gmane$org@orsmsx505.amr.corp.intel.com>
References: <1223963507-28056-1-git-send-email-yamahata@valinux.co.jp>
	<1223963507-28056-10-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1223963507-28056-10-git-send-email-yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

+++ b/arch/ia64/include/asm/pvclock-abi.h
@@ -0,0 +1,5 @@
+/*
+ * use same structure to x86's
+ * Hopefully asm-x86/pvclock-abi.h would be moved to somewhere more generic.
+ */
+#include <asm-x86/pvclock-abi.h>


I will trade out this patch for one that just makes
a copy of the x86 include file.  This #include will
break if/when x86 moves their include files to
arch/x86/include/asm

-Tony
