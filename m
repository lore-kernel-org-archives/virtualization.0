From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] Drivers: hv: Support the newly introduced KVP
	messages in the driver
Date: Fri, 16 Mar 2012 17:26:49 +0300
Message-ID: <20120316142649.GJ3163@mwanda>
References: <1331858893-775-1-git-send-email-kys@microsoft.com>
	<1331858925-827-1-git-send-email-kys@microsoft.com>
	<20120316054556.GH3163@mwanda>
	<6E21E5352C11B742B20C142EB499E0481B7666A2@TK5EX14MBXC126.redmond.corp.microsoft.com>
	<20120316071858.GH3220@mwanda>
	<6E21E5352C11B742B20C142EB499E0481B76671F@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1186326471=="
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481B76671F@TK5EX14MBXC126.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Alan Stern <stern@rowland.harvard.edu>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============1186326471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9faIjRurCDpBc7U"
Content-Disposition: inline


--+9faIjRurCDpBc7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 01:14:07PM +0000, KY Srinivasan wrote:
> Dan,
> I am trying to understand your concern here:
> You will agree with me that the current code does not overflow the=20
> buffer since the output is limited to MAX bytes and that is how=20
> big the output buffer is sized. Now, as I pointed out earlier, if the
> string to be converted were to fully occupy the MAX bytes or even be
> larger than MAX bytes (no buffer overflow here since we limit the
> conversion to MAX bytes), we will get a malformed packet that will be
> sent to the host since the size field of the message would exceed
> the protocol specified size limit. I was merely pointing out that in
> this case, I would rather have the host reject the message than send
> a truncated Key/Value string (if we were to ever get invalid key or
> value strings).=20
>=20

Sending malformed packets is a bad idea.

Normally, if you handle the error as close to the cause of the error
as possible then it makes everything easier to read.  In this case
especially, it's so easy to catch any errors.  If you decide to go
ahead and send the malformed message, at least put a comment.

When I read code, I spend all my time looking for what it does
wrong.  So when code doesn't have any error handling and sets
keylen =3D -EINVAL then sure, it's fewer lines of code to read, but
it doesn't make my life easier.  Readable code has obvious error
handling.

Introducing off by one errors is an especially bad idea.  It doesn't
matter how harmless they are, because they end up getting copy and
pasted.  I don't know how to make it any clearer than that.  :/
Never never never do that!

regards,
dan carpenter


--+9faIjRurCDpBc7U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY02pAAoJEOnZkXI/YHqRDEoP+gKhaThrvNOFUEb7aWMq1ilE
SI1nqWD7mBeDdYxDKtyv/kexXXWaGirkBFkR0uxNI3ZVBqdLByl0HYSqoqzAhy2b
yjI3RNSJ5NVA4TJfUcsIGHztCFNsk/ODBSSnpzkEON18kzutblZmZFlRIHxlRgc4
7EZ9b4u+U/l/EL6hmOnO2jM7ZQqnTJhJdzWIvbFE+a7tK9/azuwVKotBUOvtb6eY
StBbJfVSXg/GUyX03aABpsJfzpTuaeDKx7XT/ZBVgk1RtP4naMYXU4DMMuwOBw5S
BNPY5bGIEgQcma0/y127peqTQJWgRKTKYBHTx/uPYuIzvC/2XpeHwqIg5uFk4ThT
v+RPInkEaiG+s5mn4eHbHEzyzY7AboYpaKt8C4FGJLSRfN1CGnAgYp1CGnDhHEPm
5mpcGu1UrjSEM1CiWWOqSra8cWCucFjsIb7hX/VbxYiJHwq7OFKGxyEVM/gRmzea
/zMN3S1EPPmRPvtg56vhyxMINSMH0vMQfjMtLeH6o/KMwT8TASIWMugFwN7P4qQt
QuwPqU1k8MJXfmM2SY3kZ2klRMRlCc6VvZwqjryeDm3D8RjRcsG1iUL2A+b4jij3
0RkP9qqujx5Mccy3/sMbfcqZPtG2LuKYGNHFSZLdtJpJOdhwQY+6vAvJ5+JufWKa
gbJWkgdlXgNTTlBbkb78
=EXNg
-----END PGP SIGNATURE-----

--+9faIjRurCDpBc7U--

--===============1186326471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--===============1186326471==--
