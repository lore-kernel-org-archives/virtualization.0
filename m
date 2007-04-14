From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 14/28] fix paravirt-documentation
Date: Sat, 14 Apr 2007 13:42:08 -0700
Message-ID: <20070414204924.424081934@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=paravirt-fix-paravirt_lazy.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Remove #defines, add enum for PARAVIRT_LAZY_FLUSH.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/asm-i386/paravirt.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -30,6 +30,7 @@ enum paravirt_lazy_mode {
 	PARAVIRT_LAZY_NONE =3D 0,
 	PARAVIRT_LAZY_MMU =3D 1,
 	PARAVIRT_LAZY_CPU =3D 2,
+	PARAVIRT_LAZY_FLUSH =3D 3,
 };
 =

 struct paravirt_ops
@@ -906,12 +907,6 @@ static inline void set_pmd(pmd_t *pmdp, =

 }
 #endif	/* CONFIG_X86_PAE */
 =

-/* Lazy mode for batching updates / context switch */
-#define PARAVIRT_LAZY_NONE 0
-#define PARAVIRT_LAZY_MMU  1
-#define PARAVIRT_LAZY_CPU  2
-#define PARAVIRT_LAZY_FLUSH 3
-
 #define  __HAVE_ARCH_ENTER_LAZY_CPU_MODE
 static inline void arch_enter_lazy_cpu_mode(void)
 {

-- =
