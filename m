From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 18:18:13 +0100
Message-ID: <20070306171813.GA21218@elte.hu>
References: <1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2F53.2040101@goop.org>
	<20070306092636.GC26073@elte.hu> <45ED99F8.9060705@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ED99F8.9060705@goop.org>
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
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > My suggestion would be for Linux to make only a /single/ external =

> > ABI promise: VMI. (and we can extend it with higher-level paravirt =

> > ops, etc.)
> =

> "VMI" is not a promise, it's just three letters.  It doesn't even mean =

> the same thing now as it did 12 months ago.  Turning "VMI" from three =

> letters into anything remotely like a promise is a huge amount of work =

> which requires:
> =

>    1. someone actually sit down and fully document what all those
>       entrypoints are going to do
>    2. everyone to implement them
>    3. someone to test that all the implementations conform to the
>       document (bearing in mind that if anyone is going to go to all
>       this effort, they're going to use this with non-Linux guests)
>    4. and repeat all that every subsequent update

There's no process needed. The only thing needed is to treat the Linux =

implementation as the reference design, documentation and specification. =

Treat it as we treat the Linux system calls. We promise not to change =

them. There's no "process" for that either, other than our promise, our =

taste and our best efforts - plus the backing of all distributions and =

the threat of a few million users who start yelling (or worse) if we =

break it ;)

	Ingo
