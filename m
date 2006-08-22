From: Ian Campbell <Ian.Campbell@XenSource.com>
Subject: [PATCH 1 of 1] x86_43: Put .note.* sections into a
	PT_NOTE segment in vmlinux
Date: Tue, 22 Aug 2006 12:14:18 +0100
Message-ID: <1156245258.5091.17.camel@localhost.localdomain>
References: <2bf2abf6e97048bbef24.1154462451@ezr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <2bf2abf6e97048bbef24.1154462451@ezr>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@osdl.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-01 at 13:00 -0700, Jeremy Fitzhardinge wrote:
> This patch will pack any .note.* section into a PT_NOTE segment in the
> output file.
[...]
> This only changes i386 for now, but I presume the corresponding
> changes for other architectures will be as simple.

Here is the patch for x86_64.

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff -urN ref-linux-2.6.16.13/arch/x86_64/kernel/vmlinux.lds.S x86-64_elfnotes/arch/x86_64/kernel/vmlinux.lds.S
--- ref-linux-2.6.16.13/arch/x86_64/kernel/vmlinux.lds.S	2006-05-02 22:38:44.000000000 +0100
+++ x86-64_elfnotes/arch/x86_64/kernel/vmlinux.lds.S	2006-08-22 11:39:14.000000000 +0100
@@ -14,6 +14,11 @@
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
+PHDRS {
+	text PT_LOAD FLAGS(5);	/* R_E */
+	data PT_LOAD FLAGS(7);	/* RWE */
+	note PT_NOTE FLAGS(4);	/* R__ */
+}
 SECTIONS
 {
   . = __START_KERNEL;
@@ -26,7 +31,7 @@
 	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
+	} :text = 0x9090
   				/* out-of-line lock text */
   .text.lock : AT(ADDR(.text.lock) - LOAD_OFFSET) { *(.text.lock) }
 
@@ -43,7 +48,7 @@
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
 	CONSTRUCTORS
-	}
+	} :data
 
   _edata = .;			/* End of data section */
 
@@ -201,4 +206,6 @@
   STABS_DEBUG
 
   DWARF_DEBUG
+
+  NOTES
 }
