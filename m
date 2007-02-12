From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 7/7] cleanup: make disable_acpi() valid w/o CONFIG_ACPI
Date: Mon, 12 Feb 2007 14:39:38 +1100
Message-ID: <1171251578.10409.17.camel@localhost.localdomain>
References: <1171251120.10409.2.camel@localhost.localdomain>
	 <1171251185.10409.4.camel@localhost.localdomain>
	 <1171251258.10409.7.camel@localhost.localdomain>
	 <1171251335.10409.10.camel@localhost.localdomain>
	 <1171251406.10409.13.camel@localhost.localdomain>
	 <1171251471.10409.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932953AbXBLDkY@vger.kernel.org>
In-Reply-To: <1171251471.10409.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Len Brown <len.brown@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Len Brown <lenb@kernel.org> said:
> Okay, but better to use disable_acpi()
> indeed, since this would be the first code not already inside CONFIG_ACPI
> to invoke disable_acpi(), we could define the inline as empty and you could
> then scratch the #ifdef too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/include/asm-i386/acpi.h
+++ b/include/asm-i386/acpi.h
@@ -127,6 +127,7 @@ extern int acpi_irq_balance_set(char *st
 #define acpi_ioapic 0
 static inline void acpi_noirq_set(void) { }
 static inline void acpi_disable_pci(void) { }
+static inline void disable_acpi(void) { }
 
 #endif	/* !CONFIG_ACPI */
 
