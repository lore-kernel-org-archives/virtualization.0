From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCHv2 RFC] virtio-pci: flexible configuration layout
Date: Mon, 5 Dec 2011 11:16:05 -0800
Message-ID: <20111205111605.73b60faa__25763.9480675154$1323112828$gmane$org@jbarnes-desktop>
References: <20111114181854.GA24953@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4785324416193713943=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111114181854.GA24953@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============4785324416193713943==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/pIs=5uj_sahI834pRq7Htux"; protocol="application/pgp-signature"

--Sig_/pIs=5uj_sahI834pRq7Htux
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Nov 2011 20:18:55 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Add a flexible mechanism to specify virtio configuration layout, using
> pci vendor-specific capability.  A separate capability is used for each
> of common, device specific and data-path accesses.
>=20
> Warning: compiled only.
> This patch also needs to be split up, pci_iomap changes
> also need arch updates for non-x86.
> There might also be more spec changes.
>=20
> Posting here for early feedback, and to allow Sasha to
> proceed with his "kvm tool" work.
>=20
> Changes from v1:
> Updated to match v3 of the spec, see:
> 	Subject: [PATCHv3 RFC] virtio-spec: flexible configuration layout
> 	Message-ID: <20111110122436.GA13144@redhat.com>
> 	In-Reply-To: <20111109195901.GA28155@redhat.com>

Looks like this conflicts with your other iomap changes... I didn't
check your latest tree; do you just add another patch on top for the
virtio changes now?

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/pIs=5uj_sahI834pRq7Htux
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3Rh1AAoJEIEoDkX4Qk9hjh4P/1yvlEFpEmkbdoPs091WOtnd
SqaeTG1GO9tQW9TJPDWuotu4MPIkA9WNdWKYvAvGzYGZ2t0SATwXZkJyDkfqg+u8
zQ/6sx/0sz6fZg8MK56BfkZ8ExRnttEVFei5KDS32nGih3rKzQkJVtnlH/eW6bRM
W7p/90N44+NBAcqly1ABxENfvS8jKk6218OmyaLxbQb8C3evpZqewSLApLB3nhPD
TMhlFsw9n03TM4G4jEa+IgoofPYyDmpyM4RQaRwC/LQKof4h8BQIjS3zfKMTzeL1
WwahmLaReBm7T2VPVcmUvWSvbZ6w77uz9PMzWCw+EeDGb1UEXT0IIVO6X7xilZ8b
vSFeysaqDlbvB5HbspEXbg/ZWWVKG8QW6sTInsXt25/pqKGj0yYNR+ul73LNI996
Dzoa4olgpXQTM4+EON4eaYsYJGcLq38dZz02E3S5FAs1Yu91B54VzIaAbeH24BzB
aJ6y1an6Cc2PyAG5xX6jzy941mQH+pSoQC4IIfApZxUAV63e8pEDGigLa5jurIfB
CrJEby8ix/s+ylvrLoWkgBhIaEPH2iTv6AIzRlZfF/cutMfDd/152Cdk8nOaQZhr
y0UQop9TMhwkEa4QnB+b38fjZlq4KpURFhQ30mX2+hCpmo6NjtlcBktI6Rkbfogk
MGYuWOpSectwfIKPDAZy
=4XTH
-----END PGP SIGNATURE-----

--Sig_/pIs=5uj_sahI834pRq7Htux--

--===============4785324416193713943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4785324416193713943==--
