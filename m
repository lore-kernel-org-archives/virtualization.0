From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] x86: tss: Eliminate fragile calculation of TSS
	segment limit
Date: Fri, 1 Nov 2013 09:40:56 -0700
Message-ID: <20131101164055.GB32434@leaf>
References: <cover.1382407802.git.josh@joshtriplett.org>
	<edeb47cf74bc015f4e36f5c5c7af4cd7d9532df8.1382407802.git.josh@joshtriplett.org>
	<1383249734.5399.41325681.3DEA6791@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1383249734.5399.41325681.3DEA6791@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, xen-devel@lists.xenproject.org, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <keescook@chromium.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ross
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 31, 2013 at 09:02:14PM +0100, Alexander van Heukelum wrote:
> Hi Josh,
> 
> On Tue, Oct 22, 2013, at 3:34, Josh Triplett wrote:
> > __set_tss_desc has a complex calculation of the TSS segment limit,
> > duplicating the quirky details of the I/O bitmap array length, and
> > requiring a complex comment to explain.  Replace that calculation with a
> > simpler one based on the offsetof the "stack" field that follows the
> > array.
> > 
> > That then removes the last use of IO_BITMAP_OFFSET, so delete it.
> > 
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > ---
> >  arch/x86/include/asm/desc.h      | 11 +----------
> >  arch/x86/include/asm/processor.h |  3 ++-
> >  2 files changed, 3 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> > index b90e5df..17ac92f 100644
> > --- a/arch/x86/include/asm/desc.h
> > +++ b/arch/x86/include/asm/desc.h
> > @@ -177,16 +177,7 @@ static inline void __set_tss_desc(unsigned cpu, unsigned int entry, void *addr)
> >  	struct desc_struct *d = get_cpu_gdt_table(cpu);
> >  	tss_desc tss;
> >  
> > -	/*
> > -	 * sizeof(unsigned long) coming from an extra "long" at the end
> > -	 * of the iobitmap. See tss_struct definition in processor.h
> > -	 *
> > -	 * -1? seg base+limit should be pointing to the address of the
> > -	 * last valid byte
> > -	 */
> > -	set_tssldt_descriptor(&tss, (unsigned long)addr, DESC_TSS,
> > -			      IO_BITMAP_OFFSET + IO_BITMAP_BYTES +
> > -			      sizeof(unsigned long) - 1);
> > +	set_tssldt_descriptor(&tss, (unsigned long)addr, DESC_TSS, TSS_LIMIT);
> >  	write_gdt_entry(d, entry, &tss, DESC_TSS);
> >  }
> >  
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 987c75e..03d3003 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -259,9 +259,10 @@ struct x86_hw_tss {
> >  #define IO_BITMAP_BITS			65536
> >  #define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
> >  #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
> > -#define IO_BITMAP_OFFSET		offsetof(struct tss_struct, io_bitmap)
> >  #define INVALID_IO_BITMAP_OFFSET	0x8000
> >  
> > +#define TSS_LIMIT	(offsetof(struct tss_struct, stack) - 1)
> > +
> 
> I wonder if the 'stack' in tss_struct has any meaning anymore. Can it be removed?
> If so, the offsetof can be changed to sizeof(struct tss_struct), which looks more
> natural to me.

That might be possible, if nothing references the stack.  The obvious
references would be easy to search for, but I'd be concerned that
something might reference the stack in some non-obvious way, like "right
after the TSS base+limit", which a search wouldn't necessarily turn up.

In any case, that change could easily occur in another patch on top of
this one.

> Even so, I think this is already an improvement.
> 
> Acked-by: Alexander van Heukelum <heukelum@fastmail.fm>

Thanks.

- Josh Triplett
