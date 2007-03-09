From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC/PATCH LGUEST X86_64 03/13] lguest64 core
Date: Fri, 09 Mar 2007 15:10:48 +1100
Message-ID: <1173413448.32234.119.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
	<1173375527.32170.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173375527.32170.5.camel@localhost.localdomain>
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
> +lg-objs :=3D core.o hypervisor.o lguest_user.o hv_vm.o page_tables.o \
> +hypercalls.o io.o interrupts_and_traps.o lguest_debug.o

Right, I missed the trick here: hypervisor.S doesn't require any
relocations, so that fact that it's linked at the wrong address doesn't
matter at all.  Excuse me while I prepare a patch 8)

> +extern long end_hyper_text;
> +extern long start_hyper_text;

The standard way of doing this is "extern char end_hyper_text[];"
doesn't matter on x86/x86-64, but on some platforms gcc can make
assumptions about addresses based on the size of the variable (sbss
etc).  So nice to use that everywhere for asm constants.

Cheers,
Rusty.
