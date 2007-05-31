From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 00:27:14 -0700
Message-ID: <465E78D2.9080609@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I started with Vivek's ELF bzImage patch from Oct last year, mashed it
to apply to hpa's new setup/boot code.

This patch does a couple of things, which would probably be better split
into multiple patches:

   1. Glue an ELF header onto the front of bzImage.  This is a real ELF
      header at the front of the file.  Breaks akpm's laptop,
      apparently, but it works for me.
   2. Drop tools/build, and use ld to do all the lifting to put the
      bzImage together.  This has the advantage of being able to use the
      linker to compute all the things to shove in the ELF header and
      boot_params structure, rather than having to poke them in later.
   3. Move notes out into their own .S.  This is to make adding other
      notes (ie Xen) more obvious.
   4. other random stuff (make linux/elf.h asm-includable)

Future stuff:

   1. move the ELF header to a non-zero offset.  Probably add a
      boot_param entry to point to it, but I suspect it will be within a
      few bytes of the start of the file (ie, just after the bugger-off
      jump)
   2. actually try to load it as an elf file (though just running it as
      a command or under valgrind makes things, erm, upset)
   3. other possibility hpa raised: make the compressed vmlinux payload
      an ELF file rather than the whole bzImage, and leave the bzImage
      wrapper as-is. seems sane to me.


What does everyone think?  Is this heading in the right direction?

    J


diff -r b9a73007e203 arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	Wed May 30 18:41:32 2007 -0700
+++ b/arch/i386/boot/Makefile	Thu May 31 00:08:52 2007 -0700
@@ -29,8 +29,9 @@ subdir- 	:= compressed
 subdir- 	:= compressed
 
 setup-y		+= a20.o apm.o cmdline.o copy.o cpu.o cpucheck.o edd.o
-setup-y		+= header.o main.o mca.o memory.o pm.o pmjump.o
+setup-y		+= header.o main.o mca.o memory.o notes.o pm.o pmjump.o
 setup-y		+= printf.o string.o tty.o video.o version.o voyager.o
+setup-y		+= kernel.o
 
 # The link order of the video-*.o modules can matter.  In particular,
 # video-vga.o *must* be listed first, followed by video-vesa.o.
@@ -39,10 +40,6 @@ setup-y		+= video-vga.o
 setup-y		+= video-vga.o
 setup-y		+= video-vesa.o
 setup-y		+= video-bios.o
-
-hostprogs-y	:= tools/build
-
-HOSTCFLAGS_build.o := $(LINUXINCLUDE)
 
 # ---------------------------------------------------------------------------
 
@@ -65,15 +62,10 @@ AFLAGS		:= $(CFLAGS) -D__ASSEMBLY__
 $(obj)/bzImage: IMAGE_OFFSET := 0x100000
 $(obj)/bzImage: EXTRA_CFLAGS := -D__BIG_KERNEL__
 $(obj)/bzImage: EXTRA_AFLAGS := $(SVGA_MODE) $(RAMDISK) -D__BIG_KERNEL__
-$(obj)/bzImage: BUILDFLAGS   := -b
 
-quiet_cmd_image = BUILD   $@
-cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/setup.bin \
-	    $(obj)/vmlinux.bin $(ROOT_DEV) > $@
+all: $(obj)/bzImage
 
-$(obj)/zImage $(obj)/bzImage: $(obj)/setup.bin \
-			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
-	$(call if_changed,image)
+$(obj)/zImage: FORCE
 	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
 $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
@@ -81,8 +73,11 @@ cmd_image = $(obj)/tools/build $(BUILDFL
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-LDFLAGS_setup.elf	:= -T
-$(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
+$(obj)/kernel.o:	EXTRA_AFLAGS := -Wa,-I$(obj)
+$(obj)/kernel.o: $(src)/kernel.S $(obj)/vmlinux.bin
+
+LDFLAGS_bzImage	:= -T
+$(obj)/bzImage: $(src)/setup.ld $(SETUP_OBJS) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_setup.bin	:= -O binary
diff -r b9a73007e203 arch/i386/boot/header.S
--- a/arch/i386/boot/header.S	Wed May 30 18:41:32 2007 -0700
+++ b/arch/i386/boot/header.S	Thu May 31 00:08:52 2007 -0700
@@ -15,6 +15,9 @@
  *
  */
 
+#include <linux/elf.h>
+#include <linux/elf_boot.h>
+#include <linux/elfnote.h>
 #include <asm/segment.h>
 #include <linux/utsrelease.h>
 #include <asm/boot.h>
@@ -48,9 +51,72 @@ SWAP_DEV	= 0			/* SWAP_DEV is now writte
 
 	.global bootsect_start
 bootsect_start:
-
+ehdr:
+	# e_ident is carefully crafted so if this is treated
+	# as an x86 bootsector you will execute through
+	# e_ident and then print the bugger off message.
+	# The 1 stores to bx+di is unfortunate it is
+	# unlikely to affect the ability to print
+	# a message and you aren't supposed to be booting a
+	# bzImage directly from a floppy anyway.
+
+	# e_ident
+	.byte ELFMAG0, ELFMAG1, ELFMAG2, ELFMAG3
+	.byte ELFCLASS32, ELFDATA2LSB, EV_CURRENT, ELFOSABI_STANDALONE
+	.byte 0xeb, 0x3d, 0, 0, 0, 0, 0, 0
+#ifndef CONFIG_RELOCATABLE
+	.word ET_EXEC				# e_type
+#else
+	.word ET_DYN				# e_type
+#endif
+	.word EM_386				# e_machine
+	.int  1					# e_version
+	.int  LOAD_PHYSICAL_ADDR		# e_entry
+	.int  phdr - bootsect_start		# e_phoff
+	.int  0					# e_shoff
+	.int  0					# e_flags
+	.word e_ehdr - ehdr			# e_ehsize
+	.word e_phdr1 - phdr			# e_phentsize
+	.word (e_phdr - phdr)/(e_phdr1 - phdr)	# e_phnum
+	.word 40				# e_shentsize
+	.word 0					# e_shnum
+	.word 0					# e_shstrndx
+e_ehdr:
+
+	.org 71
+normalize:
 	# Normalize the start address
 	ljmp	$BOOTSEG, $start2
+
+	.org 80
+phdr:
+	.int PT_LOAD					# p_type
+	.int _text					# p_offset
+	.int 0x8000					# p_vaddr
+	.int 0x8000					# p_paddr
+	.int _filesz					# p_filesz
+	.int _memsz					# p_memsz
+	.int PF_R | PF_W | PF_X				# p_flags
+	.int 4						# p_align
+e_phdr1:
+	.int PT_LOAD					# p_type
+	.int kernel - bootsect_start			# p_offset
+	.int LOAD_PHYSICAL_ADDR				# p_vaddr
+	.int LOAD_PHYSICAL_ADDR				# p_paddr
+	.int kernel_size				# p_filesz
+	.int kernel_size				# p_memsz
+	.int PF_R | PF_W | PF_X				# p_flags
+	.int CONFIG_PHYSICAL_ALIGN			# p_align
+
+	.int PT_NOTE					# p_type
+	.int notes - bootsect_start			# p_offset
+	.int 0						# p_vaddr
+	.int 0						# p_paddr
+	.int notes_size					# p_filesz
+	.int 0						# p_memsz
+	.int 0						# p_flags
+	.int 0						# p_align
+e_phdr:
 
 start2:
 	movw	%cs, %ax
@@ -97,9 +163,9 @@ bugger_off_msg:
 	.section ".header", "a"
 	.globl	hdr
 hdr:
-setup_sects:	.byte SETUPSECTS
+setup_sects:	.byte __setup_sects
 root_flags:	.word ROOT_RDONLY
-syssize:	.long SYSSIZE
+syssize:	.long kernel_size_para
 ram_size:	.word RAMDISK
 vid_mode:	.word SVGA_MODE
 root_dev:	.word ROOT_DEV
@@ -117,7 +183,6 @@ 1:
 1:
 
 	# Part 2 of the header, from the old setup.S
-
 		.ascii	"HdrS"		# header signature
 		.word	0x0206		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
diff -r b9a73007e203 arch/i386/boot/notes.S
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/boot/notes.S	Thu May 31 00:08:52 2007 -0700
@@ -0,0 +1,8 @@
+#include <linux/elfnote.h>
+#include <linux/elf_boot.h>
+#include <linux/utsrelease.h>
+
+ELFNOTE(ELF_NOTE_BOOT, EIN_PROGRAM_NAME, .asciz "Linux")
+ELFNOTE(ELF_NOTE_BOOT, EIN_PROGRAM_VERSION, .asciz UTS_RELEASE)
+ELFNOTE(ELF_NOTE_BOOT, EIN_ARGUMENT_STYLE, .asciz "Linux")
+ELFNOTE(ELF_NOTE_BOOT, EIN_BOOT_PARAMS, .long _start)
diff -r b9a73007e203 arch/i386/boot/setup.ld
--- a/arch/i386/boot/setup.ld	Wed May 30 18:41:32 2007 -0700
+++ b/arch/i386/boot/setup.ld	Thu May 31 00:08:52 2007 -0700
@@ -3,7 +3,7 @@
  *
  * Linker script for the i386 setup code
  */
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_FORMAT("binary")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
 
@@ -15,6 +15,7 @@ SECTIONS
 
 	. = 497;
 	.header		: { *(.header) }
+	_text = .;
 	.inittext	: { *(.inittext) }
 	.initdata	: { *(.initdata) }
 	.text		: { *(.text*) }
@@ -36,6 +37,7 @@ SECTIONS
 		LONG(0x5a5aaa55)
 	}
 
+	_filesz = . - _text;
 
 	. = ALIGN(16);
 	__bss_start = .;
@@ -46,8 +48,25 @@ SECTIONS
 	. = ALIGN(16);
 	_end = .;
 
-	/DISCARD/ : { *(.note*) }
+	_memsz = . - _text;
 
-	. = ASSERT(_end <= 0x8000, "Setup too big!");
-	. = ASSERT(hdr == 0x1f1, "The setup header has the wrong offset!");
+	__setup_sects = . / 512;
+
+	_ = ASSERT(_end <= 0x8000, "Setup too big!");
+	_ = ASSERT(hdr == 0x1f1, "The setup header has the wrong offset!");
+
+	.notes		: {
+		notes = .;
+		*(.note*)
+		notes_end = .;
+	}
+	notes_size = notes_end - notes;
+
+	.kernel		: {
+		kernel = .;
+		*(.kernel)
+		kernel_end = .;
+		kernel_size = kernel_end - kernel;
+		kernel_size_para = (kernel_size + 15) / 16;
+	}
 }
diff -r b9a73007e203 arch/i386/boot/tools/.gitignore
--- a/arch/i386/boot/tools/.gitignore	Wed May 30 18:41:32 2007 -0700
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,1 +0,0 @@
-build
diff -r b9a73007e203 arch/i386/boot/tools/build.c
--- a/arch/i386/boot/tools/build.c	Wed May 30 18:41:32 2007 -0700
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,168 +0,0 @@
-/*
- *  Copyright (C) 1991, 1992  Linus Torvalds
- *  Copyright (C) 1997 Martin Mares
- *  Copyright (C) 2007 H. Peter Anvin
- */
-
-/*
- * This file builds a disk-image from three different files:
- *
- * - setup: 8086 machine code, sets up system parm
- * - system: 80386 code for actual system
- *
- * It does some checking that all files are of the correct type, and
- * just writes the result to stdout, removing headers and padding to
- * the right amount. It also writes some system data to stderr.
- */
-
-/*
- * Changes by tytso to allow root device specification
- * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
- * Cross compiling fixes by Gertjan van Wingerde, July 1996
- * Rewritten by Martin Mares, April 1997
- * Substantially overhauled by H. Peter Anvin, April 2007
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/sysmacros.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <asm/boot.h>
-
-typedef unsigned char  u8;
-typedef unsigned short u16;
-typedef unsigned long  u32;
-
-#define DEFAULT_MAJOR_ROOT 0
-#define DEFAULT_MINOR_ROOT 0
-
-/* Minimal number of setup sectors */
-#define SETUP_SECT_MIN 5
-#define SETUP_SECT_MAX 64
-
-/* This must be large enough to hold the entire setup */
-u8 buf[SETUP_SECT_MAX*512];
-int is_big_kernel;
-
-static void die(const char * str, ...)
-{
-	va_list args;
-	va_start(args, str);
-	vfprintf(stderr, str, args);
-	fputc('\n', stderr);
-	exit(1);
-}
-
-static void usage(void)
-{
-	die("Usage: build [-b] setup system [rootdev] [> image]");
-}
-
-int main(int argc, char ** argv)
-{
-	unsigned int i, sz, setup_sectors;
-	int c;
-	u32 sys_size;
-	u8 major_root, minor_root;
-	struct stat sb;
-	FILE *file;
-	int fd;
-	void *kernel;
-
-	if (argc > 2 && !strcmp(argv[1], "-b"))
-	  {
-	    is_big_kernel = 1;
-	    argc--, argv++;
-	  }
-	if ((argc < 3) || (argc > 4))
-		usage();
-	if (argc > 3) {
-		if (!strcmp(argv[3], "CURRENT")) {
-			if (stat("/", &sb)) {
-				perror("/");
-				die("Couldn't stat /");
-			}
-			major_root = major(sb.st_dev);
-			minor_root = minor(sb.st_dev);
-		} else if (strcmp(argv[3], "FLOPPY")) {
-			if (stat(argv[3], &sb)) {
-				perror(argv[3]);
-				die("Couldn't stat root device.");
-			}
-			major_root = major(sb.st_rdev);
-			minor_root = minor(sb.st_rdev);
-		} else {
-			major_root = 0;
-			minor_root = 0;
-		}
-	} else {
-		major_root = DEFAULT_MAJOR_ROOT;
-		minor_root = DEFAULT_MINOR_ROOT;
-	}
-	fprintf(stderr, "Root device is (%d, %d)\n", major_root, minor_root);
-
-	/* Copy the setup code */
-	file = fopen(argv[1], "r");
-	if (!file)
-		die("Unable to open `%s': %m", argv[1]);
-	c = fread(buf, 1, sizeof(buf), file);
-	if (ferror(file))
-		die("read-error on `setup'");
-	if (c < 1024)
-		die("The setup must be at least 1024 bytes");
-	if (buf[510] != 0x55 || buf[511] != 0xaa)
-		die("Boot block hasn't got boot flag (0xAA55)");
-	fclose(file);
-
-	/* Pad unused space with zeros */
-	setup_sectors = (c + 511) / 512;
-	if (setup_sectors < SETUP_SECT_MIN)
-		setup_sectors = SETUP_SECT_MIN;
-	i = setup_sectors*512;
-	memset(buf+c, 0, i-c);
-
-	/* Set the default root device */
-	buf[508] = minor_root;
-	buf[509] = major_root;
-
-	fprintf(stderr, "Setup is %d bytes (padded to %d bytes).\n", c, i);
-
-	/* Open and stat the kernel file */
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0)
-		die("Unable to open `%s': %m", argv[2]);
-	if (fstat(fd, &sb))
-		die("Unable to stat `%s': %m", argv[2]);
-	sz = sb.st_size;
-	fprintf (stderr, "System is %d kB\n", (sz+1023)/1024);
-	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
-	if (kernel == MAP_FAILED)
-		die("Unable to mmap '%s': %m", argv[2]);
-	sys_size = (sz + 15) / 16;
-	if (!is_big_kernel && sys_size > DEF_SYSSIZE)
-		die("System is too big. Try using bzImage or modules.");
-
-	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
-	buf[0x1f4] = sys_size;
-	buf[0x1f5] = sys_size >> 8;
-	buf[0x1f6] = sys_size >> 16;
-	buf[0x1f7] = sys_size >> 24;
-
-	if (fwrite(buf, 1, i, stdout) != i)
-		die("Writing setup failed");
-
-	/* Copy the kernel code */
-	if (fwrite(kernel, 1, sz, stdout) != sz)
-		die("Writing kernel failed");
-	close(fd);
-
-	/* Everything is OK */
-	return 0;
-}
diff -r b9a73007e203 include/linux/elf.h
--- a/include/linux/elf.h	Wed May 30 18:41:32 2007 -0700
+++ b/include/linux/elf.h	Thu May 31 00:08:52 2007 -0700
@@ -1,9 +1,10 @@
 #ifndef _LINUX_ELF_H
 #define _LINUX_ELF_H
 
+#include <linux/elf-em.h>
+#ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/auxvec.h>
-#include <linux/elf-em.h>
 #include <asm/elf.h>
 
 struct file;
@@ -31,6 +32,7 @@ typedef __u32	Elf64_Word;
 typedef __u32	Elf64_Word;
 typedef __u64	Elf64_Xword;
 typedef __s64	Elf64_Sxword;
+#endif	/* __ASSEMBLY__ */
 
 /* These constants are for the segment types stored in the image headers */
 #define PT_NULL    0
@@ -123,6 +125,7 @@ typedef __s64	Elf64_Sxword;
 #define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
 #define ELF64_ST_TYPE(x)	ELF_ST_TYPE(x)
 
+#ifndef __ASSEMBLY__
 typedef struct dynamic{
   Elf32_Sword d_tag;
   union{
@@ -138,6 +141,7 @@ typedef struct {
     Elf64_Addr d_ptr;
   } d_un;
 } Elf64_Dyn;
+#endif	/* __ASSEMBLY__ */
 
 /* The following are used with relocations */
 #define ELF32_R_SYM(x) ((x) >> 8)
@@ -146,6 +150,7 @@ typedef struct {
 #define ELF64_R_SYM(i)			((i) >> 32)
 #define ELF64_R_TYPE(i)			((i) & 0xffffffff)
 
+#ifndef __ASSEMBLY__
 typedef struct elf32_rel {
   Elf32_Addr	r_offset;
   Elf32_Word	r_info;
@@ -185,10 +190,11 @@ typedef struct elf64_sym {
   Elf64_Addr st_value;		/* Value of the symbol */
   Elf64_Xword st_size;		/* Associated symbol size */
 } Elf64_Sym;
-
+#endif	/* __ASSEMBLY__ */
 
 #define EI_NIDENT	16
 
+#ifndef __ASSEMBLY__
 typedef struct elf32_hdr{
   unsigned char	e_ident[EI_NIDENT];
   Elf32_Half	e_type;
@@ -222,6 +228,7 @@ typedef struct elf64_hdr {
   Elf64_Half e_shnum;
   Elf64_Half e_shstrndx;
 } Elf64_Ehdr;
+#endif	/* __ASSEMBLY__ */
 
 /* These constants define the permissions on sections in the program
    header, p_flags. */
@@ -229,6 +236,7 @@ typedef struct elf64_hdr {
 #define PF_W		0x2
 #define PF_X		0x1
 
+#ifndef __ASSEMBLY__
 typedef struct elf32_phdr{
   Elf32_Word	p_type;
   Elf32_Off	p_offset;
@@ -250,6 +258,7 @@ typedef struct elf64_phdr {
   Elf64_Xword p_memsz;		/* Segment size in memory */
   Elf64_Xword p_align;		/* Segment alignment, file & memory */
 } Elf64_Phdr;
+#endif	/* __ASSEMBLY__ */
 
 /* sh_type */
 #define SHT_NULL	0
@@ -285,6 +294,7 @@ typedef struct elf64_phdr {
 #define SHN_COMMON	0xfff2
 #define SHN_HIRESERVE	0xffff
  
+#ifndef __ASSEMBLY__ 
 typedef struct elf32_shdr {
   Elf32_Word	sh_name;
   Elf32_Word	sh_type;
@@ -310,6 +320,7 @@ typedef struct elf64_shdr {
   Elf64_Xword sh_addralign;	/* Section alignment */
   Elf64_Xword sh_entsize;	/* Entry size if section holds table */
 } Elf64_Shdr;
+#endif	/* __ASSEMBLY__ */
 
 #define	EI_MAG0		0		/* e_ident[] indexes */
 #define	EI_MAG1		1
@@ -343,6 +354,7 @@ typedef struct elf64_shdr {
 
 #define ELFOSABI_NONE	0
 #define ELFOSABI_LINUX	3
+#define ELFOSABI_STANDALONE	255
 
 #ifndef ELF_OSABI
 #define ELF_OSABI ELFOSABI_NONE
@@ -357,6 +369,7 @@ typedef struct elf64_shdr {
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 
 
+#ifndef __ASSEMBLY__
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
   Elf32_Word	n_namesz;	/* Name size */
@@ -396,5 +409,6 @@ static inline void arch_write_notes(stru
 #define ELF_CORE_EXTRA_NOTES_SIZE arch_notes_size()
 #define ELF_CORE_WRITE_EXTRA_NOTES arch_write_notes(file)
 #endif /* ARCH_HAVE_EXTRA_ELF_NOTES */
+#endif	/* __ASSEMBLY__ */
 
 #endif /* _LINUX_ELF_H */
diff -r b9a73007e203 include/linux/elf_boot.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/linux/elf_boot.h	Thu May 31 00:08:52 2007 -0700
@@ -0,0 +1,16 @@
+#ifndef ELF_BOOT_H
+#define ELF_BOOT_H
+
+/* Elf notes to help bootloaders identify what program they are booting.
+ */
+
+/* Standardized Elf image notes for booting... The name for all of these is ELFBoot */
+#define ELF_NOTE_BOOT		ELFBoot
+
+#define EIN_PROGRAM_NAME	1 /* The program in this ELF file */
+#define EIN_PROGRAM_VERSION	2 /* The version of the program in this ELF file */
+#define EIN_PROGRAM_CHECKSUM	3 /* ip style checksum of the memory image. */
+#define EIN_ARGUMENT_STYLE	4 /* String identifying argument passing style */
+#define EIN_BOOT_PARAMS		5 /* Offset of boot_params block */
+
+#endif /* ELF_BOOT_H */
