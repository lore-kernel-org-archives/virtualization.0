From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 12/20] virtio: disallow late feature changes for
	virtio-1
Date: Tue, 20 Jan 2015 11:14:21 +0000
Message-ID: <20150120111421.GK17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-13-git-send-email-cornelia.huck@de.ibm.com>
	<20141212115538.2aa96fd2@oc7435384737.ibm.com>
	<20141212121825.6c09af4d.cornelia.huck@de.ibm.com>
	<20141212122547.511baafd@oc7435384737.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6222054341006445628=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141212122547.511baafd@oc7435384737.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============6222054341006445628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cy+5HEalSgyXkpVS"
Content-Disposition: inline


--Cy+5HEalSgyXkpVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2014 at 12:25:47PM +0100, Thomas Huth wrote:
> On Fri, 12 Dec 2014 12:18:25 +0100
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>=20
> > On Fri, 12 Dec 2014 11:55:38 +0100
> > Thomas Huth <thuth@linux.vnet.ibm.com> wrote:
> >=20
> > > On Thu, 11 Dec 2014 14:25:14 +0100
> > > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > >=20
> > > > For virtio-1 devices, the driver must not attempt to set feature bi=
ts
> > > > after it set FEATURES_OK in the device status. Simply reject it in
> > > > that case.
> > > >=20
> > > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > > ---
> > > >  hw/virtio/virtio.c         |   16 ++++++++++++++--
> > > >  include/hw/virtio/virtio.h |    2 ++
> > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index 57190ba..a3dd67b 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -978,7 +978,7 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *=
f)
> > > >      vmstate_save_state(f, &vmstate_virtio, vdev);
> > > >  }
> > > >=20
> > > > -int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > > > +static int __virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > >=20
> > > Maybe avoid the double underscores here? But unfortunately, I also fa=
il
> > > to come up with a better suggestion for a name here ...
> >=20
> > virtio_set_features_nocheck()?
>=20
> Sounds ok to me.
>=20
> > This function is only called within virtio.c anyway...
>=20
> Right, so the double underscores should be ok here, too. (I still do
> not like them very much, but that's just my personal taste in this case)

C99 "7.1.3 Reserved identifiers" says:

  All identifiers that begin with an underscore and either an uppercase
  letter or another underscore are always reserved for any use

[by the standard library]

You can use a trailing underscore or useless word like "do", e.g.
virtio_do_set_features(), for internal functions.

--Cy+5HEalSgyXkpVS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvjiNAAoJEJykq7OBq3PIs3YH/3B0hKswuZVJqEhHDmRegdQs
R/JXgdhlqxLma5BMdW25Y0CP3EDUPIicS8twn8xG6XpCpOr8bk9lIExNV4R4VVtR
bZh2XXxMCUwgbjWusXTHfMciMLXAKPexn/oDHt5QIPfx75QnI3RLCoNfwlYJy2VA
6lsG3wrVy+skZgCXrX4sKKLoexlIPqyGSOCOENG3B75wEJjxym31EcaYZeprsrMY
oXXwjCXy0QyHfVRX6C0FtziEJnwgcEi1oHpbjGbr4mhrZq5l0l187XSeMNGt59Ki
bE4BVVSVir+XpJkKij9K0YLsyske5KTFOXBug85rXsHwNE8NozECamYdCTgCGws=
=sL9I
-----END PGP SIGNATURE-----

--Cy+5HEalSgyXkpVS--

--===============6222054341006445628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6222054341006445628==--
