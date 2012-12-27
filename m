From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v3 11/11] x86: Add Xen kexec control code size check to linker
	script
Date: Thu, 27 Dec 2012 03:19:00 +0100
Message-ID: <1356574740-6806-12-git-send-email-daniel.kiper__47781.652006279$1356574927$gmane$org@oracle.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-5-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-6-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-7-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-8-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-9-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-11-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1356574740-6806-11-git-send-email-daniel.kiper@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, maxim.uvarov@oracle.com, mingo@redhat.com, tglx@linutronix.de, vgoyal@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Add Xen kexec control code size check to linker script.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/kernel/vmlinux.lds.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 22a1530..f18786a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -360,5 +360,10 @@ INIT_PER_CPU(irq_stack_union);
 
 . = ASSERT(kexec_control_code_size <= KEXEC_CONTROL_CODE_MAX_SIZE,
            "kexec control code size is too big");
-#endif
 
+#ifdef CONFIG_XEN
+. = ASSERT(xen_kexec_control_code_size - xen_relocate_kernel <=
+		KEXEC_CONTROL_CODE_MAX_SIZE,
+		"Xen kexec control code size is too big");
+#endif
+#endif
-- 
1.5.6.5
