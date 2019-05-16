From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/8] vsock/virtio: free packets during the socket
	release
Date: Thu, 16 May 2019 16:32:18 +0100
Message-ID: <20190516153218.GC29808__40345.5470733874$1558020753$gmane$org@stefanha-x1.localdomain>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-3-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1829386865257363735=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190510125843.95587-3-sgarzare@redhat.com>
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


--===============1829386865257363735==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 02:58:37PM +0200, Stefano Garzarella wrote:
> When the socket is released, we should free all packets
> queued in the per-socket list in order to avoid a memory
> leak.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Ouch, this would be nice as a separate patch that can be merged right
away (with s/virtio_vsock_buf/virtio_vsock_pkt/).

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzdgoIACgkQnKSrs4Gr
c8inUgf/ZWWrRlkmdo0umzZLZb20m5kj29mccKVqTXumpuuP4uj0fUgYDiHaO2Nw
RzI9h1D2ZxH0eu8lymsu9LScLZ+x/WoZh36H7BDqAJCqvo3/t3mKQVRj8h+x2Pqg
nhlAE54DTQLjeNBahCiZSNHDx2znDN7XQhTGD4LlEJr4Fo5wxNkflX2aPUtwjH2P
dQFDh2kXCqneuo2QQ/GPpYAufMXA4+n2YNsLKPqV3XtJP26a14tbdhbqaGOnOV4q
J9tOGaC8xukkX331J0Pqo0lPRLwqgeJEYTbjsjfUHcw8OP9Fcsy+/tDZMALSTc1P
4gMCqmXG6V/yfH6zkt7xipW8qhpmsQ==
=htot
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

--===============1829386865257363735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1829386865257363735==--
