From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 08/20] dataplane: allow virtio-1
	devices
Date: Thu, 22 Jan 2015 13:12:48 +1100
Message-ID: <20150122021248.GJ27371@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-9-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3679758163999210580=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-9-git-send-email-cornelia.huck@de.ibm.com>
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


--===============3679758163999210580==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:10PM +0100, Cornelia Huck wrote:
> Handle endianness conversion for virtio-1 virtqueues correctly.
>=20
> Note that dataplane now needs to be built per-target.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwFygAAoJEGw4ysog2bOS6wMQAKVWdCnKapnLR6rxUzVgEa9V
L/DZ9Z1C8cF5qm8OfFyCUA9BKRr5qF0njB2C5HDXC0Q3cf61L2njZ0qctChDjyj6
7JzHpkZJPirNF8Yy3d6/+WbgXa5F8Fp93wkqIJxhoajqP3Qj1HqQ8RHdkn4fHURd
BfgjVgWxZCRdYvwlX+OfZeUbzEDFebhpA2SQCWtr5wJKkt7y2UDMRBbRhpxvJSMY
lsBr+HEVxgbVJg5xHP6VZ5X5dMCa5PQXo0f3WCtfhqMQv9/FdQpduZ4r8BMJ6K/x
JexXBXeRZR/WCO7ZPfgFFWzgqA6+5Bnla8uN73iYQVnz6vpDwimMt2UByi1XnkMv
WLGVieGSpG/RmE/UqgZGgfepQTDDCtoGXrvKebu34IhTOMmNmHjfU1UMwAOH8wXk
ZH4IMCdaOLSe2jcupo+IEMRWgN5cPB4UinY3tewU8tuz/Yza2wylzZWFj90SGWPh
uTrvxLn/kQSYdKSFceRtQXA3ojyhQND7BH4Ag4IXWogbknB16o4HORe5FyZb4g4C
lHsThHIv2P5XUcG9iXUHhncBTxZCzu/We9am+abek+DmAVuZ6BRogeJyHSSUrgHb
jtGUO2cMqE1M/EUyFJhNLX0mTjq0cXkItzQ5xMhoUTXkNwX7KuiV1LexoJIj5LIe
CJvuk6FSdOBSb2XM0LxU
=cSuT
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--

--===============3679758163999210580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3679758163999210580==--
