From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 11/11] vsock_test: wait for the remote to close the
	connection
Date: Fri, 23 Aug 2019 11:09:21 +0100
Message-ID: <20190823100921.GD12092__3763.5699309007$1566554973$gmane$org@stefanha-x1.localdomain>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<20190801152541.245833-12-sgarzare@redhat.com>
	<20190820082828.GA9855@stefanha-x1.localdomain>
	<20190822091546.qcns2kot6tzju7yv@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3303573342666839353=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190822091546.qcns2kot6tzju7yv@steredhat>
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


--===============3303573342666839353==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 11:15:46AM +0200, Stefano Garzarella wrote:
> On Tue, Aug 20, 2019 at 09:28:28AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Aug 01, 2019 at 05:25:41PM +0200, Stefano Garzarella wrote:
> > > +/* Wait for the remote to close the connection */
> > > +void vsock_wait_remote_close(int fd)
> > > +{
> > > +	struct epoll_event ev;
> > > +	int epollfd, nfds;
> > > +
> > > +	epollfd =3D epoll_create1(0);
> > > +	if (epollfd =3D=3D -1) {
> > > +		perror("epoll_create1");
> > > +		exit(EXIT_FAILURE);
> > > +	}
> > > +
> > > +	ev.events =3D EPOLLRDHUP | EPOLLHUP;
> > > +	ev.data.fd =3D fd;
> > > +	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) =3D=3D -1) {
> > > +		perror("epoll_ctl");
> > > +		exit(EXIT_FAILURE);
> > > +	}
> > > +
> > > +	nfds =3D epoll_wait(epollfd, &ev, 1, TIMEOUT * 1000);
> > > +	if (nfds =3D=3D -1) {
> > > +		perror("epoll_wait");
> > > +		exit(EXIT_FAILURE);
> > > +	}
> > > +
> > > +	if (nfds =3D=3D 0) {
> > > +		fprintf(stderr, "epoll_wait timed out\n");
> > > +		exit(EXIT_FAILURE);
> > > +	}
> > > +
> > > +	assert(nfds =3D=3D 1);
> > > +	assert(ev.events & (EPOLLRDHUP | EPOLLHUP));
> > > +	assert(ev.data.fd =3D=3D fd);
> > > +
> > > +	close(epollfd);
> > > +}
> >=20
> > Please use timeout_begin()/timeout_end() so that the test cannot hang.
> >=20
>=20
> I used the TIMEOUT macro in the epoll_wait() to avoid the hang.
> Do you think is better to use the timeout_begin()/timeout_end()?
> In this case, should I remove the timeout in the epoll_wait()?

Oops, you're right.  There are no other blocking calls in this function
so the existing patch is fine.

Thanks,
Stefan

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1fu1EACgkQnKSrs4Gr
c8jQlQf/e7aGXCiFEXR/fv7L4FF9eS7lMkOgWamvi2VQREbzelZCJ2YN+WJbgScs
AoWswurbMlnTinfdZGo2iSdsB+8Y1Ufkivjv4thTUNOSkBF2M8Wxk3DG2Pnbttu4
+x3W1QWUop0vp8vw5w/P8zxG5k5AkwZu1CT9EbPv4eCUeCG9awehnr+dS5ThKl2S
tktgQl1Xn8C+drVb1J3hB8FPtuHp7MQ7uLNUJdNwwjBWVFXYTneOV83Y058VnWv+
SQnba6jDppi9aUSbvew7xpiMLwcIMstMjl9i62+fOjJnedQhWjMlmYXvRP7fC+lw
4a8sOFnOeh3zkFN9tpxISsv+LKpzvg==
=CuTk
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--

--===============3303573342666839353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3303573342666839353==--
