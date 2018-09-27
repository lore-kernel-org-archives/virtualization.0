From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net V2] vhost-vsock: fix use after free
Date: Thu, 27 Sep 2018 16:33:21 +0100
Message-ID: <20180927153321.GB10133@stefanha-x1.localdomain>
References: <20180927122204.4188-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3382227332270914202=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180927122204.4188-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, sergei.shtylyov@cogentembedded.com, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============3382227332270914202==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 08:22:04PM +0800, Jason Wang wrote:
> The access of vsock is not protected by vhost_vsock_lock. This may
> lead to use after free since vhost_vsock_dev_release() may free the
> pointer at the same time.
>=20
> Fix this by holding the lock during the access.
>=20
> Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
> Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> - V2: fix typos
> - The patch is needed for -stable.
> ---
>  drivers/vhost/vsock.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Thank you, Jason!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbrPhBAAoJEJykq7OBq3PI4+YH/iTCwaaWk6eiQLX6SQFLM1S5
dtkS+0+ja7FhmKnTwHQYN+tB025xfmFwtDhSEb+F582co7ggqflOhNUdh3t8Ehel
SNkeDGEeolpB1IX5evuvbnZuFpAjPhMqBIUqnoxIoJNAyYo6fMbQkdfyBXnqDsnH
c5oS9yz5OvUzu4IhR/KYqKtljwZNUcniitMKYNN1+LpH7g0QzLpeAs3FADVtoNUB
HEAFFhvOa7k+7EFJfw7FgccC5zWsDSVyoVtdxtFK2BPujrW3JfFLRWKQgrUKhY2u
TKVp0htYP4qG2YXbBPjbbC8OUrILllvtxENF2mgZZXvDE3lIZw9Vl8b5+WVVrlo=
=wXAN
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

--===============3382227332270914202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3382227332270914202==--
