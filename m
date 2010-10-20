From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: xen PV on HVM and initial domain merge in linux-next
Date: Thu, 21 Oct 2010 10:45:41 +1100
Message-ID: <20101021104541.8e10159a.sfr@canb.auug.org.au>
References: <alpine.DEB.2.00.1010191254460.2423@kaball-desktop>
	<alpine.DEB.2.00.1010191847290.10348@kaball-desktop>
	<20101020113256.3647b1d9.sfr@canb.auug.org.au>
	<alpine.DEB.2.00.1010201455160.10348@kaball-desktop>
	<20101020152808.GA22328@dumpdata.com>
	<alpine.DEB.2.00.1010201644380.10348@kaball-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0146554102=="
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <alpine.DEB.2.00.1010201644380.10348@kaball-desktop>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============0146554102==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__21_Oct_2010_10_45_41_+1100_aOZ1O+a0EbuxnsNc"

--Signature=_Thu__21_Oct_2010_10_45_41_+1100_aOZ1O+a0EbuxnsNc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefano,

On Wed, 20 Oct 2010 16:47:51 +0100 Stefano Stabellini <stefano.stabellini@e=
u.citrix.com> wrote:
>
> Good idea, I have created a link called linux-next to
> 2.6.36-rc8-initial-domain-v5 so the following should also work:
>=20
> git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git linux-next

I have added that branch from today with just you listed as the contact
(if you ant anyone else (even a mailing list) listed as a contact, just
let me know.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Thu__21_Oct_2010_10_45_41_+1100_aOZ1O+a0EbuxnsNc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMv38lAAoJEDMEi1NhKgbssYcH/Rgoe/X3hHmTyxgC9NHtLPPH
NJB4HMSj7XUq1IA9ZBodDDhHVnjht20Dgo0ZBX8VU/HLunyHcrWjJ5PqQ4IPaTXm
KfakafvDOByNQSZ9iFDYRIAFin1EcvjXExJaSNbWqqlzeqZ/Pu1MPTavq+VQwlUM
+LaSc++JhMzs435lswNiS1UxvbofAkSTH/qu+JPh2kJnK/URF47petNPHLeEg9EK
RA6xfNiyw24n4ACEJgV2XNGF40nMUWhRNxx2T/1TwWwwEG2KtIW7RmjcuP5BrtnO
EFX/MRnEc7hE3UPVDDbKr+SH6yFDfNc2aPdyQGTZ0Cm3Ht6sSarn2IfRnGP66lc=
=3G9U
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Oct_2010_10_45_41_+1100_aOZ1O+a0EbuxnsNc--


--===============0146554102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--===============0146554102==--
