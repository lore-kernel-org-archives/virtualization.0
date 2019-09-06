From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 11/18] virtiofs: stop and drain queues after sending
	DESTROY
Date: Fri, 6 Sep 2019 12:50:26 +0100
Message-ID: <20190906115026.GS5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-12-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7346664300694486098=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-12-vgoyal@redhat.com>
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


--===============7346664300694486098==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zn93sY2JrH9m7VZ"
Content-Disposition: inline


--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:52PM -0400, Vivek Goyal wrote:
> During virtio_kill_sb() we first stop forget queue and drain it and then
> call fuse_kill_sb_anon(). This will result in sending DESTROY request to
> fuse server. Once finished, stop all the queues and drain one more time
> just to be sure and then free up the devices.
>=20
> Given drain queues will call flush_work() on various workers, remove this
> logic from virtio_free_devs().
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6zn93sY2JrH9m7VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySAIACgkQnKSrs4Gr
c8hPCggAqxxAtpxUlxuyJ1JMZVearCJpL7Y98Ts25vXNZJKaGv/Z7w+0b1YNHE04
RuXVOEqhwAG5VKOIpPYs+SJwTEwWTgsHEdAgtprbwW+v/vrOlf3LEaC9QS7+Z6bZ
altTVdvWHQiqulsObNYVrgm/alLh75y8skYmwHHAK0EtbLoOwBnwzYNHyuOsH7tk
YdpXmipXCBBtjQrC9rWXSt0ug0xCm29uK/voTea5mrDVFTpTixcKJ2LM6jnT6r4v
mXBtZwegQNYew2LLapEqG+GNE2SSbMD765Z/MFyR48cksq/5mEbCOavSmN8S1HfH
zelxUzsGNaQAsRXvt+wUI8Y94D+aoQ==
=OYfd
-----END PGP SIGNATURE-----

--6zn93sY2JrH9m7VZ--

--===============7346664300694486098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7346664300694486098==--
