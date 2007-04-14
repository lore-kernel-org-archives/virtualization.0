From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 26/28] From: Andrew Morton <akpm@linux-foundation.org>
Date: Sat, 14 Apr 2007 13:42:20 -0700
Message-ID: <20070414204925.334896811@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=rename-the-parainstructions-symbols-to-be-consistent-with-the-others-fix.patch
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

x86_64:

arch/x86_64/kernel/../../i386/kernel/alternative.c: In function 'alternativ=
e_instructions':
arch/x86_64/kernel/../../i386/kernel/alternative.c:374: error: '__parainstr=
uctions' undeclared (first use in this function)
arch/x86_64/kernel/../../i386/kernel/alternative.c:374: error: (Each undecl=
ared identifier is reported only once
arch/x86_64/kernel/../../i386/kernel/alternative.c:374: error: for each fun=
ction it appears in.)
arch/x86_64/kernel/../../i386/kernel/alternative.c:374: error: '__parainstr=
uctions_end' undeclared (first use in this function)

Cc: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/asm-x86_64/alternative.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86_64/alternative.h~rename-the-parainstructions-symbols-=
to-be-consistent-with-the-others-fix
+++ a/include/asm-x86_64/alternative.h
@@ -141,8 +141,8 @@ void apply_paravirt(struct paravirt_patc
 static inline void
 apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
 {}
-#define __start_parainstructions NULL
-#define __stop_parainstructions NULL
+#define __parainstructions NULL
+#define __parainstructions_end NULL
 #endif
 =

 #endif /* _X86_64_ALTERNATIVE_H */
_

-- =
