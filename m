From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 11/20] s390x/virtio-ccw: support virtio-1 set_vq
	format
Date: Tue, 20 Jan 2015 11:06:03 +0000
Message-ID: <20150120110603.GI17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-12-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1235220879235266828=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-12-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============1235220879235266828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:13PM +0100, Cornelia Huck wrote:
> Support the new CCW_CMD_SET_VQ format for virtio-1 devices.
>=20
> While we're at it, refactor the code a bit and enforce big endian
> fields (which had always been required, even for legacy).
>=20
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c |  114 ++++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 80 insertions(+), 34 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvjabAAoJEJykq7OBq3PIBB0H/0vooJuDbRCRHFTeFTCTAnmB
Folf7374kAhfsBABS4+WqGHi4U2MwhIfuX2h8XgWYEPojzC+n1r6mE8V5C5Fmxwn
iu41infnE67ImwJJkiM7Yze+BICGAFOwpgey+nTxAWGCKa9p70s4qtbEdFwTlv7I
KRFCZBcIaVsFVw2xHbvTD8/h3F1fhaLkesPoa3Wo4K/g080QkVFpZb4usFTDTy/h
vAFVyeUg3KkOLXNccFCA6thDJZ/at7yrvEJk0fGbCkQJarDEtPtCSP2SO4IKsqur
v37o+DLtkGrOPfkW6l6+aO2Hwv9VNQWByN4RK+U16H4FbNMEqi07B+syiC22Qac=
=xA1A
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--

--===============1235220879235266828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1235220879235266828==--
