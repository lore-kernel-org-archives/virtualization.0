From: Chris Malley <mail@chrismalley.co.uk>
Subject: Re: [Lguest] [patch 43/43] lguest: generalize
	lgread_u32/lgwrite_u32.
Date: Thu, 27 Sep 2007 14:04:24 +0100
Message-ID: <1190898264.6648.12.camel@feisty>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063652.917809564@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926063652.917809564@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: lguest@ozlabs.org, Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty, Jes et al

This last patch causes page_tables.c to fail compilation on my system thu=
s:

....
  CC [M]  drivers/kvm/vmx.o
  CC [M]  drivers/kvm/kvm_main.o
  CC [M]  drivers/kvm/mmu.o
  CC [M]  drivers/kvm/x86_emulate.o
  LD [M]  drivers/kvm/kvm.o
  LD [M]  drivers/kvm/kvm-intel.o
  CC      drivers/leds/led-core.o
  LD      drivers/leds/built-in.o
  CC [M]  drivers/leds/led-class.o
  CC      drivers/lguest/lguest_device.o
  LD      drivers/lguest/built-in.o
  CC [M]  drivers/lguest/core.o
  CC [M]  drivers/lguest/hypercalls.o
  CC [M]  drivers/lguest/page_tables.o
drivers/lguest/page_tables.c: In function =E2=80=98demand_page=E2=80=99:
drivers/lguest/page_tables.c:212: error: expected expression before =E2=80=
=98{=E2=80=99 token
drivers/lguest/page_tables.c:238: error: expected expression before =E2=80=
=98{=E2=80=99 token
drivers/lguest/page_tables.c:284: error: =E2=80=98v=E2=80=99 undeclared (=
first use in this function)
drivers/lguest/page_tables.c:284: error: (Each undeclared identifier is r=
eported only once
drivers/lguest/page_tables.c:284: error: for each function it appears in.=
)
drivers/lguest/page_tables.c:284: warning: type defaults to =E2=80=98int=E2=
=80=99 in declaration of =E2=80=98__dummy2=E2=80=99
drivers/lguest/page_tables.c:284: warning: comparison of distinct pointer=
 types lacks a cast
drivers/lguest/page_tables.c:284: warning: passing argument 3 of =E2=80=98=
__lgwrite=E2=80=99 makes pointer from integer without a cast
drivers/lguest/page_tables.c: In function =E2=80=98guest_pa=E2=80=99:
drivers/lguest/page_tables.c:372: error: expected expression before =E2=80=
=98{=E2=80=99 token
drivers/lguest/page_tables.c:377: error: expected expression before =E2=80=
=98{=E2=80=99 token
make[2]: *** [drivers/lguest/page_tables.o] Error 1
make[1]: *** [drivers/lguest] Error 2
make: *** [drivers] Error 2


It compiles fine with all the previous patches applied, just doesn't
seem to like the new lgread/lgwrite macros.

(GCC 4.1.2 on i686 in case that makes any difference, patched against v2.=
6.23-rc8)

--
Chris


On Wed, 2007-09-26 at 16:37 +1000, rusty@rustcorp.com.au wrote:
> Jes complains that page table code still uses lgread_u32 even though
> it now uses general kernel pte types.  The best thing to do is to
> generalize lgread_u32 and lgwrite_u32.
>=20
> This means we lose the efficiency of getuser().  We could potentially
> regain it if we used __copy_from_user instead of copy_from_user, but
> I'm not certain that our range check is equivalent to access_ok() on
> all platforms.
>=20
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Jes Sorensen <jes@sgi.com>
> ---
>  drivers/lguest/core.c                 |   39 ++++++-------------------=
--------
>  drivers/lguest/hypercalls.c           |    2 -
>  drivers/lguest/i386_core.c            |    4 +--
>  drivers/lguest/interrupts_and_traps.c |    2 -
>  drivers/lguest/lg.h                   |   23 ++++++++++++++++---
>  drivers/lguest/page_tables.c          |   10 ++++----
>  drivers/lguest/segments.c             |    4 +--
>  7 files changed, 38 insertions(+), 46 deletions(-)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/lguest/core.c
> +++ b/drivers/lguest/core.c
> @@ -145,33 +145,10 @@ int lguest_address_ok(const struct lgues
>  	return (addr+len) / PAGE_SIZE < lg->pfn_limit && (addr+len >=3D addr)=
;
>  }
> =20
> -/* This is a convenient routine to get a 32-bit value from the Guest (=
a very
> - * common operation).  Here we can see how useful the kill_lguest() ro=
utine we
> - * met in the Launcher can be: we return a random value (0) instead of=
 needing
> - * to return an error. */
> -u32 lgread_u32(struct lguest *lg, unsigned long addr)
> -{
> -	u32 val =3D 0;
> -
> -	/* Don't let them access lguest binary. */
> -	if (!lguest_address_ok(lg, addr, sizeof(val))
> -	    || get_user(val, (u32 *)(lg->mem_base + addr)) !=3D 0)
> -		kill_guest(lg, "bad read address %#lx: pfn_limit=3D%u membase=3D%p",=
 addr, lg->pfn_limit, lg->mem_base);
> -	return val;
> -}
> -
> -/* Same thing for writing a value. */
> -void lgwrite_u32(struct lguest *lg, unsigned long addr, u32 val)
> -{
> -	if (!lguest_address_ok(lg, addr, sizeof(val))
> -	    || put_user(val, (u32 *)(lg->mem_base + addr)) !=3D 0)
> -		kill_guest(lg, "bad write address %#lx", addr);
> -}
> -
> -/* This routine is more generic, and copies a range of Guest bytes int=
o a
> - * buffer.  If the copy_from_user() fails, we fill the buffer with zer=
oes, so
> - * the caller doesn't end up using uninitialized kernel memory. */
> -void lgread(struct lguest *lg, void *b, unsigned long addr, unsigned b=
ytes)
> +/* This routine copies memory from the Guest.  Here we can see how use=
ful the
> + * kill_lguest() routine we met in the Launcher can be: we return a ra=
ndom
> + * value (all zeroes) instead of needing to return an error. */
> +void __lgread(struct lguest *lg, void *b, unsigned long addr, unsigned=
 bytes)
>  {
>  	if (!lguest_address_ok(lg, addr, bytes)
>  	    || copy_from_user(b, lg->mem_base + addr, bytes) !=3D 0) {
> @@ -181,15 +158,15 @@ void lgread(struct lguest *lg, void *b,=20
>  	}
>  }
> =20
> -/* Similarly, our generic routine to copy into a range of Guest bytes.=
 */
> -void lgwrite(struct lguest *lg, unsigned long addr, const void *b,
> -	     unsigned bytes)
> +/* This is the write (copy into guest) version. */
> +void __lgwrite(struct lguest *lg, unsigned long addr, const void *b,
> +	       unsigned bytes)
>  {
>  	if (!lguest_address_ok(lg, addr, bytes)
>  	    || copy_to_user(lg->mem_base + addr, b, bytes) !=3D 0)
>  		kill_guest(lg, "bad write address %#lx len %u", addr, bytes);
>  }
> -/* (end of memory access helper routines) :*/
> +/*:*/
> =20
>  /*H:030 Let's jump straight to the the main loop which runs the Guest.
>   * Remember, this is called by the Launcher reading /dev/lguest, and w=
e keep
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/lguest/hypercalls.c
> +++ b/drivers/lguest/hypercalls.c
> @@ -47,7 +47,7 @@ static void do_hcall(struct lguest *lg,=20
>  		char msg[128];
>  		/* If the lgread fails, it will call kill_guest() itself; the
>  		 * kill_guest() with the message will be ignored. */
> -		lgread(lg, msg, args->arg1, sizeof(msg));
> +		__lgread(lg, msg, args->arg1, sizeof(msg));
>  		msg[sizeof(msg)-1] =3D '\0';
>  		kill_guest(lg, "CRASH: %s", msg);
>  		break;
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/lguest/i386_core.c
> +++ b/drivers/lguest/i386_core.c
> @@ -222,7 +222,7 @@ static int emulate_insn(struct lguest *l
>  		return 0;
> =20
>  	/* Decoding x86 instructions is icky. */
> -	lgread(lg, &insn, physaddr, 1);
> +	insn =3D lgread(lg, &insn, u8);
> =20
>  	/* 0x66 is an "operand prefix".  It means it's using the upper 16 bit=
s
>  	   of the eax register. */
> @@ -230,7 +230,7 @@ static int emulate_insn(struct lguest *l
>  		shift =3D 16;
>  		/* The instruction is 1 byte so far, read the next byte. */
>  		insnlen =3D 1;
> -		lgread(lg, &insn, physaddr + insnlen, 1);
> +		insn =3D lgread(lg, physaddr + insnlen, u8);
>  	}
> =20
>  	/* We can ignore the lower bit for the moment and decode the 4 opcode=
s
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/lguest/interrupts_and_traps.c
> +++ b/drivers/lguest/interrupts_and_traps.c
> @@ -45,7 +45,7 @@ static void push_guest_stack(struct lgue
>  {
>  	/* Stack grows upwards: move stack then write value. */
>  	*gstack -=3D 4;
> -	lgwrite_u32(lg, *gstack, val);
> +	lgwrite(lg, *gstack, u32, val);
>  }
> =20
>  /*H:210 The set_guest_interrupt() routine actually delivers the interr=
upt or
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/lguest/lg.h
> +++ b/drivers/lguest/lg.h
> @@ -99,12 +99,27 @@ extern struct mutex lguest_lock;
>  extern struct mutex lguest_lock;
> =20
>  /* core.c: */
> -u32 lgread_u32(struct lguest *lg, unsigned long addr);
> -void lgwrite_u32(struct lguest *lg, unsigned long addr, u32 val);
> -void lgread(struct lguest *lg, void *buf, unsigned long addr, unsigned=
 len);
> -void lgwrite(struct lguest *lg, unsigned long, const void *buf, unsign=
ed len);
>  int lguest_address_ok(const struct lguest *lg,
>  		      unsigned long addr, unsigned long len);
> +void __lgread(struct lguest *, void *, unsigned long, unsigned);
> +void __lgwrite(struct lguest *, unsigned long, const void *, unsigned)=
;
> +
> +/*L:306 Using memory-copy operations like that is usually inconvient, =
so we
> + * have the following helper macros which read and write a specific ty=
pe (often
> + * an unsigned long).
> + *
> + * This reads into a variable of the given type then returns that. */
> +#define lgread(lg, addr, type)						\
> +	{( type _v; __lgread((lg), &_v, (addr), sizeof(_v)); _v; )}
> +
> +/* This checks that the variable is of the given type, then writes it =
out. */
> +#define lgwrite(lg, addr, type, val)				\
> +	do {							\
> +		typecheck(type, v);				\
> +		__lgwrite((lg), &(v), (addr), sizeof(v));	\
> +	} while(0)
> +/* (end of memory access helper routines) :*/
> +
>  int run_guest(struct lguest *lg, unsigned long __user *user);
> =20
>  /* Helper macros to obtain the first 12 or the last 20 bits, this is o=
nly the
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/lguest/page_tables.c
> +++ b/drivers/lguest/page_tables.c
> @@ -209,7 +209,7 @@ int demand_page(struct lguest *lg, unsig
>  	pte_t *spte;
> =20
>  	/* First step: get the top-level Guest page table entry. */
> -	gpgd =3D __pgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
> +	gpgd =3D lgread(lg, gpgd_addr(lg, vaddr), pgd_t);
>  	/* Toplevel not present?  We can't map it in. */
>  	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
>  		return 0;
> @@ -235,7 +235,7 @@ int demand_page(struct lguest *lg, unsig
>  	/* OK, now we look at the lower level in the Guest page table: keep i=
ts
>  	 * address, because we might update it later. */
>  	gpte_ptr =3D gpte_addr(lg, gpgd, vaddr);
> -	gpte =3D __pte(lgread_u32(lg, gpte_ptr));
> +	gpte =3D lgread(lg, gpte_ptr, pte_t);
> =20
>  	/* If this page isn't in the Guest page tables, we can't page it in. =
*/
>  	if (!(pte_flags(gpte) & _PAGE_PRESENT))
> @@ -281,7 +281,7 @@ int demand_page(struct lguest *lg, unsig
> =20
>  	/* Finally, we write the Guest PTE entry back: we've set the
>  	 * _PAGE_ACCESSED and maybe the _PAGE_DIRTY flags. */
> -	lgwrite_u32(lg, gpte_ptr, pte_val(gpte));
> +	lgwrite(lg, gpte_ptr, pte_t, gpte);
> =20
>  	/* We succeeded in mapping the page! */
>  	return 1;
> @@ -369,12 +369,12 @@ unsigned long guest_pa(struct lguest *lg
>  	pte_t gpte;
> =20
>  	/* First step: get the top-level Guest page table entry. */
> -	gpgd =3D __pgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
> +	gpgd =3D lgread(lg, gpgd_addr(lg, vaddr), pgd_t);
>  	/* Toplevel not present?  We can't map it in. */
>  	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
>  		kill_guest(lg, "Bad address %#lx", vaddr);
> =20
> -	gpte =3D __pte(lgread_u32(lg, gpte_addr(lg, gpgd, vaddr)));
> +	gpte =3D lgread(lg, gpte_addr(lg, gpgd, vaddr), pte_t);
>  	if (!(pte_flags(gpte) & _PAGE_PRESENT))
>  		kill_guest(lg, "Bad address %#lx", vaddr);
> =20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/lguest/segments.c
> +++ b/drivers/lguest/segments.c
> @@ -150,7 +150,7 @@ void load_guest_gdt(struct lguest *lg, u
>  		kill_guest(lg, "too many gdt entries %i", num);
> =20
>  	/* We read the whole thing in, then fix it up. */
> -	lgread(lg, lg->arch.gdt, table, num * sizeof(lg->arch.gdt[0]));
> +	__lgread(lg, lg->arch.gdt, table, num * sizeof(lg->arch.gdt[0]));
>  	fixup_gdt_table(lg, 0, ARRAY_SIZE(lg->arch.gdt));
>  	/* Mark that the GDT changed so the core knows it has to copy it agai=
n,
>  	 * even if the Guest is run on the same CPU. */
> @@ -161,7 +161,7 @@ void guest_load_tls(struct lguest *lg, u
>  {
>  	struct desc_struct *tls =3D &lg->arch.gdt[GDT_ENTRY_TLS_MIN];
> =20
> -	lgread(lg, tls, gtls, sizeof(*tls)*GDT_ENTRY_TLS_ENTRIES);
> +	__lgread(lg, tls, gtls, sizeof(*tls)*GDT_ENTRY_TLS_ENTRIES);
>  	fixup_gdt_table(lg, GDT_ENTRY_TLS_MIN, GDT_ENTRY_TLS_MAX+1);
>  	lg->changed |=3D CHANGED_GDT_TLS;
>  }
>=20
> --
>    there are those who do and those who hang on and you don't see too
>    many doers quoting their contemporaries.  -- Larry McVoy
>=20
> _______________________________________________
> Lguest mailing list
> Lguest@ozlabs.org
> https://ozlabs.org/mailman/listinfo/lguest
