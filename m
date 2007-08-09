From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix Malicious Guest GDT Host Crash
Date: Thu, 09 Aug 2007 15:13:50 +1000
Message-ID: <1186636430.17752.35.camel@localhost.localdomain>
References: <1186546220.17470.23.camel@localhost.localdomain>
	<13426df10708082140r61dbaf0m7f03da23e8bf0421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <13426df10708082140r61dbaf0m7f03da23e8bf0421@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ron minnich <rminnich@gmail.com>
Cc: lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-08-08 at 21:40 -0700, ron minnich wrote:
> On 8/7/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > Hi all,
> >
> >         Testing would be appreciated (esp. Ron?): I'd like to push this as soon
> > as possible into 2.6.23.  I thought of it while pondering kvm-lite, and
> > then proved it was a problem...
> 
> Works fine here.
> 
> Be aware that in the early Plan 9 port to lguest I created a gdt entry
> and forgot to wrap the GDT #  with a macro with the result that I
> loaded a gdt # instead of a selector into the gdt entry, and when the
> guest switched back to the host (and back to guest, I guess) it
> crashed my machine so hard that it went into the BIOS 'let's set this
> brand new thinkpad up' dialog.

Wow.  That's impressive.  It's understandable, however: I got a host
triplefault here when a malformed GDT entry caused a #GP on guest entry.

I'd be interested to check that this fixes it, but I'm pretty confident
(it fixed it here).

> The guys at the Plan 9  BOF at Google thought lguest was pretty darn cool.

Cool!

Rusty.
