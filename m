From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH RESEND] x86-64: use RIP-relative calls for paravirt
	indirect ones
Date: Wed, 15 Aug 2018 02:09:26 -0600
Message-ID: <5B73DFB602000078001DE35E__38262.8255094916$1534320448$gmane$org@prv1-mh.provo.novell.com>
References: <5B30C3F102000078001CD6F1@prv1-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: the arch/x86 maintainers <x86@kernel.org>, Juergen Gross <jgross@suse.com>, Alok Kataria <akataria@vmware.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This saves one insn byte per instance, summing up to a savings of over
4k in my (stripped down) configuration. No variant of to be patched in
replacement code relies on the one byte larger size.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
Resend to include x86 maintainers, who aren't listed explicitly for the
file changed.
---
 arch/x86/include/asm/paravirt_types.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- 4.18/arch/x86/include/asm/paravirt_types.h
+++ 4.18-x86_64-pvops-call-RIPrel/arch/x86/include/asm/paravirt_types.h
@@ -393,9 +393,15 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
+#ifdef CONFIG_X86_32
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
 	"call *%c[paravirt_opptr];"
+#else
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr](%%rip);"
+#endif
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
