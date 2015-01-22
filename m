From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 02/20] virtio: cull
	virtio_bus_set_vdev_features
Date: Thu, 22 Jan 2015 12:24:08 +1100
Message-ID: <20150122012408.GC27371@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2822688470497831769=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-3-git-send-email-cornelia.huck@de.ibm.com>
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


--===============2822688470497831769==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:04PM +0100, Cornelia Huck wrote:
> The only user of this function was virtio-ccw, and it should use
> virtio_set_features() like everybody else: We need to make sure
> that bad features are masked out properly, which this function did
> not do.
>=20
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFE4AAoJEGw4ysog2bOSC9wQAJCyBGFawyqCcREAiu86evo0
zjLXmxdJ4xA1pDwzu6rPuNLbtoZYU72v3DLUs1+9ygeW7rTn/Y+pmCDpuYGmxuaF
kKYvzN3Qa8WWMg39urWcyu/7AU8C1InThYKBNE7Yb1DdwCxtERtz1GQH6NqhdR9j
2/UDh21Rp6YmiWfq+oZ5VDl/FmgbnKu8wKyggt9LPlpXYTH1ArjsRGHOpHChRqnY
kqIzaI634kXok4PP4VQjzHdNrG9TT2blB/lcB/5figIXwrFeBqmbNBYgBidlKMqI
6mukFAjxSQ1iQj3IVRp4RfdSkIRQgdRffTh0z6dq5SXR0GkRX+sPEZliY6s0xe3U
AqySuL27QRCvtm0wi6mfuSbNGiTJa9IJGjcvk5RMxii/jMy83QiGnNBmJV4DmKyq
ZBDZbDhH2Ri6dKj59WluqsQRYHtlFRPoLvYnqbPKQZ9Ti2ML3lJu5qL2BENPEuXe
RrtLyXDD6BF5gpzAiC3kDniE6TtUgFgUpt8zbxuqtAdSRGuvQk/dCzyiYOe4FCfV
K7RP1A/xG2o9F94TYqzY0L/C79ki/kZkQP/pMG/J5nlkeaBcBM/2uLIrShzhKHXl
L84K9OdduIjKpYPjG2PxgOwRTvFw/7Qu58U4XRoB3PNJbSBe1K37vtkTs+P0oUeM
cY/CipvrOj1TlzKTgsTL
=zvBL
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

--===============2822688470497831769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2822688470497831769==--
