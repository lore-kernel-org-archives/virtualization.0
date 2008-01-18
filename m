From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/7] More lguest massage.
Date: Thu, 17 Jan 2008 22:35:45 -0200
Message-ID: <1200616561270-git-send-email-gcosta__7485.84887846864$1200616652$gmane$org@redhat.com>
References: <1200616550283-git-send-email-gcosta@redhat.com>
	<12006165571406-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006165571406-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

inour model, a guest does not run in a cpu anymore: a virtual cpu
does.So we change last_guest to last_cpu

Signed-off-by:Glauber de Oliveira Costa <gcosta@redhat.com>
---
drivers/lguest/x86/core.c |    6 +++---
1 files changed, 3 insertions(+), 3 deletions(-)

diff--git a/drivers/lguest/x86/core.c b/drivers/lguest/x86/core.c
index2859447..25f48fd 100644
---a/drivers/lguest/x86/core.c
+++b/drivers/lguest/x86/core.c
@@-60,7 +60,7 @@ static struct lguest_pages *lguest_pages(unsigned int cpu)
		  (SWITCHER_ADDR + SHARED_SWITCHER_PAGES*PAGE_SIZE))[cpu]);
}

-staticDEFINE_PER_CPU(struct lguest *, last_guest);
+staticDEFINE_PER_CPU(struct lg_cpu *, last_cpu);

/*S:010
 * We approach the Switcher.
@@-80,8 +80,8 @@ static void copy_in_guest_info(struct lg_cpu *cpu, struct lguest_pages *pages)
	 * same Guest we ran last time (and that Guest hasn't run anywhere else
	 * meanwhile).  If that's not the case, we pretend everything in the
	 * Guest has changed. */
-	if(__get_cpu_var(last_guest) != lg || lg->last_pages != pages) {
-		__get_cpu_var(last_guest)= lg;
+	if(__get_cpu_var(last_cpu) != cpu || lg->last_pages != pages) {
+		__get_cpu_var(last_cpu)= cpu;
		lg->last_pages = pages;
		lg->changed = CHANGED_ALL;
	}
--
1.5.0.6
