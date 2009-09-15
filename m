From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 15 Sep 2009 09:03:27 -0400
Message-ID: <4AAF909F.9080306__19303.2220624902$1253019947$gmane$org@gmail.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<4AAA7415.5080204@gmail.com> <20090913120140.GA31218@redhat.com>
	<4AAE6A97.7090808@gmail.com> <20090914164750.GB3745@redhat.com>
	<4AAE961B.6020509@gmail.com> <4AAF8A03.5020806@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6350488334294093894=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AAF8A03.5020806@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6350488334294093894==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46A1F91EB19287765BBD0682"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46A1F91EB19287765BBD0682
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> On 09/14/2009 10:14 PM, Gregory Haskins wrote:
>> To reiterate, as long as the model is such that the ppc boards are
>> considered the "owner" (direct access, no translation needed) I believ=
e
>> it will work.  If the pointers are expected to be owned by the host,
>> then my model doesn't work well either.
>>   =20
>=20
> In this case the x86 is the owner and the ppc boards use translated
> access.  Just switch drivers and device and it falls into place.
>=20

You could switch vbus roles as well, I suppose.  Another potential
option is that he can stop mapping host memory on the guest so that it
follows the more traditional model.  As a bus-master device, the ppc
boards should have access to any host memory at least in the GFP_DMA
range, which would include all relevant pointers here.

I digress:  I was primarily addressing the concern that Ira would need
to manage the "host" side of the link using hvas mapped from userspace
(even if host side is the ppc boards).  vbus abstracts that access so as
to allow something other than userspace/hva mappings.  OTOH, having each
ppc board run a userspace app to do the mapping on its behalf and feed
it to vhost is probably not a huge deal either.  Where vhost might
really fall apart is when any assumptions about pageable memory occur,
if any.

As an aside: a bigger issue is that, iiuc, Ira wants more than a single
ethernet channel in his design (multiple ethernets, consoles, etc).  A
vhost solution in this environment is incomplete.

Note that Ira's architecture highlights that vbus's explicit management
interface is more valuable here than it is in KVM, since KVM already has
its own management interface via QEMU.

Kind Regards,
-Greg


--------------enig46A1F91EB19287765BBD0682
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqvkJ8ACgkQP5K2CMvXmqGd0wCbB/8y7sxyTXx/3odUb27n3vc/
W/AAn3rM1U3FG86WYLElMfmUO3tXTp6R
=vpj/
-----END PGP SIGNATURE-----

--------------enig46A1F91EB19287765BBD0682--

--===============6350488334294093894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============6350488334294093894==--
