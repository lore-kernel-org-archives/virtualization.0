From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 03/13] vsock: remove include/linux/vm_sockets.h file
Date: Wed, 9 Oct 2019 12:43:11 +0100
Message-ID: <20191009114311.GD5747__37444.1330599197$1570621406$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-4-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3212301308155736846=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-4-sgarzare@redhat.com>
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


--===============3212301308155736846==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:53PM +0200, Stefano Garzarella wrote:
> This header file now only includes the "uapi/linux/vm_sockets.h".
> We can include directly it when needed.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/vm_sockets.h            | 13 -------------
>  include/net/af_vsock.h                |  2 +-
>  include/net/vsock_addr.h              |  2 +-
>  net/vmw_vsock/vmci_transport_notify.h |  1 -
>  4 files changed, 2 insertions(+), 16 deletions(-)
>  delete mode 100644 include/linux/vm_sockets.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dx88ACgkQnKSrs4Gr
c8g54wf+PL7xAZ3eI74ytwJozmNe/9DWAw5l7bnOPC5lh3yi3O6H/afVtuNy65xz
NYAwGHyFqaMtLm4reJeETuun6duQ7+ZKHr8NJHdUkQJFCQIfHJLI7JXfjDD2VSbp
xn9tbLC2eFnCvlnT7Ke8Er9e1KOI2IBGggkOVvn4HbowDVF8/aeCh0aoPt6bYBVf
FXFaWL0WeGoaalzf14LEf3uDMQptQaMFfcXudbWsv4Xfdmtu9EULADXwa2o4rNVx
1c7Iiu7NOXS7jiD/2NzveQvH0lxrPvUQtgNth9abPF1XA+6yJev9DrLnlYTKCn5q
rmIv4DoNGcc8wrcQ6ZB+Quid23UtAg==
=13TI
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--

--===============3212301308155736846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3212301308155736846==--
