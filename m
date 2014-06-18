From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Wed, 18 Jun 2014 18:48:49 +0800
Message-ID: <20140618104849.GH14030@stefanha-thinkpad.redhat.com>
References: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
	<53A00464.8090609@6wind.com> <53A00DEB.8030400@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7566510489892571681=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A00DEB.8030400@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, David Marchand <david.marchand@6wind.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Vincent JARDIN <vincent.jardin@6wind.com>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7566510489892571681==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 11:44:11AM +0200, Paolo Bonzini wrote:
> Il 17/06/2014 11:03, David Marchand ha scritto:
> >>Unless someone steps up and maintains ivshmem, I think it should be
> >>deprecated and dropped from QEMU.
> >
> >Then I can maintain ivshmem for QEMU.
> >If this is ok, I will send a patch for MAINTAINERS file.
>=20
> Typically, adding yourself to maintainers is done only after having proved
> your ability to be a maintainer. :)
>=20
> So, let's stop talking and go back to code!  You can start doing what was
> suggested elsewhere in the thread: get the server and uio driver merged i=
nto
> the QEMU tree, document the protocol in docs/specs/ivshmem_device_spec.tx=
t,
> and start fixing bugs such as the ones that Markus reported.

One more thing to add to the list:

static void ivshmem_read(void *opaque, const uint8_t * buf, int flags)

The "flags" argument should be "size".  Size should be checked before
accessing buf.

Please also see the bug fixes in the following unapplied patch:
"[PATCH] ivshmem: fix potential OOB r/w access (#2)" by Sebastian Krahmer
https://lists.gnu.org/archive/html/qemu-devel/2014-04/msg03538.html

Stefan

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJToW6RAAoJEJykq7OBq3PI+0wH/iAKhezs5crrEP4LmcyhGwHH
pIl1XcppxflzkLonaRnT11scmzXY6ilnw0ajpX2axVTao/YHOR/ii7DRhZGKGuLu
jNUS0xk9mgUpfTZ7z4OdXHum8MhLaIF21znbUKPhtpz086+oiwhmMYgOiNW/PXAP
LsOLJXON5/NAoP3GzIkhW06Kq7fRUST3ZxqIDVvoNCBYEEd8/qGD234rxyAk9u7P
Fo3j+KJ1h+RwOeu4A+lQCsP//45L6EWfhmdVKlPD3/98F8/7gfQkCxEozAeKmoYL
3UJFzioZZjE22GrLA59vgXtCqGm0HnYzX3ebAqEtlM/ORi3RLA+L1pXCDg8hpgs=
=bsS6
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--

--===============7566510489892571681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7566510489892571681==--
