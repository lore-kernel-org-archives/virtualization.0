From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/4] Drivers: hv: Support the newly introduced KVP
	messages in the driver
Date: Fri, 16 Mar 2012 08:38:29 +0300
Message-ID: <20120316053829.GG3163@mwanda>
References: <1331422331-4381-1-git-send-email-kys@microsoft.com>
	<1331422331-4381-2-git-send-email-kys@microsoft.com>
	<20120311104230.GC3337@mwanda>
	<6E21E5352C11B742B20C142EB499E0481B75B403@TK5EX14MBXC122.redmond.corp.microsoft.com>
	<20120311184916.GD3337@mwanda>
	<6E21E5352C11B742B20C142EB499E0481B75D433@TK5EX14MBXC122.redmond.corp.microsoft.com>
	<20120312052221.GE3337@mwanda>
	<6E21E5352C11B742B20C142EB499E0481B75D4CE@TK5EX14MBXC122.redmond.corp.microsoft.com>
	<20120312130353.GF3337@mwanda>
	<6E21E5352C11B742B20C142EB499E0481B7663B1@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0564235925=="
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481B7663B1@TK5EX14MBXC126.redmond.corp.microsoft.com>
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


--===============0564235925==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 11:36:16PM +0000, KY Srinivasan wrote:
>=20
> Dan,=20
>=20
> Sorry I could not get back to you earlier. You are right, in that I am tr=
usting
> the host! I am of the firm belief that in a virtualized environment, if y=
ou don't trust
> the host, there is not a whole lot you can do in a guest! I have had this=
 arguments=20
> with other on this mailing list in the past. Having said that, I think we=
 have spent more
> time debating this than we should; your proposal is reasonable and I will=
 go ahead and
> re-spin those patches based on your comments. I should be posting them sh=
ortly.
>=20
> Regards,

It's not about trusting the host or not trusting the host.  It's
about "if you're going to specify a limitter, it can't be off by one
even if you don't expect to hit the limit".

But thanks for redoing these.

regards,
dan carpenter


--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYtHVAAoJEOnZkXI/YHqR+iwQAIGXQLqYp2KkFKGuQYybNQVr
7HaKEsMy8ZD6af+BqhXR2xbUJilcIqy9XYjpWMsRWbtnSJgylttiZm5fJiqjXMmx
9DFMab2lzRKO/JsnAB70QBnZ+a5t2/znXOx2oM2kn/5rCd7MZvgDPqfaAa9UYC+W
lgoEdcWy7ugHpLGSYS0iQH6ulQOxZp2c9MKnBTZKqbh6NN1GEBp7KNcrE0wLRdAX
W3d6r9z6k97B3YU+Pbx1641q4eh3AigWUQOLhwag+JI9DgA8hDnzPK3iWY1IIbk9
REaV94Fbi3b2k3o8xkBaKcqyenScRF095EWqvmiYhR9B6tvpi6Wyh4bpnymPUz1b
u63Q1C81VcpmgfhxYacFO90UfnOmXiLFr3FfiM8bJxY29ULrXcfdaCRTuS90RqQ3
hulzv/Duelgeva+LUWB8afQmHi+hwgPqAJeZ/Xbsj5PJP3XP7kE4zZ3hMJP+C8H4
QDD6WCZhmsBMwIXzSIZPIZUEYyOmq1F+1x84s7aNXq4FJMXfT8g/QiwrHCQ9LkIY
6kf2H+VkCC3/Vh4Z3zxVIzeZLm8MMdQYPnGZm8sxdQG4+heu5WSAIEESeR+/RNYt
mQbJiOvk3e3FlTmyev+SwJL0+emTi8QFpxPGIcs2cL6Fm15mr+gVsjk/A6OR120v
qBqOwk33iqOs9OkrqGBB
=3ARM
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--

--===============0564235925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--===============0564235925==--
