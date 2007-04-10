From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 2/10] I386 acpi remove earlyquirk warning.patch
Date: Mon, 9 Apr 2007 17:06:05 -0700
Message-ID: <200704100006.l3A06534020602@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753673AbXDJAIc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
Cc: Trivial <trivial@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Remove a warning about unused variable in !CONFIG_ACPI compilation.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 1969f6c3440a arch/i386/kernel/acpi/earlyquirk.c
--- a/arch/i386/kernel/acpi/earlyquirk.c	Fri Apr 06 14:27:45 2007 -0700
+++ b/arch/i386/kernel/acpi/earlyquirk.c	Fri Apr 06 14:29:46 2007 -0700
@@ -21,8 +21,8 @@ static int __init nvidia_hpet_check(stru
 
 static int __init check_bridge(int vendor, int device)
 {
+#ifdef CONFIG_ACPI
 	static int warned;
-#ifdef CONFIG_ACPI
 	/* According to Nvidia all timer overrides are bogus unless HPET
 	   is enabled. */
 	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
