From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 1/5] um/... convert #include "linux/..." to
	#include	<linux/...>
Date: Wed, 22 Aug 2007 12:25:08 -0400
Message-ID: <20070822162508.GA11022@c2.user-mode-linux.org>
References: <1187561903.4200.138.camel@localhost>
	<200708211909.23027.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708211909.23027.blaisorblade@yahoo.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Miklos Szeredi <mszeredi@suse.cz>, Maxim Krasnyansky <maxk@qualcomm.com>, Jeff Dike <jdike@karaya.com>, kernel-janitors@vger.kernel.org, Jason Lunz <lunz@falooley.org>, Jan Beulich <jbeulich@novell.com>, vtun@office.satix.net, Jens Axboe <jens.axboe@oracle.com>, Stephen Hemminger <shemminger@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Davide Brini <davide.brini@unibo.it>, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Alexey Dobriyan <adobriyan@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, Chris Wright <chrisw@sous-sol.org>, user-mode-linux-user@lists.sourceforge.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2007 at 07:09:17PM +0200, Blaisorblade wrote:
> Wait, this patch may or may not be sane (Jeff will tell more I guess).

It's sane.

> Since 
> we use two different sets of headers (the host ones from userspace and the 
> guest ones from Linux), this peculiar style has been used till now to make 
> clear the difference (#include <file> is used for host headers) - at least 
> that's what I think (I've never asked to Jeff, but I silently deduced this 
> and followed this practice).

Yeah, and it makes some sense to extend the practice to the kernel
side, where <> is used for generic headers and "" for UML-specific
ones.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
