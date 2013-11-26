From: Richard Yao <ryao@gentoo.org>
Subject: Re: QEMU dies on any attempt to load a Linux kernel module when using
	a 9P rootfs
Date: Tue, 26 Nov 2013 10:38:04 -0500
Message-ID: <5294C05C.20802@gentoo.org>
References: <5293718E.4090508@gentoo.org> <5293C622.4070304@gentoo.org>
	<5294BB66.3060608@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1069502602765495114=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5294BB66.3060608@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: kernel@gentoo.org, v9fs-developer@lists.sourceforge.net, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1069502602765495114==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="D2D8FPcKwsDuJhi41nq9KXL8R3uIWnVMu"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D2D8FPcKwsDuJhi41nq9KXL8R3uIWnVMu
Content-Type: multipart/mixed;
 boundary="------------090303030804060609020004"

This is a multi-part message in MIME format.
--------------090303030804060609020004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher,

It sounds like you disabled zero-copy entirely, which is not necessary.
As far as I recall, loading kernel modules is the only case in which
valloc() allocated buffers are used. In the worst case, we only need to
disable zero-copy on such buffers. I have been using a small patch to do
precisely that since yesterday. I have attached it to this email since
it sounds like the first version might be helpful to others while I take
the time to explore a few loose ends.

That being said, I would like to investigate a couple of things before I
send either this patch or some variant of it to the appropriate
subsystem maintainer. First, I need to review the valloc() routines to
ensure that range checking against [VMALLOC_START, VMALLOC_END) is the
correct way to identify valloc() generated buffers. Second, I want to
explore the feasibility of a suggestion by Alexander Graf to instead
rework the zero-copy to properly handle valloc() allocated buffers.

Yours truly,
Richard Yao

On 11/26/2013 10:16 AM, Christopher Covington wrote:
> Hi Richard,
>=20
> On 11/25/2013 04:50 PM, Richard Yao wrote:
>> I figured out the problem. There is zerocopy IO is being done via DMA =
to
>> a buffer allocated with valloc(). Right now, I am running a hack-fix
>> locally so I can get some other stuff done first. I will propose a
>> proper fix to the list in a few days.
>=20
> I've also encountered this issue on a non-QEMU simulator and have been
> carrying a disable-zero-copy hack for a few months. Let me know if ther=
e's
> anything I can help with.
>=20
> Christopher
>=20

--------------090303030804060609020004
Content-Type: text/plain; charset=UTF-8;
 name="patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="patch"

diff --git a/net/9p/client.c b/net/9p/client.c
index ee8fd6b..0adfcf5 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1557,7 +1557,9 @@ p9_client_read(struct p9_fid *fid, char *data, char=
 __user *udata, u64 offset,
 		rsize =3D count;
=20
 	/* Don't bother zerocopy for small IO (< 1024) */
-	if (clnt->trans_mod->zc_request && rsize > 1024) {
+	if (clnt->trans_mod->zc_request && rsize > 1024 &&
+		!(udata >=3D (char __user *)VMALLOC_START &&
+			udata < (char __user *)VMALLOC_END)) {
 		char *indata;
 		if (data) {
 			kernel_buf =3D 1;

--------------090303030804060609020004--

--D2D8FPcKwsDuJhi41nq9KXL8R3uIWnVMu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlMBhAAoJECDuEZm+6ExkeCkP/ih6fHAzNzlY9DP3PwqMczH6
iTUBWKwiaihYuFeNJEgPDnBUCsyJxItJpjcf9rQ0Q3JKfv4qI+brrYzOX8qkEtL5
RvmNzRHULs6ASi8hHipTdXccQ6OC7bpOUyLvC0FfjRkSqMgPpc+MuRVNKNr619eT
pl9/qhE8+8koqy3ZFHF71bA9KsCvb59YdKmahr873IuE1YgwgSpE6tk861BlxoVy
dn/NZr7GTcTjPOS7HEPqVIx88extXLxzXUZNmohcVEQTjZ6UOfVGloZCYEvAQf0c
vvtwmOz2Fy18LHX3CRmbkl1I0lI/jZdYUCwx6s/+8wHGMj/50YSmSXzoCBpXhBf7
AvmCHBWLPiFO7+mmdEoJ/+pPoZ7cE3N8MaFuWg8AmPsKLBm3YDz2+mCiZN9XEVBS
PIa4IFnmQle534rzkMLaJSu8PuXVD+zdqgb36k2sCMJc83lhyAEoJkjhz69s0EuV
zHWaTxSPRsChHgZQN0oTz3m0Rn2AoBiz3QZl+8LdOt16e/jjinITFQwLg/vzF+LB
qV+Ef2cPYjWIDCF55QkcZ1Qfn9IkuL7HH+WVaiRoaKWnPoMJhsc4kUM/5BhZWaH5
ECem2nRpOajmklnwEN/hixxr2JR8QiqSahRjGr3ijTlhDRPtPzB0Akd0O7OAmp2Q
SMamtJ3bHEbIdcnq353e
=qThl
-----END PGP SIGNATURE-----

--D2D8FPcKwsDuJhi41nq9KXL8R3uIWnVMu--

--===============1069502602765495114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1069502602765495114==--
