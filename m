From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 14/20] s390x/virtio-ccw: enable virtio 1.0
Date: Tue, 20 Jan 2015 11:15:55 +0000
Message-ID: <20150120111555.GL17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-15-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6934567409541383579=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-15-git-send-email-cornelia.huck@de.ibm.com>
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


--===============6934567409541383579==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTUhhhdwRI43FzeR"
Content-Disposition: inline


--vTUhhhdwRI43FzeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:16PM +0100, Cornelia Huck wrote:
> virtio-ccw should now have everything in place to operate virtio 1.0
> devices, so let's enable revision 1.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/virtio-ccw.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--vTUhhhdwRI43FzeR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvjjrAAoJEJykq7OBq3PIuO4IAJ2cadZX9N0/Pnrb2gAr7CwK
9cZIHs32OFR7+LRE0VP+wFvgRxSfqWV12dAuSDHBYQPOArWIlHXH7WFXhVv76B+Z
spb8Vupzm+Te8Rk7IlVq4b1J+JnngxQoH6EK+SkOqM4IUjslZu8Y27+fi3tsi0K9
/xh0PLW4m+VLU2k1Jx4UxV265+CRDI3jQ7euql5aIVaodk9Y8QtrfCCCr8fS6BlW
Nx68TfVBiFPOs8DbAlVOrcdGN2Ui9VmWZPP1jvfUwsq7SUbRghmYUy/1BewuV/Dt
6PjYRYVQEnJAYCzw+RiOinOdqTOJGd6sfPMGgy5ddJhbVHEGvzbDyPGVaCzOupg=
=ON/X
-----END PGP SIGNATURE-----

--vTUhhhdwRI43FzeR--

--===============6934567409541383579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6934567409541383579==--
