From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv8 0/3] vhost: a kernel-level virtio server
Date: Wed, 04 Nov 2009 11:02:15 -0500
Message-ID: <4AF1A587.8000509__25802.5532043122$1257350681$gmane$org@gmail.com>
References: <20091104155234.GA32673@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9213930659845850726=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091104155234.GA32673@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============9213930659845850726==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9CBB576151305611F6CF6CC2"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CBB576151305611F6CF6CC2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> Ok, I think I've addressed all comments so far here.
> Rusty, I'd like this to go into linux-next, through your tree, and
> hopefully 2.6.33.  What do you think?

I think the benchmark data is a prerequisite for merge consideration, IMO=
=2E

Do you have anything for us to look at?  I think comparison that show
the following are of interest:

throughput (e.g. netperf::TCP_STREAM): guest->host, guest->host->guest,
guest->host->remote, host->remote, remote->host->guest

latency (e.g. netperf::UDP_RR): same conditions as throughput

cpu-utilization

others?

Ideally, this should be at least between upstream virtio and vhost.
Bonus points if you include venet as well.

Kind regards,
-Greg


--------------enig9CBB576151305611F6CF6CC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrxpYcACgkQP5K2CMvXmqHHKQCfX0c8WoojuJe1A+eFFzu9twpU
PEkAn2bUMmeK9n8AfgWItG+bCqzjqtDQ
=6kXy
-----END PGP SIGNATURE-----

--------------enig9CBB576151305611F6CF6CC2--

--===============9213930659845850726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============9213930659845850726==--
