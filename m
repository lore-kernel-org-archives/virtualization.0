From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 13/13] vsock: fix bind() behaviour taking care of CID
Date: Wed, 9 Oct 2019 14:29:19 +0100
Message-ID: <20191009132919.GN5747__15008.9582124323$1570627773$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-14-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3364202245680554682=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-14-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============3364202245680554682==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cs5saTBZh7UZl2eX"
Content-Disposition: inline


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:27:03PM +0200, Stefano Garzarella wrote:
> When we are looking for a socket bound to a specific address,
> we also have to take into account the CID.
>=20
> This patch is useful with multi-transports support because it
> allows the binding of the same port with different CID, and
> it prevents a connection to a wrong socket bound to the same
> port, but with different CID.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d4K8ACgkQnKSrs4Gr
c8jIHQgArLXLyHXwZu55EHHu9yiNNFHasNE5dRT3AdGHmJvK/neRvEFmuyQ2w9Xr
Ap1yzIgihhRbUNxJaiyxXeuB1KwSQmWUSs15m027eetOieQFnnPZodUYF1PVRloj
+2ol43xqmHW4vOlqdXbTrl6Ggr97gSNylVBDC5naNbR/r7/md1MYEmkpRTGHlUFe
IPQ5Ip2z8hWKLnK70fs1yYKmj8Tbb+pZBDN68i3iC5+98SzrvY9Tix1SfeQwVSn+
HKXhugUiYvtl2VwaqSEud28/3Hqcxe3wnfZcYXFJkPhj5p0/gprCBUeLUfP4jwlz
b42+Ttg66N+HW7vXgrTesK83l3PpJA==
=f3oL
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--

--===============3364202245680554682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3364202245680554682==--
