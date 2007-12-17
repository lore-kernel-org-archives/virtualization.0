From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Mon, 17 Dec 2007 01:23:06 +0100
Message-ID: <20071217002306.GD5692__23330.0933301964$1197905537$gmane$org@elf.ucw.cz>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<20071205163017.GA4756@ucw.cz> <20071215131723.GF9720@elte.hu>
	<200712170127.31615.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712170127.31615.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Mon 2007-12-17 01:27:29, Rafael J. Wysocki wrote:
> On Saturday, 15 of December 2007, Ingo Molnar wrote:
> > 
> > * Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > > Linux never uses that register. The only user is suspend 
> > > > save/restore, but that' bogus because it wasn't ever initialized by 
> > > > Linux in the first place. It could be probably all safely removed.
> > > 
> > > It probably is safe to remove... but we currently support '2.8.95 
> > > kernel loads/resumes 2.6.24 image'... which would break if 2.8 uses 
> > > cr8.
> > > 
> > > So please keep it if it is not a big problem.
> > 
> > hm, so __save_processor_state() is in essence an ABI? Could you please 
> > also send a patch that documents this prominently, in the structure 
> > itself?
> 
> Hmm, I'm not sure if it really is an ABI part.  It doesn't communicate anything
> outside of the kernel in which it is defined.

Well, it is not "application binary interface", but it is
"kernel-to-kernel binary interface"...

> The problem is, though, that if kernel A is used for resuming kernel B, and
> kernel B doesn't save/restore everything it will need after the resume, then
> things will break if kernel A modifies that.  So, yes, we'll need to document
> that explicitly.

Agreed.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
