From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next 4/4] mlx4: sizeof style usage
Date: Tue, 15 Aug 2017 21:13:24 +0300
Message-ID: <20170815181324.GA24282__45571.9290803701$1509079179$gmane$org@mtr-leonro.local>
References: <20170815172919.26153-1-sthemmin@microsoft.com>
	<20170815172919.26153-5-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1242186647031042780=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170815172919.26153-5-sthemmin@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, mst@redhat.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mlindner@marvell.com
List-Id: virtualization@lists.linuxfoundation.org


--===============1242186647031042780==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6AFz5yWxU/FsGPwt"
Content-Disposition: inline


--6AFz5yWxU/FsGPwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2017 at 10:29:19AM -0700, Stephen Hemminger wrote:
> The kernel coding style is to treat sizeof as a function
> (ie. with parenthesis) not as an operator.
>
> Also use kcalloc and kmalloc_array
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/alloc.c         |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/cmd.c           |  4 ++--
>  drivers/net/ethernet/mellanox/mlx4/en_resources.c  |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c         |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/eq.c            | 20 +++++++++---------
>  drivers/net/ethernet/mellanox/mlx4/fw.c            |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/icm.c           |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/icm.h           |  4 ++--
>  drivers/net/ethernet/mellanox/mlx4/intf.c          |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/main.c          | 12 +++++------
>  drivers/net/ethernet/mellanox/mlx4/mcg.c           | 12 +++++------
>  drivers/net/ethernet/mellanox/mlx4/mr.c            | 10 ++++-----
>  drivers/net/ethernet/mellanox/mlx4/qp.c            | 12 +++++------
>  .../net/ethernet/mellanox/mlx4/resource_tracker.c  | 24 +++++++++++-----------
>  15 files changed, 56 insertions(+), 56 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--6AFz5yWxU/FsGPwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlmTOcQACgkQ5GN7iDZy
WKcUkxAAz34nMe12aEOReWgbjD5GC6MemcYdOgD3OhleoL0z119szmT/SkmH1h0b
gsImVbDMXD2ejKmGRRDf8GeuKPhK5NfXuEHrkH4o7mNIvvyO6gkPlIoX0VVCzqEK
/obxjH8szbtITVVwoHJMvusJUM7uHD0/ueoUJONbFoDsXG8zlVUnIouMA+rPJl0Q
pSLTR02Aw5kKqntEN+uGRWjwOIUDpoDrLi+0HPY6LqLeWGUqiO6qA+fBIF4Pa4SZ
Ms2okJkomotNGpJ2Uda4NU2P3mWWp2KVQTqcwjHTY1f9bBnx+gOAvUZiJRglFk0N
vFmjQqqCwz0kv1mYFt6uh9ayLhFmtbq124bYfOA1jEoeMhDwaPQ6kv6uYgwpjalE
y1WqkZVrN8JSDAQfE6n6LDPIQ5IBP6P0f4gD0UXMxWkX/i91Noe7eYe2gYLqo71Z
CtRiMQ+Ubtwk4oWPlv59XYdB6Y1fOfNUePcEMAKbZ68MWenlFxKFErgV/Z7MFvy5
Yv8uadwjwmZ3CJ2rLCSMmp3wWZ0TsDhHkSGs5TEF8HCQgl2qKOgHUFNyTQ//Ur8I
Y5dpdMJ5VxlxF/07RUMSOXORPxDYVlMreTuL72ywes5oqRd6yOvfqj0QiR2rd5a7
VxfGbNNoC7pyegRzZ7Q7aLExICCHO3VelrVsN7zXUBX0X3PGGvU=
=SFz8
-----END PGP SIGNATURE-----

--6AFz5yWxU/FsGPwt--

--===============1242186647031042780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1242186647031042780==--
