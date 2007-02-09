From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6c/10] lguest: the guest code
Date: Fri, 9 Feb 2007 12:49:57 -0500
Message-ID: <200702091249.58204.lenb@kernel.org>
References: <1171012296.2718.26.camel@localhost.localdomain> <200702091206.31797.lenb@kernel.org> <Pine.LNX.4.64.0702091212360.9007@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992461AbXBIRva@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0702091212360.9007@d.namei>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 09 February 2007 12:14, James Morris wrote:
> On Fri, 9 Feb 2007, Len Brown wrote:
>=20
> > On Friday 09 February 2007 05:57, Rusty Russell wrote:
> >=20
> > > +#ifdef CONFIG_ACPI
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_disabled =3D 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_ht =3D 0;
> > > +#endif
> >=20
> > If this is hard-coded to have ACPI disabled, why isn't it enforced =
at build-time?
>=20
> This is being disabled in the guest kernel only.  The host and guest=20
> kernels are expected to be the same build.

Okay, but better to use disable_acpi()
indeed, since this would be the first code not already inside CONFIG_AC=
PI
to invoke disable_acpi(), we could define the inline as empty and you c=
ould
then scratch the #ifdef too.

cheers,
-Len
