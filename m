From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Linux-next changes for module and virtio trees.
Date: Wed, 3 Oct 2012 01:12:39 +1000
Message-ID: <20121003011239.3445171ec17e422a289d2997__21599.2559715689$1349191388$gmane$org@canb.auug.org.au>
References: <871uhh4cen.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1509302501699469744=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <871uhh4cen.fsf@rustcorp.com.au>
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
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-devel <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============1509302501699469744==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__3_Oct_2012_01_12_39_+1000_MhqrEcKkTYqu8wEQ"

--Signature=_Wed__3_Oct_2012_01_12_39_+1000_MhqrEcKkTYqu8wEQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Tue, 02 Oct 2012 15:56:56 +0930 Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
>
>         Please remove my quilt tree
> http://ozlabs.org/~rusty/kernel/rr-latest/ from linux-next, and use my
> git trees from now on:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git
> Branches:
>         modules-next
>         virtio-next

Done.

> For others: beware that these will rebase, usually once after the merge
> window closes (so I can work on a more modern tree), and again just
> before it opens (where I squash in fixup patches).

The first should not be necessary since everything in these trees should
have been merged by Linus during the merge window, so a merge of -rc1 or
later should be a fast forward (though merging with the tag itself may
produce a real merge).  The second can be tricky to pick the right
moment :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__3_Oct_2012_01_12_39_+1000_MhqrEcKkTYqu8wEQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQawRnAAoJEECxmPOUX5FE6SoP+wctU7Y01f/eNenOQ5Jl1q62
zFQyqq+3gLnunQmnUN9Eo3qgtJSFKHRoUxjVPPfrRV5+gl0p4/zX/iQHx4BjrvMe
Dpx8iSBO/UWA1UE5mLi16ZnH63yO/dkvL9KtWmGifggDYnxGjjjpFtinm0LDJB7r
3HBjRGXJdMZu4ESWjnnF3ufBI/MvI4IYgvcbrR/JARKtDobBNAQ0WaxRUWriS0fD
whC28kGg+qrLDY7k4XsmC479oAl5l0K4mz8UaKlkp3HUQ0bKAOfOTDmRBLWWF1tL
afKQ1/BAoSFaQ1mf9IhgdT5Ubrbm5N3jst/E2Qg6FuL7vFV5tN7f5a40AumOXdry
GmPewFI6h6OQd1TFmbSa0LlcBEN3d8jG0j71PcVsi2BRCMUovzitUUuEYZoP54+F
CFnyzfXB1sanHhxmFSzhzC++5fqnQWX9y9v4UAXLlb4AuNI5GUyI3Dw9RPf4jRLI
1P3FjZnsNiPme7ZOLIjS8askQH1s7Zs3gfgCJAD0KDvl7ZFT1NhL1osUAqC/kdGi
ixkUW6PAlJ+WAHubXgrUeEoDAildk739hNclB7zZq9Fl2HQq7kSYmX3nUKDSiEcX
ud+h0f08hbIktWBvFaCzLQUQVJNsKRfwbnUI4ftikpdqzV2DlRHpXHW+uZEnwT6g
1Brv8erQB660Qi0+aIXo
=wFpj
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Oct_2012_01_12_39_+1000_MhqrEcKkTYqu8wEQ--

--===============1509302501699469744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1509302501699469744==--
