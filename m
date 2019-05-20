From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 10/10] docs: fix broken documentation links
Date: Mon, 20 May 2019 17:05:10 +0200
Message-ID: <20190520150510.GA2606__17925.3270661988$1558426859$gmane$org@kunai>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
	<4fd1182b4a41feb2447c7ccde4d7f0a6b3c92686.1558362030.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8731529401889652568=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4fd1182b4a41feb2447c7ccde4d7f0a6b3c92686.1558362030.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: kvm@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, linux-i2c@vger.kernel.org, linux-kselftest@vger.kernel.org, devel@driverdev.osuosl.org, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org


--===============8731529401889652568==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 11:47:39AM -0300, Mauro Carvalho Chehab wrote:
> Mostly due to x86 and acpi conversion, several documentation
> links are still pointing to the old file. Fix them.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks, didn't notice that.

>  Documentation/i2c/instantiating-devices          |  2 +-

=2E..

> diff --git a/Documentation/i2c/instantiating-devices b/Documentation/i2c/=
instantiating-devices
> index 0d85ac1935b7..5a3e2f331e8c 100644
> --- a/Documentation/i2c/instantiating-devices
> +++ b/Documentation/i2c/instantiating-devices
> @@ -85,7 +85,7 @@ Method 1c: Declare the I2C devices via ACPI
>  -------------------------------------------
> =20
>  ACPI can also describe I2C devices. There is special documentation for t=
his
> -which is currently located at Documentation/acpi/enumeration.txt.
> +which is currently located at Documentation/firmware-guide/acpi/enumerat=
ion.rst.
> =20
> =20
>  Method 2: Instantiate the devices explicitly

For this I2C part:

Reviewed-by: Wolfram Sang <wsa@the-dreams.de>


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlziwiIACgkQFA3kzBSg
Kbb/+hAArOEJ2RcuEqvOP7Ge80J7VxtEVTCR0sWRFg/7cpRGLnwf1qLSAUlfAJYj
fUhZ9ANfeB4Y4ZltOPwJ34KNtZy/kYzYyoy/WgiNfJUrf+s7auOF+dMXRvBe8VyX
v/pHpAMzTf8rtNkaESOahPExL1lgrI2dShZa3Mxofm2eb3Kam0OJRr6Cvj7mA/Rq
PHq1QUlG+Y3hZdvAHjQ6GN6wr+pNnhqeSSAd3BZg5MZQpPRiaK+C4tPkqOD/TNwX
9+iPJTMPhWsdei4UO1POHGCOclFatxkPOQm9JjsTD1h1lEJK7Afs1cTCd0crwpzW
nQuj+MSjKTqcOwQ4hF1x6PwlbJm4Hq/+r6b50UsnQYai6pt7Khp9OISmYTxPQhgI
8aXZbjsMB3k9ebYulULGdF0f3p/IPoqneTUf3yi5OxNbhJ8eyNcQ4l35MP9hEyYb
H/9a/G4GXP7CLyCtKd53OtNeE1tTF4zGKIhe7v9OInHolA3gLx1R1rxiBeQB+XyA
NO/4FdEIZ1QWAyl7m1aWBtYpar2uvFyEhZWG3sVhZYsA9dQNBfgzFSu60wus7hy4
D9FxYijaEnHZvPivrTwfcp8ittAvsIrM3xANcOhWXEU6eC6w0KX15QiiyPQUbssL
H3fPVUBxQlwicyY98Dvh7eJmnD1WEsMcDmDI5RqrAxhdD/bxbN0=
=b4+p
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

--===============8731529401889652568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8731529401889652568==--
