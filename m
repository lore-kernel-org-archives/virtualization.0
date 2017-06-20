From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Tue, 20 Jun 2017 12:44:09 -0400
Message-ID: <1497977049.20270.100.camel__41946.4047220119$1497977068$gmane$org@redhat.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8296395199317648213=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b92af473-f00e-b956-ea97-eb4626601789@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============8296395199317648213==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-TDh63EvNZF5vpHsR7dYQ"


--=-TDh63EvNZF5vpHsR7dYQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-06-12 at 07:10 -0700, Dave Hansen wrote:

> The hypervisor is going to throw away the contents of these pages,
> right?=C2=A0=C2=A0As soon as the spinlock is released, someone can alloca=
te a
> page, and put good data in it.=C2=A0=C2=A0What keeps the hypervisor from
> throwing
> away good data?

That looks like it may be the wrong API, then?

We already have hooks called arch_free_page and
arch_alloc_page in the VM, which are called when
pages are freed, and allocated, respectively.

Nitesh Lal (on the CC list) is working on a way
to efficiently batch recently freed pages for
free page hinting to the hypervisor.

If that is done efficiently enough (eg. with
MADV_FREE on the hypervisor side for lazy freeing,
and lazy later re-use of the pages), do we still
need the harder to use batch interface from this
patch?

--=20
All rights reversed
--=-TDh63EvNZF5vpHsR7dYQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZSVDaAAoJEM553pKExN6DemQIAMAsYzL7/wDfstjbSE2Z71w9
alzJ2n2LqI2pfKZYODaamSye2uq/tl38iefZnERfPAaIl1Lfjr1gp1ccw7y7Y1PV
p9kdwZPdMolL50cmhtM507Csc8Pl78zBAiY7Rr6VKUqqzJPOkBah0Xwjv0bedrfV
uYk589971LqP2XuqO3FX8AIz70mVGwOzOHOL/I5ycJ+LOkVX9Y+4l8EO/kRtOjsH
jjjCCXEmWUAYTAc0OTxz5xb9uahZwtWfFl2wg+yWE5/isOMqyjrv730Ezfl/kncv
ac2vj9rnQTijdGvzPz0vK8dbsndNYtU/npy9O4QD7AuFo11t/xaWhJjoyJXx1Ho=
=6nRH
-----END PGP SIGNATURE-----

--=-TDh63EvNZF5vpHsR7dYQ--


--===============8296395199317648213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8296395199317648213==--
