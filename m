From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 16/20] virtio-net: support longer header
Date: Tue, 20 Jan 2015 13:18:14 +0000
Message-ID: <20150120131814.GN17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-17-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4480258781331319343=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-17-git-send-email-cornelia.huck@de.ibm.com>
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


--===============4480258781331319343==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WeDu0lr7bteb/II5"
Content-Disposition: inline


--WeDu0lr7bteb/II5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:18PM +0100, Cornelia Huck wrote:
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ebbea60..7ee2bd6 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -373,15 +373,21 @@ static int peer_has_ufo(VirtIONet *n)
>      return n->has_ufo;
>  }
> =20
> -static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bu=
fs)
> +static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bu=
fs,
> +                                       int version_1)

Please use bool, it makes it 100% clear what the meaning of "version_1"
is.

s/int/bool/

--WeDu0lr7bteb/II5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvlWWAAoJEJykq7OBq3PIGCkIAKC+xXe71e3QQKzFpyuADXsV
0/swDG95FPkgI094wpj21y8AYYm6x2QiZOnnRph+c0rzxrt4n+SK8d9/0fzBJhCa
T9waiWC3MDFkONAceOO2oUMMV00dWjbebpyuDu3/izKshWzKNJ4vP6tdaJZODQLq
W4263o6BF3fe+7vGpofcS0tCDhBiDJRb+k+0vLp0vePeKVDC9IZ/G4gdf/rfa1g2
wLp9d2GLCq21RWYW+Bo7BokyrhR/MMtzuttZs3gZQ00Bk4jAz3ufZHNkYQp1BjzH
mlNi9C1Vw6V8tadrBTO514HsMCrRVb0s/q+GQZMCGh6E8FPK9hIekWOiADGORVs=
=dv3x
-----END PGP SIGNATURE-----

--WeDu0lr7bteb/II5--

--===============4480258781331319343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4480258781331319343==--
