From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
Date: Wed, 11 Sep 2019 14:24:58 +0200
Message-ID: <20190911122458.GA8859__32411.8381877028$1568204720$gmane$org@stefanha-x1.localdomain>
References: <20190910151206.4671-1-mszeredi@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1214283376661723893=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190910151206.4671-1-mszeredi@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1214283376661723893==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 05:12:02PM +0200, Miklos Szeredi wrote:
> Git tree for this version is available here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-=
v5
>=20
> Only post patches that actually add virtiofs (virtiofs-v5-base..virtiofs-=
v5).
>=20
> I've folded the series from Vivek and fixed a couple of TODO comments
> myself.  AFAICS two issues remain that need to be resolved in the short
> term, one way or the other: freeze/restore and full virtqueue.

Thank you!  I am investigating freeze/restore.

Stefan

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1455oACgkQnKSrs4Gr
c8hWrggArzr0OOPSTmdQ2dbddY7tmvuQTZgyaLYh1W0gffJZH8gkHIH2rod4htHq
AWYZ7UxNWmHEdY4JHvMZCuxHMT8NScXWjGrkYbyE9amgj0b7PjtgRMiTJDFp2AMf
pr5rza+XUKxkeoVjdSHMThZEGXWn2PP3zEA/IftMSyL7XEHSVS47NRFTFScGDDwW
HpuWwzul31EFYU6ciPAGbAYPOcvDZCZv51ViJdnCcUMnzP3JMpdYyQy/2pcTauzm
1cvyoMStnkMl3uqTswNRCwRFGU5YVqjnxAWg6Gyqu4TyEa5hp96f97XKcFZRbBjv
LFwvgwMzPdO3dZqn3kBILCi/ZSR6MA==
=TbXq
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--===============1214283376661723893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1214283376661723893==--
