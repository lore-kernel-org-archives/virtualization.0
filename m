From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 02/18] virtiofs: Check whether hiprio queue is connected
	at submission time
Date: Fri, 6 Sep 2019 11:43:29 +0100
Message-ID: <20190906104329.GJ5900__41236.1680924491$1567766627$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-3-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1332926292641024707=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-3-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============1332926292641024707==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:43PM -0400, Vivek Goyal wrote:
> For hiprio queue (forget requests), we are keeping a state in queue wheth=
er
> queue is connected or not. If queue is not connected, do not try to submit
> request and return error instead.
>=20
> As of now, we are checking for this state only in path where worker tries
> to submit forget after first attempt failed. Check this state even in
> the path when request is being submitted first time.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOFEACgkQnKSrs4Gr
c8hhnwf8C1VOQGWJHHILCVCJLNrPVQsE6GduEOaYKWu+DWRzDGKRdA6vZkRi4Pm4
M2fEi34e41LhBT3A++2Qlom33KMRqy9E9OtEkPvwJcL5NJIzoaxmfAVfuHHSTlsL
zkfGOJeruqBsGl1LzEZkJ/3BSEGv/LP45bONl4uJC5f1ebV5HWleV8dZ92nenXZ7
UQDVXLNqiwX8V1Xq3xv21CSKwgq/XakX/fu0kuLmtTJhExLjgQOeiLb6qOJ/QeUO
wV5cFWUKMZv6xSro34316GVjuRvAh9H5B4g1IXiDlQ9nel6/anE1zcTWiDAoP5Pg
boT9ocfdxNM33hESs2aomGPnPOCbzg==
=HWp9
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--

--===============1332926292641024707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1332926292641024707==--
