From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net 3/4] vhost: vsock: add weight support
Date: Thu, 16 May 2019 10:33:52 +0100
Message-ID: <20190516093352.GQ29507__3138.72537096671$1557999254$gmane$org@stefanha-x1.localdomain>
References: <1557992862-27320-1-git-send-email-jasowang@redhat.com>
	<1557992862-27320-4-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0508861305249481839=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1557992862-27320-4-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============0508861305249481839==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AFQGHouA0VN8Ovbt"
Content-Disposition: inline


--AFQGHouA0VN8Ovbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 03:47:41AM -0400, Jason Wang wrote:
> @@ -183,7 +184,8 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_=
cid)
>  		virtio_transport_deliver_tap_pkt(pkt);
> =20
>  		virtio_transport_free_pkt(pkt);
> -	}
> +		total_len +=3D pkt->len;

Please increment total_len before virtio_transport_free_pkt(pkt) to
avoid use-after-free.

--AFQGHouA0VN8Ovbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzdLoAACgkQnKSrs4Gr
c8garggAkwbbSkEoposz2FA5FIKLYtHjdQpn8NA8HSvaFqi/DcE0ejKYtN/BImRo
9Sed+GFqfzmP9ZIQni5Sh0boykMdrp8ZqK4JcFS4tTXZ4Ac0Smob4EA15WxIFX+p
H35N34MvKnfTivYZKoezEXqFiiz8re5znN+PgUWWz1u/gOqK1XfmPayal3nP/c4v
D3EYs+vIa4zOUsNI7g7Mn/KUG6z7kpMFsCKLzWWuInPsdFzKX3tE+xo907y8vlVX
vympegUH07yJlISmuaTfKi2r2AmGOJEXq6nh1L4mIkHRVconV0GcU+Q33OT546Mq
putACagRBiMVZtgw3+Fppx1fb9SvfA==
=mlka
-----END PGP SIGNATURE-----

--AFQGHouA0VN8Ovbt--

--===============0508861305249481839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0508861305249481839==--
