From: Thomas Garnier <thgarnie@chromium.org>
Subject: Re: [PATCH v9 10/11] x86/paravirt: Adapt assembly for PIE support
Date: Tue, 29 Oct 2019 14:30:15 -0700
Message-ID: <CAJcbSZG-JhBC9b1JMv1zq2r5uRQipYLtkNjM67sd7=eqy_iOaA__28661.8540574395$1572384642$gmane$org@mail.gmail.com>
References: <20190730191303.206365-1-thgarnie@chromium.org>
	<20190730191303.206365-11-thgarnie@chromium.org>
	<20190731125306.GU31381@hirez.programming.kicks-ass.net>
	<20190812125540.GD23772@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190812125540.GD23772@zn.tnic>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, Kees Cook <keescook@chromium.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "VMware,
	Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 12, 2019 at 5:54 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jul 31, 2019 at 02:53:06PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2019 at 12:12:54PM -0700, Thomas Garnier wrote:
> > > if PIE is enabled, switch the paravirt assembly constraints to be
> > > compatible. The %c/i constrains generate smaller code so is kept by
> > > default.
> > >
> > > Position Independent Executable (PIE) support will allow to extend the
> > > KASLR randomization range below 0xffffffff80000000.
> > >
> > > Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> > > Acked-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >  arch/x86/include/asm/paravirt_types.h | 25 +++++++++++++++++++++----
> > >  1 file changed, 21 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> > > index 70b654f3ffe5..fd7dc37d0010 100644
> > > --- a/arch/x86/include/asm/paravirt_types.h
> > > +++ b/arch/x86/include/asm/paravirt_types.h
> > > @@ -338,9 +338,25 @@ extern struct paravirt_patch_template pv_ops;
> > >  #define PARAVIRT_PATCH(x)                                  \
> > >     (offsetof(struct paravirt_patch_template, x) / sizeof(void *))
> > >
> > > +#ifdef CONFIG_X86_PIE
> > > +#define paravirt_opptr_call "a"
> > > +#define paravirt_opptr_type "p"
> > > +
> > > +/*
> > > + * Alternative patching requires a maximum of 7 bytes but the relative call is
> > > + * only 6 bytes. If PIE is enabled, add an additional nop to the call
> > > + * instruction to ensure patching is possible.
> > > + */
> > > +#define PARAVIRT_CALL_POST  "nop;"
> >
> > I'm confused; where does the 7 come from? The relative call is 6 bytes,
>
> Well, before it, the relative CALL is a CALL reg/mem64, i.e. the target
> is mem64. For example:
>
>
> ffffffff81025c45:       ff 14 25 68 37 02 82    callq  *0xffffffff82023768
>
> That address there is practically pv_ops + offset.
>
> Now, in the opcode bytes you have 0xff opcode, ModRM byte 0x14 and SIB
> byte 0x25, and 4 bytes imm32 offset. And this is 7 bytes.
>
> What it becomes is:
>
> ffffffff81025cd0:       ff 15 fa d9 ff 00       callq  *0xffd9fa(%rip)        # ffffffff820236d0 <pv_ops+0x30>
> ffffffff81025cd6:       90                      nop
>
> which is a RIP-relative, i.e., opcode 0xff, ModRM byte 0x15 and imm32.
> And this is 6 bytes.
>
> And since the paravirt patching doesn't do NOP padding like the
> alternatives patching does, you need to pad with a byte.
>
> Thomas, please add the gist of this to the comments because this
> incomprehensible machinery better be documented as detailed as possible.

Sorry for the late reply, busy couple months. Will add it.

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
