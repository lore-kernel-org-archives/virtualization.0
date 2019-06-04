From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH 22/22] docs: fix broken documentation links
Date: Tue, 4 Jun 2019 06:58:02 -0300
Message-ID: <20190604065802.47a9d24b__11965.5426287622$1563995119$gmane$org@coco.lan>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
	<f9fecacbe4ce0b2b3aed38d71ae3753f2daf3ce3.1559171394.git.mchehab+samsung@kernel.org>
	<64e136de-1a7b-3436-9675-44ea9fa7b64a@c-s.fr>
	<20190604064614.67cde821@coco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190604064614.67cde821@coco.lan>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, Thomas Preston <thomas.preston@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>, Alessia Mantegazza <amantegazza@vaga.pv.it>, Jakub Wilk <jwilk@jwilk.net>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Kevin Hilman <khilman@baylibre.com>, James Morris <jmorris@namei.org>, linux-acpi@vger.kernel.org, Andy Gross <agross@kernel.org>, xen-devel@lists.xenproject.org, Alexander Popov <alex.popov@linux.com>, Qian Cai <cai@lca.pw>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Kairui Song <kasong@redhat.com>, Quentin Perret <quentin.perret@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.or>
List-Id: virtualization@lists.linuxfoundation.org

Em Tue, 4 Jun 2019 06:46:14 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Em Mon, 3 Jun 2019 09:34:15 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> escreveu:
> 

> > [...]
> > 
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index 8c1c636308c8..e868d2bd48b8 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -898,7 +898,7 @@ config PPC_MEM_KEYS
> > >   	  page-based protections, but without requiring modification of the
> > >   	  page tables when an application changes protection domains.
> > >   
> > > -	  For details, see Documentation/vm/protection-keys.rst
> > > +	  For details, see Documentation/x86/protection-keys.rst  
> > 
> > It looks strange to reference an x86 file, for powerpc arch.
> 
> Indeed. Yet, seeking for the API documented there:
> 
>  $ git grep -l pkey_mprotect
> Documentation/x86/protection-keys.rst
> arch/alpha/kernel/syscalls/syscall.tbl
> arch/arm/tools/syscall.tbl
> arch/arm64/include/asm/unistd32.h
> arch/ia64/kernel/syscalls/syscall.tbl
> arch/m68k/kernel/syscalls/syscall.tbl
> arch/microblaze/kernel/syscalls/syscall.tbl
> arch/mips/kernel/syscalls/syscall_n32.tbl
> arch/mips/kernel/syscalls/syscall_n64.tbl
> arch/mips/kernel/syscalls/syscall_o32.tbl
> arch/parisc/kernel/syscalls/syscall.tbl
> arch/powerpc/kernel/syscalls/syscall.tbl
> arch/s390/kernel/syscalls/syscall.tbl
> arch/sh/kernel/syscalls/syscall.tbl
> arch/sparc/kernel/syscalls/syscall.tbl
> arch/x86/entry/syscalls/syscall_32.tbl
> arch/x86/entry/syscalls/syscall_64.tbl
> arch/xtensa/kernel/syscalls/syscall.tbl
> include/linux/syscalls.h
> include/uapi/asm-generic/unistd.h
> kernel/sys_ni.c
> mm/mprotect.c
> tools/include/uapi/asm-generic/unistd.h
> tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> tools/perf/builtin-trace.c
> tools/testing/selftests/x86/protection_keys.c
> 
> Despite being used on several archs, the only documentation for it
> is inside the x86 directory, as it seems that this is not
> arch-specific.
> 
> Perhaps the file should, instead, be moved to another book.

I guess the best is to have this inside the core-api book.

Patch enclosed.

Regards,
Mauro


[PATCH] docs: move protection-keys.rst to the core-api book

This document is used by multiple architectures:

	$ echo $(git grep -l  pkey_mprotect arch|cut -d'/' -f 2|sort|uniq)
	alpha arm arm64 ia64 m68k microblaze mips parisc powerpc s390 sh sparc x86 xtensa

So, let's move it to the core book and adjust the links to it
accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index ee1bb8983a88..2466a4c51031 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -34,6 +34,7 @@ Core utilities
    timekeeping
    boot-time-mm
    memory-hotplug
+   protection-keys
 
 
 Interfaces for kernel debugging
diff --git a/Documentation/x86/protection-keys.rst b/Documentation/core-api/protection-keys.rst
similarity index 100%
rename from Documentation/x86/protection-keys.rst
rename to Documentation/core-api/protection-keys.rst
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index ae36fc5fc649..f2de1b2d3ac7 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,7 +19,6 @@ x86-specific Documentation
    tlb
    mtrr
    pat
-   protection-keys
    intel_mpx
    amd-memory-encryption
    pti
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c1c636308c8..3b795a0cab62 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -898,7 +898,7 @@ config PPC_MEM_KEYS
 	  page-based protections, but without requiring modification of the
 	  page tables when an application changes protection domains.
 
-	  For details, see Documentation/vm/protection-keys.rst
+	  For details, see Documentation/core-api/protection-keys.rst
 
 	  If unsure, say y.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..d87d53fcd261 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1911,7 +1911,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	  page-based protections, but without requiring modification of the
 	  page tables when an application changes protection domains.
 
-	  For details, see Documentation/x86/protection-keys.txt
+	  For details, see Documentation/core-api/protection-keys.rst
 
 	  If unsure, say y.
 
diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 5d546dcdbc80..480995bceefa 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Tests x86 Memory Protection Keys (see Documentation/x86/protection-keys.txt)
+ * Tests x86 Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
  *
  * There are examples in here of:
  *  * how to set protection keys on memory
