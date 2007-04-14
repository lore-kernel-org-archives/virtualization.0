From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 13/28] paravirt: flush lazy mmu updates on kunmap_atomic
Date: Sat, 14 Apr 2007 13:42:07 -0700
Message-ID: <20070414204924.349072869@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=paravirt-flush-on-kunmap_atomic.patch
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

kunmap_atomic should flush any pending lazy mmu updates, mainly to be
consistent with kmap_atomic, and to preserve its normal behaviour.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/mm/highmem.c |    1 +
 1 file changed, 1 insertion(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/highmem.c
+++ b/arch/i386/mm/highmem.c
@@ -72,6 +72,7 @@ void kunmap_atomic(void *kvaddr, enum km
 #endif
 	}
 =

+	arch_flush_lazy_mmu_mode();
 	pagefault_enable();
 }
 =


-- =
