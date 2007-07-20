From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Move KVM, paravirt, lguest, VMI and Xen under arch-level
 Virtualization option
Date: Fri, 20 Jul 2007 08:24:01 +0300
Message-ID: <46A046F1.7040207__14291.8626581833$1184909263$gmane$org@qumranet.com>
References: <1184905342.10380.263.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184905342.10380.263.camel@localhost.localdomain>
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Any objections?
>
> Rusty.
> ===
> Having KVM appear in the middle of "drivers" is kinda strange, and
> having it alone under a menu called "virtualization" doubly so.
>
> 1) Move the "Virtualization" menu into the arch-specific i386 and
>    x86-64 Kconfig.
>   

Virtualization is hardly x86 specific.  How about moving it to
top-level, and having individual items disable themselves on archs they
don't apply to?

Otherwise we end up with $NARCH copies of that Kconfig, each slightly
different.  The top-level entry can be made to depend on the archs that
actually have some virt capability, so as not to show empty an menu.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
