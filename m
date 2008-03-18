From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 2/3] [PATCH] make native_machine_shutdown non-static
Date: Tue, 18 Mar 2008 07:30:05 -0300
Message-ID: <12058362182207-git-send-email-gcosta__33211.0207331882$1205836891$gmane$org@redhat.com>
References: <1205836206192-git-send-email-gcosta@redhat.com>
	<1205836213477-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1205836213477-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Glauber Costa <gcosta@redhat.com>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

it will allow external users to call it. It is mainly
useful for routines that will override its machine_ops
field for its own special purposes, but want to call the
normal shutdown routine after they're done

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kernel/reboot.c |    2 +-
 include/asm-x86/reboot.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index ea95f11..7215de6 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -382,7 +382,7 @@ static void native_machine_emergency_restart(void)
 	}
 }
 
-static void native_machine_shutdown(void)
+void native_machine_shutdown(void)
 {
 	/* Stop the cpus and apics */
 #ifdef CONFIG_SMP
diff --git a/include/asm-x86/reboot.h b/include/asm-x86/reboot.h
index ff9b546..c5e8722 100644
--- a/include/asm-x86/reboot.h
+++ b/include/asm-x86/reboot.h
@@ -17,5 +17,6 @@ extern struct machine_ops machine_ops;
 
 void machine_real_restart(unsigned char *code, int length);
 void native_machine_crash_shutdown(struct pt_regs *regs);
+void native_machine_shutdown(void);
 
 #endif	/* _ASM_REBOOT_H */
-- 
1.5.0.6
