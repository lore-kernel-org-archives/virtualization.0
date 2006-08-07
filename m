From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
Date: Mon, 7 Aug 2006 08:20:09 +0200
Message-ID: <200608070820.09059.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<200608070739.33428.ak@muc.de>
	<1154931222.7642.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1154931222.7642.21.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> > I think I would prefer to patch always. Is there a particular
> > reason you can't do that?
> =

> We could patch all the indirect calls into direct calls, but I don't
> think it's worth bothering: most simply don't matter.

I still think it would be better to patch always.

> Each backend wants a different patch, so alternative() doesn't cut it.
> We could look at generalizing alternative() I guess, but it works fine
> so I didn't want to touch it.

You could at least use a common function (with the replacement passed
in as argument) for lock prefixes and your stuff

-Andi
