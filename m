From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH net-next v3 00/11] VSOCK: add vsock_test test suite
Date: Thu, 19 Dec 2019 11:11:24 +0000
Message-ID: <20191219111124.GA1624084__64.362892747738$1576753906$gmane$org@stefanha-x1.localdomain>
References: <20191218180708.120337-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5221010736501477228=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191218180708.120337-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, davem@davemloft.net, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============5221010736501477228==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 07:06:57PM +0100, Stefano Garzarella wrote:
> The vsock_diag.ko module already has a test suite but the core AF_VSOCK
> functionality has no tests. This patch series adds several test cases that
> exercise AF_VSOCK SOCK_STREAM socket semantics (send/recv, connect/accept,
> half-closed connections, simultaneous connections).
>=20
> The v1 of this series was originally sent by Stefan.
>=20
> v3:
> - Patch 6:
>   * check the byte received in the recv_byte()
>   * use send(2)/recv(2) instead of write(2)/read(2) to test also flags
>     (e.g. MSG_PEEK)
> - Patch 8:
>   * removed unnecessary control_expectln("CLOSED") [Stefan].
> - removed patches 9,10,11 added in the v2
> - new Patch 9 add parameters to list and skip tests (e.g. useful for vmci
>   that doesn't support half-closed socket in the host)
> - new Patch 10 prints a list of options in the help
> - new Patch 11 tests MSG_PEEK flags of recv(2)
>=20
> v2: https://patchwork.ozlabs.org/cover/1140538/
> v1: https://patchwork.ozlabs.org/cover/847998/
>=20
> Stefan Hajnoczi (7):
>   VSOCK: fix header include in vsock_diag_test
>   VSOCK: add SPDX identifiers to vsock tests
>   VSOCK: extract utility functions from vsock_diag_test.c
>   VSOCK: extract connect/accept functions from vsock_diag_test.c
>   VSOCK: add full barrier between test cases
>   VSOCK: add send_byte()/recv_byte() test utilities
>   VSOCK: add AF_VSOCK test cases
>=20
> Stefano Garzarella (4):
>   vsock_test: wait for the remote to close the connection
>   testing/vsock: add parameters to list and skip tests
>   testing/vsock: print list of options and description
>   vsock_test: add SOCK_STREAM MSG_PEEK test
>=20
>  tools/testing/vsock/.gitignore        |   1 +
>  tools/testing/vsock/Makefile          |   9 +-
>  tools/testing/vsock/README            |   3 +-
>  tools/testing/vsock/control.c         |  15 +-
>  tools/testing/vsock/control.h         |   2 +
>  tools/testing/vsock/timeout.h         |   1 +
>  tools/testing/vsock/util.c            | 376 +++++++++++++++++++++++++
>  tools/testing/vsock/util.h            |  49 ++++
>  tools/testing/vsock/vsock_diag_test.c | 202 ++++----------
>  tools/testing/vsock/vsock_test.c      | 379 ++++++++++++++++++++++++++
>  10 files changed, 883 insertions(+), 154 deletions(-)
>  create mode 100644 tools/testing/vsock/util.c
>  create mode 100644 tools/testing/vsock/util.h
>  create mode 100644 tools/testing/vsock/vsock_test.c
>=20
> --=20
> 2.24.1
>=20
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37WtwACgkQnKSrs4Gr
c8ghowf8CLQjydPRjm3F7iQ8iS7EhFcrctrj96QbH/gFGwkxcSiXqC0mwtLprUzL
sbzvy6lfKd7nfmXz2O4fJkyKa3qF8/xm3j04fg+6m5WbLNtKMHGE9nyH0NUttTiH
chth84d78ZFP1m+KV0spdJQBoHFi3pHh3eZWdzNaEEkCdEU0sTI37W4CsJjBw1AF
PeJFTmO/sGi8c8f8lvBTb8TipXM7THMhr0O+ypUYXFBG6IuNXsKkXcPOjzd9qKFd
DGr/Ecd6BMIHdNjGgJ707hxsmOooJv9DT4MZQ58KcEzGR9fmtM+E4hnugMt40upL
3ysZQApGZuQOWqxa7oYNLe86Az04uw==
=JzCU
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============5221010736501477228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5221010736501477228==--
