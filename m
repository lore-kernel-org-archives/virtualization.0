From: joe@perches.com
Subject: [PATCH] [365/2many] MAINTAINERS - PARAVIRT_OPS INTERFACE
Date: Sun, 12 Aug 2007 23:33:31 -0700
Message-ID: <46bffb3b.jTNczaQ2ECqVDjzn%joe@perches.com>
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
To: zach@vmware.com, virtualization@lists.osdl.org, torvalds@linux-foundation.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, jeremy@xensource.com, chrisw@s
List-Id: virtualization@lists.linuxfoundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 2166416..44768ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3519,6 +3519,9 @@ M:	rusty@rustcorp.com.au
 L:	virtualization@lists.osdl.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+F:	arch/i386/kernel/paravirt.c
+F:	include/asm-i386/paravirt.h
+F:	include/asm-um/paravirt.h
 
 PC87360 HARDWARE MONITORING DRIVER
 P:	Jim Cromie
