From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] paravirt: switch maintainer
Date: Tue,  5 Sep 2017 16:34:07 +0200
Message-ID: <20170905143407.9227-1-jgross__33318.9874225811$1504622109$gmane$org@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge is stepping down as a paravirt maintainer. I'll
replace him.

While at it, update the file list to the actual pattern.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ef4694af6e8..d7565683aab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9956,7 +9956,7 @@ F:	include/uapi/linux/ppdev.h
 F:	Documentation/parport*.txt
 
 PARAVIRT_OPS INTERFACE
-M:	Jeremy Fitzhardinge <jeremy@goop.org>
+M:	Juergen Gross <jgross@suse.com>
 M:	Chris Wright <chrisw@sous-sol.org>
 M:	Alok Kataria <akataria@vmware.com>
 M:	Rusty Russell <rusty@rustcorp.com.au>
@@ -9964,7 +9964,7 @@ L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	Documentation/virtual/paravirt_ops.txt
 F:	arch/*/kernel/paravirt*
-F:	arch/*/include/asm/paravirt.h
+F:	arch/*/include/asm/paravirt*.h
 F:	include/linux/hypervisor.h
 
 PARIDE DRIVERS FOR PARALLEL PORT IDE DEVICES
-- 
2.12.3
