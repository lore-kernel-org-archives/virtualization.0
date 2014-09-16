From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: Re: [PATCH v2 3/3] hw_random: increase schedule timeout in
	rng_dev_read()
Date: Tue, 16 Sep 2014 17:01:16 +0200
Message-ID: <20140916170116.65f8d883@wiggum>
References: <1410796949-2221-1-git-send-email-akong@redhat.com>
	<1410796949-2221-4-git-send-email-akong@redhat.com>
	<20140915181331.4e3f5fed@wiggum> <20140916002740.GA5671@zen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4557979610729294036=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140916002740.GA5671@zen>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

--===============4557979610729294036==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/7=Ee=1KEUuR5Fsm=4e3N5nX"; protocol="application/pgp-signature"

--Sig_/7=Ee=1KEUuR5Fsm=4e3N5nX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Sep 2014 08:27:40 +0800
Amos Kong <akong@redhat.com> wrote:

> Set timeout to 10:
>   non-smp guest with quick backend (1.2M/s) -> about 490K/s)

That sounds like an awful lot. This is a 60% loss in throughput.
I don't think we can live with that.

--=20
Michael

--Sig_/7=Ee=1KEUuR5Fsm=4e3N5nX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUGFC8AAoJEPUyvh2QjYsO1rQP/3BUqE2P6lKKSVE6J0l47J/1
dgNKWEyQBPEa4wz7jcaQkniVEfTRbn5xZVFuVtdWGVLcLa3XCYWgveo3Jo4f/Aon
6t0nUZXEeENbi4hBYYrZ8LnG+12SqcYvaVSNCrTL4fCmfcYEv3OUdUiEYh5iw1Py
iFKDfUzohhbKlObgm2rMOCNXTv3ZPwKalE6cxvbKpbaAe/wVXHgVWhK9rGnQmzpA
Lk56gn/G7cDJ7G+HMT06p0qe2/QyFAJLNKVr8aOqCHMftRBkw8VhFYKX6P0EW7RI
ARH100K8ZPjxyyYjy3+rPbBSTEGX5ioddqAm1nwzMlRkXc9xB/Q34rlt0eoMRKmF
eiU9DcKu5DvrVsnmvj8cO1Htz2lYUMQsYRn2K5RIw0Ogej4buZHf0fkiSDwUupAV
CdTnekusbz58CwQSjAnikBvL0HykytmiQmjt43/BW41D4J5v6AETmO9pcqPORxle
CNTnPvAdeRlO5iEhyw3XTKzBidDHVi4h8uH311gWeXtq/NcfRcUpRHYWHBd6BB8w
pEYw0ukyxNkHFIDu0a7h88DgcwfvmViK5Cvl3z1djkIKaPRrONCkaXv+mLCz6LrO
kcf9lM8LMhWvyzo8/+gs3miFMROCNG+u7W3r1cBraZ8MlD+ZOp1Je9rvEuXFHe1M
45cPqwNkbt4hswTlBjCl
=8+vG
-----END PGP SIGNATURE-----

--Sig_/7=Ee=1KEUuR5Fsm=4e3N5nX--

--===============4557979610729294036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4557979610729294036==--
