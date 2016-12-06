From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v8 2/6] powerpc: pSeries/Kconfig: Add qspinlock build
	config
Date: Tue, 6 Dec 2016 08:58:34 +0800
Message-ID: <20161206005834.GC18164@tardis.cn.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1480951166-44830-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6154943720689519562=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1480951166-44830-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: peterz@infradead.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org


--===============6154943720689519562==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 10:19:22AM -0500, Pan Xinhui wrote:
> pSeries/powerNV will use qspinlock from now on.
>=20
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index bec90fb..8a87d06 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig

Why here? Not arch/powerpc/platforms/Kconfig?

> @@ -23,6 +23,14 @@ config PPC_PSERIES
>  	select PPC_DOORBELL
>  	default y
> =20
> +config ARCH_USE_QUEUED_SPINLOCKS
> +	default y
> +	bool "Enable qspinlock"

I think you just enable qspinlock by default for all PPC platforms. I
guess you need to put

	depends on PPC_PSERIES || PPC_POWERNV

here to achieve what you mean in you commit message.

Regards,
Boqun

> +	help
> +	  Enabling this option will let kernel use qspinlock which is a kind of
> +	  fairlock.  It has shown a good performance improvement on x86 and als=
o ppc
> +	  especially in high contention cases.
> +
>  config PPC_SPLPAR
>  	depends on PPC_PSERIES
>  	bool "Support for shared-processor logical partitions"
> --=20
> 2.4.11
>=20

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYRg01AAoJEEl56MO1B/q4kgsH/i3BXJKj+dRDcUNgEk6OTE7V
b0yIMiyX+D0AbdM71XRIQKSdOow4kvSJg4T+ool2PX1w21wzmAyT8w2IN6O7fB5o
4KOEZV9vGeD6tUgRxNKnRTn6IQW5xn0e4QCZxqwCbG5cxitHZ3XgckF3hE0LMUV/
/OzzM0sAv/u7cfEZL9uAE5rDIDweFRi93doWcEpEW9IzpO9debq2+BepS6bWGVNW
SN3FWA7bq3uhBOKUuy25evsvxTMopdvuGKUilXvWi4TGF6l4akIzxyET5M17kNiZ
8TmssGqybyLpTu+N3yZloNh4N8mVZ/0qSNrXUYparJUXbxbGRY8bAZJ8LD6QuvM=
=+Wv7
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

--===============6154943720689519562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6154943720689519562==--
