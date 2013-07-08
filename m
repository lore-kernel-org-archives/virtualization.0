From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] virtio: include asm/barrier explicitly
Date: Mon, 8 Jul 2013 15:33:04 +1000
Message-ID: <20130708153304.3b44e03a4897136fc9419f89@canb.auug.org.au>
References: <20130707142019.GA2447@redhat.com> <87obaderna.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6551301699240051341=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87obaderna.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============6551301699240051341==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__8_Jul_2013_15_33_04_+1000_qSX8v6cPhpIfLc41"

--Signature=_Mon__8_Jul_2013_15_33_04_+1000_qSX8v6cPhpIfLc41
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Mon, 08 Jul 2013 11:31:45 +0930 Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
>
> PS.  I'll squeeze these into this merge window, since they're trivial.

s/'re trivial/fix bugs/  ;-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__8_Jul_2013_15_33_04_+1000_qSX8v6cPhpIfLc41
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR2k8QAAoJEECxmPOUX5FEhhAP/0xcq2gPLfCbMrLhJNMGcZX/
/jRRK83jni5hTdTXccm+/N/uUdRqjStyi5CR5WQEPdSIOfuNop3K7DJBTka8znd3
kGr4vxCMjzBuuLJrLGAEbxca/2XjaaqJpgToc9aGvBCJgyQa+KeDyQcriqO1l+vf
erahYrlcATMKnTe6SFall2Rdawh33XdVN5rbzP5zs4+aj7nkS5OxP3qWuluWiJKO
RpID0f1udSf9eh6cIeWFG93L8KMAw4AZAhom+Q55H/lK4AWD1ggkbXBmRJATy2ih
ErzFueuJncjxXsuvZHNKtuxEsnFAJrULTx6Cxncclpd+dWNMgT8Q+11cuYq/LKq5
Eref/Cw5eBEhbSeKFrErwZH4BDDhhUuZqkeoLqvqTlYDiQb0nKrKmUyRwbAh/0LK
yddVBAYMhCZb06dJ6t9QHXweWKWtY0ab6NQ19KvpulAkbOjHq9pR258Afh6x+SCr
ZwFS2b1e1geJEUfxcLjjgRRu0poQiphDSK7nibKkfcEBO3pZe2YWFxDupNlqHKYj
BVbxHyqOPKGSxyMfem3dX/lL1tJIu+D810AGwXVQACLJlU30sTHTR2IXsIavOe8V
2cNJUq0rHJmFjESSZWIXBdh5M3/cauGTBE63yx9Uge0eHC17G19XPEzAB2Bn68Lj
Vh7OKq1HK6wEAMXoUfj4
=wpXo
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Jul_2013_15_33_04_+1000_qSX8v6cPhpIfLc41--

--===============6551301699240051341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6551301699240051341==--
