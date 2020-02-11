From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 07/62] x86/boot/compressed/64: Disable red-zone usage
Date: Tue, 11 Feb 2020 14:52:01 +0100
Message-ID: <20200211135256.24617-8-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

The x86-64 ABI defines a red-zone on the stack:

  The 128-byte area beyond the location pointed to by %rsp is
  considered to be reserved and shall not be modified by signal or
  interrupt handlers. 10 Therefore, functions may use this area for
  temporary data that is not needed across function calls. In
  particular, leaf functions may use this area for their entire stack
  frame, rather than adjusting the stack pointer in the prologue and
  epilogue. This area is known as the red zone.

This is not compatible with exception handling, so disable it for the
pre-decompression boot code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/Makefile            | 2 +-
 arch/x86/boot/compressed/Makefile | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 012b82fc8617..8f55e4ce1ccc 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -65,7 +65,7 @@ clean-files += cpustr.h
 
 # ---------------------------------------------------------------------------
 
-KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
+KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -mno-red-zone
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 GCOV_PROFILE := n
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 26050ae0b27e..e186cc0b628d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -30,7 +30,7 @@ KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
-cflags-$(CONFIG_X86_64) := -mcmodel=small
+cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
@@ -87,7 +87,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
-$(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
+$(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar
 
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o \
 	$(objtree)/drivers/firmware/efi/libstub/lib.a
-- 
2.17.1
