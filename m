From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 07/11] VSOCK: add AF_VSOCK test cases
Date: Wed, 9 Oct 2019 16:15:03 +0100
Message-ID: <20191009151503.GA13568__46237.0710958325$1570634118$gmane$org@stefanha-x1.localdomain>
References: <20190801152541.245833-1-sgarzare@redhat.com>
	<20190801152541.245833-8-sgarzare@redhat.com>
	<CAGxU2F4N5ACePf6YLQCBFMHPu8wDLScF+AGQ2==JAuBUj0GB-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1999454677069219780=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGxU2F4N5ACePf6YLQCBFMHPu8wDLScF+AGQ2==JAuBUj0GB-A@mail.gmail.com>
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
Cc: kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1999454677069219780==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2019 at 12:03:53PM +0200, Stefano Garzarella wrote:
> Hi Stefan,
> I'm thinking about dividing this test into single applications, one
> for each test, do you think it makes sense?
> Or is it just a useless complication?

I don't mind either way but personally I would leave it as a single
program.

Stefan

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d+XcACgkQnKSrs4Gr
c8iLyQf/Zhb+RZJm3omrM8JeMvDADeG1HsilYyQHLlWrpKPJHyQVtNqGNx9bJxd+
Eq68BTkMmICqtmYwilCPPVlrx8et8zehRq871XzI6O/sXIme49zDJ056dPX1R1Gb
+HAyhD9QD3YqFicOy1eA7YAtT8/VsQdXMQTUVkwcv/Nzi37O0xyd7KVV0TJvBVka
0NwoQYWegJqj48HghPtJrhr6xjOjj2xbBgW2AI9SFwSYNW9asQeEgfWbYAZZU/Ri
Q2/xQjZbaaEKRhiIw+WoWJ4eXSZXzAzqh4cnyHVvJnoyLnO0Ed7qEUf4tcwFS1Eu
KaaYezbOhj4tIKbacDvJ5+HM6M2QYA==
=fCBd
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============1999454677069219780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1999454677069219780==--
