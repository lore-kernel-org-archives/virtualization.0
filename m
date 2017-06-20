From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Tue, 20 Jun 2017 13:29:00 -0400
Message-ID: <1497979740.20270.102.camel__1163.84375510297$1497979755$gmane$org@redhat.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7977232898969508994=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7977232898969508994==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-9kj1x8ztObs/ecPVraUB"


--=-9kj1x8ztObs/ecPVraUB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-06-20 at 18:49 +0200, David Hildenbrand wrote:
> On 20.06.2017 18:44, Rik van Riel wrote:

> > Nitesh Lal (on the CC list) is working on a way
> > to efficiently batch recently freed pages for
> > free page hinting to the hypervisor.
> >=20
> > If that is done efficiently enough (eg. with
> > MADV_FREE on the hypervisor side for lazy freeing,
> > and lazy later re-use of the pages), do we still
> > need the harder to use batch interface from this
> > patch?
> >=20
>=20
> David's opinion incoming:
>=20
> No, I think proper free page hinting would be the optimum solution,
> if
> done right. This would avoid the batch interface and even turn
> virtio-balloon in some sense useless.

I agree with that.  Let me go into some more detail of
what Nitesh is implementing:

1) In arch_free_page, the being-freed page is added
   to a per-cpu set of freed pages.
2) Once that set is full, arch_free_pages goes into a
   slow path, which:
   2a) Iterates over the set of freed pages, and
   2b) Checks whether they are still free, and
   2c) Adds the still free pages to a list that is
       to be passed to the hypervisor, to be MADV_FREEd.
   2d) Makes that hypercall.

Meanwhile all arch_alloc_pages has to do is make sure it
does not allocate a page while it is currently being
MADV_FREEd on the hypervisor side.

The code Wei is working on looks like it could be=20
suitable for steps (2c) and (2d) above. Nitesh already
has code for steps 1 through 2b.

--=20
All rights reversed
--=-9kj1x8ztObs/ecPVraUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZSVtcAAoJEM553pKExN6DWsAH/RVdYjrbXdTBMg+9KCGD7zih
8IjHH7OSo7O9qBnWrHCPhvs8A6y/LusCYmEdWaCH2EVZc8cgvsrEc2Ju5Wt7MnPn
nT6sE5MCVS5puJmnNGlg8jA1PM+bsgx7qUYsRcVAtIMFou0eoSjIGTrQ7GCuefNB
7aW02aByPg3IaDE0ukP4tPvTeSowuTCSsYU+cdaF0TR9qO9j6kdLAr4rxhWQsuIT
HMS/6Dztj9blBhP2JZM8pYu4MqZ5/Wjf6THBCSz3jNgd8HxkD8YYZgyjIn/FTg2v
yJjcmTDnUoXXsDxzJfgKgXC3ludgiuJuhkMF+bMEYG9NpKEupa09a3JQWhi+oQ0=
=bV0p
-----END PGP SIGNATURE-----

--=-9kj1x8ztObs/ecPVraUB--


--===============7977232898969508994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7977232898969508994==--
