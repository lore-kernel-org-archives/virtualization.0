From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: lguest over qemu
Date: Thu, 12 Jul 2007 20:41:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0707122033140.10575@gandalf.stny.rr.com>
References: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
	<1184210340.6005.723.camel@localhost.localdomain>
	<21a166410707120802g705b64d4o424e1f74a876ba60@mail.gmail.com>
	<1184283874.6005.812.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184283874.6005.812.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


>
> 	(Note that lguest doesn't support NMIs, but Steven has code for NMI
> support for lguest-x86-64 which could be ported across).

Rusty,

About that.  Is there a way to get a NMI only stack in i386? In x86_64
it's part of the TSS. So I can always know I have a good stack for the
NMI. I'm not sure i368 has the same thing. Or do we always have a good
stack whenever we are in ring0?

Oh, and btw, I've just rewrote all of the Lguest64 page table handling.
I'm just going over one design change that is really bothering me. In
x86_64 we can have 2M or 4k pages (like the PSE in i386). But since 4K
pages are used by the shadow page tables, I have to map them like that.
But this means that I can have the same guest address as both a PMD and a
PTE. Which is breaking some of my code. I'm working on a fix as I write
this.

But to get you up-to-date to where I'm at. I've implemented a way to have
the HV mapped uniquely for all VCPUs.  So there's a HV text section (the
same for all VCPUs), a HV VCPU Data section (readonly in all rings with
guest cr3), and a HV VCPU Scratch Pad section (read/write in rings
0,1,and2).  So now the guest kernel runs in ring 1. With this change, I
already implemented a syscall trampoline that no longer needs to switch to
the host, as well as iretq by the guest kernel goes directly to the guest
user space (or kernel).  The next version of lguest64 will be much cleaner
and faster!!!!

-- Steve
