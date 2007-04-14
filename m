From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 03/28] fix allow-percpu-variables-to-be-page-aligned.patch
Date: Sat, 14 Apr 2007 13:41:57 -0700
Message-ID: <20070414204923.594579484@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=fix-ff-allow-percpu-variables-to-be-page-aligned.patch
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

Make sure allocation is page-aligned.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 init/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/init/main.c
+++ b/init/main.c
@@ -370,7 +370,7 @@ static void __init setup_per_cpu_areas(v
 =

 	/* Copy section for each CPU (we discard the original) */
 	size =3D ALIGN(PERCPU_ENOUGH_ROOM, PAGE_SIZE);
-	ptr =3D alloc_bootmem(size * nr_possible_cpus);
+	ptr =3D alloc_bootmem_pages(size * nr_possible_cpus);
 =

 	for_each_possible_cpu(i) {
 		__per_cpu_offset[i] =3D ptr - __per_cpu_start;

-- =
