From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] paravirt.h header
Date: Wed, 23 Aug 2006 11:20:07 +1000
Message-ID: <1156296008.12015.8.camel@localhost.localdomain>
References: <1156226116.26898.8.camel@localhost.localdomain>
	<20060822110635.d9072621.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060822110635.d9072621.ak@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-22 at 11:06 +0200, Andi Kleen wrote:
> On Tue, 22 Aug 2006 15:55:15 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> =

> > OK, this is the revised paravirt.h (Andi has seen this before), then the
> > second is the binary patching stuff.  More things get added to the
> > paravirt struct in future patches, but this basic stuff hasn't changed
> > for some time.
> =

> Thanks. I plan to revisit this after the .19 merge is done.
> Currently there is too much noise in the tree and even your =

> tree seems to be still changing too quickly.
> =

> The patch looks reasonable, except that you still have far too many
> of these nasty __s around asm and volatile.

Yes, the correct one I sent out later only has __ in two hunks (old code
which I moved): I will go through later and remove them all as a
separate patch if this annoys you.  AFAICT, everything under #ifdef
__KERNEL__ can be de-underscored without any ill effects.

Thanks,
Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
