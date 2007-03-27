From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/5] i386-gdt-pda i386 gdt and pda updates
Date: Mon, 26 Mar 2007 17:21:29 -0700
Message-ID: <20070327002129.240126099@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xensource.com, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andrew,

This patch series adds to the end of the existing i386-gdt-cleanups patches:

	 allow-per-cpu-variables-to-be-page-aligned.patch
	 i386-gdt-cleanups-use-per-cpu-variables-for-gdt-pda.patch
	 i386-gdt-cleanups-use-per-cpu-gdt-immediately-upon-boot.patch
	 i386-gdt-cleanups-use-per-cpu-gdt-immediately-upon-boot-fix.patch
	 i386-gdt-cleanups-clean-up-cpu_init.patch
	 i386-gdt-cleanups-cleanup-gdt-access.patch
	 i386-gdt-cleanups-rename-boot_gdt_table-to-boot_gdt.patch
	+i386-gdt-cleanups-page-align-the-gdt.patch
	+i386-convert-pda-into-the-percpu-section.patch
	+lguest-use-percpu.patch
	+i386-cleanups-to-help-using-per-cpu-variables-from-asm.patch
	+percpu-define-per_cpu_offset.patch

The quick summary of each patch is:

i386-gdt-cleanups-page-align-the-gdt.patch

	Make sure the GDT is page-aligned, which Xen requires, but it
	is generally helpful.

i386-convert-pda-into-the-percpu-section.patch

	Remove the PDA as a separate entity, and use the normal per-cpu
	mechanism  This still uses the PDA's underlying segment machinery
	to retain the same code-size and atomicity benefits that the
	PDA had.

lguest-use-percpu.patch

	Fix lguest's initialization to skip PDA references.

i386-cleanups-to-help-using-per-cpu-variables-from-asm.patch

	Add some tweaks to asm-i386/percpu.h to allow efficient access
	to per-cpu variables from assembler.

percpu-define-per_cpu_offset.patch

	Define per_cpu_offset in asm-i386/percpu.h, to be consistent
	with asm-generic/percpu.h.

Thanks,
	J

-- 
