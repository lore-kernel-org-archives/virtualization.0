From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v5 6/6] hwmon: use smp_call_on_cpu() for dell-smm i8k
Date: Mon, 13 Jun 2016 21:05:29 +0200
Message-ID: <201606132105.29573@pali>
References: <1459952266-3687-1-git-send-email-jgross@suse.com>
	<1459952266-3687-7-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8911136902728691291=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459952266-3687-7-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, hpa@zytor.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

--===============8911136902728691291==
Content-Type: multipart/signed;
  boundary="nextPart1914347.VdCyj8eYVV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1914347.VdCyj8eYVV
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 06 April 2016 16:17:46 Juergen Gross wrote:
> Use the smp_call_on_cpu() function to call system management
> mode on cpu 0.
> Make call secure by adding get_online_cpus() to avoid e.g. suspend
> resume cycles in between.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V4: add call to get_online_cpus()
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 35

As mentioned in discussion under V4, you can add my Acked-by.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1914347.VdCyj8eYVV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldfA/kACgkQi/DJPQPkQ1IsBACgtP36FkPCfKZdOMi15f9Ez6Kn
aHsAnApJ9m1FHxNOOU3vj7tmMGvb4N1c
=1A/l
-----END PGP SIGNATURE-----

--nextPart1914347.VdCyj8eYVV--

--===============8911136902728691291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8911136902728691291==--
