From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: 22 Sep 2006 14:32:15 +0200
Message-ID: <20060922123215.GA98728@muc.de>
References: <1158925861.26261.3.camel@localhost.localdomain>
	<1158925997.26261.6.camel@localhost.localdomain>
	<1158926106.26261.8.camel@localhost.localdomain>
	<1158926215.26261.11.camel@localhost.localdomain>
	<1158926308.26261.14.camel@localhost.localdomain>
	<1158926386.26261.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Fri, 22 Sep 2006 14:32:15 +0200
Content-Disposition: inline
In-Reply-To: <1158926386.26261.17.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

BTW I changed my copy sorry. I redid the early PDA support
to not be in assembler.

On Fri, Sep 22, 2006 at 09:59:45PM +1000, Rusty Russell wrote:
> This patch actually uses the gs register to implement the per-cpu
> sections.  It's fairly straightforward: the gs segment starts at the
> per-cpu offset for the particular cpu (or 0, in very early boot).  =

> =

> We also implement x86_64-inspired (via Jeremy Fitzhardinge) per-cpu
> accesses where a general lvalue isn't needed.  These
> single-instruction accesses are slightly more efficient, plus (being a
> single insn) are atomic wrt. preemption so we can use them to
> implement cpu_local_inc etc.

The problem is nobody uses cpu_local_inc() etc :/ And it is difficult
to use in generic code because of the usual preemption issues =

(and being slower on other archs in many cases compared to preempt disabling
around larger block of code) =


Without that it is the same code as Jeremy's variant
%gs memory reference + another reference with offset as far as I can see.

So while it looks nice I don't think it will have advantages. Or did
i miss something?

-Andi
