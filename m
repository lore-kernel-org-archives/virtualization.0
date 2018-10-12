From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'VIRTIO AND VHOST VSOCK DRIVER'
Date: Fri, 12 Oct 2018 16:46:44 +0100
Message-ID: <20181012154644.GM24267__5772.42696094817$1539361596$gmane$org@stefanha-x1.localdomain>
References: <20180928220527.32038-1-joe@perches.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6521532330051000735=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180928220527.32038-1-joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============6521532330051000735==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ICrdrp3pM9DyZLTK"
Content-Disposition: inline


--ICrdrp3pM9DyZLTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 03:05:26PM -0700, Joe Perches wrote:
> Please fix this defect appropriately.
>=20
> linux-next MAINTAINERS section:
>=20
> 	15660	VIRTIO AND VHOST VSOCK DRIVER
> 	15661	M:	Stefan Hajnoczi <stefanha@redhat.com>
> 	15662	L:	kvm@vger.kernel.org
> 	15663	L:	virtualization@lists.linux-foundation.org
> 	15664	L:	netdev@vger.kernel.org
> 	15665	S:	Maintained
> 	15666	F:	include/linux/virtio_vsock.h
> 	15667	F:	include/uapi/linux/virtio_vsock.h
> 	15668	F:	include/uapi/linux/vsockmon.h
> 	15669	F:	include/uapi/linux/vm_sockets_diag.h
> 	15670	F:	net/vmw_vsock/diag.c
> 	15671	F:	net/vmw_vsock/af_vsock_tap.c
> 	15672	F:	net/vmw_vsock/virtio_transport_common.c
> 	15673	F:	net/vmw_vsock/virtio_transport.c
> 	15674	F:	drivers/net/vsockmon.c
> 	15675	F:	drivers/vhost/vsock.c
> -->	15676	F:	drivers/vhost/vsock.h

Hi Joe,
Thanks for pointing this out and sorry for the late response.  I have
sent a patch.

Stefan

--ICrdrp3pM9DyZLTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbwMHkAAoJEJykq7OBq3PIdksIAKUz2BUlUnQ3YnlTgD2wZn0i
veEMPWYwfS3SlO16zUiW/gd+9iPXxtLK2her0WbpMrLWsNO151ha0YotNjV3RR3O
WImt57CO3RC9SA5B7J2KmsXwwgZZpRGvefcOe0PsaAU0SBIZ/m4aXScJJ3elNLSP
HguzrrdJFVA91kRnbq5kolpia05hr39LcrrBztEhFESdZrUdEtm63nlDlpJ+592O
KU163lV8YoWBI795p4NaABxvpExJe2K4Woytk9FnIUGWs+efN+TU2bO2UBnaw3ud
b8YfMpA+Oh+1PYY1gD8zwINxyzzhscXXZkThOBqlk3tWoFiQxE8AD0STARljg58=
=eJpJ
-----END PGP SIGNATURE-----

--ICrdrp3pM9DyZLTK--

--===============6521532330051000735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6521532330051000735==--
