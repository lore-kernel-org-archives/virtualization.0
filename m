From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 6/6] Define per_cpu_offset
Date: Fri, 30 Mar 2007 19:00:48 -0700
Message-ID: <20070331020055.342794717@goop.org>
References: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=percpu-define-per_cpu_offset.patch
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

Define per_cpu_offset in asm-i386/percpu.h when SMP defined, like
asm-generic/percpu.h does for UP.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>

---
 include/asm-i386/percpu.h |    2 ++
 1 file changed, 2 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/percpu.h
+++ b/include/asm-i386/percpu.h
@@ -34,6 +34,8 @@
 =

 /* This is used for other cpus to find our section. */
 extern unsigned long __per_cpu_offset[];
+
+#define per_cpu_offset(x) (__per_cpu_offset[x])
 =

 /* Separate out the type, so (int[3], foo) works. */
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name

-- =
