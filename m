From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 10:10:06 +0100
Message-ID: <20070306091006.GA26073@elte.hu>
References: <1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
	<20070306085222.GA17002@elte.hu> <45ED2E63.3070700@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ED2E63.3070700@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Zachary Amsden <zach@vmware.com> wrote:

> > > reduces the QA effort.  You still have 5 Hypervisors you have to =

> > > test against.
> >
> > yes, just like we have thousands of separate PC boards to support. =

> > But as long as the basic ABI is the same, the QA effort on the Linux =

> > kernel side is alot more focused. (Distros still have =

> > 18446744073709551616 total combinations to QA, and have to make an =

> > educated guess to reduce that to a more manageable number.)
> =

> But hardware PC boards don't do anything as remotely complicate as =

> changing the semantics required for correctness in you MMU =

> implementation. [...]

ugh, PC boards are actually far worse and far more diverse than any =

variances between hypervisors, but i digress.

anyway, my point stands: the Linux kernel is significantly more =

maintainable and easier to QA if it has only a single 'external' =

hypervisor ABI to worry about - and that might as well be VMI. This is a =

really obvious point, i expected the discussion to center more around =

the specifics of such a move ;-)

	Ingo
