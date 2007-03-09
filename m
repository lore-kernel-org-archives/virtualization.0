From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC/PATCH LGUEST X86_64 00/13] Lguest for the x86_64
Date: Fri, 09 Mar 2007 11:18:29 +1100
Message-ID: <1173399509.32234.61.camel@localhost.localdomain>
References: <1173375492.32170.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173375492.32170.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-08 at 12:38 -0500, Steven Rostedt wrote:
> So we map the hypervisor text into this area for both the host
> and the guest. The guest permissions for this area will obviously
> be restricted to DPL 0 only (guest runs in PL 3).
> =

> Now what about guest data.  Well, as suppose to the i386 code, we
> don't put any data in the hypervisor.S.  All data will be put into
> a guest shared data structure.  This structure is called lguest_vcpu.
> So each guest (and eventually, each guest cpu) will have it's own =

> lguest_vcpu, and this structure will be mapped into this HV FIXMAP
> area for both the host and the guest in the same location.

Hi Steven!

	In anticipation of the x86-64 limitations, and after discussion with
Andi and Zach Amsden, I've converted 32-bit lguest to use read-only
pages for the switcher code, rather than segment limits.  I just ran
into breaking on SMP hosts, otherwise patches would have been sent
yesterday.  But importantly, it brings us much closer together.

> As opposed to compiling a hypervisor.c blob, we build instead the
> hypervisor itself into the lg.o module. We snap shot it with
> start and end tags and align it so that it sits on it's own page.

I'll take a look; I don't see a reason to be different here?

> TODO:
> =3D=3D=3D=3D=3D
> =

> To prevent a guest from stealing all the hosts memory pages, we can
> use these hashes to also limit the number of puds, pmds, and ptes.
> =

> If the page is not pinned (currently used), we can set up LRU lists,
> and find those pages that are somewhat stale, and free them.  This
> can be done safely since we have all the info we need to put them
> back if the guest needs them again.

This is the same issue with 32-bit (one main reason why it's root-only).
In my case it's not too hard to add a shrinker (it would drop PTE pages
out of the pagetable of any non-running guest, just needs locking), but
we also want to avoid pinning in guest (ie. userspace) pages: for this I
think we really want a per-mm callback when the swapper wants to kick
something out.

I imagine kvm will have the same or similar issues (they restrict their
pagetables to 256 pages per guest, which is simultanously too many and
too few IMHO).

> cr3:
> =3D=3D=3D=3D
> =

> Right now we hold many more cr3/pgd's then the i386 version does.
> This is because we have the ability to implement page cleaning at
> a lower level, and this lets us limit the amount of pages the
> guest can take from the host.

Not sure I follow this, but I'll read the code.

> Interrupts:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> When an interrupt goes off, we've put the tss->rsp0 to point to
> the vcpu struct regs field. This way we push onto the vcpu struct
> the trapnum errcord, rip, cs, rflags, rsp and ss regs. Alse we
> put onto this field the guests regs and cr3. This is somewhat similar
> to the i386 way of doing things.
> =

> We then put back the host gdt, idt, tr and cr3 regs and jump back to
> the host.
> =

> We use the stack pointer to find our location of the vcpu struct.

This is now identical, from this description.  Great minds think alike
8)

> NMI:
> =3D=3D=3D=3D
> =

> NMI is a big PITA!!!!
> =

> I don't know how it works with i386 lguest, but this caused us loads of
> hell.  The nmi can go off at any time, and having interrupts disabled
> doesn't protect you from it.  So what to do about it!

We crash.  I have a patch which improves this to just ignore it (iret).
I tried to actually switch into the host and deliver the NMI, but since
qemu didn't seem to give NMIs at all, I spent a day toying with it on
crashing hardware before moving on to something else.  Plus the
hypervisor.S code was almost doubled for this crap.

Nested NMIs are, as you found too, particularly nasty.  I considered
actually calling the host NMI handler directly so it didn't iret back to
us...

> Debug:
> =3D=3D=3D=3D=3D
> =

> We've added lots of debugging features to make it easier to debug.
> hypervisor.S is loaded with print to serial code. Be careful,
> the output of hex numbers are backwards. So if you do a =

> PRINT_QUAD(%rax), and %rax has in it 0x12345, you will get
> 54321 out of the serial. It's just easier that way (code wise).
> The macros with a 'S_' prefix will store the regs used on the
> stack, but that's not always good, since most of the hypervisor
> code, does not have a usable stack.

Heh, I simply used qemu, but this has more geek points 8)

> Well that's it!  We currently get to just before console_init
> in init/main.c of the guest before we take an timer interrupt
> storm (guest only, host still runs fine). This happens after
> we enable interrupts. But we are working on that. If you want to
> help, we would love to accept patches!!!

Awesome, will give detailed feedback after reading patches!

Thanks!
Rusty.
