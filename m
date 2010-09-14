From: matt mooney <mfm@muteddisk.com>
Subject: [PATCH 1/4] x86: remove cast from void*
Date: Mon, 13 Sep 2010 22:18:31 -0700
Message-ID: <1284441511-11511-1-git-send-email-mfm@muteddisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Ian Campbell <ian.campbell@citrix.com>, matt mooney <mfm@muteddisk.com>, x86@kernel.org, kernel-janitors@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Unnecessary cast from void* in assignment.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 arch/x86/xen/mmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index 42086ac..7436283 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -737,7 +737,7 @@ pgd_t *xen_get_user_pgd(pgd_t *pgd)
 
 	if (offset < pgd_index(USER_LIMIT)) {
 		struct page *page = virt_to_page(pgd_page);
-		user_ptr = (pgd_t *)page->private;
+		user_ptr = page->private;
 		if (user_ptr)
 			user_ptr += offset;
 	}
-- 
1.7.2.1
