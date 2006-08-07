From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 08:17:42 +0200
Message-ID: <200608070817.42074.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<200608070730.17813.ak@muc.de>
	<1154930669.7642.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1154930669.7642.12.camel@localhost.localdomain>
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

On Monday 07 August 2006 08:04, Rusty Russell wrote:
> On Mon, 2006-08-07 at 07:30 +0200, Andi Kleen wrote:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- /dev/null
> > > +++ b/include/asm-i386/no_paravirt.h
> > =

> > I can't say I like the name. After all that should be the normal
> > case for a long time now ... native? normal? bareiron?
> =

> Yeah, I don't like it much either.  native.h doesn't say what the
> alternative is.  native_paravirt.h is kind of contradictory.

You could create a subdirectory?

> I'm just shuffling code here, and if the other approach works, I won't
> even be doing that.

If you move it you can as well clean it up.  The result would be likely
at least 50% shorter.

-Andi
