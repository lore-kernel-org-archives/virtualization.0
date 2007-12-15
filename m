From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Sat, 15 Dec 2007 14:17:23 +0100
Message-ID: <20071215131723.GF9720__22486.2657407813$1197724796$gmane$org@elte.hu>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<11967843943958-git-send-email-gcosta@redhat.com>
	<11967843983411-git-send-email-gcosta@redhat.com>
	<11967844032081-git-send-email-gcosta@redhat.com>
	<11967844071346-git-send-email-gcosta@redhat.com>
	<4755A809.4050305@qumranet.com>
	<20071204193432.GI11764@bingen.suse.de>
	<20071205163017.GA4756@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071205163017.GA4756@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ehabkost@redhat.com, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > Linux never uses that register. The only user is suspend 
> > save/restore, but that' bogus because it wasn't ever initialized by 
> > Linux in the first place. It could be probably all safely removed.
> 
> It probably is safe to remove... but we currently support '2.8.95 
> kernel loads/resumes 2.6.24 image'... which would break if 2.8 uses 
> cr8.
> 
> So please keep it if it is not a big problem.

hm, so __save_processor_state() is in essence an ABI? Could you please 
also send a patch that documents this prominently, in the structure 
itself?

	Ingo
