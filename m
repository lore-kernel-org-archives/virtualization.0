From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 1/3] mm: export use_mm/unuse_mm to modules
Date: Fri, 28 Aug 2009 11:31:30 -0400
Message-ID: <4A97F852.6060505__3649.39772193811$1251474056$gmane$org@gmail.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160656.GB23722@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7183215231741579985=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827160656.GB23722@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, akpm@linux-foundation.org
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7183215231741579985==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1C5BA6B72C76D6CD23C7D55F"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C5BA6B72C76D6CD23C7D55F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> vhost net module wants to do copy to/from user from a kernel thread,
> which needs use_mm (like what fs/aio has).  Move that into mm/ and
> export to modules.


Michael, Andrew,

I am just curious: Is there any technical reason why a kthread cannot
have a long-term use_mm() in effect? (Assuming this makes sense for the
design, of course).  For the cases there we know the kthread will always
service the same context (such as with venettap/vhost, it may make sense
to do a use_mm() at init time and just leave it until the thread exits.
 Will this break anything?

Kind Regards,
-Greg


--------------enig1C5BA6B72C76D6CD23C7D55F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqX+FIACgkQP5K2CMvXmqGsNACghgmvgLjfVfN25itYVCnOSH4G
CIwAn1VdFGYr8TJCQTlY3E1yjibfYjMF
=3B87
-----END PGP SIGNATURE-----

--------------enig1C5BA6B72C76D6CD23C7D55F--

--===============7183215231741579985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7183215231741579985==--
