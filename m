From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 3/5] vsock/virtio: fix locking in
	virtio_transport_inc_tx_pkt()
Date: Mon, 22 Jul 2019 09:53:19 +0100
Message-ID: <20190722085319.GC24934__38946.8007067748$1563785633$gmane$org@stefanha-x1.localdomain>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-4-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8321079117283513658=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717113030.163499-4-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============8321079117283513658==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 01:30:28PM +0200, Stefano Garzarella wrote:
> fwd_cnt and last_fwd_cnt are protected by rx_lock, so we should use
> the same spinlock also if we are in the TX path.
>=20
> Move also buf_alloc under the same lock.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/virtio_vsock.h            | 2 +-
>  net/vmw_vsock/virtio_transport_common.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01eX8ACgkQnKSrs4Gr
c8jE7AgAs5N6O7elzpZi4u/g75m8dfsiRpiyEG+NXL6ahFUWKw98b80S/q2RNHZR
udZDGbmyVjnwH1pok2YnjdwcqCq515JelqAdv7CdhhzzRZdwiHGMQh8uqHYDfzGZ
R2V0hSJAiSG21HxP+RBG6VoWCoBUeQU/vce3jkYsxT6F64tUqeqxJd/C+AcRHOKk
dxxTmtn2NdRRs6Hofl5nW0ulYG/wxRRtN3dTf+V/FKkXLYv1197AD0+JXZnTRw2s
159FbLvqqdFzBGt2HORUTR+7aTcBuILeDuLW8gJT6JrFF2MIw1B0VaSB0Lbv0mN6
tuZAmnZlcurH5zz8i5XOJ5mugHY72w==
=VeGT
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--

--===============8321079117283513658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8321079117283513658==--
