From: Steven Rostedt <rostedt@goodmis.org>
Subject: porting lguest to x86_64
Date: Mon, 12 Feb 2007 12:29:31 -0500
Message-ID: <1171301371.4290.48.camel@localhost.localdomain>
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
To: virtualization <virtualization@lists.osdl.org>
Cc: Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

Glauber and I have been looking into porting lguest over to the x86_64.
We've spent the last couple of weeks just trying lguest out and seeing
how far we can "force" it over to x86_64. This was more of just a
learning experience to get our feet wet in lguest since we are still
very green at it.  I also notice that lguest moves very fast (we were
still working on drivers/lguest when I now see it has moved to
arch/i386/lguest).

Anyway, we've decided that the work we have done so far was just a
learning prototype and have thrown it out for some better ideas. But
before getting too deep into coding, we want to ask the giants of lguest
for their ideas, and their thoughts on what we want.

Glauber has been focusing more an paravirt_ops for x86_64 and I've been
focusing lguest as a HV.  Since x86_64 is not as limited in address
space as i386 we've decided to redesign things differently.

Terminology:

  Host: the Linux HV kernel. (Xen terms would be dom0 plus HV).
  Guest: Linux that is run as paravirt on a Host (domU).


Host always mapped:

        Since the virtual address space is very large, it would be much
        simpler to just keep the Host always mapped in the Guests
        address space.  So the Guest will be more like a process here.
        So instead of just mapping the HV in both the Guest and Host as
        a hypervisor_blob, the entire Host will continually remain
        mapped.  This simplifies things tremendously.
        =

        Now, we're thinking of moving the guest's PAGE_OFFSET instead of
        the Host. But this hasn't been determined yet.
        =

Add PDA VCPU Field:

        Add another field in the per cpu PDA structure that can point to
        a VCPU descriptor (described below). A VCPU pointer will also be
        added to the task structure that will update this pointer on
        context switch (we can also just add the field to the task
        structure and not the PDA since the task structure is referenced
        off this structure, but the overhead in code execution might be
        too much).
        =

The VCPU descriptor:

        This will hold function pointers for system calls and fault
        handlers. It will also hold a pointer for any guest CPU info
        (allowing for SMP guests). A pointer to a generic lguest
        structure for the global guest info. This structure will be
        examined in assembly so it must be compact.
        =

System Calls:

        On all system calls (host users or guest users) the VCPU field
        of the PDA will be checked. If it is NULL, nothing different
        will happen than what the host already does today (see why it's
        better to have the field in the PDA). But if it is not NULL it
        will jump to the system_call function pointer of the VCPU
        structure to perform the guest operations.
        =

        The VCPU field of the PDA will only be non-NULL when a guest is
        running.  The pointer can point to code in the lguest module.
        And placed in the right position, it can call C code making this
        even simpler yet.
        =

        The system-call function can check to see if it is a hypercall
        or a system call made by a guest user process.  If the guest
        kernel makes a hypercall, it needs to set a flag in shared data
        between the guest and the host, saying it's making a hypercall.
        This shared data must be per VCPU.
        =

        If the system call was just a normal guest process, the host
        will load the registers back onto the guest's stack and return
        to the guest where the guest will know that the regs of the user
        process has already been stored on the stack. Since %rcx will
        point to the guest's kernel address on return, the guest will
        need to read the =

        %rcx that is stored on the stack to get the %rip of the guest's
        process to return to.
        =

Exceptions/Traps:

        Exceptions and traps will be handled the same way as system
        calls. Except that it doesn't need to check for hypercalls.  On
        an exception a check is made to see if the PDA contains a VCPU
        pointer. If this pointer is NULL, nothing different is done than
        what the host does today, else, it jumps to the exception
        function pointer in the VCPU structure.  Depending on where this
        jump is made, we can probably jump to C code in the lguest
        module.
        =

        This can check to see if the guest can handle it's own
        exception, or if we should just kill the guest (tripple fault?).
        It can return back to the guest the same way that it returns
        from a system call.
        =

Interrupts:

        Since the host kernel is always mapped in, even when the guest
        is running, we can let the host handle the interrupts with no
        changes what-so-ever (but see below).
        =

IDT / GDT:

        This is where we're not %100 sure what to do. Should the Guest
        have a different CS/DS when compiled as paravirt?  Or should it
        keep the same and we switch the host kernel's CS / DS on
        switching to and from a guest?
        =

        Changing CS / DS on guest switches may be a problem when the
        host does an interrupt. As mentioned above, we don't want to
        change any of the interrupt handling. I'm not sure how much the
        interrupts depend on the CS =3D=3D __KERNEL_CS or not (have to look
        at the code).
        =

        If we do change the host GDT we will also have to change the IDT
        to reflect those changes. So maybe at the beginning of
        development, we'll have the paravirt kernel use a different CS /
        DS than the host. And not modify the host's at all.
        =


OK, this is just a brief overview of some of the things we came up with.
Please let us know of any problems you have with this approach. Tell us
how stupid we are and show us the correct way :)

We really want to get involved, and we want to do it right, right from
the start.  As mentioned earlier, we are new to the workings of lguest,
and want to help out on the x86_64 front, even while it's still being
developed on the i386 front.  We feel that because of the lack of
limitations that x86_64 gives, the work on the x86_64 will be a large
fork from what lguest does on i386.

Comments?

Thanks for your time

-- Steve
