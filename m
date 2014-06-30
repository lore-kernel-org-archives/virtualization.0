From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] ia64: use ARRAY_SIZE instead of sizeof/sizeof[0]
Date: Mon, 30 Jun 2014 19:37:34 +0200
Message-ID: <1404149854-7382-1-git-send-email-fabf__10988.4659912952$1404408060$gmane$org@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use macro definition

Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-ia64@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---

This is untested.

 arch/ia64/kernel/paravirt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/paravirt.c b/arch/ia64/kernel/paravirt.c
index 1b22f6d..17bb2d1 100644
--- a/arch/ia64/kernel/paravirt.c
+++ b/arch/ia64/kernel/paravirt.c
@@ -864,8 +864,7 @@ __initdata_or_module =
 unsigned long __init_or_module
 ia64_native_patch_bundle(void *sbundle, void *ebundle, unsigned long type)
 {
-	const unsigned long nelems = sizeof(ia64_native_patch_bundle_elems) /
-		sizeof(ia64_native_patch_bundle_elems[0]);
+	const unsigned long nelems = ARRAY_SIZE(ia64_native_patch_bundle_elems);
 
 	return __paravirt_patch_apply_bundle(sbundle, ebundle, type,
 					      ia64_native_patch_bundle_elems,
@@ -894,9 +893,8 @@ __initconst = {
 static void __init
 ia64_native_patch_branch(unsigned long tag, unsigned long type)
 {
-	const unsigned long nelem =
-		sizeof(ia64_native_branch_target) /
-		sizeof(ia64_native_branch_target[0]);
+	const unsigned long nelem = ARRAY_SIZE(ia64_native_branch_target);
+
 	__paravirt_patch_apply_branch(tag, type,
 				      ia64_native_branch_target, nelem);
 }
-- 
1.8.4.5
