From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Unified lguest launcher
Date: Thu, 05 Apr 2007 12:44:42 +1000
Message-ID: <1175741082.12230.610.camel@localhost.localdomain>
References: <5d6222a80704040903n49442679p2a6841de69d894c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80704040903n49442679p2a6841de69d894c2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-04-04 at 13:03 -0300, Glauber de Oliveira Costa wrote:
> This is a new version of the unified lguest launcher that applies to
> the current tree. According to rusty's suggestion, I'm bothering less
> to be able to load 32 bit kernels on 64-bit machines: changing the
> launcher for such case would be the easy part! In the absence of
> further objections, I'll commit it.
> =

> Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>

Hi Glauber!

The patch looks more than reasonable, but I think we can go further with
the abstraction.  If you could spin it again, I'll apply it.  There may
be more cleanups after that, but I don't want to hold up your progress!

> --- /dev/null
> +++ linux-2.6.20/Documentation/lguest/i386/defines
> @@ -0,0 +1,4 @@
> +# We rely on CONFIG_PAGE_OFFSET to know where to put lguest binary.
> +# Some shells (dash - ubunu) can't handle numbers that big so we cheat.
> +include ../../.config
> +LGUEST_GUEST_TOP :=3D ($(CONFIG_PAGE_OFFSET) - 0x08000000)

The include needs another ../ and seems redundant (the .config is
included from the Makefile anyway).

The shells comment is obsolete and should be deleted too, my bad.

> +++ linux-2.6.20/Documentation/lguest/i386/lguest_defs.h
> @@ -0,0 +1,9 @@
> +#ifndef _LGUEST_DEFS_H_
> +#define _LGUEST_DEFS_H_
> +
> +/* LGUEST_TOP_ADDRESS comes from the Makefile */
> +#define RESERVE_TOP_ADDRESS LGUEST_GUEST_TOP - 1024*1024

Why -1M?  And RESERVE_TOP_ADDRESS isn't used in this patch?

> +static unsigned long map_elf(int elf_fd, const void *hdr, =

>                              unsigned long *page_offset)
>  {
> -       void *addr;
> +#ifndef __x86_64__
> +       const Elf32_Ehdr *ehdr =3D hdr;
>         Elf32_Phdr phdr[ehdr->e_phnum];
> +#else
> +       const Elf64_Ehdr *ehdr =3D hdr;
> +       Elf64_Phdr phdr[ehdr->e_phnum];
> +#endif

The way we did this in the module code was to define Elf_Ehdr etc in the
arch-specific headers to avoid ifdefs.  I think it would help this code,
too. =


> +           || ((ehdr->e_machine !=3D EM_386) &&
> +               (ehdr->e_machine !=3D EM_X86_64))

Similarly define ELF_MACHINE?

>                else if (*page_offset !=3D phdr[i].p_vaddr - phdr[i].p_pad=
dr)
> +               else if ((*page_offset !=3D phdr[i].p_vaddr - phdr[i].p_p=
addr)
> +#ifdef __x86_64__
> +                        && (phdr[i].p_vaddr !=3D VSYSCALL_START)
> +#endif
> +                       )

Hmm, static inline bool is_vsyscall_segment(const Elf_Phdr *) maybe?

> +/* LGUEST_TOP_ADDRESS comes from the Makefile */
> +typedef uint64_t u64;
> +#include "../../../include/asm/lguest_user.h"
> +
> +#define RESERVE_TOP_ADDRESS LGUEST_GUEST_TOP
> +
> +
> +#define BOOT_PGTABLE "boot_level4_pgt"

The comment should refer to LGUEST_GUEST_TOP?

I think the typedef should be in the main code with the others: it
doesn't hurt i386 and it's neater.

I'm not sure the BOOT_PGTABLE define helps us here, either; it might be
clearer just to put it directly into the code.

Cheers!
Rusty.
