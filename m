From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Wed, 5 Dec 2007 16:30:17 +0000
Message-ID: <20071205163017.GA4756__42530.1161864356$1197905501$gmane$org@ucw.cz>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<11967843943958-git-send-email-gcosta@redhat.com>
	<11967843983411-git-send-email-gcosta@redhat.com>
	<11967844032081-git-send-email-gcosta@redhat.com>
	<11967844071346-git-send-email-gcosta@redhat.com>
	<4755A809.4050305@qumranet.com>
	<20071204193432.GI11764@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071204193432.GI11764@bingen.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ehabkost@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Tue 2007-12-04 20:34:32, Andi Kleen wrote:
> On Tue, Dec 04, 2007 at 09:18:33PM +0200, Avi Kivity wrote:
> > Glauber de Oliveira Costa wrote:
> >> This patch moves the i386 control registers manipulation functions,
> >> wbinvd, and clts functions to system.h. They are essentially the same
> >> as in x86_64, except for the cr8 register, which we add.
> >>
> >> +
> >> +static inline unsigned long native_read_cr8(void)
> >> +{
> >> +	unsigned long cr8;
> >> +	asm volatile("mov %%cr8,%0" : "=r" (cr8), "=m" (__force_order));
> >> +	return cr8;
> >> +}
> >> +
> >>   
> >
> > There is no cr8 register on i386.  This had better be protected by an 
> > #ifdef.
> >
> > (you're likely not getting an error since it's a static inline, so the asm 
> > is never emitted)
> 
> Linux never uses that register. The only user is suspend save/restore, 
> but that' bogus because it wasn't ever initialized by Linux in the first
> place. It could be probably all safely removed.

It probably is safe to remove... but we currently support '2.8.95
kernel loads/resumes 2.6.24 image'... which would break if 2.8 uses
cr8.

So please keep it if it is not a big problem.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
