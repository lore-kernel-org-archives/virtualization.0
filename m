From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] vhost: remove unneeded linux/miscdevice.h include
Date: Tue, 23 Apr 2019 14:26:26 +0100
Message-ID: <20190423132626.GJ32465@stefanha-x1.localdomain>
References: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7041600379654838033=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============7041600379654838033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Content-Disposition: inline


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 06:58:54PM +0200, Corentin Labbe wrote:
> drivers/vhost/vhost.c does not use any miscdevice, so this patch
> remove this unnecessary inclusion.
>=20
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/vhost/vhost.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvxKCAAoJEJykq7OBq3PIxakIAKxmFI7MYIQXPO2NrlHONe5T
IoEK92iePJj7qb0xCK7O2yLLhnvzTgWJxpHCENRsAEFqY1ZGEbR+vnlkbKa+0ZCY
zcZdH6Ndl2KPut8yfQqhY/LGXFCDNT2ZZY851nWoPUpJ6e95LhcO4Grk5VKUS1Cc
v85zFOHJcWpHrmOVVg5DeYLZokXDGLYLHrR34kr3GwRM279muvjQovl67N73gO+P
sGtS88e4g5ax7W3WrFo4vqd4Jam284pYqH/gGm1SWiMIdQNmp40tZF9HLYfG5pnc
s4Rxf02nFEcsoC+F1FrPTHPYxtGoh61TzyCkYOk884j4E0q+Txrs8VpuOfwljkU=
=nDd1
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--

--===============7041600379654838033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7041600379654838033==--
