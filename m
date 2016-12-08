From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] vhost-vsock: fix orphan connection reset
Date: Thu, 8 Dec 2016 09:19:33 +0000
Message-ID: <20161208091933.GA10780__17320.0358789929$1481195859$gmane$org@stefanha-x1.localdomain>
References: <1481103947-76771-1-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5285753329070152789=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481103947-76771-1-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peng Tao <bergwolf@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5285753329070152789==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 05:45:47PM +0800, Peng Tao wrote:
> local_addr.svm_cid is host cid. We should check guest cid instead,
> which is remote_addr.svm_cid.
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: stable@vger.kernel.org #4.8+
> Signed-off-by: Peng Tao <bergwolf@gmail.com>
> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYSSWkAAoJEJykq7OBq3PI0rsH+wcuZhkfOgsQeZ/7sFHdqM4d
jeBW9nE4zWbihMIfospEg+5dZbLVRLq+mZfls99gyhqezNFNwbNnIPzAjFG5IEbA
E8a7ueMXV47VMafiusGiGFnUlHAjTFZOSthVY4S1V7fBZg6Fm6zQpLDZRKAk/0bN
Oi7HAhmGFxPL83OG42MiJaWivxm+ce/t9UiCZDDx6hG9oyQ2F0Y5mq5EZosCWtfX
FJcYANumA/guHZGzuerOTPPpcwLHO7LJMisw3ypMrOWLnDri2ReexfnVd49HXRBL
FkBlXKk1YCjd5wvl6gom8k1LKWTV0BmWYJgowJrYN1EcXtEEWukk+ltKqV03MQo=
=jmP8
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--===============5285753329070152789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5285753329070152789==--
