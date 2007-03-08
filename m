From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 09/17] paravirt_ops - bios changes
Date: Thu, 08 Mar 2007 01:02:20 -0500
Message-ID: <1173333740.25848.10.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-bios.patch)
Add an interface for paravirt ops and e820.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>



Index: clean-start/arch/x86_64/kernel/e820.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/e820.c
+++ clean-start/arch/x86_64/kernel/e820.c
@@ -567,7 +567,7 @@ void __init setup_memory_region(void)
 	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0)
 		early_panic("Cannot find a valid memory map");
 	printk(KERN_INFO "BIOS-provided physical RAM map:\n");
-	e820_print_map("BIOS-e820");
+	e820_print_map(MAP_TYPE_STR);
 }
 =

 static int __init parse_memopt(char *p)
Index: clean-start/include/asm-x86_64/e820.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/e820.h
+++ clean-start/include/asm-x86_64/e820.h
@@ -55,7 +55,22 @@ extern void finish_e820_parsing(void);
 =

 extern struct e820map e820;
 =

+#define EBDA_ADDR_POINTER 0x40E
+static inline void native_ebda_info(unsigned *addr,unsigned *size)
+{
+	*addr =3D *(unsigned short *)EBDA_ADDR_POINTER;
+	*addr <<=3D 4;
+        *size =3D *(unsigned short *)(unsigned long)*addr;
+}
+
 extern unsigned ebda_addr, ebda_size;
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define ebda_info native_ebda_info
+#define MAP_TYPE_STR "BIOS-e820"
+#endif
+
 #endif/*!__ASSEMBLY__*/
 =

 #endif/*__E820_HEADER*/

--
