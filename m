From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH] 2.6.21 - VMI logic error
Date: Thu, 12 Apr 2007 19:28:46 -0700
Message-ID: <461EEADE.8060400@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060306080607060102020809"
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------060306080607060102020809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

So there is a logic error that would prevent us from ever using NOP 
relocations, thus stopping any unnecessary callouts into a VMI ROM.  It 
doesn't affect us so much, but could conceivably affect open source 
implementations of a VMI ROM in the future.  It is not absolutely 
critical, but it would be extremely nice to get it fixed in 2.6.21 so 
there are no broken older kernels floating around that mandate having a 
workaround for this or else breaking compatibility with these kernels.

Thanks,

Zach

--------------060306080607060102020809
Content-Type: text/plain;
 name="vmi-logic-error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmi-logic-error.patch"

Fix logic error in VMI relocation processing.  NOPs would always cause
a BUG_ON to fire because the != RELOCATION_NONE in the first if clause
precluding the == VMI_RELOCATION_NOP in the second clause.  Make these
direct equality tests and just warn for unsupported relocation types
(which should never happen), falling back to native in that case.

Thanks to Anthony Liguori for noting this!

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 99800d11a3ec arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Apr 12 16:37:29 2007 -0700
+++ b/arch/i386/kernel/vmi.c	Thu Apr 12 19:00:46 2007 -0700
@@ -685,11 +685,14 @@ do {								\
 do {								\
 	reloc = call_vrom_long_func(vmi_rom, get_reloc,		\
 				    VMI_CALL_##vmicall);	\
-	if (rel->type != VMI_RELOCATION_NONE) {			\
-		BUG_ON(rel->type != VMI_RELOCATION_CALL_REL);	\
+	if (rel->type == VMI_RELOCATION_CALL_REL) 		\
 		paravirt_ops.opname = (void *)rel->eip;		\
-	} else if (rel->type == VMI_RELOCATION_NOP) 		\
+	else if (rel->type == VMI_RELOCATION_NOP) 		\
 		paravirt_ops.opname = (void *)vmi_nop;		\
+	else if (rel->type != VMI_RELOCATION_NONE)		\
+		printk(KERN_WARNING "VMI: Unknown relocation "	\
+				    "type %d for " #vmicall"\n",\
+					rel->type);		\
 } while (0)
 
 /*

--------------060306080607060102020809
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization

--------------060306080607060102020809--
