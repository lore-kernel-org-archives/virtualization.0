From: joe@perches.com
Subject: [PATCH] [545/2many] MAINTAINERS - XEN HYPERVISOR INTERFACE
Date: Sun, 12 Aug 2007 23:39:49 -0700
Message-ID: <46bffcb5.o/KKCq3EZH4S47k3%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeremy@xensource.com, chrisw@sous-sol.org, akpm
List-Id: virtualization@lists.linuxfoundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e4e1cc3..8395aba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5153,6 +5153,11 @@ M:	chrisw@sous-sol.org
 L:	virtualization@lists.osdl.org
 L:	xen-devel@lists.xensource.com
 S:	Supported
+F:	arch/i386/xen/
+F:	drivers/*/xen-*front.c
+F:	drivers/xen/
+F:	include/asm-i386/xen/
+F:	include/xen/
 
 XFS FILESYSTEM
 P:	Silicon Graphics Inc
