From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 01/13] vsock/vmci: remove unused
	VSOCK_DEFAULT_CONNECT_TIMEOUT
Date: Wed, 9 Oct 2019 12:41:33 +0100
Message-ID: <20191009114133.GB5747__47299.1518605099$1570621312$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0956305686709165686=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-2-sgarzare@redhat.com>
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


--===============0956305686709165686==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:26:51PM +0200, Stefano Garzarella wrote:
> The VSOCK_DEFAULT_CONNECT_TIMEOUT definition was introduced with
> commit d021c344051af ("VSOCK: Introduce VM Sockets"), but it is
> never used in the net/vmw_vsock/vmci_transport.c.
>=20
> VSOCK_DEFAULT_CONNECT_TIMEOUT is used and defined in
> net/vmw_vsock/af_vsock.c
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/vmci_transport.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dx20ACgkQnKSrs4Gr
c8hIqAgAvhL+0GDmzG+IqoyqU4u4zMGfhwqu1Tuctdk+5o6AtyHB9jF8qW0lxKfG
m9BlFbKLMcxjmiirqBXOj24o7GMoko98x8mhqBxofFG0/WTAEqe80ibGyAR8f5/t
jNyonyKpw3UU9kuYwlQBDZoCjh6ZAOofpmKrtCbE63GntiCzX3waJ5mlK/5Dqtcy
l7Ol7BjACIKs7gG7i9kF/TtFcU93EcjC8OJuqJ/1bx0y38wMEfCnlpwBkvh2/hQo
K2Lv1qJHosKW+CqXelAYdeT1YWXmAiE2AYfNTPFzVdStra5QV+O3UDGr536IHmDD
Y7Mo+oe8VRerZV4xgiCKHY+E7FUw/A==
=dBuq
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============0956305686709165686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0956305686709165686==--
