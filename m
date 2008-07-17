From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 07/29] ia64/xen: add a neccessary header file to copmle
	include/xen/interface/xen.h
Date: Thu, 17 Jul 2008 14:55:30 +0900
Message-ID: <20080717055530.GD25137%yamahata__29878.9128465161$1216274255$gmane$org@valinux.co.jp>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>
	<1216260662692-git-send-email-yamahata@valinux.co.jp>
	<487EDBF9.8050305@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <487EDBF9.8050305@goop.org>
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
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 16, 2008 at 10:43:21PM -0700, Jeremy Fitzhardinge wrote:
> Isaku Yamahata wrote:
> >Create include/asm-ia64/pvclock-abi.h to compile which includes
> >include/asm-x86/pvclock-abi.h because ia64/xen uses same structure.
> >Hopefully include/asm-x86/pvclock-abi.h would be moved to somewhere
> >more generic.
> >  
> 
> Could you fix the patch title spelling ("necessary", "compile")?  The 
> misspelled words are hard to search for.
> 
> >Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
> >---
> > include/asm-ia64/pvclock-abi.h |    5 +++++
> > 1 files changed, 5 insertions(+), 0 deletions(-)
> > create mode 100644 include/asm-ia64/pvclock-abi.h
> >
> >diff --git a/include/asm-ia64/pvclock-abi.h 
> >b/include/asm-ia64/pvclock-abi.h
> >new file mode 100644
> >index 0000000..1c34d11
> >--- /dev/null
> >+++ b/include/asm-ia64/pvclock-abi.h
> >@@ -0,0 +1,5 @@
> >+/*
> >+ * use same streucute to x86's
> >  
> "structure"?
> 

Thanks for pointing out. Fixed typo.


From f6cfeafb4a63058b97a3a32f45e02ef878faa947 Mon Sep 17 00:00:00 2001
From: Isaku Yamahata <yamahata@valinux.co.jp>
Date: Fri, 4 Jul 2008 11:29:33 +0900
Subject: [PATCH 12/29] ia64/xen: add a necessary header file to compile include/xen/interface/xen.h

Create include/asm-ia64/pvclock-abi.h to compile which includes
include/asm-x86/pvclock-abi.h because ia64/xen uses same structure.
Hopefully include/asm-x86/pvclock-abi.h would be moved to somewhere
more generic.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/pvclock-abi.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-ia64/pvclock-abi.h

diff --git a/include/asm-ia64/pvclock-abi.h b/include/asm-ia64/pvclock-abi.h
new file mode 100644
index 0000000..63cbcca
--- /dev/null
+++ b/include/asm-ia64/pvclock-abi.h
@@ -0,0 +1,5 @@
+/*
+ * use same structure to x86's
+ * Hopefully asm-x86/pvclock-abi.h would be moved to somewhere more generic.
+ */
+#include <asm-x86/pvclock-abi.h>
-- 
1.5.3




-- 
yamahata
