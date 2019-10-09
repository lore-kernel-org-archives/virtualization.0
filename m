From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 00/13] vsock: add multi-transports support
Date: Wed, 9 Oct 2019 14:29:52 +0100
Message-ID: <20191009132952.GO5747__38591.8267349311$1570627806$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8271682762921606467=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-1-sgarzare@redhat.com>
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


--===============8271682762921606467==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E+IgQzR66AIOcbjA"
Content-Disposition: inline


--E+IgQzR66AIOcbjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 01:26:50PM +0200, Stefano Garzarella wrote:
> Hi all,
> this series adds the multi-transports support to vsock, following
> this proposal:
> https://www.spinics.net/lists/netdev/msg575792.html

Nice series!  I have left a few comments but overall it looks promising.

Stefan

--E+IgQzR66AIOcbjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d4M8ACgkQnKSrs4Gr
c8hxCQgAvBCgXesjZRNdIi6a/BOoOtpjAFvdIAVMUPXSLpgkAAwwm/PP7tAvx1MJ
YhMxO/wQRSz0MM8hB5SXpylSlELvGW60PDeBGeQXn9mza8dNK+G1Q1gW+k0+iJId
gcqRKa56j0w0ZwF11MWPE3Z5NTAm3UqDkvnAkzkE6QBRtV6yoQfh7pXVWjL/7it/
Y+D8zOxmNIH8rnCyWudTorhTXZdaXu0HQa0G5Kgj4FQlBimBC9LWVVpc0kch0OIY
CzPrOAhxCXgPjXo7W2rw3e+D3lgiqSfV8RsUkfcWjZR0xv9w0ycyU73HsIlPtvrF
iAvhxHWYhtUV+1CUQEHabyPmMNNclg==
=y58O
-----END PGP SIGNATURE-----

--E+IgQzR66AIOcbjA--

--===============8271682762921606467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8271682762921606467==--
