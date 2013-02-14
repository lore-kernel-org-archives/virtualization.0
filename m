From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Feb 13 (virtio_console)
Date: Thu, 14 Feb 2013 18:06:51 +1100
Message-ID: <20130214180651.900763c3986c94531bb01ecf__4749.90914012796$1360826279$gmane$org@canb.auug.org.au>
References: <20130213193532.162080d7c0557a307ab451ac@canb.auug.org.au>
	<511BEC55.5090801@infradead.org> <87sj4zk3ai.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1213686494850358632=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87sj4zk3ai.fsf@rustcorp.com.au>
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
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============1213686494850358632==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__14_Feb_2013_18_06_51_+1100_u37bEWmP1NatTBF8"

--Signature=_Thu__14_Feb_2013_18_06_51_+1100_u37bEWmP1NatTBF8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Thu, 14 Feb 2013 13:30:37 +1030 Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
>
> This looks like an impossible config.  CONFIG_VIRTIO_CONSOLE=3Dy, but
> CONFIG_HVC_DRIVER isn't set.
>=20
> From drivers/char/Kconfig:
>=20
>         config VIRTIO_CONSOLE
>         	tristate "Virtio console"
>         	depends on VIRTIO

This also has "&& TTY" in -next (not actually relevant)

>         	select HVC_DRIVER

Its weird, but since CONFIG_TTY is not set (see the config), the
HVC_DRIVER symbol is not even visible, so I suspect that the above select
does nothing :-(  But also, I can't see how VIRTIO_CONSOLE could be set
in the first place since TTY is not set.

(cc'ing some more people) (this is a randconfig that has TTY=3Dn,
HVC_DRIVER=3Dn, but VIRTIO_CONSOLE=3Dy)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__14_Feb_2013_18_06_51_+1100_u37bEWmP1NatTBF8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRHI0LAAoJEECxmPOUX5FE8+MP/ib5sE7Yvv9ID+XwokXNu5QK
e+u14VmFjKY/G1VR7mOFsv6fgfegsG03Fsbjo94RESSxfLhcUDKbVecbJmOmusW+
PdR4kqOXZAOWPZ7y9PvrRLrAQVA198YDfO+xSso/gkEH6v5coTHYS6GLcqic/zHA
d+r1GvMHMqDL8uwbynuqugR9W5Uc35LigV3aH2YvWywkcBnmTRIaXASURPBUJZfU
LkSCoqKsPjhoCNOMhdSPmlXY16qPh5gFEYnhBclQbMotY5WqBocY/+NYHvr0y42W
bsAawM3ze3lyYgevXlnjaKhMuzDo6jPmZRpTe85rLE1hS6MKUPtU8v7nZ694pCaX
34bDczgmwCYaM4QQnI7Sgp9fhOKzF8nQVlkxyd3Z9C/LgMInuyj1dviD4xVFQ8Hn
4vLN5cRja3VGJTgNBaa61/eyGkKJovf3cQWfF75g/itYHEbtpqwIXF5AnBkzXkNS
l5SV5QuWZOYHjZTbsFKpwlHgNWuiRP64Abx7f/cLcQBQ44fBnZyA/Zj8jKo8Egr1
CqQhUfol9PPxChMtTg/Unio4grKH3/LyB9CBEXAq5xhpCu41933YyE8KGs8Ys44u
4qzVYv6NNyDOU/NvcsLUyoFWJpZgHQyaYPJ422CiX66d8tBTeDB3JoDoT5/N77Bp
oO+S6H5ehq7w+GxVG0Cz
=iKqk
-----END PGP SIGNATURE-----

--Signature=_Thu__14_Feb_2013_18_06_51_+1100_u37bEWmP1NatTBF8--

--===============1213686494850358632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1213686494850358632==--
