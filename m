From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: Re: [PATCH v2 3/3] hw_random: increase schedule timeout in
	rng_dev_read()
Date: Mon, 15 Sep 2014 18:13:31 +0200
Message-ID: <20140915181331.4e3f5fed__12776.8261511394$1410799152$gmane$org@wiggum>
References: <1410796949-2221-1-git-send-email-akong@redhat.com>
	<1410796949-2221-4-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4093462725938082247=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410796949-2221-4-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

--===============4093462725938082247==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/k2AhhoIPntp+aTxsAG=dZk/"; protocol="application/pgp-signature"

--Sig_/k2AhhoIPntp+aTxsAG=dZk/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Sep 2014 00:02:29 +0800
Amos Kong <akong@redhat.com> wrote:

> This patch increases the schedule timeout to 10 jiffies, it's more
> appropriate, then other takes can easy to hold the mutex lock.
>=20
> Signed-off-by: Amos Kong <akong@redhat.com>
> ---
>  drivers/char/hw_random/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 263a370..b5d1b6f 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -195,7 +195,7 @@ static ssize_t rng_dev_read(struct file *filp, char _=
_user *buf,
> =20
>  		mutex_unlock(&rng_mutex);
> =20
> -		schedule_timeout_interruptible(1);
> +		schedule_timeout_interruptible(10);
> =20
>  		if (signal_pending(current)) {
>  			err =3D -ERESTARTSYS;

Does a schedule of 1 ms or 10 ms decrease the throughput?
I think we need some benchmarks.

--=20
Michael

--Sig_/k2AhhoIPntp+aTxsAG=dZk/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUFxArAAoJEPUyvh2QjYsOGCsQAJK4Wd0MLbTsJSE0dnSuW7zm
+lF26LyK0hZJDv84A1SO9/KxnGLAPVNsdZWPCQ2G27OMxOZ6NLIbHJqdSoIImF7L
Y4EncdeOKFmu+W78PxqgJV03LkBTmgQUF+mf9bMr7GGFu25VriM5/fqJkMygjA95
xI0lKPoaPKVlHTNnZSxi/+b10vNCD5/8r+OU3keoSeOQ59UwPLpPJBwHvMB58cEh
7MZ3irpQwZfQajkD7nB7351tXekxy4MimHOPwWSoem9BhFwzxzRSlcIKwgWR0Dyi
Khmjqn5sG4GDvWTy/f1Cmuubsr5giWOsnjGtIGTfMwLHXGx7rOgYnSPbShnGNJzN
NDDf2v+BfNIHEuPTSeh3M86pd7NR/rTjB8ZuhhvGfk0IaU6R4j21wTeV1w5cWT1n
UpBKH7jJmwot/Qss4QIVaDhmFOqzgRfqumGirJbhEMqQp/L9SaKLWnE/GtSkXXSJ
Ov8ACjmuR6/sqQEJ/zos7f5lhEKGxBzfgeDFT5mVwCpyAUMnOrXWlvsTWpbi+RiV
kwQ960ok6/SIE4Qw3KFQsCjR0/S9wM00rT2PfAGUJN2czpMDf157Ip3thk4tg2/0
K59x4FJt1Or1GGJdi0+sNLH3zgoqwGNIDhPt8IsC7yMG35/CZDD7NzRqpud9Y64k
Wf/71D5PPuyFe8NpKj4c
=2MVV
-----END PGP SIGNATURE-----

--Sig_/k2AhhoIPntp+aTxsAG=dZk/--

--===============4093462725938082247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4093462725938082247==--
