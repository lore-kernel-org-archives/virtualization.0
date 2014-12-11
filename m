From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PULL] virtio: virtio 1.0 support, misc patches
Date: Fri, 12 Dec 2014 08:07:05 +1100
Message-ID: <20141212080705.50988d51__27136.0114952133$1418332611$gmane$org@canb.auug.org.au>
References: <20141211120248.GA8838@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8004044816824391045=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141211120248.GA8838@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sergei.shtylyov@cogentembedded.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, pbonzini@redhat.com, ben@decadent.org.uk, David Miller <davem@davemloft.net>, thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

--===============8004044816824391045==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K9fC0KHvcIpbf2=o17AahMp"; protocol="application/pgp-signature"

--Sig_/K9fC0KHvcIpbf2=o17AahMp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 11 Dec 2014 14:02:48 +0200 "Michael S. Tsirkin" <mst@redhat.com> wr=
ote:
>
> The following changes since commit b2776bf7149bddd1f4161f14f79520f17fc1d7=
1d:
>=20
>   Linux 3.18 (2014-12-07 14:21:05 -0800)

hmmm ...

> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_li=
nus
>=20
> for you to fetch changes up to 803cd18f7b5e6c7ad6bee9571ae8f4450190ab58:
>=20
>   virtio_ccw: finalize_features error handling (2014-12-09 16:32:41 +0200)
>=20
> Note: some net drivers are affected by these patches.
> David said he's fine with merging these patches through
> my tree.
> Rusty's on vacation, he acked using my tree for these, too.

So, either none of this has been in linux-next or you have just rebased
it all on top of v3.18 ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/K9fC0KHvcIpbf2=o17AahMp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUigeDAAoJEMDTa8Ir7ZwVFkYP+wVmpS11lWSvfW4+liWEEuQs
sYmWmb2TrJ+A/7t7PgXihGm0mSC8XO4gHJnb/fgEeHgU5+WKE5EwAWiw94QukW//
gCJma8DbVopAjpNya1XmOxILvfMCVC3wjyqD0n/jsBtys3BtarnD0G+cKTceVJ57
4zwckdh6LKn7T077ygKOaiw7jLe94fy29hHHt9nKmAFiJxP5UvqOGQ9760H7R3/h
Sfn4nkMkSU9Qq+EavQEaZSCPPOyzGbGwrC42esxnSfIt4DHAX7jkAvZA0YzjTaN0
M1Dyis56ZUcu62GWACEv9RDmnAonsA3V4It2nUHQaq4zK3lUiLeKMJoJ0IOoF/P9
WBMmtf6vhi4DTEOYjYxAqpoaM04F2+l9qEk1xBm+daj3tncLp2gOFXOS2aCP83Vj
jjwkBlsdsdZqDx9MnnbpxBImGpO+EXAq5IFgiW1qvdPLh8r8U1CHnFX83fCTzURk
ONbSgjxiZogLDNKkt15SdwQ7UKgVMwSk1y2Ve7bWTHPOfY3bW1faE37qjGAfmTsg
3ypUrZuaH7K1SPu89Kia+0vh/FKFoIv7YAsLXG8D4xv380xgY8ZPyZBoyB3+p4Bd
fLwQ/4qUmVT4dI3msvUNheB4HlD2/RS6hxR1ccBF2TIOPNY1xgLZc3JAW2ztmcZP
bvfRfmRpwl8O9GPEqZjE
=+iNT
-----END PGP SIGNATURE-----

--Sig_/K9fC0KHvcIpbf2=o17AahMp--

--===============8004044816824391045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8004044816824391045==--
