From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v5 4/7] x86: Align x86_64 PCI_MMCONFIG with 32-bit variant
Date: Wed,  7 Mar 2018 08:39:15 +0100
Message-ID: <a2faf78c54f340f5549149e8b679c95950dae83d.1520408357.git.jan.kiszka__28965.7671274201$1520408317$gmane$org@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Allow to enable PCI_MMCONFIG when only SFI is present and make this
option default on. This will help consolidating both into one Kconfig
statement.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f23521..c19f5342ec2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2659,7 +2659,8 @@ config PCI_DOMAINS
 
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access"
-	depends on X86_64 && PCI && ACPI
+	default y
+	depends on X86_64 && PCI && (ACPI || SFI)
 
 config PCI_CNB20LE_QUIRK
 	bool "Read CNB20LE Host Bridge Windows" if EXPERT
-- 
2.13.6
