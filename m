From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 1/19] unify desc_struct
Date: Thu, 6 Dec 2007 17:37:27 -0200
Message-ID: <5d6222a80712061137h74f9db55l7a8473f739549794__25844.5779829801$1196969962$gmane$org@mail.gmail.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11969578092869-git-send-email-gcosta@redhat.com>
	<47584C56.3070804@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47584C56.3070804@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Dec 6, 2007 5:24 PM, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> Glauber de Oliveira Costa wrote:
> > This patch aims to make the access of struct desc_struct variables
> > equal across architectures. In this patch, I unify the i386 and x86_64
> > versions under an anonymous union, keeping the way they are accessed
> > untouched (a and b for 32-bit code, individual bit-fields for 64-bit).
> >
> > This solution is not beautiful, but will allow us to integrate common
> > code that differed by the way descriptors were used. This is to be viewed
> > incrementally. There's simply too much code to be fixed at once.
> >
> > In the future, goal is to set up in a single way of acessing
> > the desc_struct fields.
> >
> > Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
> > ---
> >  arch/x86/kernel/apm_32.c       |    2 +-
> >  arch/x86/kernel/cpu/common.c   |   28 ++++++++++++++--------------
> >  arch/x86/kernel/process_64.c   |    2 +-
> >  arch/x86/kernel/traps_32.c     |    2 +-
> >  include/asm-x86/desc_defs.h    |   28 ++++++++++++++++++++--------
> >  include/asm-x86/processor_32.h |    5 +----
> >  6 files changed, 38 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
> > index 8cd9778..b8b9339 100644
> > --- a/arch/x86/kernel/apm_32.c
> > +++ b/arch/x86/kernel/apm_32.c
> > @@ -405,7 +405,7 @@ static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
> >  static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
> >  static struct apm_user *     user_list;
> >  static DEFINE_SPINLOCK(user_list_lock);
> > -static const struct desc_struct      bad_bios_desc = { 0, 0x00409200 };
> > +static const struct desc_struct      bad_bios_desc = {{{ 0, 0x00409200 }}};
> >
> >  static const char            driver_version[] = "1.16ac";    /* no spaces */
> >
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 235cd61..0fe1c1d 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -22,31 +22,31 @@
> >  #include "cpu.h"
> >
> >  DEFINE_PER_CPU(struct gdt_page, gdt_page) = { .gdt = {
> > -     [GDT_ENTRY_KERNEL_CS] = { 0x0000ffff, 0x00cf9a00 },
> > -     [GDT_ENTRY_KERNEL_DS] = { 0x0000ffff, 0x00cf9200 },
> > -     [GDT_ENTRY_DEFAULT_USER_CS] = { 0x0000ffff, 0x00cffa00 },
> > -     [GDT_ENTRY_DEFAULT_USER_DS] = { 0x0000ffff, 0x00cff200 },
> > +     [GDT_ENTRY_KERNEL_CS] = {{{ 0x0000ffff, 0x00cf9a00 }}},
> > +     [GDT_ENTRY_KERNEL_DS] = {{{ 0x0000ffff, 0x00cf9200 }}},
> > +     [GDT_ENTRY_DEFAULT_USER_CS] = {{{ 0x0000ffff, 0x00cffa00 }}},
> > +     [GDT_ENTRY_DEFAULT_USER_DS] = {{{ 0x0000ffff, 0x00cff200 }}},
> >
>
> I don't suppose there's some way to make all this more symbolic?

There may be, but it's not the problem I'm trying to address in this
series. It's probably not too hard
to come up with a macro that receives the relevant parts of the
descriptors and create the initializers.

but it's deferred work.

>
>
> >       /*
> >        * Segments used for calling PnP BIOS have byte granularity.
> >        * They code segments and data segments have fixed 64k limits,
> >        * the transfer segment sizes are set at run time.
> >        */
> > -     [GDT_ENTRY_PNPBIOS_CS32] = { 0x0000ffff, 0x00409a00 },/* 32-bit code */
> > -     [GDT_ENTRY_PNPBIOS_CS16] = { 0x0000ffff, 0x00009a00 },/* 16-bit code */
> > -     [GDT_ENTRY_PNPBIOS_DS] = { 0x0000ffff, 0x00009200 }, /* 16-bit data */
> > -     [GDT_ENTRY_PNPBIOS_TS1] = { 0x00000000, 0x00009200 },/* 16-bit data */
> > -     [GDT_ENTRY_PNPBIOS_TS2] = { 0x00000000, 0x00009200 },/* 16-bit data */
> > +     [GDT_ENTRY_PNPBIOS_CS32] = {{{ 0x0000ffff, 0x00409a00 }}},/* 32-bit code */
> > +     [GDT_ENTRY_PNPBIOS_CS16] = {{{ 0x0000ffff, 0x00009a00 }}},/* 16-bit code */
> > +     [GDT_ENTRY_PNPBIOS_DS] = {{{ 0x0000ffff, 0x00009200 }}}, /* 16-bit data */
> > +     [GDT_ENTRY_PNPBIOS_TS1] = {{{ 0x00000000, 0x00009200 }}},/* 16-bit data */
> > +     [GDT_ENTRY_PNPBIOS_TS2] = {{{ 0x00000000, 0x00009200 }}},/* 16-bit data */
> >       /*
> >        * The APM segments have byte granularity and their bases
> >        * are set at run time.  All have 64k limits.
> >        */
> > -     [GDT_ENTRY_APMBIOS_BASE] = { 0x0000ffff, 0x00409a00 },/* 32-bit code */
> > +     [GDT_ENTRY_APMBIOS_BASE] = {{{ 0x0000ffff, 0x00409a00 }}},/* 32-bit code */
> >       /* 16-bit code */
> > -     [GDT_ENTRY_APMBIOS_BASE+1] = { 0x0000ffff, 0x00009a00 },
> > -     [GDT_ENTRY_APMBIOS_BASE+2] = { 0x0000ffff, 0x00409200 }, /* data */
> > +     [GDT_ENTRY_APMBIOS_BASE+1] = {{{ 0x0000ffff, 0x00009a00 }}},
> > +     [GDT_ENTRY_APMBIOS_BASE+2] = {{{ 0x0000ffff, 0x00409200 }}}, /* data */
> >
> > -     [GDT_ENTRY_ESPFIX_SS] = { 0x00000000, 0x00c09200 },
> > -     [GDT_ENTRY_PERCPU] = { 0x00000000, 0x00000000 },
> > +     [GDT_ENTRY_ESPFIX_SS] = {{{ 0x00000000, 0x00c09200 }}},
> > +     [GDT_ENTRY_PERCPU] = {{{ 0x00000000, 0x00000000 }}},
> >  } };
> >  EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
> >
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index 6724840..9e99cb7 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -437,7 +437,7 @@ static inline void set_32bit_tls(struct task_struct *t, int tls, u32 addr)
> >               .limit_in_pages = 1,
> >               .useable = 1,
> >       };
> > -     struct n_desc_struct *desc = (void *)t->thread.tls_array;
> > +     struct desc_struct *desc = (void *)t->thread.tls_array;
> >       desc += tls;
> >       desc->a = LDT_entry_a(&ud);
> >       desc->b = LDT_entry_b(&ud);
> > diff --git a/arch/x86/kernel/traps_32.c b/arch/x86/kernel/traps_32.c
> > index e15014e..94c5aea 100644
> > --- a/arch/x86/kernel/traps_32.c
> > +++ b/arch/x86/kernel/traps_32.c
> > @@ -76,7 +76,7 @@ char ignore_fpu_irq = 0;
> >   * F0 0F bug workaround.. We have a special link segment
> >   * for this.
> >   */
> > -struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
> > +struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {{{ 0, 0 }}}, };
> >
> >  asmlinkage void divide_error(void);
> >  asmlinkage void debug(void);
> > diff --git a/include/asm-x86/desc_defs.h b/include/asm-x86/desc_defs.h
> > index 0890040..b3db064 100644
> > --- a/include/asm-x86/desc_defs.h
> > +++ b/include/asm-x86/desc_defs.h
> > @@ -11,18 +11,30 @@
> >
> >  #include <linux/types.h>
> >
> > +/*
> > + * FIXME: Acessing the desc_struct through its fields is more elegant,
> > + * and should be the one valid thing to do. However, a lot of open code
> > + * still touches the a and b acessors, and doing this allow us to do it
> > + * incrementally. We keep the signature as a struct, rather than an union,
> > + * so we can get rid of it transparently in the future -- glommer
> > + */
> > +#define raw_desc_struct struct { unsigned int a, b; }
> > +#define detailed_desc_struct                                   \
> > +  struct {                                                       \
> > +     u16 limit0;                                             \
> > +     u16 base0;                                              \
> > +     unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;    \
> > +     unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 :8;\
> > +  }
> > +
> >  // 8 byte segment descriptor
> >  struct desc_struct {
> > -     u16 limit0;
> > -     u16 base0;
> > -     unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;
> > -     unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 : 8;
> > +     union {
> > +             raw_desc_struct;
> > +             detailed_desc_struct;
> > +     };
> >  } __attribute__((packed));
> >
>
> Is it really necessary to use #defines?  Couldn't you just define the
> structures inline, or give them names?

No, it's not necessary. It's just the less ugly way I found.
As I intend to switch all uses to the field accesses, instead of a and
b, I don't think it's a big deal. When it's done, the struct will be
clean and simple, with no need for
these defines.



-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
