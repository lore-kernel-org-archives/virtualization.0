From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 10/16] make emulate_insn receive a vcpu struct.
Date: Thu, 20 Dec 2007 11:33:50 -0200
Message-ID: <11981576884121-git-send-email-gcosta__43207.7373414815$1198158385$gmane$org@redhat.com>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576442148-git-send-email-gcosta@redhat.com>
	<11981576492807-git-send-email-gcosta@redhat.com>
	<1198157654189-git-send-email-gcosta@redhat.com>
	<11981576581695-git-send-email-gcosta@redhat.com>
	<11981576632726-git-send-email-gcosta@redhat.com>
	<11981576671720-git-send-email-gcosta@redhat.com>
	<11981576731969-git-send-email-gcosta@redhat.com>
	<1198157678759-git-send-email-gcosta@redhat.com>
	<11981576833314-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576833314-git-send-email-gcosta@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

emulate_insn() needs to know about current eip, which will be,
in the future, a per-vcpu thing. So in this patch, the function
prototype is modified to receive a vcpu struct

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/x86/core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lguest/x86/core.c b/drivers/lguest/x86/core.c
index 9bf2213..2fb9cd3 100644
--- a/drivers/lguest/x86/core.c
+++ b/drivers/lguest/x86/core.c
@@ -220,8 +220,9 @@ void lguest_arch_run_guest(struct lguest_vcpu *vcpu)
  * When the Guest uses one of these instructions, we get a trap (General
  * Protection Fault) and come here.  We see if it's one of those troublesome
  * instructions and skip over it.  We return true if we did. */
-static int emulate_insn(struct lguest *lg)
+static int emulate_insn(struct lguest_vcpu *vcpu)
 {
+	struct lguest *lg = vcpu->lg;
 	u8 insn;
 	unsigned int insnlen = 0, in = 0, shift = 0;
 	/* The eip contains the *virtual* address of the Guest's instruction:
@@ -294,7 +295,7 @@ void lguest_arch_handle_trap(struct lguest_vcpu *vcpu)
 		 * instructions which we need to emulate.  If so, we just go
 		 * back into the Guest after we've done it. */
 		if (lg->regs->errcode == 0) {
-			if (emulate_insn(lg))
+			if (emulate_insn(vcpu))
 				return;
 		}
 		break;
-- 
1.5.0.6
