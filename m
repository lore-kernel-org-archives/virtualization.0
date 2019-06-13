From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net-next] vsock: correct removal of socket from the list
Date: Thu, 13 Jun 2019 15:47:50 +0100
Message-ID: <20190613144750.GA10708@stefanha-x1.localdomain>
References: <MW2PR2101MB11162BBAEC52B232A7B1EFAFC0EF0@MW2PR2101MB1116.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5374647294567990292=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <MW2PR2101MB11162BBAEC52B232A7B1EFAFC0EF0@MW2PR2101MB1116.namprd21.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============5374647294567990292==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 03:52:27AM +0000, Sunil Muthuswamy wrote:
> The current vsock code for removal of socket from the list is both
> subject to race and inefficient. It takes the lock, checks whether
> the socket is in the list, drops the lock and if the socket was on the
> list, deletes it from the list. This is subject to race because as soon
> as the lock is dropped once it is checked for presence, that condition
> cannot be relied upon for any decision. It is also inefficient because
> if the socket is present in the list, it takes the lock twice.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  net/vmw_vsock/af_vsock.c | 38 +++++++-------------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0CYhYACgkQnKSrs4Gr
c8iFswgAkhny+CmJw7mow5IOVXXncE2TxFf99EHKsOr8iDtwufjIL8hwWvTaUe6P
RTvfmyV/gNWaNTeDS59vx2PjBj6lqFvNcSkHgxk2TedBTjYZuT9zVpxgaR35z8/+
ijwiQDEUItPe/QTgLtGCe7cWonERvH8isScXPkJeRQwy6AM4VUgUA0BAp4UJ8d1C
wSPJN9FCoxq23VteUc5K64rfZx/HJ9nQHSgXpaGs1HZUP4ZCt+d+IdnHQqwnMqcO
StHv/E1Hw52VWDsuwnxBnabAj8upxLAAwz3fczAIBBv8Gzgcsm4mJ27kz1canPlv
TYXCHiC/JJ9sj1U5f6ggZhXBCsY9+g==
=426n
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

--===============5374647294567990292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5374647294567990292==--
