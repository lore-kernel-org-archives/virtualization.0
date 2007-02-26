From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PARAVIRT_SAVE_FLAGS_IRQ_DISABLE composite callsite
Date: Mon, 26 Feb 2007 13:43:48 +1100
Message-ID: <1172457828.13541.39.camel@localhost.localdomain>
References: <45E159A7.7060709@goop.org>
	<1172441227.13541.24.camel@localhost.localdomain>
	<45E22EF6.901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45E22EF6.901@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-02-25 at 16:51 -0800, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > Yes, the combo was *so* common we went for one patch site rather than
> > two.
> >   =

> =

> Is there any disadvantage to having two adjacent patch sites?  For
> native the same instruction sequence will be generated, but with a few
> more nops.

Originally it was just 24 bytes vs 12 bytes, it's probably less now.
But as I said, it's *really* popular.  I don't have the numbers on me,
but it's almost worth making it the default and implementing cli / sti
in terms of save & restore 8)

Rusty.
