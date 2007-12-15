From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Sat, 15 Dec 2007 23:54:19 +0100
Message-ID: <20071215225419.GB2434__44106.7473999739$1197905541$gmane$org@elf.ucw.cz>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<11967843943958-git-send-email-gcosta@redhat.com>
	<11967843983411-git-send-email-gcosta@redhat.com>
	<11967844032081-git-send-email-gcosta@redhat.com>
	<11967844071346-git-send-email-gcosta@redhat.com>
	<4755A809.4050305@qumranet.com>
	<20071204193432.GI11764@bingen.suse.de>
	<20071205163017.GA4756@ucw.cz>
	<20071215132638.GA28231@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071215132638.GA28231@basil.nowhere.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ehabkost@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Sat 2007-12-15 14:26:38, Andi Kleen wrote:
> > It probably is safe to remove... but we currently support '2.8.95
> > kernel loads/resumes 2.6.24 image'... which would break if 2.8 uses
> > cr8.
> 
> No it won't. 2.8 would just restore some random useless value.

Restoring random value seems wrong. Putting random values into cpu
registers can break stuff, right?

Even if 2.6.24 image being restored did not set %cr8 itself, it may
depend on %cr8 to have "sane" value.

> If 2.8 wants to use CR8 it would have to re-initialize it

We are talking "2.8 restores 2.6 image" here.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
