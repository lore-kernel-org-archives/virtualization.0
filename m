From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [Xen-devel] [PATCH] x86/xen: don't assume %ds is usable in
	xen_iret for 32-bit PVOPS.
Date: Sun, 17 Feb 2013 19:13:00 +0000
Message-ID: <1361128380.5374.483.camel__49408.4861748435$1361231804$gmane$org@deadeye.wl.decadent.org.uk>
References: <20130214215216.GA18740@kroah.com>
	<20130214225544.GA8068@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1220869106482854055=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130214225544.GA8068@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Petr Matousek <pmatouse@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Jan Beulich <JBeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1220869106482854055==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-LjVZHGFQIQL7m4ze19cP"


--=-LjVZHGFQIQL7m4ze19cP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2013-02-14 at 17:55 -0500, Konrad Rzeszutek Wilk wrote:
> On Thu, Feb 14, 2013 at 01:52:16PM -0800, Greg KH wrote:
> > Jan, any reason why this patch isn't in Linus's tree already, and why i=
t
>=20
> Sent out the GIT PULL this week to Linus
> > wasn't marked for inclusion in a -stable kernel release?
>=20
> I forgot to stick that. Do please include it in the stable tree.
[...]

I've queued this up for 3.2.

Ben.

--=20
Ben Hutchings
Experience is what causes a person to make new mistakes instead of old ones=
.

--=-LjVZHGFQIQL7m4ze19cP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUSErvOe/yOyVhhEJAQp3rg//XsyaxtD3UuiqqUmuBo37oI2Oryxnsg4W
JpeFQ1LZUGAkwK9LsW1rbjWhfENINyU540il0heBhqCewrQ29O7T9eBKGxrXJdVC
we5Euc+ldJaHzFk5Q50et56fLSsZcBdQJjqhqqZHu275tX6DdvJcgSGZwr+NH/0n
LEu9GoOxBbGgwsl3k5eRVwZaXewpFQ/ks6lwOdSzk18HVBJi1j0gzP99D3GewNhO
nfhu7ijC550nMC2o0Hc2txvR6r1O4V0Bw7FvIrKCMgkCYE9jjLaMSo8xlwftXW6W
RA7hwiEQVvKcvV+bRE+v4MHynhfkgBLO9uU44jsCKVn4NdnqshwIQlPJIRjKfJyr
xPtPGeRFUwW8EeUEUGTPbio5gY7t2/P8x5Qnu7CQkzhUY8Wefsn25XsoP7oJtnq9
BgdM53QEPYFHRJZ0NLOv3mVXwkUC3JQoPkPGd8F4GXl7BKvkEC1B0N0GSKbD3Y/c
Ti0KKUsMl7i96iAD/Sz0xa0y+Cfxm+diomkX8KDFGT4AfuFtbqY003jEVTBe+Y4i
gezn8ybAWFZdcjxgYaZReI+nXgRgivtGbA8X1Xo5qQxMeZlUcDhCY9kxyuqvX/oF
Dr7D8KIkrrySq0cqPa62qRd5Bgvc0M2iSojmhpYvW60GqqfcH8qS9WV6XDmBu4ZB
8fXbVTgiIso=
=K2T+
-----END PGP SIGNATURE-----

--=-LjVZHGFQIQL7m4ze19cP--

--===============1220869106482854055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1220869106482854055==--
