From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 08/13] vsock: move vsock_insert_unbound() in the
	vsock_create()
Date: Wed, 9 Oct 2019 13:34:23 +0100
Message-ID: <20191009123423.GI5747__22477.9371799499$1570624478$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-9-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5868878294701454401=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-9-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============5868878294701454401==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Content-Disposition: inline


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:58PM +0200, Stefano Garzarella wrote:
> vsock_insert_unbound() was called only when 'sock' parameter of
> __vsock_create() was not null. This only happened when
> __vsock_create() was called by vsock_create().
>=20
> In order to simplify the multi-transports support, this patch
> moves vsock_insert_unbound() at the end of vsock_create().
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Maybe transports shouldn't call __vsock_create() directly.  They always
pass NULL as the parent socket, so we could have a more specific
function that transports call without a parent sock argument.  This
would eliminate any concern over moving vsock_insert_unbound() out of
this function.  In any case, I've checked the code and this patch is
correct.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d088ACgkQnKSrs4Gr
c8jGUgf/flGT/To2png0jPgQV5oe1jDDk+0D39ubcCGjdMLuOwLdwey4BUbOWK3I
KFEzw7U6CmXNnW15vqqckacUNgL6OXgHKrOxKpiwYvonz2/C0JNLMaTIbsSfcR8u
sXWnnoihq8NTRIJhSxHFaWgqBLWFW8G3sAfFA2oCIiNI8HQhewIy0Sfh2vfuyypU
SjCHAwlodeIMuEmeIlTUEd4RKWqZ3dDAOs5xnl87OWUdzTtgmKEccQLZSvJ/t2Qi
QVVO07S3r7ASe2bpjmTgQuV1ZZ3iz/jyFOYAD3WmE6D6a+afcU+4gUTa9Tbu1TL4
en7c7jB5XF98CqjwO5kjMLozykqVWg==
=Fgki
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--

--===============5868878294701454401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5868878294701454401==--
