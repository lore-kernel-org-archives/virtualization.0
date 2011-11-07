From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression: patch
	" hvc_console: display printk messages on console." causing infinite
	loop with 3.2-rc0 + Xen.
Date: Mon, 7 Nov 2011 17:19:42 +1100
Message-ID: <20111107171942.fe21429583491475f245aa08@canb.auug.org.au>
References: <20111027053007.GA32765@phenom.dumpdata.com>
	<20111027054806.GA1377@suse.de>
	<20111102121309.4dbb0d2ac90d2879130820dd@canb.auug.org.au>
	<20111103013012.GB3449@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4808559204088451209=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111103013012.GB3449@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus <torvalds@linux-foundation.org>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, miche@google.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

--===============4808559204088451209==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__7_Nov_2011_17_19_42_+1100_pjK4iajXXyXmXJ=X"

--Signature=_Mon__7_Nov_2011_17_19_42_+1100_pjK4iajXXyXmXJ=X
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 2 Nov 2011 18:30:12 -0700 Greg KH <gregkh@suse.de> wrote:
>
> On Wed, Nov 02, 2011 at 12:13:09PM +1100, Stephen Rothwell wrote:
> >=20
> > On Thu, 27 Oct 2011 07:48:06 +0200 Greg KH <gregkh@suse.de> wrote:
> > >
> > > On Thu, Oct 27, 2011 at 01:30:08AM -0400, Konrad Rzeszutek Wilk wrote:
> > > > Hey Miche.
> > > >=20
> > > > The git commit 361162459f62dc0826b82c9690a741a940f457f0:
> > > >=20
> > > >     hvc_console: display printk messages on console.
> > > >=20
> > > > is causing an infinite loop when booting Linux under Xen, as so:
> > >=20
> > > Ick, not good, thanks for letting us know.
> >=20
> > Indeed. I am wondering why it was put in a tree and sent to Linus witho=
ut
> > any Acks or even being replied to by anyone.  It appeared in the tty tr=
ee
> > between Oct 14 and Oct 25 (while I was unfortunately on vacation).  If
> > anyone had tried to boot this on any PowerPC server, it would have been
> > immediately obvious (as it was when I booted Linus' tree last night).
> >=20
> > And the original author expressed doubts as to his understanding of how
> > it should all work anyway.
> >=20
> > Just a little more care, please.
> >=20
> > I would vote for reverting the original and having it resubmitted with
> > corrections at some later date.
>=20
> You are right, I will go do that, sorry for the problems.

Ping ...

Linus can you please just revert 361162459f62dc0826b82c9690a741a940f457f0
"hvc_console: display printk messages on console" as it breaks consoles
for all PowerPC server machines.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Nov_2011_17_19_42_+1100_pjK4iajXXyXmXJ=X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOt3h+AAoJEECxmPOUX5FENFMP/jZOS+gsCITHFxhkyVSMsq4r
b244rYfPYLAz1QBHNGnVkPYOTWGFeNMbmW03AtlJgAyhCBq0WedYTKNhkMFQBEe1
1PwCh19zGx2IURoYeQfV4xj9129sP8YbT6rDuHQKo6hKc7TEYQ4VSKklARgJxzA3
vTjJNzWoV1VFsvE3WCpckH/XwUe9M7LHqDv4HfJmaCxIv8sCqfkLxNiqw245kHou
nnT4dnK2Knwt/384z5dCWoI27hs+nwCAgFtkbioeW3DAmkPk9JHUnGLx1DPa0iru
RIbokSABq2EapKTZb8ig3SGhf8MP1Goby9nit2e/227keF0/cS9UssbH8E6KUB6q
IfMtiq7fn0d79Ukjkkoy17T2swuGQZQyqM4JF3/dt2A9b0mwjRT53vE5r3lUTmCN
oS8g8P3YINTh4uY2+JlhYGoHEUHoYH8vbco/Q3XSbMJnYgT4hInb2z8sJJa5+Rkf
L4nPGFdbxvZoc2tbXRGz7/xdxNMzylqBDTt4VjnXroK/AUSFKTd9I+ReAdJp3/SV
KGbMQ58BfCWXGrCpvpdirIPYglC6nPZa/jk3o5vSr+g9O9TLGMVa7VYcaLWKW5uC
iv2Rs1RjIaimhTTw4Vk237AM3cUWcwB1WDccwCaaNZpNgDzUZtP2ZLnKiKqNFAUu
vMXhZjFqiJK9DZqjkc8h
=HH7g
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Nov_2011_17_19_42_+1100_pjK4iajXXyXmXJ=X--

--===============4808559204088451209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4808559204088451209==--
