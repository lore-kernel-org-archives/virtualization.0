From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Wed, 19 Sep 2007 07:34:32 +1000
Message-ID: <1190151272.7262.175.camel__8630.67394025183$1190151455$gmane$org@localhost.localdomain>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<1189747124.7262.36.camel@localhost.localdomain>
	<1189747280.7262.39.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709181257.41530.ak@suse.de>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-09-18 at 12:57 +0200, Andi Kleen wrote:
> On Friday 14 September 2007 07:21, Rusty Russell wrote:
> > It's pretty widely used,
> 
> Is it? By whom?

Hi Andi,

	Please stop asking for facts!  It's was easy claim to make, and hard to
disprove 8)

> > and the distributions will turn it on. 
> 
> That's no reason to make it default y. Please undo that. default y
> is near always a bad idea.

How about a "select" based on Xen, lguest or VMI?  There's no other
reason to enable it, after all.

> Also I would still consider it experimental.

After 9 months in mainline and three kernel versions, I'd hope not.
It's been pretty damn stable (ok, you broke it once, but maybe that's
because you consider it experimental).

Cheers,
Rusty.
