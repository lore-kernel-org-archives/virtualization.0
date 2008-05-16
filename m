From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Fri, 16 May 2008 12:49:41 +0200
Message-ID: <1210934981.6381.1.camel__2070.2148591683$1211209245$gmane$org@johannes.berg>
References: <482C8595.5030509@garzik.org>
	<200805160943.08788.rusty@rustcorp.com.au>
	<200805161531.44725.rusty@rustcorp.com.au>
	<200805161539.59739.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0507575298969169640=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805161539.59739.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, "H. Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============0507575298969169640==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NK9f9znuTheOv8uVV1Mn"


--=-NK9f9znuTheOv8uVV1Mn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> +
> +/* Our random number generator device reads from /dev/urandom into the G=
uest's
> + * input buffers.  The usual case is that the Guest doesn't want random =
numbers
> + * and so has no buffers although /dev/urandom is still readable, wherea=
s
> + * console is the reverse.

Is it really a good idea to use the hosts /dev/urandom to fill the
guests /dev/random?

johannes

--=-NK9f9znuTheOv8uVV1Mn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASC1mxKVg1VMiehFYAQLyFQ/8DYZdGFEzvFitft6kv4HOi0zMlJe9irfa
liNn2pusNjPm4bdFUtU77ItiKTrv2Q3lK0ejW0dgfZ080WJ4Nt+j0B5ue0TpzZFe
jcE2AR3kmNPMmp7kLkW6udFCJbQiVDozVs2pqj+oY+ITilT2f1dEamE6i6cQM+WL
j/0+q/CHCHro4Ll1Y1rryvbugjEEzJkeGWDO4AywPOaXGs+/nNG8/ddkAm+m6jXf
l5g/ZOdqC+pU4p2dEvYdI7vx3B40aRLo17BRni2tDn/ENJSeD1aUurwMdvFNhouF
pdbnX0bid1CP0uzKvZ83ZkAN18/CHSCBKH9HhTLzQXNSwp8fM+AdGMK92jDxPZvv
iM3KJntOhGMy2nqC7ZqM9F7J/bwoq6TtFbp0gWEKG44OVWdUY+tpi6MIzSuoTSo0
FIOS3T+xdjyJW75vbhJH6VXuQQmvy02ObNCBd4wEQNilrV+TfvJtnjPDLMKdIeva
xsYwzOohtA4dld5pexI7tZazI0rzNs8ZHJ7sCdhGSkWDWp1T6P9C/AZl3J947WrB
w3TSukkzr4Vr8TGGrMrrIIEvStUCojOvoSPaRsW9qAviBS/VJwsQi4zHrBrLPrBJ
d0+7sNHKpyzkoi3SG1edIFUtuSiWkHAmfuTUGG+P+v7AVSJ3rhM5kvSbojjoMhaA
DaQrNM6OM/o=
=ACgM
-----END PGP SIGNATURE-----

--=-NK9f9znuTheOv8uVV1Mn--


--===============0507575298969169640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============0507575298969169640==--
