From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 00/13] Lguest for the x86_64
Date: Thu, 08 Mar 2007 12:38:12 -0500
Message-ID: <1173375492.32170.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Hi all!

Lately, Glauber and I have been working on getting both paravirt_ops
and lguest running on the x86_64.

I already pushed the x86_64 patches and as promised, I'm pushing now the
lguest64 patches.

This patches are greatly influenced by Rusty Russell, and we tried to stay
somewhat consistent with his work on the i386.  But there are some major
differences that we had to over come. Here's some of the thought we put
into this.

Major factors:

x86_64 has a much larger virtual space
x86_64 has 4 levels of page tables!!!!


Because of the large virtual address space that the x86_64 gives
us, we were originally going to map both the guest and the host
in the same address space. This would be great, and we thought
we could do this. One major requirement we had was to have one
kernel for both the host and a guest. But we thought with the
relocatable kernel going upstream, we could use that and have a
single kernel mapped in two locations.

The problem we found with the relocatable kernel, is that it seemed
to be focused on being located in two different locations of physical
memory and not virtual!  So it would remap itself to the virtual address
and then look at the physical.  This means that it wasn't an option
to do it this way.

So back to the drawing board!

What we came up instead, was to be a little like i386 lguest and =

have the hypervisor mapped in only.  So how to do this and not
cause too much change in the kernel?

Well, it would be nice to have the hypervisor text mapped in at
the same virtual address for both the host and the guest. But how
to do this easily?

Well, the solution that we came up with, was to use a FIXMAP area.

Why?

Well this way, since we plan on using the same kernel for both the
guest and the host, this will guarantee a location in the guest =

virtual address space that the host can use, and the guest will not.

Since it is virtual, we can make it as big as we need.

So we map the hypervisor text into this area for both the host
and the guest. The guest permissions for this area will obviously
be restricted to DPL 0 only (guest runs in PL 3).

Now what about guest data.  Well, as suppose to the i386 code, we
don't put any data in the hypervisor.S.  All data will be put into
a guest shared data structure.  This structure is called lguest_vcpu.
So each guest (and eventually, each guest cpu) will have it's own =

lguest_vcpu, and this structure will be mapped into this HV FIXMAP
area for both the host and the guest in the same location.

What's also nice about this, is that the host can see all the
guest vcpu shared data, but each guest will only have access to
their own, and only while running in dpl 0.

These vcpu structures holds lots of data, from the hosts current
gdt and idt pointer, to the cr3's (both guest and host), an
NMI trampoline section, and lots more.

Each guest also has a unique lguest_guest_info structure that stores
generic data for the guest, but nothing that would be needed for
running a specific VCPU.


Loading the hypervisor:
----------------------

As opposed to compiling a hypervisor.c blob, we build instead the
hypervisor itself into the lg.o module. We snap shot it with
start and end tags and align it so that it sits on it's own page.
We then use the tags to map it into the HV FIXMAP area.

On starting a guest, the lguest64 loader maps it into memory the same
way as the lguest32 does.  And then calls into the kernel the same
way as well.

But once in the kernel, we do things slightly differently.

The lguest_vcpu struct is allocated (via get_free_pages) and then
mapped into the HV FIXMAP area.  The host then maps the HV pages
and this vcpu data into the guest area in the same place.

Then we jump to the hypervisor which changes the gdt idt and cr3
for the guest (as well as the process GS base) and does an iretq
into the guest memory.


Page faulting:
--------------

This is a bit different too.

When the guest takes a page fault, we jump back to to the host
via switch_to_host, and the host needs to map in the page.


Page Hashes
-----------

The lguest_guest_info structure holds a bunch of pud, pmd, and
pte page hashes, so that when we take a fault and add a new pte
to the guest, we have a way to traverse back to the original cr3
of the guest.

With 4 level paging, we need to keep track of this hierarchy.

Say if the guest does a set_pte (or set_pmd or set_pud for that mater)
We need a way to know what page to free.  So we look up in the
hash the pte that's being touched.  The info in the hash points
us back to the pmd that holds the pte. And if needed, we can find
the pud that holds the pmd, and the pgd/cr3 that holds the pud.

This facilitates the managing of the page tables.

TODO:
=3D=3D=3D=3D=3D

To prevent a guest from stealing all the hosts memory pages, we can
use these hashes to also limit the number of puds, pmds, and ptes.

If the page is not pinned (currently used), we can set up LRU lists,
and find those pages that are somewhat stale, and free them.  This
can be done safely since we have all the info we need to put them
back if the guest needs them again.


cr3:
=3D=3D=3D=3D

Right now we hold many more cr3/pgd's then the i386 version does.
This is because we have the ability to implement page cleaning at
a lower level, and this lets us limit the amount of pages the
guest can take from the host.


Interrupts:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

When an interrupt goes off, we've put the tss->rsp0 to point to
the vcpu struct regs field. This way we push onto the vcpu struct
the trapnum errcord, rip, cs, rflags, rsp and ss regs. Alse we
put onto this field the guests regs and cr3. This is somewhat similar
to the i386 way of doing things.

We then put back the host gdt, idt, tr and cr3 regs and jump back to
the host.

We use the stack pointer to find our location of the vcpu struct.

NMI:
=3D=3D=3D=3D

NMI is a big PITA!!!!

I don't know how it works with i386 lguest, but this caused us loads of
hell.  The nmi can go off at any time, and having interrupts disabled
doesn't protect you from it.  So what to do about it!

Well the order of loading the TR register is important.  The guests TSS
segment has the same IST used for the NMI as the host. So if an NMI
goes off before we load the guest IDT, the host should still function.
But the guest also has it's own IST for it's NMI.  And the NMI stack =

for the guest is also on the vcpu struct. It needs it's own stack because
the nmi can go off while we are in a process of storing data from an
interrupt, and we'll mess up the vcpu struct.

After an nmi goes off, we really don't know what state we are in. So
basically we save everything.  But only save on the first NMI of =

a nested NMI (explained further down).

When an NMI goes off, we find the vcpu struct by the offset of the
stack. We check a flag letting us know if we are in a nested NMI (you'll
see soon), and if we are not, then we save the current GDT, regs, GS
base and shadow (we don't know if we swapgs or not, remember that the
guest uses its gs too, so both shadow and normal gs base can be in
the same address. That's how linux knows to swap or not). All this data
is stored in a separate location in the vcpu, reserved for NMI usage only.

We then set up the GDT, cr3 and GS base for the host, regardless of
being in a nested NMI or not.

We then set up a the call to the actual NMI handler, set the flag that
we are in a NMI handler, and then call the host NMI handler.  The return
code of that set up is actually the back to the HV text that called the
NMI handler.  But now, that we did an iret in the host, we are once again
susceptible to more NMIs (hence the nested NMI).  So we start restoring
all the stuff from the NMI Storage back to the state before the NMI.

If another NMI goes off, it will skip the storage part (and skip blowing
away all the data from the original NMI). And it will load the host
context, and jump again to the NMI handler. This time, we jump back and
try to restore again. We don't jump back to the the previous restore,
since we don't need to. We just keep trying to restore until we succeed
before another NMI goes off.

Once the everything is back to normal, and we have a return code set,
we clear the nmi flag and do a iretq back to the original code that was
interrupted by the original NMI.


Debug:
=3D=3D=3D=3D=3D

We've added lots of debugging features to make it easier to debug.
hypervisor.S is loaded with print to serial code. Be careful,
the output of hex numbers are backwards. So if you do a =

PRINT_QUAD(%rax), and %rax has in it 0x12345, you will get
54321 out of the serial. It's just easier that way (code wise).
The macros with a 'S_' prefix will store the regs used on the
stack, but that's not always good, since most of the hypervisor
code, does not have a usable stack.

Page tables. There's functions in lguest_debug.c that allows for
dumping out either the guest page tables, or host page tables.

kill_guest(linfo) - is just like i386 kill_guest and takes the
lguest_guest_info pointer as input.

kill_guest_dump(vcpu) - when possible, use the vcpu version,
since this will also dump to host printk, the regs of the guest
as well as a guest back trace. Which can be really usefull.


Well that's it!  We currently get to just before console_init
in init/main.c of the guest before we take an timer interrupt
storm (guest only, host still runs fine). This happens after
we enable interrupts. But we are working on that. If you want to
help, we would love to accept patches!!!

So, now go ahead and play, but don't hurt the puppies!

-- Steve
