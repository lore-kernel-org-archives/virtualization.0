From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Sun, 22 Apr 2007 08:28:08 -0600
Message-ID: <m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>
	<46284B40.5010106@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46284B40.5010106@goop.org> (Jeremy Fitzhardinge's message of
	"Thu, 19 Apr 2007 22:10:24 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Hm, OK, I see what you're getting at.
>
> I guess the BUG_ON()s need only fire if they're failing to patch over a
> ud2a instruction.
>
>
> I'm in two minds about this.  On the one hand, it's a clever hack which
> does achieve the desired outcome.  On the other hand, it turns an
> optimisation mechanism into a special-purpose ad-hoc linker which
> doesn't seem like quite the right way to go.  The conversion from "best
> effort, doing nothing is OK" to "doing nothing is a BUG" behaviour is a
> good indication of this.

Yes.  Has anyone thought more about David Miller's suggesting of just
using the linker and not doing the fancy binary replacement?

Especially if you are beginning to reimplement the linker anyway.

Eric
