From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Section mismatch in parainstructions
Date: Sun, 10 Dec 2006 18:34:41 -0800
Message-ID: <20061210183441.86785fee.randy.dunlap@oracle.com>
References: <20061210155821.d2c5dfa5.randy.dunlap@oracle.com>
	<457CA915.1040109@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <457CA915.1040109@goop.org>
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
Cc: akpm <akpm@osdl.org>, virtualization@lists.osdl.org, sam@ravnborg.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 10 Dec 2006 16:40:53 -0800 Jeremy Fitzhardinge wrote:

> Randy Dunlap wrote:
> > Is it OK for section .parainstructions to reference
> > exit.text?
> >
> > I'm seeing:
> >
> > WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .e=
xit.text: from .parainstructions after '' (at offset 0x0)
> > WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .e=
xit.text: from .parainstructions after '' (at offset 0x8)
> >
> > If that's OK, we need a small patch to modpost, as below.
> >   =

> =

> What are the semantics of .exit.text?  In principle a paravirtualized
> instruction can appear anywhere, so I think these warnings are bogus. =

> The only concern is if one of these sections disappears before the
> paravirt_ops instruction substitution happens.

Good question.  I don't see much doc on that subject.
Rusty could probably answer that better than me.

Something like this:

.exit.text section(s) can be discarded from built-in (non-modular)
code (or not even loaded at all).

.exit.text section(s) in modules is only loaded when
CONFIG_MODULE_UNLOAD=3Dy.


so what are the .parainstructions text sections for?
Are they for replacing code instructions based on some
condition(s)?  (like <gag> self-modifying code? </gag>)

---
~Randy
