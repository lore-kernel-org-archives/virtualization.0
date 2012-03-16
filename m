From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] Drivers: hv: Support the newly introduced KVP
	messages in the driver
Date: Fri, 16 Mar 2012 10:37:22 +0300
Message-ID: <20120316073722.GI3163@mwanda>
References: <1331858893-775-1-git-send-email-kys@microsoft.com>
	<1331858925-827-1-git-send-email-kys@microsoft.com>
	<20120316054556.GH3163@mwanda>
	<6E21E5352C11B742B20C142EB499E0481B7666A2@TK5EX14MBXC126.redmond.corp.microsoft.com>
	<20120316071858.GH3220@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1230527362=="
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120316071858.GH3220@mwanda>
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


--===============1230527362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kH8JNVvasRCCW1Oz"
Content-Disposition: inline


--kH8JNVvasRCCW1Oz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 10:18:58AM +0300, Dan Carpenter wrote:
> > > On Thu, Mar 15, 2012 at 05:48:43PM -0700, K. Y. Srinivasan wrote:
> > > >  	/*
> > > >  	 * The windows host expects the key/value pair to be encoded
> > > >  	 * in utf16.
> > > >  	 */
> > > >  	keylen =3D utf8s_to_utf16s(key_name, strlen(key_name),
> > > UTF16_HOST_ENDIAN,
> > > > -				(wchar_t *) kvp_data->data.key,
> > > > +				(wchar_t *) kvp_data->key,
> > > >  				HV_KVP_EXCHANGE_MAX_KEY_SIZE / 2);
> > > > -	kvp_data->data.key_size =3D 2*(keylen + 1); /* utf16 encoding */
> > > > +	kvp_data->key_size =3D 2*(keylen + 1); /* utf16 encoding */
> > > > +
> > >=20
> > > I feel like a jerk for asking this, but is the output length correct
> > > here?  It seems like we could go over again.  Also utf8s_to_utf16s()
> > > can return negative error codes, why do we ignore those?
> >=20
> > We are returning the strings back to the host here. There are checks el=
sewhere
> > in the code to ensure that all strings we return to the host can be acc=
ommodated
> > in the available space. For the most part these are strings that the ho=
st gave us in the=20
> > first place that have already been validated.  Furthermore, there are c=
hecks on the=20
> > host side to ensure that the returned size parameters are consistent wi=
th the protocol=20
> > definitions for the key value pair. For instance let us say somehow we =
got into a=20
> > situation where the converted utf16 string occupied the entire MAX size=
d array=20
> > without any room for the terminating character and we set the length pa=
rameter=20
> > to 2 more than the MAX value as this code would do. The host would simp=
ly discard the=20
> > message as an illegal message. This would be more appropriate than send=
ing a=20
> > truncated key or value.
> >=20
>=20
> Uh...  Looking at it again, this code is clearly off by one.  If
> we're not going to hit the limit, then we're not going to truncate,
> so that's not a concern.  Let's just use the correct limit here.
>=20

Another option of course would be to add a test after the
conversion.

	if (keylen =3D=3D HV_KVP_EXCHANGE_MAX_KEY_SIZE / 2)
		return -EINVAL;

What I'm saying is that I audit a lot of code for buffer overflows,
and I don't want to see an off by one and then I have to audit where
the string come from and audit where it's going.

If it's corrupts memory then I fix the bug and I can list it under
my achievements in my weekly status report.  If it's wrong but it
doesn't corrupt memory, it's just a complete waste of my time and it
makes me really cross.

regards,
dan carpenter


--kH8JNVvasRCCW1Oz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYu2xAAoJEOnZkXI/YHqRBSgP/j2LyX30hhi6MgWWcVfvStEa
1NKuYCtBRB1rl7ZtEwy99LTbTmSZP8xUDrci1GKKcwRzut0CdqdrgTFsPUaX8lgM
tOyuXP1qVa5dUfQUpTueSO+oQvblURwOgZ2iGMrnq6vk4yRaq41+kveDJMF33QbC
CKtCpaLVLVJA/5T29LIDfDLLB0KCwFtA+s3UZ01FjrQzel6HSjr766sRvJACJ5Fp
AmOmucC3ooZ0uIuu5WG1V0m3ujWKuOVs5ccSsb6RZZqg8hiDpZ1QH03y5xgi2FEC
t1/UocGeySe53vEqWnQuVAa5SaKKMJRVeEq8ZtjJPBV+wgR99MTs4t1I9rfZQeeZ
JucNIFyvU1M9yAFzCEjfnER0luu4W4RdGFKm9u+lCDXBFKFPEU3Y2ABZluwrykVe
sWWoWEUk7q9HobUdngt2mpfQFHwEE0x3iD6QvoXTS7TcKy2W1b2Wwq2vDX3yBgJl
Y2vWp14VK9KvCpPW/Vgd4JwqoCdTIn0VhlzzzBYY0r3a26OxfrWczlfblqDsZLuL
iBoNu1aeL3VwAAMJJI7VMhQMKpgGbnW/gqX1cr7y5XsJhquD+LeYqwZVuW9E+FFZ
MC5SXx6D2Gq8UIDBsOzzY1dbhUS6esGN99Z9DH23xE6TH1jkVwZnLeUlVQI0rQdO
MsXPjqis4aJ8F1VcWBT7
=bm98
-----END PGP SIGNATURE-----

--kH8JNVvasRCCW1Oz--

--===============1230527362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--===============1230527362==--
