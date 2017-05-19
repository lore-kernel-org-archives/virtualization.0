From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 02/10] paravirt: remove unused function
	paravirt_disable_iospace()
Date: Fri, 19 May 2017 17:47:38 +0200
Message-ID: <20170519154746.29389-3-jgross__7469.42471382699$1495208889$gmane$org@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170519154746.29389-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

paravirt_disable_iospace() isn't used anywhere. Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/paravirt.c            | 19 -------------------
 2 files changed, 21 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 7465d6fe336f..7a5de42cb465 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -396,8 +396,6 @@ unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len);
 
-int paravirt_disable_iospace(void);
-
 /*
  * This generates an indirect call based on the operation type number.
  * The type number, computed in PARAVIRT_PATCH, is derived from the
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 3586996fc50d..b8b23b3f24c2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -207,25 +207,6 @@ static u64 native_steal_clock(int cpu)
 extern void native_iret(void);
 extern void native_usergs_sysret64(void);
 
-static struct resource reserve_ioports = {
-	.start = 0,
-	.end = IO_SPACE_LIMIT,
-	.name = "paravirt-ioport",
-	.flags = IORESOURCE_IO | IORESOURCE_BUSY,
-};
-
-/*
- * Reserve the whole legacy IO space to prevent any legacy drivers
- * from wasting time probing for their hardware.  This is a fairly
- * brute-force approach to disabling all non-virtual drivers.
- *
- * Note that this must be called very early to have any effect.
- */
-int paravirt_disable_iospace(void)
-{
-	return request_resource(&ioport_resource, &reserve_ioports);
-}
-
 static DEFINE_PER_CPU(enum paravirt_lazy_mode, paravirt_lazy_mode) = PARAVIRT_LAZY_NONE;
 
 static inline void enter_lazy(enum paravirt_lazy_mode mode)
-- 
2.12.0
