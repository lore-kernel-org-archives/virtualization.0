From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 11/11] vsock_test: wait for the remote to close the
	connection
Date: Tue, 20 Aug 2019 09:28:28 +0100
Message-ID: <20190820082828.GA9855__29959.6197831974$1566289725$gmane$org@stefanha-x1.localdomain>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<20190801152541.245833-12-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4437949161351036723=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190801152541.245833-12-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============4437949161351036723==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2019 at 05:25:41PM +0200, Stefano Garzarella wrote:
> +/* Wait for the remote to close the connection */
> +void vsock_wait_remote_close(int fd)
> +{
> +	struct epoll_event ev;
> +	int epollfd, nfds;
> +
> +	epollfd =3D epoll_create1(0);
> +	if (epollfd =3D=3D -1) {
> +		perror("epoll_create1");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	ev.events =3D EPOLLRDHUP | EPOLLHUP;
> +	ev.data.fd =3D fd;
> +	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) =3D=3D -1) {
> +		perror("epoll_ctl");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	nfds =3D epoll_wait(epollfd, &ev, 1, TIMEOUT * 1000);
> +	if (nfds =3D=3D -1) {
> +		perror("epoll_wait");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (nfds =3D=3D 0) {
> +		fprintf(stderr, "epoll_wait timed out\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	assert(nfds =3D=3D 1);
> +	assert(ev.events & (EPOLLRDHUP | EPOLLHUP));
> +	assert(ev.data.fd =3D=3D fd);
> +
> +	close(epollfd);
> +}

Please use timeout_begin()/timeout_end() so that the test cannot hang.

> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock=
_test.c
> index 64adf45501ca..a664675bec5a 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -84,6 +84,11 @@ static void test_stream_client_close_server(const stru=
ct test_opts *opts)
> =20
>  	control_expectln("CLOSED");
> =20
> +	/* Wait for the remote to close the connection, before check
> +	 * -EPIPE error on send.
> +	 */
> +	vsock_wait_remote_close(fd);

Is control_expectln("CLOSED") still necessary now that we're waiting for
the poll event?  The control message was an attempt to wait until the
other side closed the socket.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1brywACgkQnKSrs4Gr
c8he/ggAs417RXraEFHwXmiz0k0MOniGzChyB01FvERBmU5Q3lFaA9yTm3CfBmeM
dsWmGaQ+UcV0T+BvE+Y+oUV6lspdjNMX2D02+Xfl9SNwKh1CGxmipyRSsITapVXg
9wFwZzD/+IJ6bSzUxyYpPZhb0n1cZNnMnB0hpTFGSvJMrbk/phSv3NVd7LrJVuM2
uTYaoaFXQ4QTPnnVO7JonGbeHJuinIleByziLGaCCDgeEan9gf48eQPsN1Pvhf+g
/YjmlJEqbpekU8wpwggoRFZ9UlkbiLhbCtZdvE7Kzj9PaS1DSF+AWLdL9fOa+N1K
jNvf8bhepUvIw0MgGeM/Az9vsHfFZw==
=E1TQ
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--===============4437949161351036723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4437949161351036723==--
