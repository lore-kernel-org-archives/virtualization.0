From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 04/18] virtiofs: Check connected state for VQ_REQUEST
	queue as well
Date: Fri, 6 Sep 2019 11:45:49 +0100
Message-ID: <20190906104549.GL5900__28591.4529742271$1567766769$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-5-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5710068701374602317=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-5-vgoyal@redhat.com>
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


--===============5710068701374602317==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L/Qt9NZ8t00Dhfad"
Content-Disposition: inline


--L/Qt9NZ8t00Dhfad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:45PM -0400, Vivek Goyal wrote:
> Right now we are checking ->connected state only for VQ_HIPRIO. Now we wa=
nt
> to make use of this method for all queues. So check it for VQ_REQUEST as
> well.
>=20
> This will be helpful if device has been removed and virtqueue is gone. In
> that case ->connected will be false and request can't be submitted anymore
> and user space will see error -ENOTCONN.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--L/Qt9NZ8t00Dhfad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yONwACgkQnKSrs4Gr
c8hiJQf/RcdMwTruxvR/8Bl1CjfN+mUt21UCtv0K/otHklhGEdna7AzGT1QFFBqi
iyQUlYckbqC72mhKLNOWT/I8JJkq3jUS+xUf2i/qzNv/4B3yVfCFazfumOIcb7P+
XriTd61VYMSaPfJRPXLvn+oxLknVB9LohRBQHZc0ljt339uGCt9YBlc38G2/XRud
PT41SRg8rwBjDyfqx3OVTzL7kgxdXaM5ZbUJo24/To3ZQdmzO/QWWDJqUCGi0kCQ
r5x6rkMUjd9gZCIUcgio7ourUi3+gfQA+sIQHU3FUH+UCyL7+nM5XM61n7t80BpH
P8ACIKgUO0IDNTm9uaTHnuUTZAUrrw==
=+Vva
-----END PGP SIGNATURE-----

--L/Qt9NZ8t00Dhfad--

--===============5710068701374602317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5710068701374602317==--
