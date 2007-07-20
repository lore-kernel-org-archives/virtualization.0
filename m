From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Move KVM, paravirt, lguest, VMI and Xen under
	arch-level Virtualization option
Date: Fri, 20 Jul 2007 16:02:27 +1000
Message-ID: <1184911347.10380.274.camel__11478.4229932868$1184911605$gmane$org@localhost.localdomain>
References: <1184905342.10380.263.camel@localhost.localdomain>
	<46A046F1.7040207@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46A046F1.7040207@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-07-20 at 08:24 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> > Any objections?
> >
> > Rusty.
> > ===
> > Having KVM appear in the middle of "drivers" is kinda strange, and
> > having it alone under a menu called "virtualization" doubly so.
> >
> > 1) Move the "Virtualization" menu into the arch-specific i386 and
> >    x86-64 Kconfig.
> >   
> 
> Virtualization is hardly x86 specific.  How about moving it to
> top-level, and having individual items disable themselves on archs they
> don't apply to?
> 
> Otherwise we end up with $NARCH copies of that Kconfig, each slightly
> different.  The top-level entry can be made to depend on the archs that
> actually have some virt capability, so as not to show empty an menu.

I dislike the duplication, too, but 

1) it's a CPU capability, and that's where it belongs in the menu.
2) And as you can see from the difference between the x86_64 and i386
help text, there are real platform differences (and not mentioning
what's under the menu would be kinda cheating).
3) Virtualization doesn't even make sense as an option for some
platforms where it's always on.

Cheers,
Rusty.
