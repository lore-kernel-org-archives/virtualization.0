From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 15/20] virtio-net: no writeable mac for virtio-1
Date: Tue, 20 Jan 2015 11:19:47 +0000
Message-ID: <20150120111947.GM17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-16-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8031126193673001618=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-16-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============8031126193673001618==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="egxrhndXibJAPJ54"
Content-Disposition: inline


--egxrhndXibJAPJ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:17PM +0100, Cornelia Huck wrote:
> Devices operating as virtio 1.0 may not allow writes to the mac
> address in config space.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/net/virtio-net.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index d6d1b98..ebbea60 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -87,6 +87,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, c=
onst uint8_t *config)
>      memcpy(&netcfg, config, n->config_size);
> =20
>      if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&

I don't see VIRTIO_NET_F_CTRL_MAC_ADDR (23) in the VIRTIO 1.0 "5.1.3.1
Legacy Interface: Feature bits" section.  Should it be there just so
people don't try to reuse bit 23 in the future?

The patch itself:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--egxrhndXibJAPJ54
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvjnTAAoJEJykq7OBq3PIshIH/ic6QXaZC11YR2cb0ygQONP2
kgtA3XPwULDkJIQqkuwGWaM/zd+e673L6p2J48gwsGXkJfH/9gfqeemn0JnkD0gu
IgY7v+7eWis36ERbOmeS55cExvk9EOPRj9OQa02ddwQpXFmSr1PvIYMByVkwu8Dj
U/yZ6tVhifW2jlX4tdbAtK3VBYAD4V4njdrRrNMBV8mF162Q/EBJ/YY9/D9LuzPG
hBQlVQOh7Lz2RrvJlRM96oAqT4cqZu+uwpnsLyUaMN8LSImDFaMLzPaHqEZEu6Sj
tCQ4/GgS/inXfua6rMiqoh7AZ8B9rHHUVOPgidRGW0u4EYD0PuDGC85A4U17CQY=
=GoiV
-----END PGP SIGNATURE-----

--egxrhndXibJAPJ54--

--===============8031126193673001618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8031126193673001618==--
