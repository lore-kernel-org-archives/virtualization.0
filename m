From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] drivers: vhost: vsock: fixed a brace coding style issue
Date: Fri, 9 Mar 2018 09:52:42 +0000
Message-ID: <20180309095242.GA9668__26013.286264106$1520589083$gmane$org@stefanha-x1.localdomain>
References: <20180309025603.4890-1-vaibhavmurkute88@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8170510737623934459=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180309025603.4890-1-vaibhavmurkute88@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============8170510737623934459==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 08:26:03AM +0530, Vaibhav Murkute wrote:
> Fixed a coding style issue.
>=20
> Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
> ---
>  drivers/vhost/vsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaollqAAoJEJykq7OBq3PIAy4H/0UVPxwyMBl7mtMlWj2JAstn
oxPazPiWs5e0X3seQR45te0T5Q0v8NDRgbiGICx9Gh6mnYH58a8Lg6IYuYwIO+U8
8bJjvjfRNiXcSe+9pwDCvDZXeu4eug79qw/pZF+Fst//mxQ2bXIRMPMp2kQXj2Ye
+9IHzC8iCNMbTcTO6cc4Z0BCtpwXXAqA9neSmzr9ox2/HJoMU7zGr9dTii4lVxJq
x/S44HFRQfLFfVOE+0qqwYAHNvpOduJp8jazVx1joYGtXLPXeNGT63LMkGsSVhul
TLoKPoYCIGb7BygT5jsHD7nDRYAWSHPraDyKrm7NQxclnkfvklRIYdDE8o2GuWQ=
=L3or
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--===============8170510737623934459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8170510737623934459==--
