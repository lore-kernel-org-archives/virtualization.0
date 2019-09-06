From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 17/18] virtiofs: Remove TODO to quiesce/end_requests
Date: Fri, 6 Sep 2019 13:06:37 +0100
Message-ID: <20190906120637.GY5900__36704.204783176$1567771613$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-18-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6644181476154957324=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-18-vgoyal@redhat.com>
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


--===============6644181476154957324==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lYVfafuUkPqz/tKz"
Content-Disposition: inline


--lYVfafuUkPqz/tKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:58PM -0400, Vivek Goyal wrote:
> We now stop queues and drain all the pending requests from all virtqueues.
> So this is not a TODO anymore.
>=20
> Got rid of incrementing fc->dev_count as well. It did not seem meaningful
> for virtio_fs.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lYVfafuUkPqz/tKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yS80ACgkQnKSrs4Gr
c8iYtAf+M+W93KWyYjt/Ozu/X8KfP7/va+YH3UjLCSvUxvX5CnMw8go9WAGz79SW
h3CwH86zMiiBVTqVtUcV6HyxuDRdKDSLC123iMP5ydQGJYa63zkdGpbq8Xnc3kFB
vQdt2JHMqvByjMdtgAzOSdVYb5kslR6VxFrH8xd+fd7x6gKvp4dNE1lDfuI5iUHN
vS3OQ2IcSBv1TpPGTRrUhDEcz7N5ebnh5/JQvDbyPbmspchYS+PUvFofzLAQ61Pl
2gKkBnoYAnpHQJwXaFq7aTp/48t2BIsX9j6WrXeK2PjkV2Xa24O1M7jM995KwK+n
lHQUmHQMYTsl27X2YQeHusZ4XB1Gdw==
=LskU
-----END PGP SIGNATURE-----

--lYVfafuUkPqz/tKz--

--===============6644181476154957324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6644181476154957324==--
