From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio_blk: fix incorrect message when disk is resized
Date: Fri, 4 Aug 2017 10:37:54 +0100
Message-ID: <20170804093754.GA9867__42090.0800418623$1501839488$gmane$org@stefanha-x1.localdomain>
References: <20170726143223.2769-1-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5213003009616028272=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170726143223.2769-1-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============5213003009616028272==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 03:32:23PM +0100, Stefan Hajnoczi wrote:
> The message printed on disk resize is incorrect.  The following is
> printed when resizing to 2 GiB:
>=20
>   $ truncate -s 1G test.img
>   $ qemu -device virtio-blk-pci,logical_block_size=3D4096,...
>   (qemu) block_resize drive1 2G
>=20
>   virtio_blk virtio0: new size: 4194304 4096-byte logical blocks (17.2 GB=
/16.0 GiB)
>=20
> The virtio_blk capacity config field is in 512-byte sector units
> regardless of logical_block_size as per the VIRTIO specification.
> Therefore the message should read:
>=20
>   virtio_blk virtio0: new size: 524288 4096-byte logical blocks (2.15 GB/=
2.0 GiB)
>=20
> Note that this only affects the printed message.  Thankfully the actual
> block device has the correct size because the block layer expects
> capacity in sectors.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Ping?

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4e02aa5fdac0..69a2d1748743 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -381,6 +381,7 @@ static void virtblk_config_changed_work(struct work_s=
truct *work)
>  	struct request_queue *q =3D vblk->disk->queue;
>  	char cap_str_2[10], cap_str_10[10];
>  	char *envp[] =3D { "RESIZE=3D1", NULL };
> +	unsigned long long nblocks;
>  	u64 capacity;
> =20
>  	/* Host must always specify the capacity. */
> @@ -393,16 +394,19 @@ static void virtblk_config_changed_work(struct work=
_struct *work)
>  		capacity =3D (sector_t)-1;
>  	}
> =20
> -	string_get_size(capacity, queue_logical_block_size(q),
> +	nblocks =3D DIV_ROUND_UP_ULL(capacity, queue_logical_block_size(q) >> 9=
);
> +
> +	string_get_size(nblocks, queue_logical_block_size(q),
>  			STRING_UNITS_2, cap_str_2, sizeof(cap_str_2));
> -	string_get_size(capacity, queue_logical_block_size(q),
> +	string_get_size(nblocks, queue_logical_block_size(q),
>  			STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
> =20
>  	dev_notice(&vdev->dev,
> -		  "new size: %llu %d-byte logical blocks (%s/%s)\n",
> -		  (unsigned long long)capacity,
> -		  queue_logical_block_size(q),
> -		  cap_str_10, cap_str_2);
> +		   "new size: %llu %d-byte logical blocks (%s/%s)\n",
> +		   nblocks,
> +		   queue_logical_block_size(q),
> +		   cap_str_10,
> +		   cap_str_2);
> =20
>  	set_capacity(vblk->disk, capacity);
>  	revalidate_disk(vblk->disk);
> --=20
> 2.13.3
>=20

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZhEByAAoJEJykq7OBq3PI9KQH/1OWO6sx6Htr4P7BG9KT++TA
DzDeVxmPS656kwLZ+0D109mRxZTuhxMe2jkUFRmgdiVqUwn3HXqeLRWOwQIOUQYZ
9yKfQiHSOGpI8/IlYWh/cBGaiZClqvZAUYxTqJ23oKzZ1JEh94F6MusuAVzmBy1x
tAq376OroVbLGe0DUf65+4oMaiTPAUe4szKTezwJmy3RvcnSbXEIG2neZ8YOfhIC
MpZyk2Re08n44Zfei7+Xp7tNZBzlAB/YYnZ8VQ3j6CdqhshKqTuM+bsWe7JsTUYg
AnJLwO8mdldRA6qt4yJVEFUW/PG3zm+daYHI4XqOf977/P0FdlegZ7g79gHMZEo=
=eZIg
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--===============5213003009616028272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5213003009616028272==--
