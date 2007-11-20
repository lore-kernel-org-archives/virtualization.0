From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 7/24] consolidate msr.h
Date: Tue, 20 Nov 2007 01:14:11 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711200108510.4062__25088.245914276$1195539401$gmane$org@gandalf.stny.rr.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
	<20071119222151.GA11178@wavehammer.waldi.eu.org>
	<Pine.LNX.4.58.0711191734270.32296@gandalf.stny.rr.com>
	<20071120055113.GC20436@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071120055113.GC20436@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Bastian Blank <bastian@waldi.eu.org>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org



On Tue, 20 Nov 2007, Ingo Molnar wrote:

> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > With PVOPS on it gives compiler warnings without that explict cast.
> > Without looking at the code, IIRC with non-PVOPS it is a macro
> > directly into asm, so it didn't matter what the cast was. But with
> > PVOPS as a function, it gave compiler warnings.
> >
> > Take it out and try compiling it for both i386 and x86_64. One of them
> > gave warnings. But maybe it's not a problem now.
>
> i dont think there's ever any true need (and good cause) to force
> integer type casts like that at the callee site.

I guess the problem is that we converted a macro to a function, where the
macro did no type checking. Now we need to pick between integers and
pointers. Some places uses intergers in wrmsrl and some use pointers. So
changing this to a typechecking protocol is not going to be nice.

Looking at the current code now, we have this:

====
	checking_wrmsrl(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
	checking_wrmsrl(MSR_IA32_SYSENTER_ESP, 0ULL);
	checking_wrmsrl(MSR_IA32_SYSENTER_EIP, (u64)ia32_sysenter_target);

	wrmsrl(MSR_CSTAR, ia32_cstar_target);
====

A typecast is already used in that same area.

-- Steve
