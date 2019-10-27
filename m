From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net-next 00/14] vsock: add multi-transports support
Date: Sun, 27 Oct 2019 09:01:46 +0100
Message-ID: <20191027080146.GA4472@stefanha-x1.localdomain>
References: <20191023095554.11340-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7542246376614576319=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-1-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7542246376614576319==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 11:55:40AM +0200, Stefano Garzarella wrote:
> This series adds the multi-transports support to vsock, following
> this proposal: https://www.spinics.net/lists/netdev/msg575792.html
>=20
> With the multi-transports support, we can use VSOCK with nested VMs
> (using also different hypervisors) loading both guest->host and
> host->guest transports at the same time.
> Before this series, vmci-transport supported this behavior but only
> using VMware hypervisor on L0, L1, etc.
>=20
> RFC: https://patchwork.ozlabs.org/cover/1168442/
> RFC -> v1:
> - Added R-b/A-b from Dexuan and Stefan
> - Fixed comments and typos in several patches (Stefan)
> - Patch 7: changed .notify_buffer_size return to void (Stefan)
> - Added patch 8 to simplify the API exposed to the transports (Stefan)
> - Patch 11:
>   + documented VSOCK_TRANSPORT_F_* flags (Stefan)
>   + fixed vsock_assign_transport() when the socket is already assigned
>   + moved features outside of struct vsock_transport, and used as
>     parameter of vsock_core_register() as a preparation of Patch 12
> - Removed "vsock: add 'transport_hg' to handle g2h\h2g transports" patch
> - Added patch 12 to register vmci_transport only when VMCI guest/host
>   are active

Has there been feedback from Jorgen or someone else from VMware?  A
Reviewed-by or Acked-by would be nice since this patch series affects
VMCI AF_VSOCK.

Stefan

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21TucACgkQnKSrs4Gr
c8jY1wf9G0k0TNCkBEFILNq2f7qw5oF5+pTf1Of9V+p/S4tsTcWiHPLrYThBzZui
QJ/Zws7KFQcXB/7+e8RQ4SXI/iMLoPtaEFK3euKQg0N48xlULtw2XuiMVuaAsTsl
iaEmsyI21PQlM7zeMFTfqt0wxt2H6MebdP4DyrfhbKvFKmzAAy7v0Xq3vtv6/ZX6
AIVIDuKDo19J9oe9ZKF51lvMe4Ndd7ynKNDD+2s2ZrrF31/uuQkE6K2ZUMjTDQVR
zcK2K/aHtAnz+98XtneyrQAlc4JV0lTIZOMB2aTS4ZQ1sHssYiwGbF/j4fR2Dj0n
iFHeCiwo4mQ5+1RKCoFZbtObs2ilQw==
=wYuh
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--

--===============7542246376614576319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7542246376614576319==--
