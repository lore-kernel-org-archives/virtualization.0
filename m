From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 06/20] virtio: endianness checks for virtio 1.0
	devices
Date: Tue, 20 Jan 2015 10:29:36 +0000
Message-ID: <20150120102936.GE17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-7-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9085001427517258032=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-7-git-send-email-cornelia.huck@de.ibm.com>
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


--===============9085001427517258032==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 02:25:08PM +0100, Cornelia Huck wrote:
> Add code that checks for the VERSION_1 feature bit in order to make
> decisions about the device's endianness. This allows us to support
> transitional devices.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/virtio/virtio.c                |    6 +++++-
>  include/hw/virtio/virtio-access.h |    4 ++++
>  include/hw/virtio/virtio.h        |    8 ++++++--
>  3 files changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvi4QAAoJEJykq7OBq3PIr3sIALLQ3jbtwstqpuPwthP71iES
GJD5gikU7eIkQyTwOfeawRPhdaYz2ZgMH7cwtjIwrDpAxbfyegL61jfRj5TqCn4O
iO4PXVS9Tf7qA0kNSk3WZCzeHBuXxb37vnWxdLEF/LuwcbR2VnQTJsXBFACCqqiJ
APAkeVRiCZLBX3/Pih5vuyKOE8/LXPGt8gb958+7GjojpklImQElf87jHEnoXmHM
j99jf3zKeG0kfr84E/OTeMS+ONS1k7XLCMMBZwijYizkgAxpL5sn1tKhicZdm75I
VCHg8O0nmAKYMeZGrs+FphhRFoYiNyC03wUDNsSx/l5aQwPXR3JAcQ2uron02d0=
=41ob
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

--===============9085001427517258032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9085001427517258032==--
