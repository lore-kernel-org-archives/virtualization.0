From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 6/6] hwmon: use smp_call_on_cpu() for dell-smm i8k
Date: Tue, 5 Apr 2016 21:31:52 +0200
Message-ID: <201604052131.52765__7385.80370457402$1459885076$gmane$org@pali>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
	<1459833007-11618-7-git-send-email-jgross@suse.com>
	<20160405145414.GB27359@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6023069049545833921=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160405145414.GB27359@roeck-us.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, hpa@zytor.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

--===============6023069049545833921==
Content-Type: multipart/signed;
  boundary="nextPart1759490.KnKAIGVcLo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1759490.KnKAIGVcLo
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 April 2016 16:54:14 Guenter Roeck wrote:
> On Tue, Apr 05, 2016 at 07:10:07AM +0200, Juergen Gross wrote:
> > Use the smp_call_on_cpu() function to call system management
> > mode on cpu 0.
> > Make call secure by adding get_online_cpus() to avoid e.g. suspend
> > resume cycles in between.
> >=20
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > ---
> > V4: add call to get_online_cpus()
>=20
> Pali, any chance to test this ?

I can test it, but just on machine where (probably) smm calls can be=20
send from any cpu... Need some time for testing and I believe I can do=20
that at the end of the week.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1759490.KnKAIGVcLo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlcEEqgACgkQi/DJPQPkQ1JTRACdFYDnNujRzhYXtAftzeujrEQn
aEIAoIWdkDdClVWVpsIMNcjmoXNNjbmq
=fHEW
-----END PGP SIGNATURE-----

--nextPart1759490.KnKAIGVcLo--

--===============6023069049545833921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6023069049545833921==--
