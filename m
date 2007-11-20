From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 7/24] consolidate msr.h
Date: Tue, 20 Nov 2007 06:51:13 +0100
Message-ID: <20071120055113.GC20436__48903.3306636431$1195538095$gmane$org@elte.hu>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0711191734270.32296@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Bastian Blank <bastian@waldi.eu.org>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > On Fri, Nov 09, 2007 at 04:42:48PM -0200, Glauber de Oliveira Costa wrote:
> > > -	wrmsrl(MSR_CSTAR, ia32_cstar_target);
> > > +	wrmsrl(MSR_CSTAR, (u64)ia32_cstar_target);
> >
> > Hmm, why do you add explicit casts? The compiler should convert that
> > correctly on its own.
> >
> > > +static inline void wrmsrl(unsigned int msr, unsigned long long val)
> >
> > Hmm, long long is 64 bit on all x86, but why not use explicit u64 to
> > show that?
> 
> (quick reply)
> 
> With PVOPS on it gives compiler warnings without that explict cast. 
> Without looking at the code, IIRC with non-PVOPS it is a macro 
> directly into asm, so it didn't matter what the cast was. But with 
> PVOPS as a function, it gave compiler warnings.
> 
> Take it out and try compiling it for both i386 and x86_64. One of them 
> gave warnings. But maybe it's not a problem now.

i dont think there's ever any true need (and good cause) to force 
integer type casts like that at the callee site.

	Ingo
