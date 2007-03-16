From: Steven Rostedt <srostedt@stny.rr.com>
Subject: Re: [patch 05/26] Xen-paravirt_ops: paravirt_ops: hooks to set up
	initial pagetable
Date: Fri, 16 Mar 2007 15:35:44 -0400
Message-ID: <1174073744.11050.7.camel@localhost.localdomain>
References: <20070301232443.195603797@goop.org>
	<20070301232526.611972133@goop.org> <20070316093348.GS23174@elte.hu>
	<45FAE46F.7080009@goop.org>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <45FAE46F.7080009@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-03-16 at 11:39 -0700, Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
> >> +	/* Make sure kernel address space is empty so that a pagetable
> >> +	   will be allocated for it. */
> >>     =

> >
> > comment style.
> >   =

> =

> As you've noticed its a comment style I use quite often.  I use it for
> what's essentially a little local comment, rather than a block comment
> which really needs to draw attention to itself.  In this case, I think us=
ing
> =


Understood, but then you need to make that comment a single line :)

The way Linux code prefers comments (like the code itself actually
prefers it!) is single line comments stay on a single line, and
multiline comments are always block.

So it's either:

   /* my little comment here */

or =


   /*
    * This comment, although small and to the point, does span multiple
    * lines and regardless, needs to be a block comment.
    */

I guess it just makes it easier on the eyes when everything conforms and
others need to look at / maintain your code.


-- Steve
