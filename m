From: Zachary Amsden <zach@vmware.com>
Subject: [RFC, PATCH 2/5] Paravirt_ops patch bugs.patch
Date: Thu, 19 Apr 2007 18:52:34 -0700 (PDT)
Message-ID: <20070420015234.5D42EBFC@zach-dev2.vmware.com>
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
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <petr@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chaz Masden <zamsden@gmail.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Failing to patch because not enough space is available for a call or jump
or because the site clobbers do not allow the target clobbers to fit is
a fatal error; it means the kernel can not be properly virtualized.

In patch_insns, we just keep a warning instead; it may not be fatal, as
they paravirt-ops backend may just be trying to insert a greedy but not
necessary inline function.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r fcb59055d2b2 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Thu Apr 19 12:36:06 2007 -0700
+++ b/arch/i386/kernel/paravirt.c	Thu Apr 19 15:42:02 2007 -0700
@@ -132,10 +140,8 @@ unsigned paravirt_patch_call(void *targe
 	unsigned char *call = site;
 	unsigned long delta = (unsigned long)target - (unsigned long)(call+5);
 
-	if (tgt_clobbers & ~site_clobbers)
-		return len;	/* target would clobber too much for this site */
-	if (len < 5)
-		return len;	/* call too long for patch site */
+	BUG_ON(tgt_clobbers & ~site_clobbers);
+	BUG_ON(len < 5);
 
 	*call++ = 0xe8;		/* call */
 	*(unsigned long *)call = delta;
@@ -148,8 +154,7 @@ unsigned paravirt_patch_jmp(void *target
 	unsigned char *jmp = site;
 	unsigned long delta = (unsigned long)target - (unsigned long)(jmp+5);
 
-	if (len < 5)
-		return len;	/* call too long for patch site */
+	BUG_ON(len < 5);
 
 	*jmp++ = 0xe9;		/* jmp */
 	*(unsigned long *)jmp = delta;
@@ -186,7 +191,10 @@ unsigned paravirt_patch_insns(void *site
 {
 	unsigned insn_len = end - start;
 
-	if (insn_len > len || start == NULL)
+	WARN_ON(insn_len > len);
+	BUG_ON(start == NULL);
+
+	if (insn_len > len)
 		insn_len = len;
 	else
 		memcpy(site, start, insn_len);
