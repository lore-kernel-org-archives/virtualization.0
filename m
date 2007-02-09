From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3 of 7]  lguest: Remove extern declaration from
	mm/discontig.c, put in header.
Date: Sat, 10 Feb 2007 02:04:44 +1100
Message-ID: <1171033484.2718.167.camel@localhost.localdomain>
References: <1171033146.2718.157.camel@localhost.localdomain>
	 <1171033383.2718.163.camel@localhost.localdomain>
	 <1171033436.2718.165.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946500AbXBIPFg@vger.kernel.org>
In-Reply-To: <1171033436.2718.165.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

lguest wants it too, but Andi won't let me put an extern decl in.
Times, they are a'changin.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/arch/i386/mm/discontig.c
+++ b/arch/i386/mm/discontig.c
@@ -101,7 +101,6 @@ extern void add_one_highpage_init(struct
 extern void add_one_highpage_init(struct page *, int, int);
 
 extern struct e820map e820;
-extern unsigned long init_pg_tables_end;
 extern unsigned long highend_pfn, highstart_pfn;
 extern unsigned long max_low_pfn;
 extern unsigned long totalram_pages;
===================================================================
--- a/include/asm-i386/setup.h
+++ b/include/asm-i386/setup.h
@@ -77,6 +77,8 @@ void __init add_memory_region(unsigned l
 void __init add_memory_region(unsigned long long start,
 			      unsigned long long size, int type);
 
+extern unsigned long init_pg_tables_end;
+
 #endif /* __ASSEMBLY__ */
 
 #endif  /*  __KERNEL__  */
