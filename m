From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: more build errors ...
Date: Tue, 09 Jan 2007 14:20:46 +0100
Message-ID: <45A396AE.8090109@suse.de>
References: <45A37BC4.6060303@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000503010500040203030202"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A37BC4.6060303@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------000503010500040203030202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>   arch/i386/kernel/built-in.o: In function `APIC_init_uniprocessor':
>   (.init.text+0x6357): undefined reference to `setup_boot_clock'

>   drivers/built-in.o: In function `xencons_rx':
>   (.text+0x17f09): undefined reference to `sysrq_enabled'

Here is the fix for both.  Not fully sure the first one is correct
though, I've just moved the inline functions into the correct #ifdef
CONFIG_foo section, but didn't uninline them like rusty did for the
apic_* ones.  As they are hardly called by modules it should be ok this
way I think.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>

--------------000503010500040203030202
Content-Type: text/plain;
 name="kraxel.buildfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kraxel.buildfix"

---
 drivers/xen/console/console.c |    3 +--
 include/asm-i386/paravirt.h   |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

Index: paravirt-2.6.20-rc4-hg689/drivers/xen/console/console.c
===================================================================
--- paravirt-2.6.20-rc4-hg689.orig/drivers/xen/console/console.c
+++ paravirt-2.6.20-rc4-hg689/drivers/xen/console/console.c
@@ -83,7 +83,6 @@ static int xc_num = -1;
 
 #ifdef CONFIG_MAGIC_SYSRQ
 static unsigned long sysrq_requested;
-extern int sysrq_enabled;
 #endif
 
 static int __init xencons_setup(char *str)
@@ -324,7 +323,7 @@ void xencons_rx(char *buf, unsigned len)
 
 	for (i = 0; i < len; i++) {
 #ifdef CONFIG_MAGIC_SYSRQ
-		if (sysrq_enabled) {
+		if (sysrq_on()) {
 			if (buf[i] == '\x0f') { /* ^O */
 				sysrq_requested = jiffies;
 				continue; /* don't print the sysrq key */
Index: paravirt-2.6.20-rc4-hg689/include/asm-i386/paravirt.h
===================================================================
--- paravirt-2.6.20-rc4-hg689.orig/include/asm-i386/paravirt.h
+++ paravirt-2.6.20-rc4-hg689/include/asm-i386/paravirt.h
@@ -493,6 +493,16 @@ static inline void apic_write_atomic(uns
 	paravirt_ops.apic_write_atomic(reg,v);
 }
 unsigned long apic_read(unsigned long reg);
+
+static inline void setup_boot_clock(void)
+{
+	paravirt_ops.setup_boot_clock();
+}
+
+static inline void setup_secondary_clock(void)
+{
+	paravirt_ops.setup_secondary_clock();
+}
 #endif
 
 /* These will be unexported once raid6 is fixed... */
@@ -525,16 +535,6 @@ static inline void pmd_clear(pmd_t *pmdp
 {
 	paravirt_ops.pmd_clear(pmdp);
 }
-
-static inline void setup_boot_clock(void)
-{
-	paravirt_ops.setup_boot_clock();
-}
-
-static inline void setup_secondary_clock(void)
-{
-	paravirt_ops.setup_secondary_clock();
-}
 #endif
 
 /* Lazy mode for batching updates / context switch */

--------------000503010500040203030202
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------000503010500040203030202--
