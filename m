From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC] VSOCK: About Virtio-vsock support "Multiqueue" feature ?
Date: Thu, 29 Nov 2018 14:06:47 +0000
Message-ID: <20181129140647.GB17554@stefanha-x1.localdomain>
References: <5BBB0203.1010400@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5729824131533215403=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5BBB0203.1010400@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: netdev@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5729824131533215403==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 03:06:43PM +0800, jiangyiwen wrote:
> Hi Stefan & All:
>=20
> Now virtio-vsock only supports two vqs(tx and rx), that means
> if multiple sockets in the guest will use the same vq to transmit
> the message and get the response. In this way, the bandwidth will
> be limited to ~700MB/s. So if there are multiple applications in
> the guest, we should support "Multiqueue" feature for Virtio-vsock.
>=20
> I want to know whether we already have plans to support multiqueue
> or already have simple demo that can be used. If not, I will try
> to implement this feature.

Multiqueue is certainly interesting.  It would be interesting to see
if/how it affects common net/vmw_vsock/ code.  Hopefully nothing much
will change there but I haven't checked if any common locking would
prevent multiqueue from working efficiently.

Stefan

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb//J3AAoJEJykq7OBq3PIPjIH/jN6ytsB1UNke7YCoCEFLikS
3sZW3djAvvYA0k+bGnafY4C2rYRz96t3FiiDaCyoCGyInrDwG5fqptWMbQxAHffY
GWIbQqsRkHtZ+G9i3pP5ZAXCWpnlHvcTtxeJGCx5ExYCxW19qqr80YI7rCOsA99l
UtUfGtiTmwtq48ZXo07gon79SiJpYCbu3PuK3PHBtCHyJFiBuLJjIw8Ng2R9yh1W
ewVGdKQXtLVXcUrKeqPb57sV6+E3vovuRWqHnlmgRFzISwJKH9njcS5iF8WzJQ8j
SI/++SsiKksAeMh/ZTgXtyR/z6QVoHwGv84yAr3kKy0L+GiV8MhUn5RAbO8f3tg=
=I88p
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

--===============5729824131533215403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5729824131533215403==--
